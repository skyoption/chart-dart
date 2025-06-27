import 'dart:async';

import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/accountBox.dart';
import 'package:example/core/framework/socket/socket.dart';
import 'package:example/features/auth/models/account_balance_model.dart';
import 'package:example/features/auth/models/account_credential.dart';
import 'package:example/features/auth/models/connected_account_info_entity.dart';
import 'package:example/features/auth/models/schema/connected_account_info_model.dart';
import 'package:example/objectbox.g.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class ConnectedAccountDataSource {
  Sockeet get socket;

  Future<void> connect({
    required String id,
    String? password,
    required bool isLogin,
    required Function onConnected,
    required Function onDisconnected,
  });

  void directConnect({
    required Function onConnected,
    required Function onDisconnected,
    required bool openLocalDatabase,
  });

  Future<AccountCredential?> setDefaultAccount({
    required int id,
    required String password,
  });

  Future<AccountCredential?> getAccountInfo({required int id});

  Future<AccountCredential?> getLoginData();

  Future<AccountCredential?> get hasUser;

  Future<ConnectedAccountInfoModel?> getDefault();

  Future<List<ConnectedAccountInfoEntity>> getAllAccountsInfo();

  Future<void> init({
    required Function(ConnectedAccountInfoEntity accountInfo) onRequest,
  });

  Future<void> deleteAccount({
    required int id,
    required Function onDeleted,
  });

  Future<void> logout({required Function() onLogout});

  Future<void> deleteDefault({
    required Function onDeleted,
  });

  void close();

  void closeSocket();
}

class ConnectedAccountDataSourceImp implements ConnectedAccountDataSource {
  @override
  final Sockeet socket;
  final AccountBox accountBox;
  StreamSubscription? listener;
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

  ConnectedAccountDataSourceImp(this.socket, this.accountBox);

  @override
  Future<void> connect({
    required String id,
    required Function onConnected,
    required Function onDisconnected,
    required bool isLogin,
    String? password,
  }) async {
    await _socketConnect(
      accountNumber: id,
      isLogin: isLogin,
      password: password,
      onDisconnected: onDisconnected,
      onConnected: () async {
        try {
          await setDefaultAccount(id: int.parse(id), password: '$password');
          onConnected();
        } catch (e) {
          kPrint("ERROR: $e");
        }
      },
    );
  }

  Future<void> _socketConnect({
    required String accountNumber,
    String? password,
    required Function onConnected,
    required Function onDisconnected,
    bool isLogin = false,
    bool openLocalDatabase = true,
  }) async {
    await socket.connect(
      password: password,
      accountNumber: accountNumber,
      onDisconnected: onDisconnected,
      onConnected: onConnected,
      openLocalDatabase: openLocalDatabase,
      isLogin: isLogin,
    );
  }

  @override
  Future<void> directConnect({
    required Function onConnected,
    required Function onDisconnected,
    bool openLocalDatabase = true,
  }) async {
    kPrint('directConnect');
    try {
      final loginData = await getLoginData();
      _socketConnect(
        openLocalDatabase: openLocalDatabase,
        accountNumber: loginData!.id.toString(),
        password: loginData.password,
        onDisconnected: onDisconnected,
        onConnected: onConnected,
        isLogin: true,
      );
    } catch (e) {
      kPrint("Couldn't login, empty data ");
    }
  }

  @override
  Future<AccountCredential?> setDefaultAccount({
    required int id,
    required String password,
  }) async {
    try {
      await _storage.write(key: id.toString(), value: password);
      final accounts = accountBox.accounts.getAll();
      for (int i = 0; i < accounts.length; i++) {
        final account = accounts[i];
        if (account.id == id) {
          account.isDefault = true;
          accountBox.accounts.put(account);
        }
      }
      return AccountCredential(id: id, password: password);
    } catch (e) {
      kPrint("ERROR SAVING");
      throw Exception('Failed to save credentials: $e');
    }
  }

  @override
  Future<AccountCredential?> get hasUser async {
    try {
      final data = await getLoginData();
      return data;
    } catch (e) {
      kPrint(e);
      return null;
    }
  }

  @override
  Future<AccountCredential?> getLoginData() async {
    try {
      final account = await getDefault();
      if (account != null) {
        final password = await _storage.read(key: account.id.toString());
        return AccountCredential(id: account.id, password: password!);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to retrieve credentials: $e');
    }
  }

  @override
  Future<ConnectedAccountInfoModel?> getDefault() async {
    final query = accountBox.accounts
        .query(ConnectedAccountInfoModel_.isDefault.equals(true))
        .build();
    final account = query.findFirst();
    query.close();
    return account;
  }

  @override
  Future<List<ConnectedAccountInfoEntity>> getAllAccountsInfo() async {
    try {
      final accountInfo = accountBox.accounts.getAll();
      return accountInfo.map((account) => account.copyToEntity()).toList();
    } catch (e) {
      throw Exception('Failed to retrieve credentials: $e');
    }
  }

  @override
  Future<void> deleteAccount({
    required int id,
    required Function onDeleted,
  }) async {
    final defaultAccount = await getDefault();
    if (defaultAccount != null && defaultAccount.id != id) {
      final deleted = accountBox.accounts.remove(id);
      if (deleted) {
        _storage.delete(key: id.toString());
        onDeleted();
      }
    }
  }

  @override
  Future<void> deleteDefault({
    required Function onDeleted,
  }) async {
    final defaultAccount = await getDefault();
    if (defaultAccount != null) {
      final deleted = accountBox.accounts.remove(defaultAccount.id);
      if (deleted) {
        _storage.delete(key: defaultAccount.id.toString());
        onDeleted();
      }
    }
  }

  @override
  Future<void> logout({required Function() onLogout}) async {
    bool loggedOut = false;
    final loggedInAccount = await getDefault();
    if (loggedInAccount != null) {
      loggedInAccount.isDefault = false;
      loggedOut = true;
      accountBox.accounts.put(loggedInAccount);
      socket.disconnect();
      listener?.cancel();
    }
    if (loggedOut) onLogout();
  }

  @override
  Future<AccountCredential?> getAccountInfo({required int id}) async {
    final password = await _storage.read(key: id.toString());
    if (password == null) return null;
    return AccountCredential(id: id, password: password);
  }

  @override
  Future<void> init({
    required Function(ConnectedAccountInfoEntity accountInfo) onRequest,
  }) async {
    kPrint("Socket init");
    listener = socket.onData(
      events: [
        SocketEvent.ev_acc_info,
        SocketEvent.ev_acc_updated,
      ],
      onReceiveRequest: (receiver) async {
        kPrint("Received ${receiver.action}");
        if (receiver.action == SocketEvent.ev_acc_info.name.toUpperCase()) {
          final accountInfo = ConnectedAccountInfoModel.fromJson(receiver.data);
          accountInfo.isDefault = true;
          accountBox.accounts.put(accountInfo);
          onRequest(accountInfo.copyToEntity());
        }
        if (receiver.action == SocketEvent.ev_acc_updated.name.toUpperCase()) {
          final accountInfo = await getDefault();
          final updatedAccount = AccountUpdateModel.fromJson(receiver.data);
          if (accountInfo != null &&
              updatedAccount.accountId == accountInfo.id) {
            if (updatedAccount.balance != null) {
              accountInfo.balance = updatedAccount.balance!;
            }
            if (updatedAccount.credit != null) {
              accountInfo.credit = updatedAccount.credit!;
            }
            accountInfo.isDefault = true;
            accountBox.accounts.put(accountInfo);
            onRequest(accountInfo.copyToEntity());
          }
        }
      },
    );
  }

  @override
  void close() {
    listener?.cancel();
    socket.disconnect();
  }

  @override
  void closeSocket() {
    socket.disconnect();
  }
}
