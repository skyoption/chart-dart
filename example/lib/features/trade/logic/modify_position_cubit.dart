import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/socket/socket.dart';
import 'package:example/features/settings/logic/platform_settings_cubit.dart';
import 'package:example/features/settings/logic/trading_logs_cubit.dart';
import 'package:example/features/trade/data_sources/positions_data_source.dart';
import 'package:example/features/trade/models/requests/modify_pos_request.dart';
import 'package:example/injection/injectable.dart';

///[ModifyPositionCubit]
///[Implementation]
@injectable
class ModifyPositionCubit extends Cubit<FlowState> {
  final PositionsDataSource dataSource;
  final PlatformSettingsCubit platformCubit;

  ModifyPositionCubit(
    this.dataSource,
    this.platformCubit,
  ) : super(const FlowState()) {
    init();
  }

  String error = '';
  int id = 0;

  void init() {
    dataSource.onData(
      onRequest: (success, message) {
        if (success) {
          error = '';
          if (platformCubit.settings.tradeNotificationSound) Player.success();
          getIt<TradingLogsCubit>()
              .log("Position Number $id Modified Successfully");
          emit(state.copyWith(type: StateType.success));
        } else {
          error = message;
          if (platformCubit.settings.tradeNotificationSound) Player.failure();
          getIt<TradingLogsCubit>().log("Error Modifying Position Number $id");

          emit(state.copyWith(data: Data.secure));
        }
      },
      events: [SocketEvent.modify_pos, SocketEvent.ev_modify_pos],
    );
  }

  void modifyPosition({
    required int id,
    required double sl,
    required double tp,
  }) {
    this.id = id;
    dataSource.modifyPosition(
      ModifyPosRequest(
        id: id,
        sl: sl,
        tp: tp,
      ),
    );
    getIt<TradingLogsCubit>().log("Requested To Modify Position Number $id");
  }

  @override
  Future<void> close() {
    dataSource.close();
    return super.close();
  }
}
