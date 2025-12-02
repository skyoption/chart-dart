import 'package:example/core/consts/exports.dart';
import 'package:example/core/enums/position_sort.dart';
import 'package:example/core/framework/socket/socket.dart';
import 'package:example/features/trade/data_sources/orders_data_source.dart';
import 'package:example/features/trade/models/order_entity.dart';

///[OrdersCubit]
///[Implementation]
@injectable
class OrdersCubit extends Cubit<FlowState> {
  final OrdersDataSource ordersDataSource;

  OrdersCubit(this.ordersDataSource)
      : super(const FlowState(type: StateType.success));

  List<OrderEntity> orders = [];
  List<OrderEntity> filteredOrders = [];

  String currentFilterSymbol = "All";

  PositionSortConfig currentSort = const PositionSortConfig(
    criteria: PositionSortCriteria.openTime,
    isAscending: false,
  );

  Future<void> init() async {
    orders = [];
    filteredOrders = [];
    ordersDataSource.onData(
      events: [
        SocketEvent.get_all_pending,
        SocketEvent.ev_open_pending,
        SocketEvent.ev_del_pending,
        SocketEvent.ev_modify_pending,
      ],
      onOpenOrderRequest: (value) {
        final index = orders.indexWhere((e) => e.id == value.id);
        if (index == -1) {
          orders.insert(0, value);
          if (currentFilterSymbol == "All" ||
              value.symbol == currentFilterSymbol) {
            filteredOrders.insert(0, value);
          }
          orders.sortByConfig(currentSort);
          filteredOrders.sortByConfig(currentSort);
        }
        emit(state.copyWith(data: Data.secure, type: StateType.success));
      },
      onDeleteOrderRequest: (id) {
        final index = orders.indexWhere((e) => e.id == id);
        if (index != -1) orders.removeAt(index);
        final filteredIndex = filteredOrders.indexWhere((e) => e.id == id);
        if (filteredIndex != -1) {
          final item = orders[filteredIndex];
          filteredOrders.removeAt(filteredIndex);
          emit(state.copyWith(data: item, type: StateType.delete));
        }
      },
      onModifyOrderRequest: (value) {
        final index = orders.indexWhere((e) => e.id == value.id);
        if (index != -1) orders[index] = value;
        final filteredIndex = filteredOrders.indexWhere(
          (e) => e.id == value.id,
        );
        if (filteredIndex != -1) {
          final item = orders[filteredIndex];
          filteredOrders.removeAt(filteredIndex);
          emit(state.copyWith(data: item, type: StateType.success));
        }
        orders.sortByConfig(currentSort);
        filteredOrders.sortByConfig(currentSort);
      },
      onAllOrderRequest: (items) {
        orders = items..sortByConfig(currentSort);
        filteredOrders = orders.filterBySymbol(currentFilterSymbol);
        filteredOrders.sortByConfig(currentSort);
        emit(state.copyWith(data: Data.secure, type: StateType.success));
      },
    );
    Future.delayed(Duration(milliseconds: 100), ordersDataSource.getAllOrders);
  }

  void resetOrders() {
    orders = [];
    filteredOrders = [];
    ordersDataSource.getAllOrders();
    emit(state.copyWith(data: Data.secure, type: StateType.success));
  }

  Future<void> getCachedOrders() async {
    orders = await ordersDataSource.getCachedOrders();
    orders.sortByConfig(currentSort);
    filteredOrders = orders.filterBySymbol(currentFilterSymbol);
    filteredOrders.sortByConfig(currentSort);
    emit(state.copyWith(data: Data.secure, type: StateType.success));
  }

  void sort(PositionSortConfig sortConfig) {
    currentSort = sortConfig;
    filteredOrders.sortByConfig(currentSort);
    emit(state.copyWith(data: Data.secure, type: StateType.success));
  }

  void filterBySymbol(String symbol) {
    currentFilterSymbol = symbol;
    filteredOrders = orders.filterBySymbol(currentFilterSymbol);
    filteredOrders.sortByConfig(currentSort);
    emit(state.copyWith(data: Data.secure, type: StateType.success));
  }

  void reset() {
    orders.clear();
    filteredOrders.clear();
    currentFilterSymbol = "All";
    currentSort = const PositionSortConfig(
      criteria: PositionSortCriteria.openTime,
      isAscending: false,
    );
  }
}
