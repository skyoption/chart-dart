import 'dart:async' as async;
import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:example/core/consts/constants.dart';
import 'package:example/core/enums/user_permissions.dart';
import 'package:example/core/framework/accountBox.dart';
import 'package:example/core/framework/app_info.dart';
import 'package:example/core/framework/device_info.dart';
import 'package:example/core/framework/objectBox.dart';
import 'package:example/core/framework/socket/models/socket_receiver_request.dart';
import 'package:example/core/framework/socket/models/socket_sender_request.dart';
import 'package:example/features/platform_settings/logic/platform_settings_cubit.dart';
import 'package:example/features/platform_settings/logic/trading_logs_cubit.dart';
import 'package:example/injection/injectable.dart';
import 'package:example/objectbox.g.dart';
import 'package:web_socket_client/web_socket_client.dart' as socket;

enum SocketEvent {
  ///[useCase]
  subscribe,
  unsubscribe,
  symbol_update,
  update_data,
  get_all_symbols,
  get_chart_data,
  open_pos,
  modify_pos,
  modify_pending,
  del_pending,
  open_pending,
  close_pos,
  get_all_pos,
  get_all_pending,
  get_history_pos,
  get_actions,
  get_history_pending,

  ///[Events]
  ev_open_pos,
  ev_modify_pos,
  ev_modify_pending,
  ev_del_pending,
  ev_open_pending,
  ev_close_pos,
  ev_pclose_pos,
  ev_margin_call,

  ///[Account]
  ev_acc_info,
  ev_acc_updated,
  ev_acc_modified,
}

@lazySingleton
class Sockeet {
  socket.WebSocket? _socket;
  final SharedPreferences sharedPreferences;
  final ObjectBox objectBox;
  final AccountBox accountBox;

  // Use Map for efficient lookup and automatic cleanup
  final Map<int, SocketSenderRequest> _pendingRequests = {};
  final Map<int, SocketReceiverRequest> _recentReceives = {};

  // Configuration for list size management
  static const int maxPendingRequests = 1000;
  static const int maxRecentReceives = 500;
  static const Duration requestTimeout = Duration(minutes: 5);
  static const Duration receiveCleanupInterval = Duration(minutes: 10);

  List<async.StreamSubscription> listeners = [];
  async.Timer? _cleanupTimer;
  String? socketUrl;
  String? _lastAccountNumber;
  Function? _onConnectedCallback;
  Function? _onDisconnectedCallback;
  bool _isReconnecting = false;
  async.Completer<void>? _reconnectCompleter;
  int _reconnectAttempts = 0;
  static const int maxReconnectAttempts = 5;
  bool _isLogin = false;
  String? _password;
  Sockeet({
    required this.accountBox,
    required this.objectBox,
    required this.sharedPreferences,
  }) {
    _startPeriodicCleanup();
  }

  bool get isConnected =>
      _socket?.connection.state != null &&
      _socket!.connection.state is socket.Connected;

  late ValueNotifier<socket.ConnectionState?> state = ValueNotifier(null);

  bool get isDisconnected => _socket?.connection.state is socket.Disconnected;

  // Getters for (read-only access)
  List<SocketSenderRequest> get requests => _pendingRequests.values.toList();

  List<SocketReceiverRequest> get receives => _recentReceives.values.toList();

  void _startPeriodicCleanup() {
    _cleanupTimer = async.Timer.periodic(receiveCleanupInterval, (_) {
      _cleanupExpiredRequests();
      _cleanupOldReceives();
    });
  }

  void _cleanupExpiredRequests() {
    final now = DateTime.now().millisecondsSinceEpoch;
    final timeoutMs = requestTimeout.inMilliseconds;

    _pendingRequests.removeWhere((requestId, request) {
      final isExpired = (now - requestId) > timeoutMs;
      if (isExpired) {
        kPrint("Removing expired request: $requestId");
      }
      return isExpired;
    });
  }

  void _cleanupOldReceives() {
    if (_recentReceives.length > maxRecentReceives) {
      // Keep only the most recent entries
      final sortedKeys = _recentReceives.keys.toList()..sort();
      final keysToRemove = sortedKeys.take(
        _recentReceives.length - maxRecentReceives,
      );

      for (final key in keysToRemove) {
        _recentReceives.remove(key);
      }
    }
  }

  void _addPendingRequest(SocketSenderRequest request) {
    // Prevent unlimited growth
    if (_pendingRequests.length >= maxPendingRequests) {
      final oldestKey = _pendingRequests.keys.reduce(math.min);
      _pendingRequests.remove(oldestKey);
    }

    _pendingRequests[request.requestId] = request;
  }

  void _addReceive(SocketReceiverRequest receive) {
    // Only store receives with valid request IDs for correlation
    if (receive.requestId != 0) {
      _recentReceives[receive.requestId] = receive;

      // Remove corresponding pending request if it exists
      _pendingRequests.remove(receive.requestId);
    }
  }

  SocketSenderRequest? getPendingRequest(int requestId) {
    return _pendingRequests[requestId];
  }

  SocketReceiverRequest? getReceive(int requestId) {
    return _recentReceives[requestId];
  }

  void clearAllRequests() {
    _pendingRequests.clear();
    _recentReceives.clear();
  }

  Future<void> connect({
    required String accountNumber,
    required Function onConnected,
    required Function onDisconnected,
    String? password,
    bool isLogin = false,
    bool openLocalDatabase = true,
    String? serverUrl,
  }) async {
    _lastAccountNumber = accountNumber;
    _onConnectedCallback = onConnected;
    _onDisconnectedCallback = onDisconnected;
    _isLogin = isLogin;
    _password = password;
    if (serverUrl != null && serverUrl.isNotEmpty && serverUrl != socketUrl) {
      socketUrl = serverUrl;
      kPrint("SOCKET URL CHANGED TO : $socketUrl");
    }

    if (openLocalDatabase) await objectBox.create(accountNumber);

    await _connect(
      password: password,
      accountNumber: accountNumber,
      onConnected: onConnected,
      onDisconnected: onDisconnected,
      isLogin: isLogin,
    );
  }

  Future<void> _reconnectOnce() async {
    if (_isReconnecting ||
        _lastAccountNumber == null ||
        _onConnectedCallback == null ||
        _onDisconnectedCallback == null) {
      return;
    }

    _isReconnecting = true;
    _reconnectCompleter = async.Completer<void>();

    try {
      kPrint("Reconnecting.. Attempt $_reconnectAttempts");

      for (var listener in listeners) {
        await listener.cancel();
      }
      listeners.clear();

      await _connect(
        accountNumber: _lastAccountNumber!,
        onConnected: _onConnectedCallback!,
        password: _password,
        onDisconnected: _onDisconnectedCallback!,
        isLogin: _isLogin,
      );

      _reconnectAttempts = 0;
    } catch (e) {
      kPrint('Reconnection failed: $e');
      _reconnectCompleter?.completeError(e);
    } finally {
      kPrint("Reconnected Successfully..");
      _isReconnecting = false;
      if (!(_reconnectCompleter?.isCompleted ?? true)) {
        _reconnectCompleter?.complete();
      }
      _reconnectCompleter = null;
    }
  }

  Future<void> ensureConnected() async {
    if (isConnected) return;

    if (_isReconnecting && _reconnectCompleter != null) {
      await _reconnectCompleter?.future;
    } else if (isDisconnected) {
      await _reconnectOnce();
    }
  }

  async.StreamSubscription<socket.ConnectionState>? listener;

  void _addStream({
    required String accountNumber,
    required Function onConnected,
    required Function onDisconnected,
    bool isLogin = false,
  }) async {
    if (listener != null) await listener!.cancel();
    listener = _socket?.connection.listen(
      (event) {
        state.value = event;

        if (event is socket.Disconnected && !isLogin) {
          if (_reconnectAttempts < maxReconnectAttempts) {
            final backoff = Duration(
              seconds: math.pow(2, _reconnectAttempts).toInt(),
            );
            async.Timer(backoff, () {
              _reconnectAttempts++;
              _reconnectOnce();
            });
          } else {
            kPrint("Max reconnect attempts reached.");
          }
        }

        if (event is socket.Disconnected && isLogin) {
          onDisconnected();
        }
        if (event is socket.Connected) {
          if (_reconnectCompleter != null &&
              !_reconnectCompleter!.isCompleted) {
            _reconnectCompleter!.complete();
          }
          if (isLogin) {
            onConnected();
          }
        }
      },
      onError: (error) {
        kPrint(error);
        if (_reconnectCompleter != null && !_reconnectCompleter!.isCompleted) {
          _reconnectCompleter!.completeError(error);
        }
        onDisconnected();
      },
      onDone: () => kPrint("Connection stream done"),
      cancelOnError: true,
    );
  }

  Future<void> _connect({
    required String accountNumber,
    required Function onConnected,
    required Function onDisconnected,
    String? password,
    bool isLogin = false,
  }) async {
    getIt<TradingLogsCubit>().accountId = int.parse(accountNumber);
    if (_socket?.connection.state is socket.Connected) {
      _socket?.close();
      _socket = null;
      clearListeners();
    }
    final token = sharedPreferences.getString(Constants.TOKENCACHED) ?? '';
    final query = accountBox.accounts
        .query(ConnectedAccountInfoModel_.id.equals(int.parse(accountNumber)))
        .build();
    final account = query.findFirst();
    final isRights = account != null &&
        account.rights!.hasPermission(UserPermissions.connect);
    if (isRights || account == null) {
      Map<String, dynamic> params = {'username': accountNumber};
      if (password != null) {
        params['password'] = password;
      } else {
        params['token'] = token.replaceAll(' ', '').replaceAll('Bearer', '');
      }
      final device = await DeviceInfo.getInfo();
      params['fcmToken'] = device.fcmToken ?? '';
      params['deviceId'] = device.id;
      params['deviceType'] = device.type;
      params['enableNotification'] =
          getIt<PlatformSettingsCubit>().settings.tradePositionNotification;
      params['appVersion'] = AppInfo.version;
      kPrint(params);
      _socket = socket.WebSocket(
        Uri.parse(socketUrl ?? Constants.SOCKETURL),
        headers: params,
      );
      kPrint("SelectedSocketURL : $socketUrl");
      _addStream(
        accountNumber: accountNumber,
        onConnected: onConnected,
        onDisconnected: onDisconnected,
        isLogin: isLogin,
      );
    }
  }

  async.StreamSubscription? onData({
    required Function(SocketReceiverRequest receiver) onReceiveRequest,
    Function(String receiver)? onUpdateSymbol,
    required List<SocketEvent> events,
  }) {
    final listener = _socket?.messages.listen(
      (data) {
        try {
          if (data.toString().contains('&') &&
              !data.toString().contains('{') &&
              events.contains(SocketEvent.update_data) &&
              onUpdateSymbol != null) {
            onUpdateSymbol(data);
          } else if (data.toString().contains('{')) {
            final json = jsonDecode(data);
            final receiver = SocketReceiverRequest.fromJson(json);
            if (events.contains(receiver.event)) {
              _addReceive(receiver);
              onReceiveRequest(receiver);
            }
          }
        } catch (e) {
          kPrint("Failed to parse JSON: $data. Error: $e");
        }
      },
      onError: (error) => kPrint("Socket message error: $error"),
      onDone: () {},
    );

    if (listener != null) listeners.add(listener);
    return listener;
  }

  Future<void> sendRequest({
    required SocketEvent event,
    required Map<String, dynamic> data,
  }) async {
    try {
      await ensureConnected();
      if (!isConnected) return;
      final request = SocketSenderRequest(
        requestId: DateTime.now().millisecondsSinceEpoch,
        data: data,
        action: event.name.toUpperCase(),
      );
      _addPendingRequest(request);
      _socket?.send(jsonEncode(request.toJson()));
      kPrint("Sending request: ${event.name.toUpperCase()}\nBody: $data");
    } catch (e) {
      kPrint("Failed to send request: $e");
    }
  }

  Future<void> send({
    required SocketEvent event,
    Map<String, dynamic>? data,
  }) async {
    try {
      await ensureConnected();
      if (!isConnected) return;
      final request = {
        "action": event.name.toUpperCase(),
        if (data != null) "data": data,
      };
      kPrint("Sending request: ${event.name.toUpperCase()}\nBody: $data");
      _socket?.send(jsonEncode(request));
    } catch (e) {
      kPrint("Send failed: $e");
    }
  }

  void clearListeners() {
    for (var listener in listeners) {
      listener.cancel();
    }
    listeners.clear();
  }

  void disconnect() {
    // Clean up timer
    _cleanupTimer?.cancel();
    _cleanupTimer = null;

    // Clean up listeners
    clearListeners();
    // Clean up socket
    _socket?.close();
    _socket = null;

    // Clear all requests and receives
    clearAllRequests();

    // Reset state
    _lastAccountNumber = null;
    _onConnectedCallback = null;
    _onDisconnectedCallback = null;
    _reconnectCompleter = null;
    _isReconnecting = false;
    _reconnectAttempts = 0;
    _isLogin = false;
  }
}
