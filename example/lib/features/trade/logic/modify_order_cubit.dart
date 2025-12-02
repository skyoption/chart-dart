import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/socket/logging_notifier.dart';
import 'package:example/core/framework/socket/socket.dart';
import 'package:example/features/platform_settings/logic/platform_settings_cubit.dart';
import 'package:example/features/platform_settings/logic/trading_logs_cubit.dart';
import 'package:example/features/trade/data_sources/orders_data_source.dart';
import 'package:example/features/trade/models/requests/modify_order_request.dart';
import 'package:example/injection/injectable.dart';

///[ModifyOrderCubit]
///[Implementation]
@injectable
class ModifyOrderCubit extends Cubit<FlowState> {
  final OrdersDataSource dataSource;
  final PlatformSettingsCubit platformCubit;

  ModifyOrderCubit(this.dataSource, this.platformCubit)
      : super(const FlowState());

  String error = '';
  int ticketNumber = 0;
  String requestSymbol = '';

  void init() {
    dataSource.onData(
      onRequestError: (message, id) => LoggingPusher.error(
        message: message,
        logErrorMessage: "Error Modifying Order Number $id",
      ),
      onRequest: (message, id) {
        LoggingPusher.success(
          message: SkyTrading.tr.orderModifiedNotification(
            ticketNumber,
            requestSymbol,
          ),
          logSuccessMessage: "Order Number $ticketNumber Modified Successfully",
        );
        emit(state.copyWith(type: StateType.success, data: Data.secure));
      },
      events: [SocketEvent.modify_pending, SocketEvent.ev_modify_pending],
    );
  }

  void modifyOrder({
    required requestSymbol,
    int? expiration,
    required int id,
    double? price,
    double? volume,
    double? sl,
    double? tp,
  }) {
    ticketNumber = id;
    requestSymbol = requestSymbol;
    dataSource.modifyOrder(
      ModifyOrderRequest(
        id: id,
        expiration: expiration,
        price: price,
        volume: volume?.toTwoDecimalNum,
        sl: sl,
        tp: tp,
      ),
    );
    getIt<TradingLogsCubit>().log(
      "Requested To Modify Order Number $ticketNumber",
    );
  }

  @override
  Future<void> close() {
    dataSource.close();
    return super.close();
  }
}
