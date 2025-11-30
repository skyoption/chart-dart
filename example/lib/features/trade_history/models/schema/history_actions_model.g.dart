// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_actions_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryActionModel _$HistoryActionModelFromJson(Map<String, dynamic> json) =>
    HistoryActionModel(
      id: (json['id'] as num).toInt(),
      createdAt: json['createdAt'] as String? ?? '',
      profit: (json['profit'] as num?)?.toDouble() ?? 0,
      price: (json['price'] as num?)?.toDouble() ?? 0,
      direction: json['direction'] as String? ?? '',
      volume: (json['volume'] as num?)?.toDouble() ?? 0,
      type: json['type'] as String? ?? '',
      source: json['source'] as String? ?? '',
      symbol: json['symbolName'] as String? ?? '',
      commission: (json['commission'] as num?)?.toDouble() ?? 0,
      account: (json['account'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$HistoryActionModelToJson(HistoryActionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'account': instance.account,
      'symbolName': instance.symbol,
      'source': instance.source,
      'direction': instance.direction,
      'type': instance.type,
      'volume': instance.volume,
      'commission': instance.commission,
      'price': instance.price,
      'profit': instance.profit,
      'createdAt': instance.createdAt,
    };
