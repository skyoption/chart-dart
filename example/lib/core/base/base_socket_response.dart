import 'package:json_annotation/json_annotation.dart';

part 'base_socket_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseSocketResponse<T> {
  final T? data;
  @JsonKey(defaultValue: '')
  String? action;

  BaseSocketResponse({
    this.data,
    this.action,
  });

  factory BaseSocketResponse.fromJson(
      Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$BaseSocketResponseFromJson(json, fromJsonT);
}
