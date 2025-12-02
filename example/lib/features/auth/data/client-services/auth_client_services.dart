import 'dart:io';

import 'package:dio/dio.dart';
import 'package:example/core/base/socket_server_response.dart';
import 'package:example/core/consts/constants.dart';
import 'package:example/features/auth/data/models/socket_server_model.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_client_services.g.dart';

@RestApi()
abstract class AuthClientServices {
  factory AuthClientServices(Dio dio, {String baseUrl}) = _AuthClientServices;

  @GET(Endpoints.socketServers)
  Future<SocketServerResponse<List<SocketServerModel>>> getSocketServers();
}
