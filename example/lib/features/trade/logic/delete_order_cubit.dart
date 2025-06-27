import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/socket/socket.dart';
import 'package:example/features/settings/logic/platform_settings_cubit.dart';
import 'package:example/features/settings/logic/trading_logs_cubit.dart';
import 'package:example/features/trade/data_sources/orders_data_source.dart';
import 'package:example/features/trade/models/requests/delete_order_request.dart';
import 'package:example/injection/injectable.dart';

///[DeleteOrderCubit]
///[Implementation]
@injectable
class DeleteOrderCubit extends Cubit<FlowState> {
  final PlatformSettingsCubit platformCubit;
  final OrdersDataSource dataSource;

  DeleteOrderCubit(
    this.dataSource,
    this.platformCubit,
  ) : super(const FlowState()) {
    _init();
  }

  int ticketNumber = 0;

  void _init() {
    dataSource.onData(
      onRequest: (success, message) {
        if (success) {
          if (platformCubit.settings.tradeNotificationSound) Player.success();
          getIt<TradingLogsCubit>()
              .log("Order Number $ticketNumber Deleted Successfully");
          emit(state.copyWith(type: StateType.success, data: Data.secure));
        } else {
          if (platformCubit.settings.tradeNotificationSound) Player.failure();
          getIt<TradingLogsCubit>()
              .log("Error Deleting Order Number $ticketNumber");
          emit(state.copyWith(data: Data.secure));
        }
      },
      events: [SocketEvent.del_pending],
    );
  }

  void deleteOrder({required int ticket}) {
    ticketNumber = ticket;
    dataSource.deleteOrder(DeleteOrderRequest(ticket: ticket));
    getIt<TradingLogsCubit>()
        .log("Requested To Delete Order Number $ticketNumber");
  }

  @override
  Future<void> close() {
    dataSource.close();
    return super.close();
  }
}
