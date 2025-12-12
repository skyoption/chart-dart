import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
import 'package:example/features/main/models/connected_account_info_entity.dart';

part 'connected_account_info_model.g.dart';

@Entity()
@JsonSerializable()
class ConnectedAccountInfoModel {
  @Id(assignable: true)
  @JsonKey(name: "number", defaultValue: 0)
  int id;
  @JsonKey(defaultValue: "")
  final String group;
  @JsonKey(defaultValue: "")
  String fullName;
  @JsonKey(defaultValue: 1)
  int leverage;

  @JsonKey(defaultValue: 0.0)
  double balance;

  @JsonKey(defaultValue: 0.0)
  double credit;

  @JsonKey(defaultValue: 0.0)
  final double equity;

  @JsonKey(defaultValue: 0.0)
  final double floating;

  @JsonKey(defaultValue: 0.0)
  final double margin;

  @JsonKey(defaultValue: 0.0)
  final double marginFree;

  @JsonKey(includeIfNull: false)
  double? marginLevel;
  @JsonKey(includeIfNull: false)
  bool? isSwapFree;
  @JsonKey(includeIfNull: false)
  int? limitPositions;
  @JsonKey(includeIfNull: false)
  int? limitPending;
  @JsonKey(includeIfNull: false)
  int? rights;
  @JsonKey(defaultValue: false)
  bool isDefault;
  @JsonKey(defaultValue: 0.0)
  double marginCallLevel;
  @JsonKey(defaultValue: "")
  final String connectionMode;

  ConnectedAccountInfoModel({
    required this.id,
    required this.group,
    required this.leverage,
    required this.balance,
    required this.credit,
    required this.equity,
    required this.floating,
    required this.margin,
    required this.marginFree,
    this.marginLevel,
    this.isSwapFree,
    required this.fullName,
    this.limitPositions,
    this.limitPending,
    this.rights,
    required this.isDefault,
    required this.marginCallLevel,
    required this.connectionMode,
  });

  ConnectedAccountInfoEntity copyToEntity() {
    return ConnectedAccountInfoEntity(
      id: id,
      group: group,
      leverage: leverage,
      balance: balance,
      fullName: fullName,
      credit: credit,
      equity: equity,
      floating: floating,
      margin: margin,
      marginFree: marginFree,
      rights: rights,
      marginLevel: marginLevel,
      limitPending: limitPending,
      limitPositions: limitPositions,
      isSwapFree: isSwapFree,
      isDefault: isDefault,
      marginCallLevel: marginCallLevel,
      connectionMode: connectionMode,
    );
  }

  factory ConnectedAccountInfoModel.fromJson(Map<String, dynamic> json) =>
      _$ConnectedAccountInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConnectedAccountInfoModelToJson(this);
}
