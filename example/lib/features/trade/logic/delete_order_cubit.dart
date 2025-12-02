import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/socket/logging_notifier.dart';
import 'package:example/core/framework/socket/socket.dart';
import 'package:example/features/platform_settings/logic/trading_logs_cubit.dart';
import 'package:example/features/trade/data_sources/orders_data_source.dart';
import 'package:example/features/trade/models/order_entity.dart';
import 'package:example/features/trade/models/requests/delete_order_request.dart';
import 'package:example/injection/injectable.dart';

import '../../platform_settings/logic/platform_settings_cubit.dart';

///[DeleteOrderCubit]
///[Implementation]
@injectable
class DeleteOrderCubit extends Cubit<FlowState> {
  final PlatformSettingsCubit platformCubit;
  final OrdersDataSource dataSource;

  DeleteOrderCubit(this.dataSource, this.platformCubit)
      : super(const FlowState()) {
    _init();
  }

  int ticketNumber = 0;
  String requestSymbol = "";
  String type = "";
  double profit = 0.0;

  void _init() {
    dataSource.onData(
      onRequestError: (message, id) => LoggingPusher.error(
        message: message,
        logErrorMessage: "Error Deleting Order Number $id",
      ),
      onRequest: (message, id) {
        LoggingPusher.success(
          message: SkyTrading.tr.orderClosedNotification(
            profit,
            requestSymbol,
            ticketNumber,
          ),
          logSuccessMessage: "Order Number $ticketNumber Deleted Successfully",
        );
        emit(state.copyWith(type: StateType.success, data: Data.secure));
      },
      events: [SocketEvent.del_pending, SocketEvent.ev_del_pending],
    );
  }

  void deleteOrder({required OrderEntity order, double? profitValue}) {
    ticketNumber = order.id;
    requestSymbol = order.symbol;
    type = order.direction;
    profit = profitValue ?? 0.0;
    dataSource.deleteOrder(DeleteOrderRequest(ticket: ticketNumber));
    getIt<TradingLogsCubit>().log(
      "Requested To Delete Order Number $ticketNumber",
    );
  }

  @override
  Future<void> close() {
    dataSource.close();
    return super.close();
  }
}
