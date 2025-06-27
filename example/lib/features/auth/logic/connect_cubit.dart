import 'dart:async';

import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/socket/models/socket_receiver_request.dart';
import 'package:example/features/auth/data_source/connected_account_data_source.dart';
import 'package:example/features/auth/models/account_credential.dart';
import 'package:example/features/auth/models/connected_account_info_entity.dart';
import 'package:example/features/settings/logic/trading_logs_cubit.dart';
import 'package:example/injection/injectable.dart';
import 'package:web_socket_client/web_socket_client.dart' as socket;

///[ConnectCubit]
///[Implementation]
@singleton
class ConnectCubit extends Cubit<FlowState> {
  ///[LoginUseCase]
  final GlobalKey<FormState> loginFormKey;
  final TextEditingController number;
  final TextEditingController password;
  final List<SocketReceiverRequest> receives = [];
  final ConnectedAccountDataSource loginDataSource;
  bool hasLoggedOut = false;

  ValueNotifier<ConnectedAccountInfoEntity?> accountInfo = ValueNotifier(null);

  ValueNotifier<socket.ConnectionState?> get socketState =>
      loginDataSource.socket.state;

  ConnectCubit(
    this.loginFormKey,
    this.number,
    this.password,
    this.loginDataSource,
  ) : super(const FlowState()) {
    userLoggedIn.then(
      (value) {
        if (value != null) {
          getIt<TradingLogsCubit>().accountId = value.id;
        }
      },
    );
  }

  Future<AccountCredential?> get userLoggedIn async =>
      await loginDataSource.hasUser;

  Future<void> execute({required Function onConnected}) async {
    hasLoggedOut = false;
    if (loginFormKey.currentState!.validate()) {
      await connect(
        isLogin: true,
        number: number.text,
        password: password.text,
        onConnected: onConnected,
      );
    }
  }

  Future<void> connect({
    required String number,
    required String password,
    required Function onConnected,
    Function? refresh,
    required bool isLogin,
    bool showError = true,
  }) async {
    emit(state.copyWith(type: StateType.loadingPopUp, data: Data.secure));
    loginDataSource.connect(
      id: number,
      password: password,
      isLogin: isLogin,
      onConnected: () {
        hasLoggedOut = false;
        loginDataSource.init(onRequest: (value) {
          accountInfo.value = value;
          if (refresh != null) refresh();
        });
        getIt<TradingLogsCubit>().accountId = int.parse(number);
        kPrint("Connected Done");
        onConnected();
        emit(state.copyWith(type: StateType.success));
      },
      onDisconnected: () {
        if (showError && !hasLoggedOut) {
          emit(
            state.copyWith(
              type: StateType.errorPopUp,
              message: "Please enter valid data",
            ),
          );
        } else {
          emit(state.copyWith(data: Data.secure));
        }
      },
    );
  }

  Future<void> directConnect({
    required Function onConnected,
    bool openLocalDatabase = true,
  }) async {
    if (socketState.value == null || socketState.value.isDisconnected) {
      loginDataSource.directConnect(
        openLocalDatabase: openLocalDatabase,
        onConnected: onConnected,
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
    required ValueChanged<AccountCredential> onSwitch,
  }) async {
    final value = await loginDataSource.getAccountInfo(id: id);
    if (value != null) {
      hasLoggedOut = true;
      getIt<TradingLogsCubit>().log("Switched Account To $id");
      onSwitch(value);
    } else {
      kPrint("Switch Failed..");
    }
  }

  Future<void> deleteAccount({
    required int id,
    required Function onDeleted,
  }) async {
    await loginDataSource.deleteAccount(id: id, onDeleted: onDeleted).then(
      (value) {
        getIt<TradingLogsCubit>().log("Removed $id From Stored Accounts");
      },
    );
  }

  Future<void> logout({
    required Function() onLogout,
  }) async {
    await loginDataSource.logout(onLogout: () {
      hasLoggedOut = true;
      getIt<TradingLogsCubit>().log("Logged out");
      onLogout();
    });
  }

  void closeSocket() {
    loginDataSource.closeSocket();
  }

  void updateDefaultAccountBalance(double balance) {
    accountInfo.value?.balance = balance;
  }

  void dispose() {
    loginDataSource.close();
  }
}
