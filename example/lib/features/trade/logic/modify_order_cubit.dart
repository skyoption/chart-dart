import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/socket/socket.dart';
import 'package:example/features/settings/logic/platform_settings_cubit.dart';
import 'package:example/features/settings/logic/trading_logs_cubit.dart';
import 'package:example/features/trade/data_sources/orders_data_source.dart';
import 'package:example/features/trade/models/requests/modify_order_request.dart';
import 'package:example/injection/injectable.dart';

///[ModifyOrderCubit]
///[Implementation]
@injectable
class ModifyOrderCubit extends Cubit<FlowState> {
  final OrdersDataSource dataSource;
  final PlatformSettingsCubit platformCubit;

  ModifyOrderCubit(
    this.dataSource,
    this.platformCubit,
  ) : super(const FlowState()) {
    _init();
  }

  String error = '';
  int ticketNumber = 0;

  void _init() {
    dataSource.onData(
      onRequest: (success, message) {
        if (success) {
          error = '';
          if (platformCubit.settings.tradeNotificationSound) Player.success();
          getIt<TradingLogsCubit>()
              .log("Order Number $ticketNumber Modified Successfully");
          emit(state.copyWith(type: StateType.success));
        } else {
          error = message;
          if (platformCubit.settings.tradeNotificationSound) Player.failure();
          getIt<TradingLogsCubit>()
              .log("Error Modifying Order Number $ticketNumber");
          emit(state.copyWith(data: Data.secure));
        }
      },
      events: [SocketEvent.modify_pending, SocketEvent.ev_modify_pending],
    );
  }

  void modifyOrder({
    int? expiration,
    required int id,
    double? price,
    double? volume,
    double? sl,
    double? tp,
  }) {
    ticketNumber = id;
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
    getIt<TradingLogsCubit>()
        .log("Requested To Modify Order Number $ticketNumber");
  }

  @override
  Future<void> close() {
    dataSource.close();
    return super.close();
  }
}
