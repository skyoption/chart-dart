import 'package:example/features/auth/domain/use-cases/get_socket_servers_use_case.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/features/auth/domain/entities/socket_server_entity.dart';

///[GetSocketServersCubit]
///[Implementation]
@injectable
class GetSocketServersCubit extends Cubit<FlowState> {
  ///[GetProfileUseCase]
  final GetSocketServersUseCase _getSocketServersUseCase;

  GetSocketServersCubit(this._getSocketServersUseCase)
      : super(const FlowState());

  List<SocketServerEntity> servers = [];

  Future<void> execute() async {
    emit(state.copyWith(type: StateType.loading));
    final res = await _getSocketServersUseCase.execute();
    res.left((failure) {
      emit(state.copyWith(type: StateType.error, message: failure.message));
    });
    res.right((data) {
      servers = data.servers ?? [];
      emit(
        state.copyWith(
          type: StateType.success,
          message: "Fetched",
          data: Data.secure,
        ),
      );
    });
  }
}
