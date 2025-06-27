import 'package:json_annotation/json_annotation.dart';

part 'socket_sender_request.g.dart';

@JsonSerializable()
class SocketSenderRequest {
  @JsonKey(name: 'request_id')
  final int requestId;
  final Map<String, dynamic> data;
  final String action;

  SocketSenderRequest({
    required this.requestId,
    required this.data,
    required this.action,
  });

  factory SocketSenderRequest.fromJson(Map<String, dynamic> json) =>
      _$SocketSenderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SocketSenderRequestToJson(this);
}
