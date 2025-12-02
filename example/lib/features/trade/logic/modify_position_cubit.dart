import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/socket/logging_notifier.dart';
import 'package:example/core/framework/socket/socket.dart';
import 'package:example/features/platform_settings/logic/platform_settings_cubit.dart';
import 'package:example/features/platform_settings/logic/trading_logs_cubit.dart';
import 'package:example/features/trade/data_sources/positions_data_source.dart';
import 'package:example/features/trade/models/requests/modify_pos_request.dart';
import 'package:example/injection/injectable.dart';

///[ModifyPositionCubit]
///[Implementation]
@injectable
class ModifyPositionCubit extends Cubit<FlowState> {
  final PositionsDataSource dataSource;
  final PlatformSettingsCubit platformCubit;

  ModifyPositionCubit(this.dataSource, this.platformCubit)
      : super(const FlowState());

  String error = '';
  int id = 0;
  String requestSymbol = '';
  String type = '';

  void init() {
    dataSource.onData(
      onRequestError: (message, id) => LoggingPusher.error(
        message: message,
        logErrorMessage: "Error Modifying Position Number $id",
      ),
      onRequest: (message, id) {
        LoggingPusher.success(
          message: SkyTrading.tr.positionModifiedNotification(
            id.toString(),
            requestSymbol,
          ),
          logSuccessMessage: "Position Number $id Modified Successfully",
        );
        emit(state.copyWith(type: StateType.success, data: Data.secure));
      },
      events: [SocketEvent.ev_modify_pos, SocketEvent.modify_pos],
    );
  }

  void modifyPosition({
    required requestSymbol,
    required int id,
    required double sl,
    required double tp,
    required String type,
  }) {
    this.requestSymbol = requestSymbol;
    this.id = id;
    dataSource.modifyPosition(ModifyPosRequest(id: id, sl: sl, tp: tp));
    getIt<TradingLogsCubit>().log("Requested To Modify Position Number $id");
  }

  @override
  Future<void> close() {
    dataSource.close();
    return super.close();
  }
}
