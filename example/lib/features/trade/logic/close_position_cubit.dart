import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/functions.dart';
import 'package:example/core/framework/socket/socket.dart';
import 'package:example/features/settings/logic/platform_settings_cubit.dart';
import 'package:example/features/settings/logic/trading_logs_cubit.dart';
import 'package:example/features/trade/data_sources/positions_data_source.dart';
import 'package:example/features/trade/models/requests/close_position_request.dart';
import 'package:example/injection/injectable.dart';
import 'package:example/main.dart';

///[ClosePositionCubit]
///[Implementation]
@injectable
class ClosePositionCubit extends Cubit<FlowState> {
  final PositionsDataSource dataSource;
  final PlatformSettingsCubit platformCubit;

  ClosePositionCubit(
    this.dataSource,
    this.platformCubit,
  ) : super(const FlowState()) {
    init();
  }

  String error = '';
  int ticketNumber = 0;
  double profit = 0;
  String symbol = '';

  void init() {
    dataSource.onData(
      onRequest: (success, message) {
        if (success) {
          error = '';
          showTradeNotification(
            platformSettings: platformCubit.settings,
            message: SkyTrading.tr.positionClosedNotification(
              DateTime.now().toLocal().toIso8601String().toDateOnly,
              profit,
              symbol,
              ticketNumber,
            ),
            color: profit > 0 ? Coolors.green : Colors.redAccent,
          );
          getIt<TradingLogsCubit>()
              .log("Position Number $ticketNumber Closed Successfully");

          emit(state.copyWith(type: StateType.success));
        } else {
          getIt<TradingLogsCubit>()
              .log("Error Closing Position Number $ticketNumber");
          error = message;
          if (platformCubit.settings.tradeNotificationSound) Player.failure();
          emit(state.copyWith(data: Data.secure));
        }
      },
      events: [SocketEvent.close_pos],
    );
  }

  void closePosition({
    required int ticketNumber,
    required double volume,
    required double sl,
    required double tp,
    required String profit,
    required String symbol,
  }) {
    this.ticketNumber = ticketNumber;
    this.profit = double.parse(profit);
    this.symbol = symbol;
    dataSource.closePosition(
      ClosePositionRequest(
        id: ticketNumber,
        volume: volume.toTwoDecimalNum,
        sl: sl,
        tp: tp,
      ),
    );
    getIt<TradingLogsCubit>()
        .log("Requested To Close Position Number $ticketNumber");
  }

  @override
  Future<void> close() {
    dataSource.close();
    return super.close();
  }
}
