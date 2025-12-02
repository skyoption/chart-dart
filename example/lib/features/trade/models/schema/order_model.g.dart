// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
  id: (json['id'] as num).toInt(),
  expirationDate: json['expirationDate'] as String? ?? '',
  symbol: json['symbolName'] as String? ?? '',
  direction: json['direction'] as String? ?? '',
  volume: (json['volume'] as num?)?.toDouble() ?? 0,
  tp: (json['tp'] as num?)?.toDouble() ?? 0,
  sl: (json['sl'] as num?)?.toDouble() ?? 0,
  openPrice: (json['openPrice'] as num?)?.toDouble() ?? 0,
  createdAt: json['createdAt'] as String? ?? '',
  comment: json['comment'] as String? ?? '',
  openTime: json['openTime'] as String? ?? '',
);

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'symbolName': instance.symbol,
      'direction': instance.direction,
      'expirationDate': instance.expirationDate,
      'createdAt': instance.createdAt,
      'volume': instance.volume,
      'openPrice': instance.openPrice,
      'tp': instance.tp,
      'sl': instance.sl,
      'comment': instance.comment,
      'openTime': instance.openTime,
    };
