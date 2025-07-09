import 'dart:async';

import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/objectBox.dart';
import 'package:example/core/framework/socket/socket.dart';
import 'package:example/features/chart/models/requests/get_candles_request.dart';
import 'package:example/features/symbols/models/schema/symbol_model.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';

abstract class ChartDataSource {
  void getCandles(GetCandlesRequest request);

  bool getTimeframeStart(int timestamp, int lastTime, String timeframe);

  void onData({
    required Function(List<KLineEntity> items, int offset) onReceiveRequest,
    required Function(String symbol, double ask) onAskUpdated,
    required Function(String symbol, double bid) onBidUpdated,
  });

  void close();

  void setDefaultSymbol({
    required ValueNotifier<SymbolEntity?> value,
    required Function(String symbol, double ask, double bid) onAskAndBidUpdated,
  });

  void setCandleTimeFormat(CandleTimeFormat frame);
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
  void setDefaultSymbol({
    required ValueNotifier<SymbolEntity?> value,
    required Function(String symbol, double ask, double bid) onAskAndBidUpdated,
  }) {
    currentSymbol = value;
    currentSymbol.addListener(() {
      if (currentSymbol.value != null) {
        offset = 0;
        socket.sendRequest(
          event: SocketEvent.get_chart_data,
          data: GetCandlesRequest(
            symbol: currentSymbol.value!.symbol,
            timeFrame: timeFrame,
            offset: offset,
          ).toJson(),
        );
        onAskAndBidUpdated(
          currentSymbol.value!.symbol,
          currentSymbol.value!.ask,
          currentSymbol.value!.bid,
        );
        updatedAt = DateTime(1990);
      }
    });
  }

  @override
  void setCandleTimeFormat(CandleTimeFormat frame) {
    timeFrame = frame.name;
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
    required Function(List<KLineEntity> items, int offset) onReceiveRequest,
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
            onReceiveRequest(items, offset);
            updatedAt = DateTime.now().add(Duration(milliseconds: 100));
          }
        }
      },
      onUpdateSymbol: (data) async {
        if (data.contains('&')) {
          final values = data.split('&');
          if (DateTime.now().difference(updatedAt).inMilliseconds >= 150) {
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
            updatedAt = DateTime(1990);
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
  bool getTimeframeStart(int timestampSeconds, int lastTime, String timeframe) {
    switch (timeframe) {
      case "M1":
        return timestampSeconds - lastTime > 60;
      case "M5":
        return timestampSeconds - lastTime > 300;
      case "M15":
        return timestampSeconds - lastTime > 900;
      case "M30":
        return timestampSeconds - lastTime > 1800;
      case "H1":
        return timestampSeconds - lastTime > 3600;
      case "H4":
        return timestampSeconds - lastTime > 14400;
      case "D1":
        return timestampSeconds - lastTime > 86400;
      case "W1":
        return timestampSeconds - lastTime > 604800;
      case "MN1":
        return timestampSeconds - lastTime > 2592000;
      default:
        return timestampSeconds - lastTime > 60;
    }
  }

  @override
  void close() {
    listener?.cancel();
  }
}
