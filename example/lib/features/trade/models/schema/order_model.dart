import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
import 'package:example/features/trade/models/order_entity.dart';

part 'order_model.g.dart';

@Entity()
@JsonSerializable()
class OrderModel {
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
  @JsonKey(defaultValue: '')
  String comment;
  @JsonKey(defaultValue: '')
  String openTime;

  OrderModel({
    required this.id,
    required this.expirationDate,
    required this.symbol,
    required this.direction,
    required this.volume,
    required this.tp,
    required this.sl,
    required this.openPrice,
    required this.createdAt,
    required this.comment,
    required this.openTime,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  OrderEntity copyToEntity() {
    return OrderEntity(
      id: id,
      direction: direction,
      createdAt: createdAt,
      symbol: symbol,
      expirationDate: expirationDate,
      comment: comment,
      volume: volume,
      openPrice: openPrice,
      openTime: openTime,
      sl: sl,
      tp: tp,
    );
  }
}
