import 'package:eitherx/eitherx.dart';
import 'package:example/core/base/socket_server_response.dart';
import 'package:example/features/auth/domain/entities/socket_server_entity.dart';
import 'package:mwidgets/mwidgets.dart';

///[Implementation]
abstract class AuthRepository {
  Future<Either<Failure, SocketServerResponse<List<SocketServerEntity>>>>
      getSocketServers();
}
