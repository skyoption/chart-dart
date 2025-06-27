// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'socket_receiver_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocketReceiverRequest _$SocketReceiverRequestFromJson(
        Map<String, dynamic> json) =>
    SocketReceiverRequest(
      requestId: (json['request_id'] as num?)?.toInt() ?? 0,
      data: json['data'],
      action: json['type'] as String? ?? '',
      message: json['message'] as String? ?? '',
      success: json['success'] as bool? ?? true,
    );

Map<String, dynamic> _$SocketReceiverRequestToJson(
        SocketReceiverRequest instance) =>
    <String, dynamic>{
      'request_id': instance.requestId,
      'data': instance.data,
      'type': instance.action,
      'success': instance.success,
      'message': instance.message,
    };
