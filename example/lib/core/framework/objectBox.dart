import 'package:path_provider/path_provider.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/features/symbols/models/schema/symbol_model.dart';
import 'package:example/features/trade/models/schema/order_model.dart';
import 'package:example/features/trade/models/schema/position_model.dart';
import 'package:example/features/trade_history/models/schema/account_founds_model.dart';
import 'package:example/features/trade_history/models/schema/history_actions_model.dart';
import 'package:example/features/trade_history/models/schema/history_pending_model.dart';
import 'package:example/features/trade_history/models/schema/history_position_model.dart';
import 'package:example/objectbox.g.dart';

class ObjectBox {
  Store? _store;
  Admin? _admin;

  Box<OrderModel>? orderBox;
  Box<PositionModel>? positionsBox;
  Box<AccountFoundsModel>? accountFoundsBox;
  Box<HistoryActionModel>? historyActionBox;
  Box<HistoryPendingModel>? historyPendingBox;
  Box<HistoryPositionModel>? historyPositionBox;
  Box<SymbolModel>? symbolBox;

  Future<ObjectBox> create(dynamic id) async {
    final baseUrl = await getCachePath();
    await createDir('$baseUrl/sky5-data');
    if (_store != null && !_store!.isClosed()) {
      _store!.close();
    }
    _store = await openStore(directory: '$baseUrl/sky5-data/$id-data-v2');
    if (Admin.isAvailable()) {
      _admin = Admin(_store!);
    }
    symbolBox = Box<SymbolModel>(_store!);
    orderBox = Box<OrderModel>(_store!);
    positionsBox = Box<PositionModel>(_store!);
    accountFoundsBox = Box<AccountFoundsModel>(_store!);
    historyActionBox = Box<HistoryActionModel>(_store!);
    historyPendingBox = Box<HistoryPendingModel>(_store!);
    historyPositionBox = Box<HistoryPositionModel>(_store!);
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
