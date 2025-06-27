import 'package:example/core/consts/exports.dart';
import 'package:example/core/enums/history_sort.dart';
import 'package:example/core/framework/socket/socket.dart';
import 'package:example/features/trade_history/data_sources/history_data_source.dart';
import 'package:example/features/trade_history/models/history_action_entity.dart';
import 'package:example/features/trade_history/views/filter_history_screen.dart';

///[PositionsCubit]
///[Implementation]
@injectable
class HistoryActionsCubit extends Cubit<FlowState> {
  final HistoryDataSource historyDataSource;

  HistoryActionsCubit(
    this.historyDataSource,
  ) : super(const FlowState());

  List<HistoryActionEntity> actions = [];

  String? selectedTimeFilter;
  int? customFromTime;
  int? customToTime;

  HistorySortConfig currentSort = const HistorySortConfig(
    criteria: HistorySortCriteria.date,
    isAscending: false,
  );

  Future<void> init() async {
    historyDataSource.onData(
      events: [SocketEvent.get_actions],
      onAllActionsRequest: (items) {
        actions = items;
        sortData(currentSort);
        emit(state.copyWith(data: Data.secure));
        updateInfo();
      },
    );
  }

  ValueNotifier<double> floating = ValueNotifier(0);
  ValueNotifier<double> commission = ValueNotifier(0);

  Future<void> getCachedActions() async {
    actions = await historyDataSource.getCachedActions();
    actions.sortByConfig(currentSort);
    updateInfo();
    emit(state.copyWith(data: Data.secure));
  }

  Future<void> getAll({
    String? type,
    int? from,
    int? to,
  }) async {
    emit(state.copyWith(type: StateType.none));
    if (type != null) {
      selectedTimeFilter = type;
      customToTime = to;
      customFromTime = from;
    }
    from ??= customFromTime ??
        DateTime.now().subtract(const Duration(days: 7)).toStartTime;
    to ??= customToTime ??
        DateTime.now().subtract(const Duration(days: 7)).toEndTime;
    historyDataSource.getAllActions(from: from, to: to);
  }

  void updateInfo() {
    if (actions.isNotEmpty) {
      double floating = 0, commission = 0;
      for (int i = 0; i < actions.length; i++) {
        floating += actions[i].profit;
        commission += actions[i].commission;
      }
      this.floating.value = floating;
      this.commission.value = commission;
    } else {
      floating.value = 0;
      commission.value = 0;
    }
  }

  void sortData(HistorySortConfig sortConfig) {
    currentSort = sortConfig;
    actions.sortByConfig(currentSort);
    emit(state.copyWith(data: Data.secure));
  }

  TimeEntity getSelectedTimeFilter() {
    return TimeEntity(
      type: selectedTimeFilter ?? "Last Week",
      from: customFromTime ??
          DateTime.now().subtract(const Duration(days: 7)).toStartTime,
      to: customToTime ?? DateTime.now().toEndTime,
    );
  }

  void reset() {
    selectedTimeFilter = null;
    customToTime = null;
    customFromTime = null;
    commission.value = 0;
    floating.value = 0;
    currentSort = const HistorySortConfig(
      criteria: HistorySortCriteria.date,
      isAscending: false,
    );
  }

  @override
  Future<void> close() {
    floating.dispose();
    commission.dispose();
    return super.close();
  }
}
