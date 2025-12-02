import 'package:example/core/consts/exports.dart';
import 'package:example/core/enums/position_sort.dart';
import 'package:example/core/enums/user_permissions.dart';
import 'package:example/core/framework/socket/socket.dart';
import 'package:example/features/main/data_source/connected_account_data_source.dart';
import 'package:example/features/main/logic/connect_cubit.dart';
import 'package:example/features/main/models/connected_account_info_entity.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';
import 'package:example/features/trade/data_sources/positions_data_source.dart';
import 'package:example/features/trade/logic/position_assets_lose_alert_cubit.dart';
import 'package:example/features/trade/models/position_entity.dart';

///[PositionsCubit]
///[Implementation]
@injectable
class PositionsCubit extends Cubit<FlowState> {
  final PositionsDataSource tradeDataSource;
  final ConnectedAccountDataSource loginDataSource;
  final QuotesCubit quotesCubit;
  final ConnectCubit connectCubit;
  final PositionAssetsLoseAlertCubit assetsLoseAlertCubit;
  PositionsCubit(
    this.tradeDataSource,
    this.loginDataSource,
    this.quotesCubit,
    this.connectCubit,
    this.assetsLoseAlertCubit,
  ) : super(const FlowState(type: StateType.success));

  List<String> get symbols {
    List<String> items = [];
    for (var item in positions) {
      if (!items.contains(item.groupSymbol)) {
        items.add(item.groupSymbol);
      }
    }
    return items;
  }

  List<SymbolEntity> get subscribedSymbols {
    List<SymbolEntity> items = [];
    for (var item in positions) {
      final symbol = quotesCubit.getSymbol(item.groupSymbol);
      if (symbol != null && !items.contains(symbol)) {
        items.add(symbol);
      }
    }
    return items;
  }

  Map<String, ValueNotifier<double>> floatingSymbols = {};

  PositionEntity? getPosition(int id) {
    return tradeDataSource.getPositionById(id);
  }

  List<PositionEntity> positions = [];
  List<PositionEntity> filteredPositions = [];

  String currentFilterSymbol = "All";

  ValueNotifier<ConnectedAccountInfoEntity?> account = ValueNotifier(null);
  bool isMainAccount() => account.value?.isMainAccount ?? true;
  bool hasPermission(UserPermissions permission) =>
      account.value?.rights?.hasPermission(permission) ?? false;
  ValueNotifier<double> floating = ValueNotifier(0);
  ValueNotifier<double> balance = ValueNotifier(0);
  ValueNotifier<double> credit = ValueNotifier(0);
  ValueNotifier<double> equity = ValueNotifier(0);
  ValueNotifier<double> freeMargin = ValueNotifier(0);
  ValueNotifier<double> margin = ValueNotifier(0);
  ValueNotifier<double> marginLevel = ValueNotifier(0);

  PositionSortConfig currentSort = const PositionSortConfig(
    criteria: PositionSortCriteria.openTime,
    isAscending: false,
  );

  bool isAscending = true;

  Future<void> init() async {
    positions = [];
    filteredPositions = [];
    tradeDataSource.onData(
      events: [
        SocketEvent.ev_open_pos,
        SocketEvent.ev_close_pos,
        SocketEvent.ev_modify_pos,
        SocketEvent.get_all_pos,
        SocketEvent.ev_acc_updated,
        SocketEvent.ev_pclose_pos,
        SocketEvent.ev_acc_info,
        SocketEvent.ev_acc_modified,
      ],
      onOpenPositionRequest: (value) {
        final index = positions.indexWhere((e) => e.id == value.id);
        if (index == -1) {
          positions.insert(0, value);
          updateTargetPositions(positions);
        }
        emit(state.copyWith(data: Data.secure, type: StateType.success));
      },
      onClosePositionRequest: (id) {
        final index = positions.indexWhere((e) => e.id == id);
        final item = positions[index];
        if (index != -1) positions.removeAt(index);
        updateTargetPositions(positions);
        emit(state.copyWith(data: item, type: StateType.delete));
      },
      onModifyPositionRequest: (value) {
        final index = positions.indexWhere((e) => e.id == value.id);
        final fIndex = filteredPositions.indexWhere((e) => e.id == value.id);
        positions[index] = value;
        filteredPositions[fIndex] = value;
        updateTargetPositions(positions);
        emit(state.copyWith(data: Data.secure, type: StateType.success));
      },
      onAllPositionRequest: (items) {
        floatingSymbols = {};
        positions = items..sortByConfig(currentSort);
        updateTargetPositions(positions);
        emit(state.copyWith(data: Data.secure, type: StateType.success));
      },
      onUpdateSymbol: (List<PositionEntity> items) {
        updateTargetPositions(items);
      },
      onBalanceUpdate: (newBalance) {
        balance.value = newBalance;
        equity.value = balance.value + floating.value;
        freeMargin.value = newBalance;
        connectCubit.updateDefaultAccountBalance(newBalance);
      },
      onCreditUpdate: (newCredit) {
        credit.value = newCredit;
      },
      onMarginUpdate: (newMargin) {
        margin.value = newMargin;
        if (margin.value != 0 &&
            marginLevel.value != 0 &&
            positions.isNotEmpty) {
          assetsLoseAlertCubit.execute(
            marginCallLevel: account.value?.marginCallLevel ?? 0,
            marginLevel: marginLevel.value,
          );
        }
      },
      onAccountInfoRequest: (item) {
        account.value = item;
        balance.value = item.balance;
        margin.value = item.margin;
        equity.value = item.equity;
        freeMargin.value = item.marginFree;
        floating.value = item.floating;
        credit.value = item.credit;
        marginLevel.value = item.marginLevel ?? 0;
        connectCubit.setAccountInfo(item);
        kPrint("MARGIN :${margin.value}");
        if (margin.value != 0 &&
            marginLevel.value != 0 &&
            positions.isNotEmpty) {
          assetsLoseAlertCubit.execute(
            marginCallLevel: item.marginCallLevel,
            marginLevel: marginLevel.value,
          );
        }
      },
    );
    Future.delayed(
      Duration(milliseconds: 100),
      tradeDataSource.getAllPositions,
    );
  }

  void resetPositions() {
    positions = [];
    filteredPositions = [];
    tradeDataSource.getAllPositions();
    emit(state.copyWith(data: Data.secure, type: StateType.success));
  }

  Future<void> getCachedPositions() async {
    positions = await tradeDataSource.getCachedPositions();
    positions.sortByConfig(currentSort);
    filteredPositions = positions;
    emit(state.copyWith(data: Data.secure, type: StateType.success));
  }

  void updateTargetPositions(List<PositionEntity> items) {
    if (positions.isNotEmpty) {
      double totalFloating = 0;
      double commission = 0;

      for (final updated in items) {
        final index = positions.indexWhere((p) => p.id == updated.id);
        if (index != -1) {
          positions[index] = updated;
        } else {
          positions.add(updated);
        }
      }

      for (var item in positions) {
        final symbol = item.groupSymbol;
        floatingSymbols[symbol] ??= ValueNotifier(0);
        final floatingValue = item.floating.toTwoDecimalNum;
        final swapValue = item.swap.toTwoDecimalNum;
        final commissionValue = item.commission.toTwoDecimalNum;
        final itemFloating = floatingValue + swapValue - commissionValue;
        totalFloating += itemFloating;
        commission += commissionValue;
        final currentFloating = floatingSymbols[symbol]!.value.toTwoDecimalNum;
        final newFloating = currentFloating + floatingValue;
        floatingSymbols[symbol]!.value = newFloating;
      }

      positions.sortByConfig(currentSort);
      filteredPositions = positions.filterBySymbol(currentFilterSymbol);
      filteredPositions.sortByConfig(currentSort);
      floating.value = totalFloating;
      equity.value = balance.value + floating.value + commission;
      freeMargin.value = equity.value - margin.value;
      marginLevel.value =
          margin.value == 0 ? 0 : (equity.value / margin.value) * 100;
      if (margin.value != 0 && marginLevel.value != 0) {
        assetsLoseAlertCubit.execute(
          marginCallLevel: account.value?.marginCallLevel ?? 0,
          marginLevel: marginLevel.value,
        );
      }
    } else {
      floatingSymbols = {};
      floating.value = 0;
      equity.value = balance.value;
      freeMargin.value = balance.value;
      marginLevel.value = 0;
      assetsLoseAlertCubit.stop();
      positions.sortByConfig(currentSort);
      filteredPositions.sortByConfig(currentSort);
    }
  }

  Future<void> getInfo() async {
    final data = await loginDataSource.getDefault();
    account.value = data?.copyToEntity();
    if (account.value != null) {
      balance.value = account.value!.balance;
      credit.value = account.value!.credit;
      equity.value = account.value!.equity;
      freeMargin.value = account.value!.marginFree;
      margin.value = account.value!.margin;
      marginLevel.value = account.value!.marginLevel ?? 0;
      floating.value = account.value!.floating;
    }
  }

  void sort(PositionSortConfig sortConfig) {
    currentSort = sortConfig;
    filteredPositions.sortByConfig(currentSort);
    emit(state.copyWith(data: Data.secure, type: StateType.success));
  }

  void filterBySymbol(String symbol) {
    currentFilterSymbol = symbol;
    filteredPositions = positions.filterBySymbol(currentFilterSymbol);
    filteredPositions.sortByConfig(currentSort);
    emit(state.copyWith(data: Data.secure, type: StateType.success));
  }

  void reset() {
    positions.clear();
    filteredPositions.clear();
    currentSort = PositionSortConfig(
      criteria: PositionSortCriteria.openTime,
      isAscending: false,
    );
    account = ValueNotifier(null);
    floating = ValueNotifier(0);
    balance = ValueNotifier(0);
    credit = ValueNotifier(0);
    equity = ValueNotifier(0);
    freeMargin = ValueNotifier(0);
    margin = ValueNotifier(0);
    marginLevel = ValueNotifier(0);
  }

  bool get canTrade => hasPermission(UserPermissions.trade);

  @override
  Future<void> close() {
    balance.dispose();
    equity.dispose();
    freeMargin.dispose();
    margin.dispose();
    floating.dispose();
    marginLevel.dispose();
    return super.close();
  }
}
