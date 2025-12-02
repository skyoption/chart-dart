import 'package:example/app.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/socket/logging_notifier.dart';
import 'package:example/core/framework/socket/socket.dart';
import 'package:example/features/platform_settings/logic/platform_settings_cubit.dart';
import 'package:example/features/platform_settings/logic/trading_logs_cubit.dart';
import 'package:example/features/trade/data_sources/positions_data_source.dart';
import 'package:example/features/trade/models/requests/close_position_request.dart';
import 'package:example/injection/injectable.dart';

///[ClosePositionCubit]
///[Implementation]
@injectable
class ClosePositionCubit extends Cubit<FlowState> {
  final PositionsDataSource dataSource;
  final PlatformSettingsCubit platformCubit;

  ClosePositionCubit(this.dataSource, this.platformCubit)
      : super(const FlowState());

  String error = '';
  double profit = 0;
  String symbol = '';

  void init() {
    dataSource.onData(
      onRequestError: (message, id) => LoggingPusher.error(
        message: message,
        logErrorMessage: "Error Closing Position Number $id",
      ),
      onRequest: (message, id) {
        LoggingPusher.success(
          message: SkyTrading.tr.positionClosedNotification(
            profit,
            symbol,
            id.toString(),
          ),
          logSuccessMessage: "Position Number $id Closed Successfully",
          color: profit > 0
              ? getIt<AppColorScheme>().light.success
              : getIt<AppColorScheme>().light.error,
        );
        emit(state.copyWith(type: StateType.success, data: Data.secure));
      },
      events: [
        SocketEvent.ev_close_pos,
        SocketEvent.close_pos,
        SocketEvent.ev_pclose_pos,
      ],
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
    getIt<TradingLogsCubit>().log(
      "Requested To Close Position Number $ticketNumber",
    );
  }

  @override
  Future<void> close() {
    dataSource.close();
    return super.close();
  }
}
