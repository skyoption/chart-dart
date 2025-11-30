// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlatformSettingsModel _$PlatformSettingsModelFromJson(
        Map<String, dynamic> json) =>
    PlatformSettingsModel(
      tradeNotification: json['trade_notification'] as bool? ?? true,
      tradeNotificationVibration:
          json['trade_notification_vibration'] as bool? ?? true,
      tradeNotificationSound: json['trade_notification_sound'] as bool? ?? true,
      showAskLine: json['chart_ask_line'] as bool? ?? true,
      chartLineSize: (json['chart_line_size'] as num?)?.toDouble() ?? 1.0,
      chartThemeDarkColorValue:
          (json['chart_theme_color'] as num?)?.toInt() ?? 4286612100,
      askDarkColorValue: (json['ask_color'] as num?)?.toInt() ?? -12651722,
      bidDarkColorValue: (json['bid_color'] as num?)?.toInt() ?? 7331033,
      stopLossDarkColorValue:
          (json['stop_loss_color'] as num?)?.toInt() ?? -12651722,
      takeProfitDarkColorValue:
          (json['take_profit_color'] as num?)?.toInt() ?? 2613088,
      chartGridDarkColorValue:
          (json['default_chart_grid_color'] as num?)?.toInt() ?? 4286612100,
      chartThemeLightColorValue:
          (json['chart_theme_color_light'] as num?)?.toInt() ?? 7331033,
      askLightColorValue:
          (json['ask_color_light'] as num?)?.toInt() ?? -12651722,
      bidLightColorValue: (json['bid_color_light'] as num?)?.toInt() ?? 7331033,
      stopLossLightColorValue:
          (json['stop_loss_color_light'] as num?)?.toInt() ?? -12651722,
      takeProfitLightColorValue:
          (json['take_profit_color_light'] as num?)?.toInt() ?? 2613088,
      chartGridLightColorValue:
          (json['default_chart_grid_color_light'] as num?)?.toInt() ??
              4286612100,
      tradeLightColorValue:
          (json['position_light_color_value'] as num?)?.toInt() ?? 4289871338,
      tradeDarkColorValue:
          (json['position_dark_color_value'] as num?)?.toInt() ?? 4289871338,
      areaDarkColorValue:
          (json['chart_area_dark_color'] as num?)?.toInt() ?? 4286612100,
      areaLightColorValue:
          (json['chart_area_light_color'] as num?)?.toInt() ?? 4286612100,
    );

Map<String, dynamic> _$PlatformSettingsModelToJson(
        PlatformSettingsModel instance) =>
    <String, dynamic>{
      'trade_notification': instance.tradeNotification,
      'trade_notification_vibration': instance.tradeNotificationVibration,
      'trade_notification_sound': instance.tradeNotificationSound,
      'chart_ask_line': instance.showAskLine,
      'chart_line_size': instance.chartLineSize,
      'chart_theme_color': instance.chartThemeDarkColorValue,
      'ask_color': instance.askDarkColorValue,
      'bid_color': instance.bidDarkColorValue,
      'stop_loss_color': instance.stopLossDarkColorValue,
      'take_profit_color': instance.takeProfitDarkColorValue,
      'default_chart_grid_color': instance.chartGridDarkColorValue,
      'chart_theme_color_light': instance.chartThemeLightColorValue,
      'ask_color_light': instance.askLightColorValue,
      'bid_color_light': instance.bidLightColorValue,
      'stop_loss_color_light': instance.stopLossLightColorValue,
      'take_profit_color_light': instance.takeProfitLightColorValue,
      'default_chart_grid_color_light': instance.chartGridLightColorValue,
      'position_light_color_value': instance.tradeLightColorValue,
      'position_dark_color_value': instance.tradeDarkColorValue,
      'chart_area_dark_color': instance.areaDarkColorValue,
      'chart_area_light_color': instance.areaLightColorValue,
    };
