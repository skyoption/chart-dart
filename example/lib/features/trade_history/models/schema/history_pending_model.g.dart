// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_pending_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryPendingModel _$HistoryPendingModelFromJson(Map<String, dynamic> json) =>
    HistoryPendingModel(
      id: (json['id'] as num).toInt(),
      expirationDate: json['expirationDate'] as String? ?? '',
      symbol: json['symbolName'] as String? ?? '',
      direction: json['direction'] as String? ?? '',
      closedAt: json['closedAt'] as String? ?? '',
      reason: json['reason'] as String? ?? '',
      volume: (json['volume'] as num?)?.toDouble() ?? 0,
      tp: (json['tp'] as num?)?.toDouble() ?? 0,
      sl: (json['sl'] as num?)?.toDouble() ?? 0,
      openPrice: (json['openPrice'] as num?)?.toDouble() ?? 0,
      type: (json['type'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] as String? ?? '',
      comment: json['comment'] as String? ?? '',
      openTime: json['openTime'] as String? ?? '',
    );

Map<String, dynamic> _$HistoryPendingModelToJson(
  HistoryPendingModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'symbolName': instance.symbol,
  'direction': instance.direction,
  'expirationDate': instance.expirationDate,
  'createdAt': instance.createdAt,
  'volume': instance.volume,
  'openPrice': instance.openPrice,
  'tp': instance.tp,
  'sl': instance.sl,
  'type': instance.type,
  'comment': instance.comment,
  'openTime': instance.openTime,
  'closedAt': instance.closedAt,
  'reason': instance.reason,
};
