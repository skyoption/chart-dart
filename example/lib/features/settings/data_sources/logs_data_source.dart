import 'dart:async';

import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/accountBox.dart';
import 'package:example/features/settings/models/app_log_entity.dart';

abstract class LogsDataSource {
  Future<List<AppLogEntity>> getAllLogs();
  Future<void> storeLog(AppLogEntity log);
  Future<void> deleteOldLogs();
  void startPeriodicCleanup();
}

@Injectable(as: LogsDataSource)
class LogsDataSourceImpl extends LogsDataSource {
  Timer? _cleanupTimer;
  final AccountBox accountBox;

  LogsDataSourceImpl(this.accountBox);

  @override
  void startPeriodicCleanup() {
    _cleanupTimer?.cancel();
    _cleanupTimer = Timer.periodic(const Duration(hours: 1), (_) {
      deleteOldLogs();
    });
  }

  @override
  Future<List<AppLogEntity>> getAllLogs() async {
    await deleteOldLogs();
    final items = accountBox.logs.getAll();
    final logs = items.map((item) => item.copyToEntity()).toList();
    return logs;
  }

  @override
  Future<void> storeLog(AppLogEntity log) async {
    accountBox.logs.put(log.copyToModel());
  }

  @override
  Future<void> deleteOldLogs() async {
    final items = accountBox.logs.getAll();
    for (var item in items) {
      if (item.createdAt.difference(DateTime.now()).inHours > 24) {
        accountBox.logs.remove(item.id);
      }
    }
  }
}
