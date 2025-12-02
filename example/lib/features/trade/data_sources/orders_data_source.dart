import 'dart:async';

import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/objectBox.dart';
import 'package:example/core/framework/socket/models/socket_receiver_request.dart';
import 'package:example/core/framework/socket/socket.dart';
import 'package:example/features/symbols/models/schema/symbol_model.dart';
import 'package:example/features/trade/models/order_entity.dart';
import 'package:example/features/trade/models/requests/delete_order_request.dart';
import 'package:example/features/trade/models/requests/modify_order_request.dart';
import 'package:example/features/trade/models/requests/open_order_request.dart';
import 'package:example/features/trade/models/schema/order_model.dart';
import 'package:example/features/trade_history/models/requests/get_history_request.dart';
import 'package:example/objectbox.g.dart';

abstract class OrdersDataSource {
  Future<List<OrderEntity>> getCachedOrders();

  void getAllOrders();

  Future<void> deleteAllOrders();

  Future<void> deleteAllBuyLimitOrders();

  Future<void> deleteAllSellLimitOrders();

  Future<void> deleteAllBuyStopOrders();

  Future<void> deleteAllSellStopOrders();

  void openOrder(OpenOrderRequest request);

  void modifyOrder(ModifyOrderRequest request);

  void deleteOrder(DeleteOrderRequest request);

  void onData({
    required List<SocketEvent> events,
    Function(String message, int? id)? onRequest,
    Function(String message, int? id)? onRequestError,
    Function(OrderEntity item)? onOpenOrderRequest,
    Function(int id)? onDeleteOrderRequest,
    Function(OrderEntity item)? onModifyOrderRequest,
    Function(List<OrderEntity> items)? onAllOrderRequest,
  });

  void close();
}

@Injectable(as: OrdersDataSource)
class OrdersDataSourceImp implements OrdersDataSource {
  StreamSubscription? listener;
  final Sockeet socket;
  final ObjectBox objectBox;

  OrdersDataSourceImp(this.socket, this.objectBox);

  List<OrderEntity> orders = [];
  Map<String, SymbolModel> symbols = {};

  @override
  void getAllOrders() {
    socket.send(event: SocketEvent.get_all_pending, data: {});
  }

  @override
  Future<List<OrderEntity>> getCachedOrders() async {
    final items = objectBox.orderBox!.getAll();
    orders = items.map((item) => item.copyToEntity()).toList();
    return orders;
  }

  Future<void> _fillSymbols() async {
    final items = objectBox.symbolBox!.getAll();
    for (var item in items) {
      symbols[item.name] = item;
    }
  }

  @override
  void onData({
    required List<SocketEvent> events,
    Function(String message, int? id)? onRequest,
    Function(String message, int? id)? onRequestError,
    Function(OrderEntity item)? onOpenOrderRequest,
    Function(int id)? onDeleteOrderRequest,
    Function(OrderEntity item)? onModifyOrderRequest,
    Function(List<OrderEntity> items)? onAllOrderRequest,
  }) {
    symbols.clear();
    orders.clear();
    _fillSymbols();
    listener = socket.onData(
      events: [SocketEvent.subscribe, SocketEvent.unsubscribe, ...events],
      onReceiveRequest: (receiver) async {
        kPrint("Event: ${receiver.event}\nData: ${receiver.data}");
        if (!receiver.success && onRequestError != null) {
          onRequestError(receiver.message, receiver.data?['id']);
          return;
        }

        if (receiver.event == SocketEvent.ev_open_pending) {
          await _handleOpenOrder(receiver, onOpenOrderRequest);
        } else if (receiver.event == SocketEvent.ev_del_pending) {
          await _handleDeleteOrder(receiver, onDeleteOrderRequest);
        } else if (receiver.event == SocketEvent.ev_modify_pending) {
          await _handleModifyOrder(receiver, onModifyOrderRequest);
        } else if (receiver.event == SocketEvent.get_all_pending) {
          await _handleAllOrders(receiver, onAllOrderRequest);
        } else if (receiver.event == SocketEvent.subscribe ||
            receiver.event == SocketEvent.unsubscribe) {
          _fillSymbols();
        }
        _checkSymbols();
        if (events.contains(receiver.event) &&
            receiver.event.name.contains('ev') &&
            onRequest != null) {
          onRequest(receiver.message, receiver.data?['id']);
        }
      },
    );
  }

  Future<void> _checkSymbols() async {
    final ordersSymbols = orders.map((e) => e.symbol).toSet();
    final existingSymbols =
        objectBox.symbolBox!.getAll().map((e) => e.name).toSet();

    final missingSymbols = ordersSymbols.difference(existingSymbols);

    for (final symbol in missingSymbols) {
      subscribeSymbol(symbol);
    }
  }

  void subscribeSymbol(String symbol) {
    socket.send(event: SocketEvent.subscribe, data: {'symbol': symbol});
  }

  Future<void> _handleOpenOrder(
    SocketReceiverRequest receiver,
    Function(OrderEntity item)? onOpenOrderRequest,
  ) async {
    if (onOpenOrderRequest != null) {
      final item = OrderModel.fromJson(receiver.data);
      final index = orders.indexWhere((e) => e.id == item.id);
      if (index == -1) {
        await objectBox.orderBox!.putAsync(item);
        final order = item.copyToEntity();
        orders.add(order);
        onOpenOrderRequest(order);
        getAllPending();
      }
    }
  }

  Future<void> _handleDeleteOrder(
    SocketReceiverRequest receiver,
    Function(int id)? onDeleteOrderRequest,
  ) async {
    if (onDeleteOrderRequest != null) {
      orders.removeWhere((e) => e.id == receiver.data['id']);
      onDeleteOrderRequest(receiver.data['id']);
      await objectBox.positionsBox!.removeAsync(receiver.data['id']);
      getAllPending();
      getHistoryPending();
    }
  }

  Future<void> _handleModifyOrder(
    SocketReceiverRequest receiver,
    Function(OrderEntity item)? onModifyOrderRequest,
  ) async {
    if (onModifyOrderRequest != null) {
      final index = orders.indexWhere(
        (element) => element.id == receiver.data['id'],
      );
      if (index != -1 && receiver.data['updates'] != null) {
        final item = orders[index];
        var updates = receiver.data['updates'];
        if (updates['volume'] != null) item.volume = updates['volume'];
        if (updates['openPrice'] != null) item.openPrice = updates['openPrice'];
        if (updates['sl'] != null) item.sl = updates['sl'];
        if (updates['tp'] != null) item.tp = updates['tp'];
        if (updates['expirationDate'] != null) {
          item.expirationDate = updates['expirationDate'];
        }
        await objectBox.orderBox!.putAsync(item.copyToModel());
        onModifyOrderRequest(item);
        getAllPending();
      }
    }
  }

  Future<void> _handleAllOrders(
    SocketReceiverRequest receiver,
    Function(List<OrderEntity> items)? onAllOrderRequest,
  ) async {
    if (onAllOrderRequest != null && receiver.data['pending'] != null) {
      List<OrderModel> items = (receiver.data['pending'] as List<dynamic>)
          .map((e) => OrderModel.fromJson(e))
          .toList();
      await objectBox.orderBox!.removeAllAsync();
      objectBox.orderBox!.putMany(items);
      orders = items.map((item) => item.copyToEntity()).toList();
      onAllOrderRequest(orders);
    }
  }

  @override
  void openOrder(OpenOrderRequest request) {
    socket.sendRequest(event: SocketEvent.open_pending, data: request.toJson());
  }

  @override
  void deleteOrder(DeleteOrderRequest request) {
    socket.sendRequest(event: SocketEvent.del_pending, data: request.toJson());
  }

  @override
  void modifyOrder(ModifyOrderRequest request) {
    socket.sendRequest(
      event: SocketEvent.modify_pending,
      data: request.toJson(),
    );
  }

  Future<void> getAllPending() async {
    socket.send(
      event: SocketEvent.get_all_pending,
      data: GetHistoryRequest(
        from: DateTime.now().subtract(const Duration(days: 7)).toStartTime,
        to: DateTime.now().toEndTime,
      ).toJson(),
    );
  }

  Future<void> getHistoryPending() async {
    socket.send(
      event: SocketEvent.get_history_pending,
      data: GetHistoryRequest(
        from: DateTime.now().subtract(const Duration(days: 7)).toStartTime,
        to: DateTime.now().toEndTime,
      ).toJson(),
    );
  }

  @override
  Future<void> deleteAllBuyLimitOrders() async {
    await _deleteWhen('BUY_LIMIT');
  }

  @override
  Future<void> deleteAllBuyStopOrders() async {
    await _deleteWhen('BUY_STOP');
  }

  @override
  Future<void> deleteAllOrders() async {
    await _deleteWhen('ALL');
  }

  @override
  Future<void> deleteAllSellLimitOrders() async {
    await _deleteWhen('SELL_LIMIT');
  }

  @override
  Future<void> deleteAllSellStopOrders() async {
    await _deleteWhen('SELL_STOP');
  }

  Future<void> _deleteWhen(String event) async {
    final items = await objectBox.orderBox!.getAllAsync();
    for (var item in items) {
      final query = objectBox.symbolBox!
          .query(SymbolModel_.name.contains(item.symbol))
          .build();
      final symbol = query.findFirst();
      query.close();
      if (symbol != null && !symbol.isMarketClose) {
        if (item.direction == event || event == 'ALL') {
          deleteOrder(DeleteOrderRequest(ticket: item.id));
          await Future.delayed(const Duration(milliseconds: 25));
        }
      }
    }
  }

  @override
  void close() {
    listener?.cancel();
  }
}
