import 'package:example/core/consts/exports.dart';
import 'package:example/features/platform_settings/data_sources/logs_data_source.dart';
import 'package:example/features/platform_settings/models/app_log_entity.dart';

@singleton
class TradingLogsCubit extends Cubit<FlowState> {
  final LogsDataSource logsDataSource;

  int? accountId;

  TradingLogsCubit(this.logsDataSource) : super(const FlowState());

  List<AppLogEntity> logs = [];

  Future<void> getAllLogs() async {
    final appLogs = await logsDataSource.getAllLogs();
    appLogs.sort((a, b) => b.id.compareTo(a.id));
    logs = appLogs;
    emit(state.copyWith(data: Data.secure));
  }

  Future<void> log(
    String event,
  ) async {
    if (accountId != null) {
      final log = AppLogEntity(
        id: DateTime.now().millisecondsSinceEpoch,
        accountNumber: accountId!,
        event: event,
        createdAt: DateTime.now(),
      );
      logs.insert(0, log);
      await logsDataSource.storeLog(log);
      emit(state.copyWith(data: Data.secure));
    }
  }
}
