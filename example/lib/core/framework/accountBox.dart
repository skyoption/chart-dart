import 'package:path_provider/path_provider.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/features/main/models/schema/connected_account_info_model.dart';
import 'package:example/features/platform_settings/models/schema/app_log_model.dart';
import 'package:example/objectbox.g.dart';

@singleton
class AccountBox {
  Store? _store;
  Admin? admin;

  late final Box<ConnectedAccountInfoModel> accounts;
  late final Box<AppLogModel> logs;

  Future<AccountBox> create() async {
    final baseUrl = await getCachePath();
    await createDir('$baseUrl/accounts');
    if (_store != null && !_store!.isClosed()) {
      _store!.close();
    }
    _store = await openStore(directory: '$baseUrl/accounts/accounts-v3');
    if (Admin.isAvailable()) {
      admin = Admin(_store!);
    }
    accounts = Box<ConnectedAccountInfoModel>(_store!);
    logs = Box<AppLogModel>(_store!);
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
