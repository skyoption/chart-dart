import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:example/core/consts/constants.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/accountBox.dart';
import 'package:example/core/framework/socket/socket.dart';
import 'package:example/features/main/models/account_credential.dart';
import 'package:example/features/main/models/connected_account_info_entity.dart';
import 'package:example/features/main/models/schema/connected_account_info_model.dart';
import 'package:example/injection/injectable.dart';

abstract class ConnectedAccountDataSource {
  Sockeet get socket;

  Future<void> connect({
    required String id,
    String? password,
    String? serverUrl,
    required bool isLogin,
    required Function onConnected,
    required Function onDisconnected,
  });

  void directConnect({
    required Function onConnected,
    required Function onDisconnected,
    required bool openLocalDatabase,
  });

  Future<void> saveLoginData({required int id});

  Future<AccountCredential?> getLoginData();

  Future<AccountCredential?> get hasUser;

  Future<AccountCredential?> getAccountCredentials(int accountId);

  Future<AccountCredential?> updateDefaultAccount({
    required int id,
    String? password,
    String? serverUrl,
  });

  Future<ConnectedAccountInfoModel?> getDefault();

  Future<List<ConnectedAccountInfoEntity>> getAllAccountsInfo();

  Future<void> deleteAccount({required int id, required Function onDeleted});

  Future<void> clearAllAccounts({required Function onCleared});

  Future<void> logout({required Function() onLogout});

  Future<void> deleteDefault({required Function onDeleted});

  void close();

  void closeSocket();
}

@Injectable(as: ConnectedAccountDataSource)
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
    String? password,
    String? serverUrl,
    required Function onConnected,
    required Function onDisconnected,
    required bool isLogin,
  }) async {
    await _socketConnect(
      accountNumber: id,
      isLogin: isLogin,
      onDisconnected: onDisconnected,
      password: password,
      serverUrl: serverUrl,
      onConnected: () {
        onConnected();
        saveLoginData(
          id: int.parse(id),
          password: password,
          serverUrl: serverUrl,
        );
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
    String? serverUrl,
  }) async {
    await socket.connect(
      accountNumber: accountNumber,
      onDisconnected: onDisconnected,
      password: password,
      serverUrl: serverUrl,
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
      if (loginData != null && loginData.serverUrl != null) {
        getIt<Sockeet>().socketUrl = loginData.serverUrl!;
      }
      _socketConnect(
        openLocalDatabase: openLocalDatabase,
        accountNumber: loginData!.id.toString(),
        onDisconnected: onDisconnected,
        onConnected: onConnected,
        password: loginData.password,
        isLogin: true,
      );
    } catch (e) {
      kPrint("Couldn't login, empty data ");
    }
  }

  @override
  Future<void> saveLoginData({
    required int id,
    String? password,
    String? serverUrl,
  }) async {
    try {
      final accountCredential = AccountCredential(
        id: id,
        password: password,
        serverUrl: serverUrl,
      );
      await _storage.write(
        key: id.toString(),
        value: jsonEncode(accountCredential.toJson()),
      );
      await _storage.write(
        key: Constants.USERCACHED,
        value: jsonEncode(accountCredential.toJson()),
      );
    } catch (e) {
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
      final results = await _storage.read(key: Constants.USERCACHED);
      if (results == null) return null;
      return AccountCredential.fromJson(jsonDecode(results));
    } catch (e) {
      throw Exception('Failed to retrieve credentials: $e');
    }
  }

  @override
  Future<AccountCredential?> getAccountCredentials(int accountId) async {
    try {
      final results = await _storage.read(key: accountId.toString());
      if (results == null) return null;
      return AccountCredential.fromJson(jsonDecode(results));
    } catch (e) {
      throw Exception('Failed to retrieve account credentials: $e');
    }
  }

  @override
  Future<ConnectedAccountInfoModel?> getDefault() async {
    final defaultAccount = await getLoginData();
    final account = accountBox.accounts.get(defaultAccount!.id);
    return account;
  }

  @override
  Future<AccountCredential?> updateDefaultAccount({
    required int id,
    String? password,
    String? serverUrl,
  }) async {
    try {
      final account = accountBox.accounts.get(id);
      if (account == null) return null;
      account.isDefault = true;
      accountBox.accounts.put(account);

      if (password == null) {
        final storedCredentials = await getAccountCredentials(id);
        password ??= storedCredentials?.password;
      }

      await saveLoginData(
        id: account.id,
        password: password,
        serverUrl: serverUrl,
      );
      return await getLoginData();
    } catch (e) {
      throw Exception('Failed to update the default account: $e');
    }
  }

  @override
  Future<List<ConnectedAccountInfoEntity>> getAllAccountsInfo() async {
    try {
      final accountInfo = accountBox.accounts.getAll();
      final accounts =
          accountInfo.map((account) => account.copyToEntity()).toList();

      final currentAccount = await getLoginData();
      final currentAccountId = currentAccount?.id;

      if (currentAccountId != null) {
        accounts.sort((a, b) {
          if (a.id == currentAccountId && b.id != currentAccountId) {
            return -1;
          }
          if (a.id != currentAccountId && b.id == currentAccountId) {
            return 1;
          }
          return 0;
        });
      }

      return accounts;
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
        _storage.delete(key: Constants.USERCACHED);
        onDeleted();
      }
    }
  }

  @override
  Future<void> clearAllAccounts({required Function onCleared}) async {
    accountBox.accounts.removeAll();
    await _storage.deleteAll();
    onCleared();
  }

  @override
  Future<void> deleteDefault({required Function onDeleted}) async {
    final defaultAccount = await getDefault();
    if (defaultAccount != null) {
      final deleted = accountBox.accounts.remove(defaultAccount.id);
      if (deleted) {
        _storage.delete(key: defaultAccount.id.toString());
        await _storage.write(key: Constants.USERCACHED, value: null);
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
      accountBox.accounts.put(loggedInAccount);
      await _storage.write(key: Constants.USERCACHED, value: null);
      loggedOut = true;
    }
    if (loggedOut) onLogout();
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
