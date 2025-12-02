import 'package:example/features/auth/domain/entities/socket_server_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'socket_server_model.g.dart';

@JsonSerializable()
class SocketServerModel implements SocketServerEntity {
  @override
  @JsonKey(name: "companyName", defaultValue: "")
  final String companyName;
  @override
  @JsonKey(name: "url", defaultValue: "")
  final String url;
  @override
  @JsonKey(name: "serverName", defaultValue: "")
  final String serverName;
  const SocketServerModel({
    required this.companyName,
    required this.url,
    required this.serverName,
  });

  factory SocketServerModel.fromJson(Map<String, dynamic> json) =>
      _$SocketServerModelFromJson(json);

  Map<String, dynamic> toJson() => _$SocketServerModelToJson(this);
}
