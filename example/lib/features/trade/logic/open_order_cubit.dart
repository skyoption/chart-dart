import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/socket/socket.dart';
import 'package:example/features/settings/logic/platform_settings_cubit.dart';
import 'package:example/features/settings/logic/trading_logs_cubit.dart';
import 'package:example/features/trade/data_sources/orders_data_source.dart';
import 'package:example/features/trade/models/requests/open_order_request.dart';
import 'package:example/injection/injectable.dart';

///[OpenOrderCubit]
///[Implementation]
@injectable
class OpenOrderCubit extends Cubit<FlowState> {
  final OrdersDataSource dataSource;
  final PlatformSettingsCubit platformCubit;

  OpenOrderCubit(
    this.dataSource,
    this.platformCubit,
  ) : super(const FlowState()) {
    _init();
  }

  String error = '';
  String requestSymbol = '';

  void _init() {
    dataSource.onData(
      onRequest: (success, message) {
        if (success) {
          error = '';
          if (platformCubit.settings.tradeNotificationSound) Player.success();
          getIt<TradingLogsCubit>()
              .log("Successfully Opened Order For $requestSymbol Symbol");
          emit(state.copyWith(type: StateType.success));
        } else {
          error = message;
          if (platformCubit.settings.tradeNotificationSound) Player.failure();
          getIt<TradingLogsCubit>()
              .log("Failed to Open Order For $requestSymbol Symbol");
          emit(state.copyWith(data: Data.secure));
        }
      },
      events: [SocketEvent.open_pending],
    );
  }

  void openOrder({
    required String symbol,
    required String direction,
    required int expirationDate,
    required double price,
    required double volume,
    required double sl,
    required double tp,
  }) {
    requestSymbol = symbol;
    dataSource.openOrder(
      OpenOrderRequest(
        direction: direction,
        expirationDate: expirationDate,
        symbol: symbol,
        price: price,
        volume: volume.toTwoDecimalNum,
        sl: sl,
        tp: tp,
      ),
    );
    getIt<TradingLogsCubit>().log("Requested To Open Order For $symbol Symbol");
  }

  @override
  Future<void> close() {
    dataSource.close();
    return super.close();
  }
}
