import 'package:example/core/framework/socket/socket.dart';
import 'package:json_annotation/json_annotation.dart';

part 'socket_receiver_request.g.dart';

@JsonSerializable()
class SocketReceiverRequest {
  @JsonKey(name: 'request_id', defaultValue: 0)
  final int requestId;
  final dynamic data;
  @JsonKey(name: 'type', defaultValue: '')
  final String action;
  @JsonKey(defaultValue: true)
  final bool success;
  @JsonKey(defaultValue: '')
  final String message;
  SocketEvent get event {
    final index = SocketEvent.values.indexWhere((e) {
      return e.name.toUpperCase() == action;
    });
    return SocketEvent.values[index];
  }

  SocketReceiverRequest({
    required this.requestId,
    required this.data,
    required this.action,
    required this.message,
    required this.success,
  });

  @override
  String toString() {
    return 'SocketReceiverRequest('
        'requestId: $requestId, '
        'data: $data, '
        'action: $action, '
        'success: $success, '
        'message: $message, '
        'event: $event)';
  }

  factory SocketReceiverRequest.fromJson(Map<String, dynamic> json) =>
      _$SocketReceiverRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SocketReceiverRequestToJson(this);
}
