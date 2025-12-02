import 'package:json_annotation/json_annotation.dart';
import 'package:example/core/framework/app_prefs.dart';
import 'package:example/injection/injectable.dart';

part 'base_response.g.dart';

@JsonSerializable(genericArgumentFactories: true, createToJson: false)
class BaseResponse<T> {
  final T? data;
  @JsonKey(name: 'documents')
  final T? documents;
  @JsonKey(name: 'message', defaultValue: '', fromJson: getMessage)
  String message;
  @JsonKey(name: 'count', defaultValue: 0)
  int count;
  @JsonKey(name: 'statusCode', defaultValue: 0)
  int statusCode;
  @JsonKey(name: 'success', defaultValue: true)
  bool success;

  BaseResponse({
    this.data,
    this.documents,
    required this.message,
    required this.statusCode,
    required this.count,
    required this.success,
  });

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$BaseResponseFromJson(json, fromJsonT);
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
