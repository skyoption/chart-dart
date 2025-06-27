import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/features/trade/models/position_entity.dart';

part 'position_model.g.dart';

@Entity()
@JsonSerializable()
class PositionModel {
  @Id(assignable: true)
  int id;
  @JsonKey(defaultValue: '')
  String groupSymbol;
  @JsonKey(defaultValue: '')
  String direction;
  @JsonKey(defaultValue: 0)
  double volumeInit;
  @JsonKey(defaultValue: 0)
  double volumeCurrent;
  @JsonKey(defaultValue: 0)
  double openPrice;
  @JsonKey(defaultValue: 0)
  double tp;
  @JsonKey(defaultValue: 0)
  double sl;
  @JsonKey(defaultValue: 0)
  double floating;
  @JsonKey(defaultValue: 0)
  double margin;
  @JsonKey(defaultValue: 0)
  double commission;
  @JsonKey(defaultValue: 0)
  double swap;
  @JsonKey(defaultValue: '')
  String comment;
  @JsonKey(defaultValue: '')
  String openTime;

  PositionModel({
    required this.id,
    required this.groupSymbol,
    required this.direction,
    required this.volumeInit,
    required this.volumeCurrent,
    required this.openPrice,
    required this.tp,
    required this.sl,
    required this.floating,
    required this.margin,
    required this.commission,
    required this.swap,
    required this.comment,
    required this.openTime,
  });

  factory PositionModel.fromJson(Map<String, dynamic> json) =>
      _$PositionModelFromJson(json);

  Map<String, dynamic> toJson() => _$PositionModelToJson(this);

  PositionEntity copyToEntity() {
    return PositionEntity(
      id: id,
      margin: margin,
      direction: direction,
      comment: comment,
      commission: commission.toTwoDecimalNum,
      floating: floating.toTwoDecimalNum,
      openPrice: openPrice,
      openTime: openTime,
      sl: sl,
      swap: swap,
      tp: tp,
      volumeCurrent: volumeCurrent.toTwoDecimalNum,
      volumeInit: volumeInit.toTwoDecimalNum,
      groupSymbol: groupSymbol,
    );
  }
}
