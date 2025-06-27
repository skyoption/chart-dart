// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connected_account_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConnectedAccountInfoModel _$ConnectedAccountInfoModelFromJson(
        Map<String, dynamic> json) =>
    ConnectedAccountInfoModel(
      id: (json['number'] as num?)?.toInt() ?? 0,
      group: json['group'] as String? ?? '',
      leverage: (json['leverage'] as num?)?.toInt() ?? 1,
      balance: (json['balance'] as num?)?.toDouble() ?? 0.0,
      credit: (json['credit'] as num?)?.toDouble() ?? 0.0,
      equity: (json['equity'] as num?)?.toDouble() ?? 0.0,
      floating: (json['floating'] as num?)?.toDouble() ?? 0.0,
      margin: (json['margin'] as num?)?.toDouble() ?? 0.0,
      marginFree: (json['marginFree'] as num?)?.toDouble() ?? 0.0,
      marginLevel: (json['marginLevel'] as num?)?.toDouble(),
      isSwapFree: json['isSwapFree'] as bool?,
      fullName: json['fullName'] as String? ?? '',
      limitPositions: (json['limitPositions'] as num?)?.toInt(),
      limitPending: (json['limitPending'] as num?)?.toInt(),
      rights: (json['rights'] as num?)?.toInt(),
      isDefault: json['isDefault'] as bool? ?? false,
    );

Map<String, dynamic> _$ConnectedAccountInfoModelToJson(
        ConnectedAccountInfoModel instance) =>
    <String, dynamic>{
      'number': instance.id,
      'group': instance.group,
      'fullName': instance.fullName,
      'leverage': instance.leverage,
      'balance': instance.balance,
      'credit': instance.credit,
      'equity': instance.equity,
      'floating': instance.floating,
      'margin': instance.margin,
      'marginFree': instance.marginFree,
      if (instance.marginLevel case final value?) 'marginLevel': value,
      if (instance.isSwapFree case final value?) 'isSwapFree': value,
      if (instance.limitPositions case final value?) 'limitPositions': value,
      if (instance.limitPending case final value?) 'limitPending': value,
      if (instance.rights case final value?) 'rights': value,
      'isDefault': instance.isDefault,
    };
