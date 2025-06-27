import 'dart:async';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/objectBox.dart';
import 'package:example/core/framework/socket/socket.dart';
import 'package:example/features/symbols/models/schema/symbol_model.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';
import 'package:example/objectbox.g.dart' as Box;

abstract class QuotesDataSource {
  List<String> categories = [];

  Future<List<SymbolEntity>> getCachedSymbols();

  Future<void> sendToSubscribe();

  void subscribeSymbol(String symbol);

  void unsubscribeSymbol(String symbols);

  void onData({
    required Function(List<SymbolEntity> items, List<String> categories)
        onReceiveRequest,
    required Function(List<SymbolEntity> items) onUpdateSymbol,
    required Function(SymbolEntity item) onRemoveSymbol,
  });

  Future<void> setSymbolFav({required SymbolEntity item, required bool value});

  Future<void> updateSymbol(SymbolEntity value);

  Future<void> removeSymbol(SymbolEntity value);

  void onSwitchAccount(List<String> symbols);

  void reorderMappedSymbols();

  SymbolEntity? getSymbol(String value);

  void close();
}

@Injectable(as: QuotesDataSource)
class QuotesDataSourceImp implements QuotesDataSource {
  final Sockeet socket;
  final ObjectBox objectBox;
  StreamSubscription? listener;
  @override
  List<String> categories = [];
  Map<String, SymbolEntity> mappedSymbol = {};

  QuotesDataSourceImp(this.socket, this.objectBox);

  @override
  void onData({
    required Function(List<SymbolEntity> items, List<String> categories)
        onReceiveRequest,
    required Function(List<SymbolEntity> items) onUpdateSymbol,
    required Function(SymbolEntity item) onRemoveSymbol,
  }) {
    categories.clear();
    mappedSymbol.clear();
    updatedAt = DateTime(1990);
    listener = socket.onData(
      events: [
        SocketEvent.subscribe,
        SocketEvent.unsubscribe,
        SocketEvent.update_data,
        SocketEvent.symbol_update
      ],
      onReceiveRequest: (receiver) async {
        if (receiver.event == SocketEvent.subscribe) {
          final symbol = SymbolModel.fromJson(receiver.data);
          await _addSymbol(symbol.copyToEntity());
          onReceiveRequest(mappedSymbol.values.toList(), categories);
        } else if (receiver.event == SocketEvent.unsubscribe) {
          final String symbolName = receiver.data['symbol'];
          if (mappedSymbol.containsKey(symbolName)) {
            final symbol = mappedSymbol[symbolName]!;
            onRemoveSymbol(symbol);
            await removeSymbol(symbol);
          }
        } else if (receiver.event == SocketEvent.symbol_update) {
          final symbol = SymbolModel.fromJson(receiver.data);
          await updateSymbol(symbol.copyToEntity());
          onReceiveRequest(mappedSymbol.values.toList(), categories);
        }
      },
      onUpdateSymbol: (data) async {
        if (data.contains('&')) {
          final values = data.split('&');
          final item = mappedSymbol[values[0]];
          if (item != null) {
            if (values.last == '1') {
              final value = double.tryParse(values[1]) ?? 0.0;
              final ask = value + (item.askDifference * item.contractSize);
              final color = item.ask < ask ? Colors.red : Colors.green;
              item.askColor.value = color;
              item.ask = ask;
              item.askChange.value = ask;
              item.askColorHex = colorToHex(color);
            } else {
              final value = double.tryParse(values[1]) ?? 0.0;
              final bed = value + (item.bidDifference * item.contractSize);
              final color = item.bid > bed ? Colors.red : Colors.green;
              item.bidColor.value = color;
              item.bid = bed;
              item.bidChange.value = bed;
              item.bidColorHex = colorToHex(color);
            }
            final tick = (item.ask - item.bid) / item.tickSize;
            item.tick.value = tick;
            item.timestamp = DateTime.now().millisecondsSinceEpoch;
            item.dateTime.value = DateTime.now().millisecondsSinceEpoch;
            if (DateTime.now().difference(updatedAt).inSeconds >= 5) {
              await updateSymbol(item);
              updatedAt = DateTime.now();
            }
            onUpdateSymbol(mappedSymbol.values.toList());
          }
        }
      },
    );
  }

  @override
  void reorderMappedSymbols() {
    final sortedList = mappedSymbol.values.toList()
      ..sort((a, b) => a.index.compareTo(b.index));
    mappedSymbol.clear();
    for (var symbol in sortedList) {
      mappedSymbol[symbol.symbol] = symbol;
    }
  }

  @override
  void onSwitchAccount(List<String> symbols) {
    for (var symbol in symbols) {
      subscribeSymbol(symbol);
    }
  }

  @override
  void subscribeSymbol(String symbol) {
    socket.send(
      event: SocketEvent.subscribe,
      data: {
        'symbol': symbol,
      },
    );
  }

  @override
  void unsubscribeSymbol(String symbol) {
    socket.send(
      event: SocketEvent.unsubscribe,
      data: {'symbol': symbol},
    );
  }

  Future<void> _addSymbol(SymbolEntity value) async {
    if (mappedSymbol[value.symbol] == null) {
      mappedSymbol[value.symbol] = value;
      value.index = mappedSymbol.length;
      if (!categories.contains(value.sector)) {
        categories.add(value.sector);
      }
      objectBox.symbolBox!.put(value.copyToModel());
    }
  }

  @override
  Future<void> removeSymbol(SymbolEntity value) async {
    final id = mappedSymbol[value.symbol]?.id;
    mappedSymbol.remove(value.symbol);

    if (id != null) {
      objectBox.symbolBox!.remove(id);
    }
    await _updateSymbolsIndexAfterRemove();
  }

  DateTime updatedAt = DateTime.now();
  DateTime storeUpdatedAt = DateTime.now();

  @override
  Future<void> updateSymbol(SymbolEntity value) async {
    final id = mappedSymbol[value.symbol]?.id;
    if (id != null) {
      mappedSymbol[value.symbol] = value;
      if (DateTime.now().difference(storeUpdatedAt).inSeconds >= 5) {
        storeUpdatedAt = DateTime.now();
        objectBox.symbolBox!.put(value.copyToModel());
      }
    }
  }

  Future<void> _updateSymbolsIndexAfterRemove() async {
    final symbols = mappedSymbol.values.toList()
      ..sort((a, b) => a.index.compareTo(b.index));

    for (int i = 0; i < symbols.length; i++) {
      symbols[i].index = i;
      mappedSymbol[symbols[i].symbol] = symbols[i];

      objectBox.symbolBox!.put(symbols[i].copyToModel());
    }
  }

  @override
  Future<List<SymbolEntity>> getCachedSymbols() async {
    try {
      final query = objectBox.symbolBox!
          .query()
          .order(Box.SymbolModel_.index, flags: Box.Order.descending)
          .build();
      final symbols = query.find();
      query.close();
      return symbols.map((e) {
        if (!categories.contains(e.sector)) {
          categories.add(e.sector);
        }
        mappedSymbol[e.name] = e.copyToEntity();
        return mappedSymbol[e.name]!;
      }).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> setSymbolFav({
    required SymbolEntity item,
    required bool value,
  }) async {
    item.isFav = value;
    item.isFavChange.value = value;
    await updateSymbol(item);
  }

  @override
  void close() {
    listener?.cancel();
  }

  @override
  Future<void> sendToSubscribe() async {
    final symbols = objectBox.symbolBox!.getAll();
    if (symbols.isEmpty) {
      for (var item in ['GBPUSD', 'EURUSD', 'XAUUSD']) {
        subscribeSymbol(item);
      }
    } else {
      for (var item in symbols) {
        subscribeSymbol(item.name);
      }
    }
  }

  @override
  SymbolEntity? getSymbol(String value) {
    return mappedSymbol[value];
  }
}
