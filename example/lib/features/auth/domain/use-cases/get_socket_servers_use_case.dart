import 'package:eitherx/eitherx.dart';
import 'package:example/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:example/core/base/no_params.dart';
import 'package:example/core/base/socket_server_response.dart';
import 'package:example/features/auth/domain/entities/socket_server_entity.dart';

///[GetSocketServersUseCase]
///[Implementation]
@injectable
class GetSocketServersUseCase
    implements
        BaseUseCase<
            NoParams,
            Future<
                Either<Failure,
                    SocketServerResponse<List<SocketServerEntity>>>>> {
  final AuthRepository repository;
  const GetSocketServersUseCase(this.repository);

  @override
  Future<Either<Failure, SocketServerResponse<List<SocketServerEntity>>>>
      execute({NoParams? request}) async {
    return await repository.getSocketServers();
  }
}
