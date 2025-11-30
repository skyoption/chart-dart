// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'socket_sender_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocketSenderRequest _$SocketSenderRequestFromJson(Map<String, dynamic> json) =>
    SocketSenderRequest(
      requestId: (json['request_id'] as num).toInt(),
      data: json['data'] as Map<String, dynamic>,
      action: json['action'] as String,
    );

Map<String, dynamic> _$SocketSenderRequestToJson(
        SocketSenderRequest instance) =>
    <String, dynamic>{
      'request_id': instance.requestId,
      'data': instance.data,
      'action': instance.action,
    };
