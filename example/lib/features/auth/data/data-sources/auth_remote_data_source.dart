import 'package:eitherx/eitherx.dart';
import 'package:example/core/base/socket_server_response.dart';
import 'package:example/features/auth/data/models/socket_server_model.dart';
import 'package:mwidgets/mwidgets.dart';

///[Implementation]
abstract class AuthRemoteDataSource {
  Future<Either<Failure, SocketServerResponse<List<SocketServerModel>>>>
      getSocketServers();
}
