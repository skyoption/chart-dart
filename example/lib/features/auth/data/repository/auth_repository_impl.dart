import 'package:eitherx/eitherx.dart';
import 'package:example/core/base/socket_server_response.dart';
import 'package:example/features/auth/data/data-sources/auth_remote_data_source.dart';
import 'package:example/features/auth/domain/entities/socket_server_entity.dart';
import 'package:example/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mwidgets/mwidgets.dart';

///[AuthRepositoryImplement]
///[Implementation]
@Injectable(as: AuthRepository)
class AuthRepositoryImplement implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  const AuthRepositoryImplement(
    this.authRemoteDataSource,
  );

  @override
  Future<Either<Failure, SocketServerResponse<List<SocketServerEntity>>>>
      getSocketServers() async {
    return await authRemoteDataSource.getSocketServers();
  }
}
