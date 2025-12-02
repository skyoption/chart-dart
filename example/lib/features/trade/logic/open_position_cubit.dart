import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/socket/logging_notifier.dart';
import 'package:example/core/framework/socket/socket.dart';
import 'package:example/features/platform_settings/logic/platform_settings_cubit.dart';
import 'package:example/features/platform_settings/logic/trading_logs_cubit.dart';
import 'package:example/features/trade/data_sources/positions_data_source.dart';
import 'package:example/features/trade/models/requests/open_position_request.dart';
import 'package:example/injection/injectable.dart';

///[OpenPositionCubit]
///[Implementation]
@injectable
class OpenPositionCubit extends Cubit<FlowState> {
  final PositionsDataSource dataSource;
  final PlatformSettingsCubit platformCubit;

  OpenPositionCubit(this.dataSource, this.platformCubit)
      : super(const FlowState());

  String requestSymbol = '';
  String direction = '';
  double volume = 0.0;
  double price = 0.0;

  Future<void> init() async {
    await dataSource.onData(
      onRequestError: (message, id) => LoggingPusher.error(
        message: message,
        logErrorMessage: "Error Opening Position Number $id",
      ),
      onRequest: (message, id) {
        LoggingPusher.success(
          message: SkyTrading.tr.positionOpenedNotification(
            direction,
            requestSymbol,
            volume.toString(),
          ),
          logSuccessMessage:
              "Successfully Opened Position For $requestSymbol Symbol",
        );
        emit(state.copyWith(type: StateType.success, data: Data.secure));
      },
      events: [SocketEvent.ev_open_pos, SocketEvent.open_pos],
    );
  }

  void openPosition({
    required String symbol,
    required String direction,
    required double volume,
    required double sl,
    required double tp,
    required double price,
  }) {
    requestSymbol = symbol;
    this.direction = direction;
    this.volume = volume;
    this.price = price;
    dataSource.openPosition(
      OpenPositionRequest(
        symbol: symbol,
        direction: direction,
        volume: volume.toTwoDecimalNum,
        sl: sl,
        tp: tp,
      ),
    );
    getIt<TradingLogsCubit>().log(
      "Requested To Open Position For $symbol Symbol",
    );
  }

  @override
  Future<void> close() {
    dataSource.close();
    return super.close();
  }
}
