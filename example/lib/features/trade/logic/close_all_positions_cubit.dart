import 'package:example/core/consts/exports.dart';
import 'package:example/features/settings/logic/trading_logs_cubit.dart';
import 'package:example/features/trade/data_sources/positions_data_source.dart';
import 'package:example/injection/injectable.dart';

///[CloseAllPositionsCubit]
///[Implementation]
@injectable
class CloseAllPositionsCubit extends Cubit<FlowState> {
  final PositionsDataSource dataSource;

  CloseAllPositionsCubit(
    this.dataSource,
  ) : super(const FlowState());

  void closeAllPositions() {
    dataSource.closeAllPositions();
    getIt<TradingLogsCubit>().log("Requested To Close All Positions");
  }

  void closeLosingPositions() {
    dataSource.closeLosingPositions();
    getIt<TradingLogsCubit>().log("Requested To Close All Losing Positions");
  }

  void closeProfitablePositions() {
    dataSource.closeProfitablePositions();
    getIt<TradingLogsCubit>()
        .log("Requested To Close All Profitable Positions");
  }
}
