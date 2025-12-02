// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_founds_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountFoundsModel _$AccountFoundsModelFromJson(Map<String, dynamic> json) =>
    AccountFoundsModel(
        id: (json['id'] as num).toInt(),
        amount: (json['amount'] as num?)?.toDouble() ?? 0,
        type: json['type'] as String? ?? '',
        comment: json['comment'] as String? ?? '',
        source: json['source'] as String? ?? '',
        date: json['createdAt'] as String? ?? '',
      )
      ..commission = (json['commission'] as num?)?.toDouble() ?? 0
      ..isA = json['isA'] as String? ?? 'found'
      ..swap = (json['swap'] as num?)?.toDouble() ?? 0;

Map<String, dynamic> _$AccountFoundsModelToJson(AccountFoundsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'amount': instance.amount,
      'comment': instance.comment,
      'source': instance.source,
      'createdAt': instance.date,
      'commission': instance.commission,
      'isA': instance.isA,
      'swap': instance.swap,
    };
