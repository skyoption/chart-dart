import 'package:example/core/consts/exports.dart';
import 'package:example/core/enums/history_sort.dart';
import 'package:example/core/framework/socket/socket.dart';
import 'package:example/features/trade_history/data_sources/history_data_source.dart';
import 'package:example/features/trade_history/models/filters.dart';
import 'package:example/features/trade_history/models/history.dart';
import 'package:example/features/trade_history/models/history_position_entity.dart';

///[PositionsCubit]
///[Implementation]
@injectable
class HistoryPositionsCubit extends Cubit<FlowState> {
  final HistoryDataSource historyDataSource;

  HistoryPositionsCubit(this.historyDataSource) : super(const FlowState());

  List<HistoryPositionEntity> positions = [];

  History? balance;
  ValueNotifier<double> deposit = ValueNotifier(0);
  ValueNotifier<double> withdrawal = ValueNotifier(0);
  ValueNotifier<double> floating = ValueNotifier(0);
  ValueNotifier<double> commission = ValueNotifier(0);
  ValueNotifier<double> swap = ValueNotifier(0);
  ValueNotifier<double> totalWinAmount = ValueNotifier(0);
  ValueNotifier<int> totalWinCount = ValueNotifier(0);
  ValueNotifier<double> totalLoseAmount = ValueNotifier(0);
  ValueNotifier<int> totalLoseCount = ValueNotifier(0);

  String? selectedTimeFilter;
  int? customFromTime;
  int? customToTime;

  HistorySortConfig currentSort = const HistorySortConfig(
    criteria: HistorySortCriteria.date,
    isAscending: false,
  );

  Future<void> init() async {
    historyDataSource.onData(
      events: [SocketEvent.get_history_pos],
      onAccountFoundsRequest: (items) {
        withdrawal.value = 0;
        deposit.value = 0;
        for (var item in items) {
          if (item.type == 'Balance') {
            balance = item;
          }
          if (item.amount > 0) {
            final value = deposit.value + item.amount;
            deposit.value = value;
          } else {
            final value = withdrawal.value + item.amount;
            withdrawal.value = value;
          }
        }
        positions.addAll(items.map((e) => e.toPosition()).toList());
        positions.sortByConfig(currentSort);
        emit(state.copyWith(data: Data.secure));
      },
      onAllPositionsRequest: (items) {
        positions = items;
        positions.sortByConfig(currentSort);
        updateInfo();
        emit(state.copyWith(data: Data.secure));
      },
    );
  }

  Future<void> getCachedPositions() async {
    positions = await historyDataSource.getCachedPositions();
    positions.sortByConfig(currentSort);
    updateInfo();
    emit(state.copyWith(data: Data.secure));
  }

  Future<void> getAll({String? type, int? from, int? to}) async {
    if (type != null) {
      selectedTimeFilter = type;
      customToTime = to;
      customFromTime = from;
    }
    from ??= customFromTime ??
        DateTime.now().subtract(const Duration(days: 7)).toStartTime;
    to ??= customToTime ?? DateTime.now().toEndTime;
    historyDataSource.getAllPositions(from: from, to: to);
  }

  void updateInfo() {
    if (positions.isNotEmpty) {
      double floating = 0, commission = 0, swap = 0;
      double totalWinAmount = 0, totalLoseAmount = 0;
      int totalWinCount = 0, totalLoseCount = 0;

      for (int i = 0; i < positions.length; i++) {
        floating += positions[i].amount;
        swap += positions[i].swap;
        commission += positions[i].commission;

        // Calculate win/lose positions
        if (positions[i].amount > 0) {
          totalWinAmount += positions[i].amount;
          totalWinCount++;
        } else if (positions[i].amount < 0) {
          totalLoseAmount += positions[i].amount;
          totalLoseCount++;
        }
      }

      this.floating.value = floating;
      this.commission.value = commission;
      this.swap.value = swap;
      this.totalWinAmount.value = totalWinAmount;
      this.totalWinCount.value = totalWinCount;
      this.totalLoseAmount.value = totalLoseAmount;
      this.totalLoseCount.value = totalLoseCount;
    } else {
      floating.value = 0;
      swap.value = 0;
      commission.value = 0;
      totalWinAmount.value = 0;
      totalWinCount.value = 0;
      totalLoseAmount.value = 0;
      totalLoseCount.value = 0;
    }
  }

  void sortData(HistorySortConfig sortConfig) {
    currentSort = sortConfig;
    positions.sortByConfig(currentSort);
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
    positions = [];
    deposit.value = 0;
    withdrawal.value = 0;
    floating.value = 0;
    commission.value = 0;
    swap.value = 0;
    totalWinAmount.value = 0;
    totalWinCount.value = 0;
    totalLoseAmount.value = 0;
    totalLoseCount.value = 0;
    selectedTimeFilter = null;
    customFromTime = null;
    customToTime = null;
    currentSort = const HistorySortConfig(
      criteria: HistorySortCriteria.date,
      isAscending: false,
    );
  }

  @override
  Future<void> close() {
    floating.dispose();
    deposit.dispose();
    commission.dispose();
    swap.dispose();
    withdrawal.dispose();
    totalWinAmount.dispose();
    totalWinCount.dispose();
    totalLoseAmount.dispose();
    totalLoseCount.dispose();
    return super.close();
  }
}
