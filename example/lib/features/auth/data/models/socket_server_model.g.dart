// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'socket_server_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocketServerModel _$SocketServerModelFromJson(Map<String, dynamic> json) =>
    SocketServerModel(
      companyName: json['companyName'] as String? ?? '',
      url: json['url'] as String? ?? '',
      serverName: json['serverName'] as String? ?? '',
    );

Map<String, dynamic> _$SocketServerModelToJson(SocketServerModel instance) =>
    <String, dynamic>{
      'companyName': instance.companyName,
      'url': instance.url,
      'serverName': instance.serverName,
    };
