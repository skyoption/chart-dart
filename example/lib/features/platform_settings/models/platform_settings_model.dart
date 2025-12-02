import 'package:example/app.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:example/core/consts/exports.dart';

part 'platform_settings_model.g.dart';

@JsonSerializable()
class PlatformSettingsModel {
  @JsonKey(name: 'trade_position_notification', defaultValue: true)
  final bool tradePositionNotification;

  @JsonKey(name: 'trade_position_notification_vibration', defaultValue: true)
  final bool tradePositionNotificationVibration;

  @JsonKey(name: 'trade_position_notification_sound', defaultValue: true)
  final bool tradePositionNotificationSound;

  @JsonKey(name: 'trade_order_notification_sound', defaultValue: true)
  final bool tradeOrderNotificationSound;

  @JsonKey(name: 'trade_order_notification', defaultValue: true)
  final bool tradeOrderNotification;

  @JsonKey(name: 'trade_order_notification_vibration', defaultValue: true)
  final bool tradeOrderNotificationVibration;

  @JsonKey(name: 'chart_ask_line', defaultValue: true)
  final bool showAskLine;

  @JsonKey(name: 'chart_line_size', defaultValue: 1.0)
  final double chartLineSize;

  @JsonKey(name: 'chart_theme_color', defaultValue: 4286612100)
  final int chartThemeDarkColorValue;

  @JsonKey(name: 'ask_color', defaultValue: -12651722)
  final int askDarkColorValue;

  @JsonKey(name: 'bid_color', defaultValue: 7331033)
  final int bidDarkColorValue;

  @JsonKey(name: 'stop_loss_color', defaultValue: -12651722)
  final int stopLossDarkColorValue;

  @JsonKey(name: 'take_profit_color', defaultValue: 2613088)
  final int takeProfitDarkColorValue;

  @JsonKey(name: 'default_chart_grid_color', defaultValue: 4278856500)
  final int chartGridDarkColorValue;

  @JsonKey(name: 'chart_theme_color_light', defaultValue: 7331033)
  final int chartThemeLightColorValue;

  @JsonKey(name: 'ask_color_light', defaultValue: -12651722)
  final int askLightColorValue;

  @JsonKey(name: 'bid_color_light', defaultValue: 7331033)
  final int bidLightColorValue;

  @JsonKey(name: 'stop_loss_color_light', defaultValue: -12651722)
  final int stopLossLightColorValue;

  @JsonKey(name: 'take_profit_color_light', defaultValue: 2613088)
  final int takeProfitLightColorValue;

  @JsonKey(name: 'default_chart_grid_color_light', defaultValue: 4286612100)
  final int chartGridLightColorValue;

  @JsonKey(name: 'position_light_color_value', defaultValue: 4289871338)
  final int tradeLightColorValue;

  @JsonKey(name: 'position_dark_color_value', defaultValue: 4289871338)
  final int tradeDarkColorValue;

  @JsonKey(name: 'chart_area_dark_color', defaultValue: 4286612100)
  final int areaDarkColorValue;

  @JsonKey(name: 'chart_area_light_color', defaultValue: 4286612100)
  final int areaLightColorValue;

  @JsonKey(name: 'cursor_light_color', defaultValue: 4286612100)
  final int cursorLightColorValue;

  @JsonKey(name: 'cursor_dark_color', defaultValue: 4278856500)
  final int cursorDarkColorValue;

  @JsonKey(name: 'candle_up_light_color', defaultValue: 4285195591)
  final int candleUpLightColorValue;

  @JsonKey(name: 'candle_down_light_color', defaultValue: 4293532938)
  final int candleDownLightColorValue;

  @JsonKey(name: 'candle_up_dark_color', defaultValue: 4285195591)
  final int candleUpDarkColorValue;

  @JsonKey(name: 'candle_down_dark_color', defaultValue: 4293532938)
  final int candleDownDarkColorValue;

  const PlatformSettingsModel({
    this.tradePositionNotification = true,
    this.tradePositionNotificationVibration = true,
    this.tradePositionNotificationSound = true,
    this.tradeOrderNotification = true,
    this.tradeOrderNotificationVibration = true,
    this.tradeOrderNotificationSound = true,
    this.showAskLine = true,
    this.chartLineSize = 1,
    required this.chartThemeDarkColorValue,
    required this.askDarkColorValue,
    required this.bidDarkColorValue,
    required this.stopLossDarkColorValue,
    required this.takeProfitDarkColorValue,
    required this.chartGridDarkColorValue,
    required this.chartThemeLightColorValue,
    required this.askLightColorValue,
    required this.bidLightColorValue,
    required this.stopLossLightColorValue,
    required this.takeProfitLightColorValue,
    required this.chartGridLightColorValue,
    required this.tradeLightColorValue,
    required this.tradeDarkColorValue,
    required this.areaDarkColorValue,
    required this.areaLightColorValue,
    required this.cursorLightColorValue,
    required this.cursorDarkColorValue,
    required this.candleUpLightColorValue,
    required this.candleDownLightColorValue,
    required this.candleUpDarkColorValue,
    required this.candleDownDarkColorValue,
  });

  Color get chartThemeColor => SkyTrading.context.isDarkTheme
      ? Color(chartThemeDarkColorValue)
      : Color(chartThemeLightColorValue);

  Color get askColor => SkyTrading.context.isDarkTheme
      ? Color(askDarkColorValue)
      : Color(askLightColorValue);

  Color get bidColor => SkyTrading.context.isDarkTheme
      ? Color(bidDarkColorValue)
      : Color(bidLightColorValue);

  Color get stopLossColor => SkyTrading.context.isDarkTheme
      ? Color(stopLossDarkColorValue)
      : Color(stopLossLightColorValue);

  Color get takeProfitColor => SkyTrading.context.isDarkTheme
      ? Color(takeProfitDarkColorValue)
      : Color(takeProfitLightColorValue);

  Color get chartGridColor => SkyTrading.context.isDarkTheme
      ? Color(chartGridDarkColorValue)
      : Color(chartGridLightColorValue);

  Color get tradeColor => SkyTrading.context.isDarkTheme
      ? Color(tradeDarkColorValue)
      : Color(tradeLightColorValue);

  Color get areaColor => SkyTrading.context.isDarkTheme
      ? Color(areaDarkColorValue)
      : Color(areaLightColorValue);

  Color get cursorColor => SkyTrading.context.isDarkTheme
      ? Color(cursorDarkColorValue)
      : Color(cursorLightColorValue);

  Color get candleUpColor => SkyTrading.context.isDarkTheme
      ? Color(candleUpDarkColorValue)
      : Color(candleUpLightColorValue);

  Color get candleDownColor => SkyTrading.context.isDarkTheme
      ? Color(candleDownDarkColorValue)
      : Color(candleDownLightColorValue);

  factory PlatformSettingsModel.defaultSettings() => PlatformSettingsModel(
        tradePositionNotificationSound: true,
        tradePositionNotificationVibration: true,
        tradePositionNotification: true,
        tradeOrderNotificationVibration: true,
        tradeOrderNotification: true,
        tradeOrderNotificationSound: true,
        showAskLine: true,
        chartLineSize: 1,
        chartThemeDarkColorValue: AppColors.defaultChartColor.toARGB32(),
        askDarkColorValue: AppColors.defaultAskColor.toARGB32(),
        bidDarkColorValue: AppColors.defaultBidColor.toARGB32(),
        stopLossDarkColorValue: AppColors.defaultStopLossColor.toARGB32(),
        takeProfitDarkColorValue: AppColors.defaultTakeProfitColor.toARGB32(),
        chartGridDarkColorValue: AppColors.defaultChartColor.toARGB32(),
        chartThemeLightColorValue: AppColors.defaultChartColor.toARGB32(),
        askLightColorValue: AppColors.defaultAskColor.toARGB32(),
        bidLightColorValue: AppColors.defaultBidColor.toARGB32(),
        stopLossLightColorValue: AppColors.defaultStopLossColor.toARGB32(),
        takeProfitLightColorValue: AppColors.defaultTakeProfitColor.toARGB32(),
        chartGridLightColorValue: AppColors.defaultChartColor.toARGB32(),
        tradeDarkColorValue: AppColors.tradeDarkColorValue.toARGB32(),
        tradeLightColorValue: AppColors.tradeDarkColorValue.toARGB32(),
        areaDarkColorValue: AppColors.defaultChartColor.toARGB32(),
        areaLightColorValue: AppColors.defaultChartColor.toARGB32(),
        cursorLightColorValue: AppColors.defaultChartColor.toARGB32(),
        cursorDarkColorValue: AppColors.defaultChartColor.toARGB32(),
        candleDownLightColorValue: AppColors.defaultCandleDownColor.toARGB32(),
        candleUpLightColorValue: AppColors.defaultCandleUpColor.toARGB32(),
        candleDownDarkColorValue: AppColors.defaultCandleDownColor.toARGB32(),
        candleUpDarkColorValue: AppColors.defaultCandleUpColor.toARGB32(),
      );

  PlatformSettingsModel copyWith({
    bool? tradePositionNotificationSound,
    bool? tradePositionNotificationVibration,
    bool? tradePositionNotification,
    bool? tradeOrderNotificationVibration,
    bool? tradeOrderNotification,
    bool? tradeOrderNotificationSound,
    bool? showAskLine,
    double? chartLineSize,
    Color? chartThemeDarkColor,
    Color? askDarkColor,
    Color? bidDarkColor,
    Color? stopLossDarkColor,
    Color? takeProfitDarkColor,
    Color? chartGridDarkColor,
    Color? chartThemeLightColor,
    Color? askLightColor,
    Color? bidLightColor,
    Color? stopLossLightColor,
    Color? takeProfitLightColor,
    Color? chartGridLightColor,
    Color? tradeDarkColor,
    Color? tradeLightColor,
    Color? areaDarkColor,
    Color? areaLightColor,
    Color? cursorLightColor,
    Color? cursorDarkColor,
    Color? candleUpLightColor,
    Color? candleDownLightColor,
    Color? candleUpDarkColor,
    Color? candleDownDarkColor,
  }) {
    return PlatformSettingsModel(
      tradePositionNotificationSound:
          tradePositionNotificationSound ?? this.tradePositionNotificationSound,
      tradePositionNotificationVibration: tradePositionNotificationVibration ??
          this.tradePositionNotificationVibration,
      tradePositionNotification:
          tradePositionNotification ?? this.tradePositionNotification,
      tradeOrderNotificationVibration: tradeOrderNotificationVibration ??
          this.tradeOrderNotificationVibration,
      tradeOrderNotification:
          tradeOrderNotification ?? this.tradeOrderNotification,
      tradeOrderNotificationSound:
          tradeOrderNotificationSound ?? this.tradeOrderNotificationSound,
      showAskLine: showAskLine ?? this.showAskLine,
      chartLineSize: chartLineSize ?? this.chartLineSize,
      chartThemeDarkColorValue:
          chartThemeDarkColor?.toARGB32() ?? chartThemeDarkColorValue,
      askDarkColorValue: askDarkColor?.toARGB32() ?? askDarkColorValue,
      bidDarkColorValue: bidDarkColor?.toARGB32() ?? bidDarkColorValue,
      stopLossDarkColorValue:
          stopLossDarkColor?.toARGB32() ?? stopLossDarkColorValue,
      takeProfitDarkColorValue:
          takeProfitDarkColor?.toARGB32() ?? takeProfitDarkColorValue,
      chartGridDarkColorValue:
          chartGridDarkColor?.toARGB32() ?? chartGridDarkColorValue,
      chartThemeLightColorValue:
          chartThemeLightColor?.toARGB32() ?? chartThemeLightColorValue,
      askLightColorValue: askLightColor?.toARGB32() ?? askLightColorValue,
      bidLightColorValue: bidLightColor?.toARGB32() ?? bidLightColorValue,
      stopLossLightColorValue:
          stopLossLightColor?.toARGB32() ?? stopLossLightColorValue,
      takeProfitLightColorValue:
          takeProfitLightColor?.toARGB32() ?? takeProfitLightColorValue,
      chartGridLightColorValue:
          chartGridLightColor?.toARGB32() ?? chartGridLightColorValue,
      tradeLightColorValue: tradeLightColor?.toARGB32() ?? tradeLightColorValue,
      tradeDarkColorValue: tradeDarkColor?.toARGB32() ?? tradeDarkColorValue,
      areaDarkColorValue: areaDarkColor?.toARGB32() ?? areaDarkColorValue,
      areaLightColorValue: areaLightColor?.toARGB32() ?? areaLightColorValue,
      cursorLightColorValue:
          cursorLightColor?.toARGB32() ?? cursorLightColorValue,
      cursorDarkColorValue: cursorDarkColor?.toARGB32() ?? cursorDarkColorValue,
      candleUpLightColorValue:
          candleUpLightColor?.toARGB32() ?? candleUpLightColorValue,
      candleDownLightColorValue:
          candleDownLightColor?.toARGB32() ?? candleDownLightColorValue,
      candleUpDarkColorValue:
          candleUpDarkColor?.toARGB32() ?? candleUpDarkColorValue,
      candleDownDarkColorValue:
          candleDownDarkColor?.toARGB32() ?? candleDownDarkColorValue,
    );
  }

  factory PlatformSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$PlatformSettingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlatformSettingsModelToJson(this);
}
