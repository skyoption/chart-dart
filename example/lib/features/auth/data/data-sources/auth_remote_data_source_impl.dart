import 'package:eitherx/eitherx.dart';
import 'package:example/core/base/safe_request_handler.dart';
import 'package:example/core/base/socket_server_response.dart';
import 'package:example/features/auth/data/client-services/auth_client_services.dart';
import 'package:example/features/auth/data/data-sources/auth_remote_data_source.dart';
import 'package:example/features/auth/data/models/socket_server_model.dart';
import 'package:injectable/injectable.dart';
import 'package:mwidgets/mwidgets.dart';

///[AuthRemoteDataSource]
///[Implementation]
@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImplement implements AuthRemoteDataSource {
  final AuthClientServices authClientServices;
  final SafeApi api;
  const AuthRemoteDataSourceImplement(this.authClientServices, this.api);

  @override
  Future<Either<Failure, SocketServerResponse<List<SocketServerModel>>>>
      getSocketServers() async {
    return await api<SocketServerResponse<List<SocketServerModel>>>(
      apiCall: authClientServices.getSocketServers(),
    );
  }
}
