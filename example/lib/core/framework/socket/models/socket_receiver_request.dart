import 'package:json_annotation/json_annotation.dart';
import 'package:example/core/framework/app_prefs.dart';
import 'package:example/core/framework/socket/socket.dart';
import 'package:example/injection/injectable.dart';

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
  @JsonKey(defaultValue: '', fromJson: getMessage)
  String message;
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

String getMessage(String message) {
  if (message.contains('||')) {
    try {
      final parts = message.split('||');
      if (parts.length >= 2) {
        bool isArabic = getIt<AppPreferences>().isArabic;
        final enMessage = parts[0];
        final arMessage = parts[1];
        return isArabic ? arMessage : enMessage;
      }
    } catch (e) {
      return message;
    }
  }
  return message;
}
