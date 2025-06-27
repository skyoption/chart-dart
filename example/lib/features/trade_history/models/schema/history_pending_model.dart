import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
import 'package:example/features/trade_history/models/history_pending_entity.dart';

part 'history_pending_model.g.dart';

@Entity()
@JsonSerializable()
class HistoryPendingModel {
  @Id(assignable: true)
  int id;
  @JsonKey(defaultValue: '', name: 'symbolName')
  String symbol;
  @JsonKey(defaultValue: '')
  String direction;
  @JsonKey(defaultValue: '')
  String expirationDate;
  @JsonKey(defaultValue: '')
  String createdAt;
  @JsonKey(defaultValue: 0)
  double volume;
  @JsonKey(defaultValue: 0)
  double openPrice;
  @JsonKey(defaultValue: 0)
  double tp;
  @JsonKey(defaultValue: 0)
  double sl;
  @JsonKey(defaultValue: 0)
  int type;
  @JsonKey(defaultValue: '')
  String comment;
  @JsonKey(defaultValue: '')
  String openTime;
  @JsonKey(defaultValue: '')
  String closedAt;
  @JsonKey(defaultValue: '')
  String reason;

  HistoryPendingModel({
    required this.id,
    required this.expirationDate,
    required this.symbol,
    required this.direction,
    required this.closedAt,
    required this.reason,
    required this.volume,
    required this.tp,
    required this.sl,
    required this.openPrice,
    required this.type,
    required this.createdAt,
    required this.comment,
    required this.openTime,
  });

  factory HistoryPendingModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryPendingModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryPendingModelToJson(this);

  HistoryPendingEntity copyToEntity() {
    return HistoryPendingEntity(
      id: id,
      direction: direction,
      createdAt: createdAt,
      symbol: symbol,
      expirationDate: expirationDate,
      comment: comment,
      volume: volume,
      reason: reason,
      closedAt: closedAt,
      openPrice: openPrice,
      type: type,
      openTime: openTime,
      sl: sl,
      tp: tp,
    );
  }
}
