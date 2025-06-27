import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
import 'package:example/features/trade_history/models/history_action_entity.dart';

part 'history_actions_model.g.dart';

@Entity()
@JsonSerializable()
class HistoryActionModel {
  @Id(assignable: true)
  int id;
  @JsonKey(defaultValue: 0)
  int account;
  @JsonKey(name: 'symbolName', defaultValue: '')
  String symbol;
  @JsonKey(defaultValue: '')
  String source;
  @JsonKey(defaultValue: '')
  String direction;
  @JsonKey(defaultValue: '')
  String type;
  @JsonKey(defaultValue: 0)
  double volume;
  @JsonKey(defaultValue: 0)
  double commission;
  @JsonKey(defaultValue: 0)
  double price;
  @JsonKey(defaultValue: 0)
  double profit;
  @JsonKey(defaultValue: '')
  String createdAt;

  HistoryActionModel({
    required this.id,
    required this.createdAt,
    required this.profit,
    required this.price,
    required this.direction,
    required this.volume,
    required this.type,
    required this.source,
    required this.symbol,
    required this.commission,
    required this.account,
  });

  factory HistoryActionModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryActionModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryActionModelToJson(this);

  HistoryActionEntity copyToEntity() {
    return HistoryActionEntity(
      id: id,
      type: type,
      direction: direction,
      commission: commission,
      price: price,
      createdAt: createdAt,
      source: source,
      volume: volume,
      account: account,
      profit: profit,
      symbol: symbol,
    );
  }
}
