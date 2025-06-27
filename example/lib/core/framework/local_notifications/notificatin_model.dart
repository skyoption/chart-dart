import 'package:json_annotation/json_annotation.dart';

part 'notificatin_model.g.dart';

@JsonSerializable()
class NotificationModel {
  String? title;
  String? body;
  String? imageUrl;
  String? status;

  NotificationModel(this.title, this.body, this.imageUrl, this.status);

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
