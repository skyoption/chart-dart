import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/socket/logging_notifier.dart';
import 'package:example/core/framework/socket/socket.dart';
import 'package:example/features/platform_settings/logic/platform_settings_cubit.dart';
import 'package:example/features/platform_settings/logic/trading_logs_cubit.dart';
import 'package:example/features/trade/data_sources/orders_data_source.dart';
import 'package:example/features/trade/models/requests/open_order_request.dart';
import 'package:example/injection/injectable.dart';

///[OpenOrderCubit]
///[Implementation]
@injectable
class OpenOrderCubit extends Cubit<FlowState> {
  final OrdersDataSource dataSource;
  final PlatformSettingsCubit platformCubit;

  OpenOrderCubit(this.dataSource, this.platformCubit)
      : super(const FlowState()) {
    _init();
  }

  String requestSymbol = '';
  String direction = '';
  double price = 0.0;
  void _init() {
    dataSource.onData(
      onRequestError: (message, id) => LoggingPusher.error(
        message: message,
        logErrorMessage: "Error Opening Order Number $id",
      ),
      onRequest: (message, id) {
        LoggingPusher.success(
          message: SkyTrading.tr.orderOpenedNotification(
            direction,
            requestSymbol,
            price.toString(),
          ),
          logSuccessMessage:
              "Successfully Opened Order For $requestSymbol Symbol",
        );
        emit(state.copyWith(type: StateType.success, data: Data.secure));
      },
      events: [SocketEvent.open_pending, SocketEvent.ev_open_pending],
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
    this.direction = direction;
    this.price = price;
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
