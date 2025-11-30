// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notificatin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      json['title'] as String?,
      json['body'] as String?,
      json['imageUrl'] as String?,
      json['status'] as String?,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'imageUrl': instance.imageUrl,
      'status': instance.status,
    };
