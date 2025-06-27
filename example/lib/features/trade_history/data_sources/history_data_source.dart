import 'dart:async';

import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/objectBox.dart';
import 'package:example/core/framework/socket/models/socket_receiver_request.dart';
import 'package:example/core/framework/socket/socket.dart';
import 'package:example/features/trade_history/models/history.dart';
import 'package:example/features/trade_history/models/history_action_entity.dart';
import 'package:example/features/trade_history/models/history_pending_entity.dart';
import 'package:example/features/trade_history/models/history_position_entity.dart';
import 'package:example/features/trade_history/models/requests/get_history_request.dart';
import 'package:example/features/trade_history/models/schema/account_founds_model.dart';
import 'package:example/features/trade_history/models/schema/history_actions_model.dart';
import 'package:example/features/trade_history/models/schema/history_pending_model.dart';
import 'package:example/features/trade_history/models/schema/history_position_model.dart';

abstract class HistoryDataSource {
  Future<List<HistoryPositionEntity>> getCachedPositions();

  Future<List<HistoryPendingEntity>> getCachedPending();

  Future<List<HistoryActionEntity>> getCachedActions();

  void getAllPositions({
    required int from,
    required int to,
  });

  void getAllPending({
    required int from,
    required int to,
  });

  void getAllActions({
    required int from,
    required int to,
  });

  void onData({
    required List<SocketEvent> events,
    Function(List<HistoryPositionEntity> items)? onAllPositionsRequest,
    Function(List<HistoryActionEntity> items)? onAllActionsRequest,
    Function(List<HistoryPendingEntity> items)? onAllPendingRequest,
    Function(List<History> items)? onAccountFoundsRequest,
  });

  void close();
}

@Injectable(as: HistoryDataSource)
class HistoryDataSourceImp implements HistoryDataSource {
  StreamSubscription? listener;
  final Sockeet socket;
  final ObjectBox objectBox;

  HistoryDataSourceImp(this.socket, this.objectBox);

  List<HistoryPendingEntity> pending = [];
  List<HistoryPositionEntity> positions = [];
  List<History> founds = [];
  List<HistoryActionEntity> actions = [];

  @override
  void getAllPositions({
    required int from,
    required int to,
  }) {
    socket.send(
      event: SocketEvent.get_history_pos,
      data: GetHistoryRequest(from: from, to: to).toJson(),
    );
  }

  @override
  Future<List<HistoryPositionEntity>> getCachedPositions() async {
    final items = objectBox.historyPositionBox!.getAll();
    positions = items.map((item) => item.copyToEntity()).toList();
    return positions;
  }

  @override
  Future<List<HistoryPendingEntity>> getCachedPending() async {
    final items = objectBox.historyPendingBox!.getAll();
    items.sort((a, b) => (b.id).compareTo(a.id));
    pending = items.map((item) => item.copyToEntity()).toList();
    return pending;
  }

  @override
  Future<List<HistoryActionEntity>> getCachedActions() async {
    final items = objectBox.historyActionBox!.getAll();
    items.sort((a, b) => (b.id).compareTo(a.id));
    actions = items.map((item) => item.copyToEntity()).toList();
    return actions;
  }

  @override
  void getAllActions({
    required int from,
    required int to,
  }) {
    socket.send(
      event: SocketEvent.get_actions,
      data: GetHistoryRequest(from: from, to: to).toJson(),
    );
  }

  @override
  void getAllPending({
    required int from,
    required int to,
  }) async {
    socket.send(
      event: SocketEvent.get_history_pending,
      data: GetHistoryRequest(from: from, to: to).toJson(),
    );
  }

  @override
  void onData({
    required List<SocketEvent> events,
    Function(List<HistoryPositionEntity> items)? onAllPositionsRequest,
    Function(List<HistoryActionEntity> items)? onAllActionsRequest,
    Function(List<HistoryPendingEntity> items)? onAllPendingRequest,
    Function(List<History> items)? onAccountFoundsRequest,
  }) {
    pending.clear();
    positions.clear();
    founds.clear();
    actions.clear();
    listener = socket.onData(
      events: events,
      onReceiveRequest: (receiver) async {
        kPrint(receiver.data);

        if (receiver.event == SocketEvent.get_history_pos) {
          _handleHistoryPositions(
            receiver,
            onAllPositionsRequest,
            onAccountFoundsRequest,
          );
        }

        if (receiver.event == SocketEvent.get_actions) {
          _handleHistoryActions(receiver, onAllActionsRequest);
        }

        if (receiver.event == SocketEvent.get_history_pending) {
          _handleHistoryPending(receiver, onAllPendingRequest);
        }
      },
    );
  }

  void _handleHistoryPositions(
    SocketReceiverRequest receiver,
    Function(List<HistoryPositionEntity> items)? onAllPositionsRequest,
    Function(List<History> items)? onAccountFoundsRequest,
  ) async {
    if (receiver.data['history'] != null && onAllPositionsRequest != null) {
      List<HistoryPositionModel> items =
          (receiver.data['history'] as List<dynamic>)
              .map((e) => HistoryPositionModel.fromJson(e))
              .toList();

      objectBox.historyPositionBox!.removeAll();
      objectBox.historyPositionBox!.putMany(items);

      positions = items.map((item) => item.copyToEntity()).toList();
      onAllPositionsRequest(positions);
    }

    if (receiver.data['accountFunds'] != null &&
        onAccountFoundsRequest != null) {
      List<AccountFoundsModel> items =
          (receiver.data['accountFunds'] as List<dynamic>)
              .map((e) => AccountFoundsModel.fromJson(e))
              .toList();
      items.sort((a, b) => (b.id).compareTo(a.id));

      objectBox.accountFoundsBox!.putMany(items);

      founds = items.map((item) => item.copyToEntity()).toList();
      onAccountFoundsRequest(founds);
    }
  }

  void _handleHistoryActions(
    SocketReceiverRequest receiver,
    Function(List<HistoryActionEntity> items)? onAllActionsRequest,
  ) async {
    if (receiver.data['actions'] != null && onAllActionsRequest != null) {
      List<HistoryActionModel> items =
          (receiver.data['actions'] as List<dynamic>)
              .map((e) => HistoryActionModel.fromJson(e))
              .toList();
      items.sort((a, b) => (b.id).compareTo(a.id));

      objectBox.historyActionBox!.removeAll();
      objectBox.historyActionBox!.putMany(items);

      actions = items.map((item) => item.copyToEntity()).toList();
      onAllActionsRequest(actions);
    }
  }

  void _handleHistoryPending(
    SocketReceiverRequest receiver,
    Function(List<HistoryPendingEntity> items)? onAllPendingRequest,
  ) async {
    if (receiver.data['pendingHistory'] != null &&
        onAllPendingRequest != null) {
      List<HistoryPendingModel> items =
          (receiver.data['pendingHistory'] as List<dynamic>)
              .map((e) => HistoryPendingModel.fromJson(e))
              .toList();
      items.sort((a, b) => (b.id).compareTo(a.id));

      objectBox.historyPendingBox!.removeAll();
      objectBox.historyPendingBox!.putMany(items);

      pending = items.map((item) => item.copyToEntity()).toList();
      onAllPendingRequest(pending);
    }
  }

  @override
  void close() {
    listener?.cancel();
  }
}
