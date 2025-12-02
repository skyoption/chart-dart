import 'package:json_annotation/json_annotation.dart';

part 'socket_server_response.g.dart';

@JsonSerializable(genericArgumentFactories: true, createToJson: false)
class SocketServerResponse<T> {
  final T? servers;

  SocketServerResponse({required this.servers});

  factory SocketServerResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$SocketServerResponseFromJson(json, fromJsonT);
}
