import 'package:path_provider/path_provider.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/features/auth/models/schema/connected_account_info_model.dart';
import 'package:example/features/settings/models/schema/app_log_model.dart';
import 'package:example/objectbox.g.dart';

class AccountBox {
  Store? _store;
  Admin? _admin;
  late final Box<ConnectedAccountInfoModel> accounts;
  late final Box<AppLogModel> logs;

  Future<AccountBox> create() async {
    final baseUrl = await getCachePath();
    await createDir('$baseUrl/sky5-accounts');
    if (_store != null && !_store!.isClosed()) {
      _store!.close();
    }
    _store = await openStore(directory: '$baseUrl/sky5-accounts/accounts-v1');
    accounts = Box<ConnectedAccountInfoModel>(_store!);
    logs = Box<AppLogModel>(_store!);
    if (Admin.isAvailable()) {
      _admin = Admin(_store!);
    }
    return this;
  }

  static Future<String> getCachePath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationCacheDirectory();
      } else {
        directory = await getTemporaryDirectory();
      }
    } catch (err) {
      kPrint(err.toString());
    }
    return directory?.path ?? '/';
  }

  static createDir(path) {
    if (!(Directory(path).existsSync())) {
      Directory(path).createSync();
    }
  }
}
