// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlatformSettingsModel _$PlatformSettingsModelFromJson(
  Map<String, dynamic> json,
) => PlatformSettingsModel(
  tradePositionNotification:
      json['trade_position_notification'] as bool? ?? true,
  tradePositionNotificationVibration:
      json['trade_position_notification_vibration'] as bool? ?? true,
  tradePositionNotificationSound:
      json['trade_position_notification_sound'] as bool? ?? true,
  tradeOrderNotification: json['trade_order_notification'] as bool? ?? true,
  tradeOrderNotificationVibration:
      json['trade_order_notification_vibration'] as bool? ?? true,
  tradeOrderNotificationSound:
      json['trade_order_notification_sound'] as bool? ?? true,
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
      (json['default_chart_grid_color'] as num?)?.toInt() ?? 4278856500,
  chartThemeLightColorValue:
      (json['chart_theme_color_light'] as num?)?.toInt() ?? 7331033,
  askLightColorValue: (json['ask_color_light'] as num?)?.toInt() ?? -12651722,
  bidLightColorValue: (json['bid_color_light'] as num?)?.toInt() ?? 7331033,
  stopLossLightColorValue:
      (json['stop_loss_color_light'] as num?)?.toInt() ?? -12651722,
  takeProfitLightColorValue:
      (json['take_profit_color_light'] as num?)?.toInt() ?? 2613088,
  chartGridLightColorValue:
      (json['default_chart_grid_color_light'] as num?)?.toInt() ?? 4286612100,
  tradeLightColorValue:
      (json['position_light_color_value'] as num?)?.toInt() ?? 4289871338,
  tradeDarkColorValue:
      (json['position_dark_color_value'] as num?)?.toInt() ?? 4289871338,
  areaDarkColorValue:
      (json['chart_area_dark_color'] as num?)?.toInt() ?? 4286612100,
  areaLightColorValue:
      (json['chart_area_light_color'] as num?)?.toInt() ?? 4286612100,
  cursorLightColorValue:
      (json['cursor_light_color'] as num?)?.toInt() ?? 4286612100,
  cursorDarkColorValue:
      (json['cursor_dark_color'] as num?)?.toInt() ?? 4278856500,
  candleUpLightColorValue:
      (json['candle_up_light_color'] as num?)?.toInt() ?? 4285195591,
  candleDownLightColorValue:
      (json['candle_down_light_color'] as num?)?.toInt() ?? 4293532938,
  candleUpDarkColorValue:
      (json['candle_up_dark_color'] as num?)?.toInt() ?? 4285195591,
  candleDownDarkColorValue:
      (json['candle_down_dark_color'] as num?)?.toInt() ?? 4293532938,
);

Map<String, dynamic> _$PlatformSettingsModelToJson(
  PlatformSettingsModel instance,
) => <String, dynamic>{
  'trade_position_notification': instance.tradePositionNotification,
  'trade_position_notification_vibration':
      instance.tradePositionNotificationVibration,
  'trade_position_notification_sound': instance.tradePositionNotificationSound,
  'trade_order_notification_sound': instance.tradeOrderNotificationSound,
  'trade_order_notification': instance.tradeOrderNotification,
  'trade_order_notification_vibration':
      instance.tradeOrderNotificationVibration,
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
  'cursor_light_color': instance.cursorLightColorValue,
  'cursor_dark_color': instance.cursorDarkColorValue,
  'candle_up_light_color': instance.candleUpLightColorValue,
  'candle_down_light_color': instance.candleDownLightColorValue,
  'candle_up_dark_color': instance.candleUpDarkColorValue,
  'candle_down_dark_color': instance.candleDownDarkColorValue,
};
