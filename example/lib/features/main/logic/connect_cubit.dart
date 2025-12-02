import 'dart:async';

import 'package:example/core/consts/exports.dart';
import 'package:example/core/enums/user_permissions.dart';
import 'package:example/core/framework/socket/models/socket_receiver_request.dart';
import 'package:example/core/framework/socket/socket.dart';
import 'package:example/features/main/data_source/connected_account_data_source.dart';
import 'package:example/features/main/models/account_credential.dart';
import 'package:example/features/main/models/connected_account_info_entity.dart';
import 'package:example/features/platform_settings/logic/trading_logs_cubit.dart';
import 'package:example/injection/injectable.dart';
import 'package:web_socket_client/web_socket_client.dart' as socket;

///[ConnectCubit]
///[Implementation]
@singleton
class ConnectCubit extends Cubit<FlowState> {
  final GlobalKey<FormState>? loginFormKey;
  final TextEditingController number;
  final TextEditingController? password;
  String? serverUrl;
  final ConnectedAccountDataSource loginDataSource;
  final List<SocketReceiverRequest> receives = [];

  bool hasLoggedOut = false;
  bool isSwitching = false;
  int? _previousAccountId;
  AccountCredential? _previousAccountCredential;

  ValueNotifier<socket.ConnectionState?> get socketState =>
      loginDataSource.socket.state;

  ValueNotifier<bool> hasTradePermission = ValueNotifier(false);
  ValueNotifier<ConnectedAccountInfoEntity?> accountInfo = ValueNotifier(null);

  ConnectCubit(
    this.loginDataSource,
    this.number, {
    this.password,
    this.loginFormKey,
  }) : super(const FlowState()) {
    userLoggedIn.then((value) {
      if (value != null) {
        getIt<TradingLogsCubit>().accountId = value.id;
      }
    });
  }

  Future<AccountCredential?> get userLoggedIn async =>
      await loginDataSource.hasUser;

  Future<void> execute({
    required Function onConnected,
    String? serverUrl,
  }) async {
    hasLoggedOut = false;
    // validate only if formKey exists
    if (loginFormKey == null || loginFormKey!.currentState!.validate()) {
      await connect(
        serverUrl: serverUrl,
        number: number.text,
        password: password?.text,
        isLogin: true,
        onConnected: onConnected,
      );
    }
  }

  Future<void> connect({
    required String number,
    String? serverUrl,
    String? password,
    required bool isLogin,
    required Function onConnected,
    Function? refresh,
    bool showError = true,
    bool isSwitch = false,
    bool isSkyTrade = false,
  }) async {
    if (isSwitch) {
      emit(state.copyWith(type: StateType.success, data: Data.secure));
    } else {
      emit(state.copyWith(type: StateType.loadingPopUp));
    }
    if (isSwitch) {
      if (number == accountInfo.value?.id.toString()) {
        if (isSkyTrade) {
          emit(
            state.copyWith(
              type: StateType.errorPopUp,
              message: "Account already exists",
            ),
          );
        }
        return;
      }
      _previousAccountId = accountInfo.value?.id;
      // Store previous account credentials for fail-safe reconnection
      final previousId = _previousAccountId;
      if (previousId != null && isSkyTrade) {
        // Get the current account's credentials (includes the password type being used)
        final currentCredentials = await loginDataSource.getLoginData();
        if (currentCredentials != null && currentCredentials.id == previousId) {
          _previousAccountCredential = currentCredentials;
          kPrint(
            "Stored previous account credentials for fail-safe: $previousId (password type: ${currentCredentials.password != null ? 'stored' : 'token'})",
          );
        } else {
          _previousAccountCredential =
              await loginDataSource.getAccountCredentials(previousId);
          kPrint(
            "Stored previous account credentials for fail-safe: $previousId (from stored)",
          );
        }
      }
      kPrint("Switching Account..");
      kPrint("Server URL: $serverUrl");
      kPrint("Number: $number");
      kPrint("Password: $password");
      kPrint("SwitchUrl ${getIt<Sockeet>().socketUrl}");
    }
    loginDataSource.connect(
      id: number,
      serverUrl: serverUrl,
      password: password,
      isLogin: isLogin,
      onConnected: () {
        hasLoggedOut = false;
        if (isSwitch) {
          isSwitching = false;
          _previousAccountCredential = null;
          _previousAccountId = null;
        }
        getIt<TradingLogsCubit>().accountId = int.tryParse(number) ?? 0;
        onConnected();
        emit(state.copyWith(type: StateType.success, data: Data.secure));
      },
      onDisconnected: () async {
        if (isSwitch) {
          isSwitching = false;
          if (_previousAccountId != null &&
              _previousAccountCredential != null &&
              isSkyTrade) {
            kPrint(
              "Account switch failed. Reconnecting to previous account: $_previousAccountId",
            );
            emit(
              state.copyWith(
                type: StateType.errorPopUp,
                message: "Account switch failed. Invalid credentials",
              ),
            );
            try {
              await connect(
                number: _previousAccountId.toString(),
                password: _previousAccountCredential!.password,
                serverUrl: _previousAccountCredential!.serverUrl,
                isLogin: true,
                showError: false,
                isSwitch: false,
                onConnected: () {
                  kPrint(
                    "Successfully reconnected to previous account: $_previousAccountId",
                  );
                  onConnected();
                  _previousAccountCredential = null;
                  _previousAccountId = null;
                  if (refresh != null) refresh();
                },
              );
            } catch (e) {
              kPrint("Failed to reconnect to previous account: $e");
              _previousAccountCredential = null;
              _previousAccountId = null;
              if (showError && !hasLoggedOut) {
                emit(
                  state.copyWith(
                    type: StateType.errorPopUp,
                    message: "Failed to switch account. Please try again.",
                  ),
                );
              } else {
                emit(state.copyWith(type: StateType.none));
              }
            }
          } else {
            // No previous account to reconnect to
            if (showError && !hasLoggedOut) {
              if (isSkyTrade) {
                emit(
                  state.copyWith(
                    type: StateType.errorPopUp,
                    message: "Please enter valid data",
                  ),
                );
              }
            } else {
              emit(state.copyWith(type: StateType.none));
            }
          }
        } else {
          if (showError && !hasLoggedOut) {
            emit(
              state.copyWith(
                type: StateType.errorPopUp,
                message: "Please enter valid data",
              ),
            );
          } else {
            emit(state.copyWith(type: StateType.none));
          }
        }
      },
    );
  }

  Future<void> directConnect({
    required Function onConnected,
    bool openLocalDatabase = true,
  }) async {
    if (socketState.value == null || socketState.value!.isDisconnected) {
      loginDataSource.directConnect(
        openLocalDatabase: openLocalDatabase,
        onConnected: () async {
          onConnected();
        },
        onDisconnected: () {
          kPrint("Socket Lost Connection");
        },
      );
    } else {
      onConnected();
    }
  }

  Future<void> switchAccount({
    required int id,
    String? password,
    String? serverUrl,
    bool isSkyTrade = false,
    required ValueChanged<AccountCredential> onSwitch,
  }) async {
    if (id == accountInfo.value?.id && isSkyTrade) {
      emit(
        state.copyWith(
          type: StateType.errorPopUp,
          message: "Account already exists",
        ),
      );
      return;
    }
    if (isSwitching) {
      kPrint("Account switch already in progress, ignoring request");
      return;
    }
    isSwitching = true;
    try {
      final value = await loginDataSource.updateDefaultAccount(
        id: id,
        password: password,
        serverUrl: serverUrl,
      );
      if (value != null) {
        hasLoggedOut = true;
        kPrint("Switched Account To $id");
        getIt<TradingLogsCubit>().log("Switched Account To $id");
        onSwitch(value);
      } else {
        kPrint("Switch Failed..");
        isSwitching = false;
      }
    } catch (e) {
      kPrint("Switch error: $e");
      isSwitching = false;
      rethrow;
    }
  }

  Future<void> deleteAccount({
    required int id,
    required Function onDeleted,
  }) async {
    await loginDataSource.deleteAccount(id: id, onDeleted: onDeleted).then(
          (_) =>
              getIt<TradingLogsCubit>().log("Removed $id From Stored Accounts"),
        );
  }

  Future<void> logout({required Function() onLogout}) async {
    await loginDataSource.logout(
      onLogout: () {
        loginDataSource.clearAllAccounts(
          onCleared: () {
            hasLoggedOut = true;
            hasTradePermission.value = false;
            accountInfo.value = null;
            getIt<TradingLogsCubit>().log("Logged out");
            onLogout();
          },
        );
      },
    );
  }

  void closeSocket() => loginDataSource.closeSocket();

  void setAccountInfo(ConnectedAccountInfoEntity accountInfo) {
    this.accountInfo.value = accountInfo;
    hasTradePermission.value = hasPermission(UserPermissions.trade);
  }

  void updateDefaultAccountBalance(double balance) {
    accountInfo.value?.balance = balance;
  }

  bool hasPermission(UserPermissions permission) {
    return accountInfo.value?.rights?.hasPermission(permission) ?? false;
  }

  bool get canTrade => hasPermission(UserPermissions.trade);

  void clear() {
    hasLoggedOut = false;
    isSwitching = false;
    _previousAccountId = null;
    _previousAccountCredential = null;
    accountInfo.value = null;
    hasTradePermission.value = false;
  }

  void dispose() => loginDataSource.close();
}
