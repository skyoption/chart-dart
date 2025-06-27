import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
import 'package:example/features/trade_history/models/history_position_entity.dart';

part 'history_position_model.g.dart';

@Entity()
@JsonSerializable()
class HistoryPositionModel {
  @Id(assignable: true)
  int id;
  @JsonKey(defaultValue: '')
  String symbol;
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
  @JsonKey(defaultValue: 0)
  double closePrice;
  @JsonKey(defaultValue: '')
  String closeTime;

  HistoryPositionModel({
    required this.id,
    required this.symbol,
    required this.direction,
    required this.volumeInit,
    required this.closeTime,
    required this.volumeCurrent,
    required this.openPrice,
    required this.tp,
    required this.sl,
    required this.closePrice,
    required this.floating,
    required this.margin,
    required this.commission,
    required this.swap,
    required this.comment,
    required this.openTime,
  });

  factory HistoryPositionModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryPositionModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryPositionModelToJson(this);

  HistoryPositionEntity copyToEntity() {
    return HistoryPositionEntity(
      id: id,
      margin: margin,
      direction: direction,
      comment: comment,
      date: closeTime,
      commission: commission,
      amount: floating,
      openPrice: openPrice,
      openTime: openTime,
      sl: sl,
      closePrice: closePrice,
      swap: swap,
      tp: tp,
      volumeCurrent: volumeCurrent,
      volumeInit: volumeInit,
      symbol: symbol,
      type: '',
      isA: 'position',
      source: '',
    );
  }
}
