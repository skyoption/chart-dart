import 'dart:async';

import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/objectBox.dart';
import 'package:example/core/framework/socket/socket.dart';
import 'package:example/features/chart/models/requests/get_candles_request.dart';
import 'package:example/features/symbols/models/schema/symbol_model.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';

abstract class ChartDataSource {
  void getCandles(GetCandlesRequest request);

  int getTimeframeStart(int timestamp, String timeframe);

  void onData({
    required Function(List<KLineEntity> items) onReceiveRequest,
    required Function(String symbol, double ask) onAskUpdated,
    required Function(String symbol, double bid) onBidUpdated,
  });

  void close();

  void setDefaultSymbol(ValueNotifier<SymbolEntity?> value);
}

@LazySingleton(as: ChartDataSource)
class QuotesDataSourceImp implements ChartDataSource {
  final Sockeet socket;
  final ObjectBox objectBox;
  StreamSubscription? listener;
  Map<String, SymbolModel> symbols = {};
  late ValueNotifier<SymbolEntity?> currentSymbol;
  int offset = 0;
  String timeFrame = 'M15';

  QuotesDataSourceImp(this.socket, this.objectBox);

  @override
  void setDefaultSymbol(ValueNotifier<SymbolEntity?> value) {
    currentSymbol = value;
    currentSymbol.addListener(() {
      if (currentSymbol.value != null) {
        socket.sendRequest(
          event: SocketEvent.get_chart_data,
          data: GetCandlesRequest(
            symbol: currentSymbol.value!.symbol,
            timeFrame: timeFrame,
            offset: offset,
          ).toJson(),
        );
      }
    });
  }

  @override
  void getCandles(GetCandlesRequest request) {
    timeFrame = request.timeFrame;
    offset = request.offset;
    if (request.symbol.isEmpty) {
      request.symbol = 'GBPUSD';
    }
    socket.sendRequest(
      event: SocketEvent.get_chart_data,
      data: request.toJson(),
    );
    final items = objectBox.symbolBox!.getAll();
    for (var item in items) {
      symbols[item.name] = item;
    }
  }

  DateTime updatedAt = DateTime.now();

  @override
  void onData({
    required Function(List<KLineEntity> items) onReceiveRequest,
    required Function(String symbol, double ask) onAskUpdated,
    required Function(String symbol, double bid) onBidUpdated,
  }) {
    symbols.clear();
    updatedAt = DateTime(1990);
    _fillSymbols();
    listener = socket.onData(
      events: [SocketEvent.get_chart_data, SocketEvent.update_data],
      onReceiveRequest: (receiver) async {
        kPrint(receiver.data);
        if (receiver.event == SocketEvent.get_chart_data) {
          final candles = receiver.data['candles'];
          if (candles.isNotEmpty) {
            List<KLineEntity> items = [];
            for (var item in candles) {
              final candle = KLineEntity.fromString(item.toString());
              items.add(candle);
            }
            onReceiveRequest(items);
            updatedAt = DateTime.now().add(Duration(milliseconds: 100));
          }
        }
      },
      onUpdateSymbol: (data) async {
        if (data.contains('&')) {
          final values = data.split('&');
          if (DateTime.now().difference(updatedAt).inMilliseconds >= 100) {
            final symbol = symbols[values[0]];
            if (symbol != null && currentSymbol.value?.symbol == symbol.name) {
              if (values.last == '1') {
                final value = double.tryParse(values[1]) ?? 0.0;
                final amount = symbol.askDifference * symbol.contractSize;
                final ask = value + amount;
                onAskUpdated(symbol.name, ask);
              } else {
                final value = double.tryParse(values[1]) ?? 0.0;
                final amount = symbol.bidDifference * symbol.contractSize;
                final bid = value + amount;
                onBidUpdated(symbol.name, bid);
              }
            }
            updatedAt = DateTime.now();
          }
        }
      },
    );
  }

  int times = 0;
  Future<void> _fillSymbols() async {
    if (times == 10) return;
    final items = objectBox.symbolBox!.getAll();
    for (var item in items) {
      symbols[item.name] = item;
    }
    if (symbols.isEmpty) {
      await Future.delayed(Duration(milliseconds: 200));
      times++;
      return await _fillSymbols();
    }
  }

  @override
  int getTimeframeStart(int timestampMs, String timeframe) {
    int timestampMinutes = timestampMs ~/ 60000;
    switch (timeframe) {
      case "M1":
        return timestampMinutes;
      case "M5":
        return (timestampMinutes ~/ 5) * 5;
      case "M15":
        return (timestampMinutes ~/ 15) * 15;
      case "M30":
        return (timestampMinutes ~/ 30) * 30;
      case "H1":
        return (timestampMinutes ~/ 60) * 60;
      case "H4":
        return (timestampMinutes ~/ 240) * 240;
      case "D1":
        return (timestampMinutes ~/ 1440) * 1440;
      case "W1":
        return (timestampMinutes ~/ 10080) * 10080;
      case "MN1":
        return (timestampMinutes ~/ 43200) *
            43200; // Approximate month (30 days)
      default:
        return timestampMinutes;
    }
  }

  @override
  void close() {
    listener?.cancel();
  }
}
