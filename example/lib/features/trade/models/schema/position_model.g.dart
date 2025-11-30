// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PositionModel _$PositionModelFromJson(Map<String, dynamic> json) =>
    PositionModel(
      id: (json['id'] as num).toInt(),
      groupSymbol: json['groupSymbol'] as String? ?? '',
      direction: json['direction'] as String? ?? '',
      volumeInit: (json['volumeInit'] as num?)?.toDouble() ?? 0,
      volumeCurrent: (json['volumeCurrent'] as num?)?.toDouble() ?? 0,
      openPrice: (json['openPrice'] as num?)?.toDouble() ?? 0,
      tp: (json['tp'] as num?)?.toDouble() ?? 0,
      sl: (json['sl'] as num?)?.toDouble() ?? 0,
      floating: (json['floating'] as num?)?.toDouble() ?? 0,
      margin: (json['margin'] as num?)?.toDouble() ?? 0,
      commission: (json['commission'] as num?)?.toDouble() ?? 0,
      swap: (json['swap'] as num?)?.toDouble() ?? 0,
      comment: json['comment'] as String? ?? '',
      openTime: json['openTime'] as String? ?? '',
    );

Map<String, dynamic> _$PositionModelToJson(PositionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'groupSymbol': instance.groupSymbol,
      'direction': instance.direction,
      'volumeInit': instance.volumeInit,
      'volumeCurrent': instance.volumeCurrent,
      'openPrice': instance.openPrice,
      'tp': instance.tp,
      'sl': instance.sl,
      'floating': instance.floating,
      'margin': instance.margin,
      'commission': instance.commission,
      'swap': instance.swap,
      'comment': instance.comment,
      'openTime': instance.openTime,
    };
