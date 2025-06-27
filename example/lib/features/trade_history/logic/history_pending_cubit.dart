import 'package:example/core/consts/exports.dart';
import 'package:example/core/enums/history_sort.dart';
import 'package:example/core/framework/socket/socket.dart';
import 'package:example/features/trade_history/data_sources/history_data_source.dart';
import 'package:example/features/trade_history/models/history_pending_entity.dart';
import 'package:example/features/trade_history/views/filter_history_screen.dart';

///[PositionsCubit]
///[Implementation]
@injectable
class HistoryPendingCubit extends Cubit<FlowState> {
  final HistoryDataSource historyDataSource;

  HistoryPendingCubit(
    this.historyDataSource,
  ) : super(const FlowState());
  List<HistoryPendingEntity> pending = [];

  String? selectedTimeFilter;
  int? customFromTime;
  int? customToTime;

  HistorySortConfig currentSort = const HistorySortConfig(
    criteria: HistorySortCriteria.date,
    isAscending: false,
  );

  Future<void> init() async {
    historyDataSource.onData(
      events: [SocketEvent.get_history_pending],
      onAllPendingRequest: (items) {
        pending = items;
        sortData(currentSort);
        emit(state.copyWith(data: Data.secure));
        updateInfo();
      },
    );
  }

  ValueNotifier<int> filled = ValueNotifier(0);
  ValueNotifier<int> canceled = ValueNotifier(0);
  ValueNotifier<int> total = ValueNotifier(0);

  Future<void> getCachedPositions() async {
    pending = await historyDataSource.getCachedPending();
    pending.sortByConfig(currentSort);
    updateInfo();
    emit(state.copyWith(data: Data.secure));
  }

  Future<void> getAll({
    String? type,
    int? from,
    int? to,
  }) async {
    if (type != null) {
      selectedTimeFilter = type;
      customToTime = to;
      customFromTime = from;
    }
    from ??= customFromTime ??
        DateTime.now().subtract(const Duration(days: 7)).toStartTime;
    to ??= customToTime ?? DateTime.now().toEndTime;
    historyDataSource.getAllPending(from: from, to: to);
  }

  void updateInfo() {
    if (pending.isNotEmpty) {
      int canceled = 0, filled = 0;
      for (int i = 0; i < pending.length; i++) {
        if (pending[i].type < 1) {
          canceled++;
        } else {
          filled++;
        }
      }
      this.canceled.value = canceled;
      this.filled.value = filled;
      total.value = pending.length;
    } else {
      canceled.value = 0;
      filled.value = 0;
      total.value = 0;
    }
  }

  void sortData(HistorySortConfig sortConfig) {
    currentSort = sortConfig;
    pending.sortByConfig(currentSort);
    emit(state.copyWith(data: Data.secure));
  }

  TimeEntity getSelectedTimeFilter() {
    return TimeEntity(
      type: selectedTimeFilter ?? "Last Week",
      from: customFromTime ??
          DateTime.now().subtract(const Duration(days: 7)).toStartTime,
      to: DateTime.now().subtract(const Duration(days: 7)).toEndTime,
    );
  }

  void reset() {
    selectedTimeFilter = null;
    customToTime = null;
    customFromTime = null;
    canceled.value = 0;
    filled.value = 0;
    total.value = 0;
    currentSort = const HistorySortConfig(
      criteria: HistorySortCriteria.date,
      isAscending: false,
    );
  }

  @override
  Future<void> close() {
    filled.dispose();
    canceled.dispose();
    total.dispose();
    return super.close();
  }
}
