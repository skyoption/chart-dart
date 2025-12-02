import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/request_debouncer.dart';
import 'package:example/features/platform_settings/logic/trading_logs_cubit.dart';
import 'package:example/features/trade/data_sources/positions_data_source.dart';
import 'package:example/injection/injectable.dart';

///[CloseAllPositionsCubit]
///[Implementation]
@injectable
class CloseAllPositionsCubit extends Cubit<FlowState> {
  final PositionsDataSource dataSource;

  CloseAllPositionsCubit(this.dataSource) : super(const FlowState());

  void closeAllPositions() {
    RequestDebouncer.run(() {
      dataSource.closeAllPositions();
      getIt<TradingLogsCubit>().log("Requested To Close All Positions");
    });
  }

  void closeLosingPositions() {
    RequestDebouncer.run(() {
      dataSource.closeLosingPositions();
      getIt<TradingLogsCubit>().log("Requested To Close All Losing Positions");
    });
  }

  void closeProfitablePositions() {
    RequestDebouncer.run(() {
      dataSource.closeProfitablePositions();
      getIt<TradingLogsCubit>().log(
        "Requested To Close All Profitable Positions",
      );
    });
  }
}
