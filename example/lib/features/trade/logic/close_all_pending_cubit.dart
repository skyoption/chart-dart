import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/request_debouncer.dart';
import 'package:example/features/platform_settings/logic/trading_logs_cubit.dart';
import 'package:example/features/trade/data_sources/orders_data_source.dart';
import 'package:example/injection/injectable.dart';

///[CloseAllPendingCubit]
///[Implementation]
@injectable
class CloseAllPendingCubit extends Cubit<FlowState> {
  final OrdersDataSource dataSource;

  CloseAllPendingCubit(this.dataSource) : super(const FlowState());

  Future<void> deleteAllOrders() async {
    RequestDebouncer.run(() {
      dataSource.deleteAllOrders();
      getIt<TradingLogsCubit>().log("Requested To Close All Pending");
    });
  }

  Future<void> deleteAllBuyLimitOrders() async {
    RequestDebouncer.run(() {
      dataSource.deleteAllBuyLimitOrders();
      getIt<TradingLogsCubit>().log("Requested To Close All Buy Limit Pending");
    });
  }

  Future<void> deleteAllSellLimitOrders() async {
    RequestDebouncer.run(() {
      dataSource.deleteAllSellLimitOrders();
      getIt<TradingLogsCubit>().log(
        "Requested To Close All Sell Limit Pending",
      );
    });
  }

  Future<void> deleteAllBuyStopOrders() async {
    RequestDebouncer.run(() {
      dataSource.deleteAllBuyStopOrders();
      getIt<TradingLogsCubit>().log("Requested To Close All Buy Stop Pending");
    });
  }

  Future<void> deleteAllSellStopOrders() async {
    RequestDebouncer.run(() {
      dataSource.deleteAllSellStopOrders();
      getIt<TradingLogsCubit>().log("Requested To Close All Sell Stop Pending");
    });
  }
}
