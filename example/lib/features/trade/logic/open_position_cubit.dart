import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/functions.dart';
import 'package:example/core/framework/socket/socket.dart';
import 'package:example/features/settings/logic/platform_settings_cubit.dart';
import 'package:example/features/settings/logic/trading_logs_cubit.dart';
import 'package:example/features/trade/data_sources/positions_data_source.dart';
import 'package:example/features/trade/models/requests/open_position_request.dart';
import 'package:example/injection/injectable.dart';
import 'package:example/main.dart';

///[OpenPositionCubit]
///[Implementation]
@injectable
class OpenPositionCubit extends Cubit<FlowState> {
  final PositionsDataSource dataSource;
  final PlatformSettingsCubit platformCubit;

  OpenPositionCubit(
    this.dataSource,
    this.platformCubit,
  ) : super(const FlowState());

  String error = '';
  String requestSymbol = '';
  String type = '';

  Future<void> init() async {
    await dataSource.onData(
      onRequest: (success, message) {
        if (success) {
          error = '';
          showTradeNotification(
            platformSettings: platformCubit.settings,
            message: SkyTrading.tr.positionOpenedNotification(
              DateTime.now().toLocal().toIso8601String().toDateOnly,
              requestSymbol,
              type,
            ),
            color: Coolors.primaryColor,
          );
          getIt<TradingLogsCubit>().log(
              "Successfully Opened Position With Type $type For $requestSymbol Symbol");
          emit(state.copyWith(type: StateType.success));
        } else {
          error = message;
          if (platformCubit.settings.tradeNotificationSound) Player.failure();
          getIt<TradingLogsCubit>().log(
              "Failed to Open Position With Type $type For $requestSymbol Symbol");
          emit(state.copyWith(data: Data.secure));
        }
      },
      events: [
        SocketEvent.ev_open_pos,
      ],
    );
  }

  void openPosition({
    required String symbol,
    required String direction,
    required double volume,
    required double sl,
    required double tp,
  }) {
    requestSymbol = symbol;
    type = direction;
    dataSource.openPosition(
      OpenPositionRequest(
        symbol: symbol,
        direction: direction,
        volume: volume.toTwoDecimalNum,
        sl: sl,
        tp: tp,
      ),
    );
    getIt<TradingLogsCubit>()
        .log("Requested To Open Position For $symbol Symbol");
  }

  @override
  Future<void> close() {
    dataSource.close();
    return super.close();
  }
}
