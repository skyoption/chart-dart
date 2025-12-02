import 'dart:async';

import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/objectBox.dart';
import 'package:example/core/framework/socket/socket.dart';
import 'package:example/features/symbols/models/schema/symbol_model.dart';

abstract class SearchDataSource {
  Map<String, SymbolModel> symbols = {};

  void getAllSymbols();

  void subscribeSymbol(String symbol);

  void unsubscribeSymbol(String symbol);

  void onData({
    required Function(Map<String, List<SymbolModel>> categories)
        onReceiveRequest,
  });

  void close();
}

@Injectable(as: SearchDataSource)
class SearchDataSourceImp implements SearchDataSource {
  final Sockeet socket;
  final ObjectBox objectBox;
  @override
  Map<String, SymbolModel> symbols = {};
  final Map<String, List<SymbolModel>> categories = {};
  StreamSubscription? listener;

  SearchDataSourceImp(this.socket, this.objectBox);

  @override
  void getAllSymbols() async {
    socket.send(event: SocketEvent.get_all_symbols, data: {'name': ''});
    final items = objectBox.symbolBox!.getAll();
    for (var item in items) {
      symbols[item.name] = item;
    }
  }

  @override
  void onData({
    required Function(Map<String, List<SymbolModel>> categories)
        onReceiveRequest,
  }) {
    symbols.clear();
    categories.clear();
    listener = socket.onData(
      events: [SocketEvent.get_all_symbols],
      onReceiveRequest: (receiver) {
        kPrint("Event: ${receiver.event}\nData: ${receiver.data}");
        for (var item in receiver.data['symbols']) {
          final value = SymbolModel.fromJson(item);
          if (categories[value.sector] == null) {
            categories[value.sector] = [value];
          } else {
            categories[value.sector]!.add(value);
          }
        }
        onReceiveRequest(categories);
      },
      onUpdateSymbol: (data) {},
    );
  }

  @override
  void subscribeSymbol(String symbol) {
    socket.send(event: SocketEvent.subscribe, data: {'symbol': symbol});
  }

  @override
  void unsubscribeSymbol(String symbol) {
    socket.send(event: SocketEvent.unsubscribe, data: {'symbol': symbol});
  }

  @override
  void close() {
    listener?.cancel();
  }
}
