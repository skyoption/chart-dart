// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_socket_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseSocketResponse<T> _$BaseSocketResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    BaseSocketResponse<T>(
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
      action: json['action'] as String? ?? '',
    );

Map<String, dynamic> _$BaseSocketResponseToJson<T>(
  BaseSocketResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': _$nullableGenericToJson(instance.data, toJsonT),
      'action': instance.action,
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
