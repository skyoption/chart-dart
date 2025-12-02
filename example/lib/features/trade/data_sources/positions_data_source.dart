import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:example/core/consts/constants.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/accountBox.dart';
import 'package:example/core/framework/objectBox.dart';
import 'package:example/core/framework/socket/models/socket_receiver_request.dart';
import 'package:example/core/framework/socket/socket.dart';
import 'package:example/features/main/models/account_balance_model.dart';
import 'package:example/features/main/models/account_credential.dart';
import 'package:example/features/main/models/connected_account_info_entity.dart';
import 'package:example/features/main/models/schema/connected_account_info_model.dart';
import 'package:example/features/symbols/models/schema/symbol_model.dart';
import 'package:example/features/trade/models/position_entity.dart';
import 'package:example/features/trade/models/requests/close_position_request.dart';
import 'package:example/features/trade/models/requests/modify_pos_request.dart';
import 'package:example/features/trade/models/requests/open_position_request.dart';
import 'package:example/features/trade/models/schema/position_model.dart';
import 'package:example/features/trade_history/models/requests/get_history_request.dart';
import 'package:example/objectbox.g.dart';

abstract class PositionsDataSource {
  void getAllPositions();

  Future<List<PositionEntity>> getCachedPositions();

  Future<void> getHistoryPositions();

  Future<void> closeLosingPositions();

  Future<void> closeProfitablePositions();

  Future<void> closeAllPositions();

  Future<void> getHistoryActions();

  void modifyPosition(ModifyPosRequest request);

  void openPosition(OpenPositionRequest request);

  void closePosition(ClosePositionRequest request);

  PositionEntity? getPositionById(int id);

  Future<void> onData({
    required List<SocketEvent> events,
    Function(String message, int? id)? onRequest,
    Function(String message, int? id)? onRequestError,
    Function(PositionEntity item)? onOpenPositionRequest,
    Function(int id)? onClosePositionRequest,
    Function(PositionEntity item)? onModifyPositionRequest,
    Function(ConnectedAccountInfoEntity item)? onAccountInfoRequest,
    Function(List<PositionEntity> items)? onAllPositionRequest,
    Function(double newBalance)? onBalanceUpdate,
    Function(double newCredit)? onCreditUpdate,
    Function(double newMargin)? onMarginUpdate,
    Function(List<PositionEntity> items)? onUpdateSymbol,
  });

  void close();
}

@Injectable(as: PositionsDataSource)
class PositionsDataSourceImp implements PositionsDataSource {
  StreamSubscription? listener;
  final Sockeet socket;
  final ObjectBox objectBox;
  final AccountBox accountBox;

  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
      resetOnError: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
      synchronizable: true,
    ),
  );

  PositionsDataSourceImp(this.socket, this.objectBox, this.accountBox);

  Map<int, PositionEntity> positions = {};

  Map<String, SymbolModel> symbols = {};

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
  Future<List<PositionEntity>> getCachedPositions() async {
    final items = objectBox.positionsBox!.getAll();
    positions = Map.fromEntries(
      items.map((item) => MapEntry(item.id, item.copyToEntity())),
    );
    return positions.values.toList();
  }

  @override
  PositionEntity? getPositionById(int id) {
    return positions[id];
  }

  @override
  Future<void> onData({
    required List<SocketEvent> events,
    Function(String message, int? id)? onRequest,
    Function(String message, int? id)? onRequestError,
    Function(PositionEntity item)? onOpenPositionRequest,
    Function(int id)? onClosePositionRequest,
    Function(PositionEntity item)? onModifyPositionRequest,
    Function(List<PositionEntity> items)? onAllPositionRequest,
    Function(ConnectedAccountInfoEntity item)? onAccountInfoRequest,
    Function(double newBalance)? onBalanceUpdate,
    Function(double newCredit)? onCreditUpdate,
    Function(double newMargin)? onMarginUpdate,
    Function(List<PositionEntity> items)? onUpdateSymbol,
  }) async {
    symbols.clear();
    positions.clear();
    updatedAt = DateTime(1990);
    _fillSymbols();
    listener = socket.onData(
      events: [
        ...events,
        SocketEvent.update_data,
        SocketEvent.subscribe,
        SocketEvent.unsubscribe,
      ],
      onReceiveRequest: (receiver) async {
        kPrint("Event: ${receiver.event}\nData: ${receiver.data}");
        if (!receiver.success && onRequestError != null) {
          onRequestError(receiver.message, receiver.data?['id']);
          return;
        }
        if (receiver.event == SocketEvent.ev_open_pos) {
          await _handleOpenPosition(
            receiver,
            onOpenPositionRequest,
            onUpdateSymbol,
          );
        } else if (receiver.event == SocketEvent.ev_close_pos) {
          await _handleClosePosition(receiver, onClosePositionRequest);
        } else if (receiver.event == SocketEvent.ev_modify_pos) {
          await _handleModifyPosition(receiver, onModifyPositionRequest);
        } else if (receiver.event == SocketEvent.ev_pclose_pos) {
          await _handlePartialClosePosition(receiver, onModifyPositionRequest);
        } else if (receiver.event == SocketEvent.get_all_pos) {
          await _handleAllPositions(receiver, onAllPositionRequest);
        } else if (receiver.event == SocketEvent.ev_acc_updated) {
          kPrint("MARGIN UPDATED :${receiver.data}");
          await _updateBalanceOrEquity(
            receiver.data,
            onBalanceUpdate,
            onCreditUpdate,
            onMarginUpdate,
          );
        } else if (receiver.action ==
            SocketEvent.ev_acc_info.name.toUpperCase()) {
          await _handleAccountInfo(receiver, onAccountInfoRequest);
        } else if (receiver.action ==
            SocketEvent.ev_acc_modified.name.toUpperCase()) {
          await _handleAccountModified(receiver, onAccountInfoRequest);
        } else if (receiver.event == SocketEvent.subscribe ||
            receiver.event == SocketEvent.unsubscribe) {
          await _handleSymbolUpdate();
        } else if (receiver.event == SocketEvent.ev_margin_call) {
          if (onRequest != null) {
            onRequest(receiver.message, receiver.data?['id']);
          }
        }
        _checkSymbols();
        _handleOnRequest(receiver, events, onRequest, onClosePositionRequest);
      },
      onUpdateSymbol: (data) {
        _handleSymbolDataUpdate(data, onUpdateSymbol);
      },
    );
  }

  void _handleOnRequest(
    SocketReceiverRequest receiver,
    List<SocketEvent> events,
    Function(String message, int? id)? onRequest,
    Function(int id)? onClosePositionRequest,
  ) async {
    if (events.contains(receiver.event) &&
        receiver.event.name.contains('ev') &&
        onRequest != null) {
      if (receiver.message == 'Position not found or already closed') {
        _handleClosePositionError(receiver, onClosePositionRequest);
        onRequest('', null);
      } else {
        int? id;
        if (receiver.event == SocketEvent.ev_close_pos) {
          id = receiver.data;
        } else if (receiver.data.isNotEmpty) {
          id = receiver.data?['id'];
        }
        onRequest(receiver.message, id);
      }
    }
  }

  void _handleClosePositionError(
    SocketReceiverRequest receiver,
    Function(int id)? onClosePositionRequest,
  ) async {
    if (onClosePositionRequest != null) {
      onClosePositionRequest(-1);
    }
    getAllPositions();
  }

  Future<void> _handleOpenPosition(
    SocketReceiverRequest receiver,
    Function(PositionEntity item)? onOpenPositionRequest,
    Function(List<PositionEntity> items)? onUpdateSymbol,
  ) async {
    if (onOpenPositionRequest != null) {
      final item = PositionModel.fromJson(receiver.data);
      final position = item.copyToEntity();

      if (positions[item.id] == null) {
        final symbol = symbols[position.groupSymbol];
        if (symbol != null && item.groupSymbol == symbol.name) {
          final value = position.float(symbol);
          if (value != null) {
            position.floating = value;
            position.floatingChange.value = value;
          }
        }

        positions[position.id] = position;
        objectBox.positionsBox!.put(item);
        if (onUpdateSymbol != null) onUpdateSymbol(positions.values.toList());
        getHistoryActions();
        onOpenPositionRequest(position);
      }
    }
  }

  Future<void> _handleClosePosition(
    SocketReceiverRequest receiver,
    Function(int id)? onClosePositionRequest,
  ) async {
    if (onClosePositionRequest == null) return;
    objectBox.positionsBox!.remove(receiver.data);
    onClosePositionRequest(receiver.data);
    getHistoryPositions();
    getHistoryActions();
    positions.remove(receiver.data);
  }

  Future<void> _handleModifyPosition(
    SocketReceiverRequest receiver,
    Function(PositionEntity item)? onModifyPositionRequest,
  ) async {
    if (onModifyPositionRequest != null) {
      final position = positions[receiver.data['id']];
      if (position != null) {
        if (receiver.data['type'] == "SL") {
          position.sl = double.tryParse(receiver.data['value'].toString()) ?? 0;
        } else if (receiver.data['type'] == "TP") {
          position.tp = double.tryParse(receiver.data['value'].toString()) ?? 0;
        }

        objectBox.positionsBox!.put(position.copyToModel());

        onModifyPositionRequest(position);
        getHistoryActions();
      }
    }
  }

  Future<void> _handlePartialClosePosition(
    SocketReceiverRequest receiver,
    Function(PositionEntity item)? onModifyPositionRequest,
  ) async {
    if (onModifyPositionRequest != null) {
      final position = positions[receiver.data['id']];
      if (position != null) {
        position.margin = receiver.data['newMargin'];
        position.volumeCurrent = receiver.data['newVolumeCurrent'];

        objectBox.positionsBox!.put(position.copyToModel());

        onModifyPositionRequest(position);
        getHistoryActions();
        getHistoryPositions();
      }
    }
  }

  Future<void> _handleAllPositions(
    SocketReceiverRequest receiver,
    Function(List<PositionEntity> items)? onAllPositionRequest,
  ) async {
    objectBox.positionsBox!.removeAll();
    if (onAllPositionRequest != null && receiver.data['positions'] != null) {
      List<PositionModel> items = (receiver.data['positions'] as List<dynamic>)
          .map((e) => PositionModel.fromJson(e))
          .toList();

      Map<int, PositionEntity> newPositions = {};
      for (var item in items) {
        PositionEntity position = item.copyToEntity();
        final symbol = symbols[position.groupSymbol];
        if (symbol != null && item.groupSymbol == symbol.name) {
          final value = position.float(symbol);
          if (value != null) {
            position.floating = value;
            position.floatingChange.value = value;
          }
        }
        // else {
        //   subscribeSymbol(item.groupSymbol);
        // }
        newPositions[position.id] = position;
      }
      final data = newPositions.values.toList();
      objectBox.positionsBox!.putMany(
        data.map((e) => e.copyToModel()).toList(),
      );
      onAllPositionRequest(data);
      positions = newPositions;
    }
  }

  Future<void> _handleAccountInfo(
    SocketReceiverRequest receiver,
    Function(ConnectedAccountInfoEntity item)? onAccountInfoRequest,
  ) async {
    if (onAccountInfoRequest != null) {
      final accountInfo = ConnectedAccountInfoModel.fromJson(receiver.data);
      await accountBox.accounts.putAsync(accountInfo);

      onAccountInfoRequest(accountInfo.copyToEntity());
    }
  }

  Future<void> _handleAccountModified(
    SocketReceiverRequest receiver,
    Function(ConnectedAccountInfoEntity item)? onAccountInfoRequest,
  ) async {
    if (onAccountInfoRequest != null) {
      final account = await _updateAccount(receiver.data);
      if (account != null) onAccountInfoRequest(account.copyToEntity());
    }
  }

  Future<void> _handleSymbolUpdate() async {
    await _fillSymbols();
  }

  DateTime updatedAt = DateTime.now();

  Future<void> _handleSymbolDataUpdate(
    String data,
    Function(List<PositionEntity> items)? onUpdateSymbol,
  ) async {
    if (data.contains('&') && positions.isNotEmpty && onUpdateSymbol != null) {
      final values = data.split('&');
      final symbol = symbols[values[0]];
      if (symbol != null) {
        final value = double.tryParse(values[1]) ?? 0.0;
        if (values.last == '1') {
          symbol.ask = double.parse(
            (value + symbol.askDifference).toStringAsFixed(symbol.digits),
          );
        } else {
          symbol.bid = double.parse(
            (value + symbol.bidDifference).toStringAsFixed(symbol.digits),
          );
        }
        final targetPositions = positions.values
            .where((e) => e.groupSymbol == symbol.name)
            .toList();
        for (var item in targetPositions) {
          final value = item.float(symbol);
          if (value != null) {
            item.floating = value;
            item.floatingChange.value = item.floating;
          }
        }

        if (DateTime.now().difference(updatedAt).inSeconds >= 2) {
          final items = positions.values.map((e) => e.copyToModel()).toList();
          objectBox.positionsBox!.putMany(items);
          updatedAt = DateTime.now();
        }
        if (targetPositions.isNotEmpty) onUpdateSymbol(targetPositions);
      }
    }
  }

  Future<void> _updateBalanceOrEquity(
    Map<String, dynamic> data,
    Function(double newBalance)? onBalanceUpdate,
    Function(double newCredit)? onCreditUpdate,
    Function(double newMargin)? onMarginUpdate,
  ) async {
    final results = await _storage.read(key: Constants.USERCACHED);
    if (results != null) {
      final credential = AccountCredential.fromJson(jsonDecode(results));
      final account = await accountBox.accounts.getAsync(credential.id);
      if (account != null) {
        final updateInfo = AccountUpdateModel.fromJson(data);
        if (updateInfo.accountId == account.id) {
          if (updateInfo.balance != null) {
            account.balance = updateInfo.balance!;
          }
          if (updateInfo.credit != null) {
            account.credit = updateInfo.credit!;
          }
          accountBox.accounts.put(account);
        }
        if (updateInfo.balance != null && onBalanceUpdate != null) {
          onBalanceUpdate(updateInfo.balance!);
        }
        if (updateInfo.credit != null && onCreditUpdate != null) {
          onCreditUpdate(updateInfo.credit!);
        }
        if (updateInfo.margin != null && onMarginUpdate != null) {
          onMarginUpdate(updateInfo.margin!);
        }
      }
    }
  }

  Future<ConnectedAccountInfoModel?> _updateAccount(
    Map<String, dynamic> data,
  ) async {
    final results = await _storage.read(key: Constants.USERCACHED);
    if (results != null) {
      final credential = AccountCredential.fromJson(jsonDecode(results));
      final account = accountBox.accounts.get(credential.id);
      if (account != null) {
        if (data['leverage'] != null) {
          account.leverage = data['leverage'];
          socket.send(event: SocketEvent.get_all_pos, data: {});
        }
        if (data['limitPending'] != null) {
          account.limitPending = data['limitPending'];
        }
        if (data['limitPositions'] != null) {
          account.limitPositions = data['limitPositions'];
        }
        if (data['isSwapFree'] != null) {
          account.isSwapFree = data['isSwapFree'];
        }
        if (data['rights'] != null) {
          account.rights = data['rights'];
        }
        if (data['fullName'] != null) {
          account.fullName = data['fullName'];
        }
        accountBox.accounts.put(account);
        return account;
      }
    }
    return null;
  }

  @override
  void openPosition(OpenPositionRequest request) {
    socket.sendRequest(event: SocketEvent.open_pos, data: request.toJson());
  }

  @override
  void closePosition(ClosePositionRequest request) {
    socket.sendRequest(event: SocketEvent.close_pos, data: request.toJson());
  }

  @override
  void close() {
    listener?.cancel();
  }

  @override
  void modifyPosition(ModifyPosRequest request) {
    socket.sendRequest(event: SocketEvent.modify_pos, data: request.toJson());
  }

  Future<void> _checkSymbols() async {
    final positionSymbols = positions.values.map((e) => e.groupSymbol).toSet();
    final existingSymbols =
        objectBox.symbolBox!.getAll().map((e) => e.name).toSet();

    final missingSymbols = positionSymbols.difference(existingSymbols);

    for (final symbol in missingSymbols) {
      subscribeSymbol(symbol);
    }
  }

  void subscribeSymbol(String symbol) {
    socket.send(event: SocketEvent.subscribe, data: {'symbol': symbol});
  }

  @override
  Future<void> getHistoryPositions() async {
    socket.send(
      event: SocketEvent.get_history_pos,
      data: GetHistoryRequest(
        from: DateTime.now().subtract(const Duration(days: 7)).toStartTime,
        to: DateTime.now().toEndTime,
      ).toJson(),
    );
  }

  @override
  Future<void> getHistoryActions() async {
    socket.send(
      event: SocketEvent.get_actions,
      data: GetHistoryRequest(
        from: DateTime.now().subtract(const Duration(days: 7)).toStartTime,
        to: DateTime.now().toEndTime,
      ).toJson(),
    );
  }

  @override
  Future<void> closeAllPositions() async {
    if (objectBox.positionsBox == null) return;
    final items = objectBox.positionsBox!.getAll();
    for (var item in items) {
      final query = objectBox.symbolBox!
          .query(SymbolModel_.name.contains(item.groupSymbol))
          .build();
      final symbol = query.findFirst();
      query.close();
      if (symbol != null && !symbol.isMarketClose) {
        kPrint(symbol.isMarketClose);
        closePosition(
          ClosePositionRequest(
            id: item.id,
            sl: item.sl,
            tp: item.tp,
            volume: item.volumeCurrent,
          ),
        );
        await Future.delayed(const Duration(milliseconds: 30));
      }
    }
  }

  @override
  Future<void> closeLosingPositions() async {
    if (objectBox.positionsBox == null) return;
    final items = objectBox.positionsBox!.getAll();
    for (var item in items) {
      final query = objectBox.symbolBox!
          .query(SymbolModel_.name.contains(item.groupSymbol))
          .build();
      final symbol = query.findFirst();
      query.close();
      if (symbol != null && !symbol.isMarketClose) {
        kPrint(symbol.isMarketClose);
        if (item.floating < 0) {
          closePosition(
            ClosePositionRequest(
              id: item.id,
              sl: item.sl,
              tp: item.tp,
              volume: item.volumeCurrent,
            ),
          );
          await Future.delayed(const Duration(milliseconds: 30));
        }
      }
    }
  }

  @override
  Future<void> closeProfitablePositions() async {
    if (objectBox.positionsBox == null) return;
    final items = objectBox.positionsBox!.getAll();
    for (var item in items) {
      final query = objectBox.symbolBox!
          .query(SymbolModel_.name.contains(item.groupSymbol))
          .build();
      final symbol = query.findFirst();
      query.close();
      if (symbol != null && !symbol.isMarketClose) {
        kPrint(symbol.isMarketClose);
        if (item.floating > 0) {
          closePosition(
            ClosePositionRequest(
              id: item.id,
              sl: item.sl,
              tp: item.tp,
              volume: item.volumeCurrent,
            ),
          );
          await Future.delayed(const Duration(milliseconds: 30));
        }
      }
    }
  }

  @override
  void getAllPositions() {
    socket.send(event: SocketEvent.get_all_pos, data: {});
  }
}
