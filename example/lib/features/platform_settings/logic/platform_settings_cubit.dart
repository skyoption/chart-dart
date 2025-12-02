import 'package:example/core/consts/exports.dart';
import 'package:example/core/consts/pick_option.dart';
import 'package:example/core/framework/app_prefs.dart';
import 'package:example/features/platform_settings/models/platform_settings_model.dart';

@singleton
class PlatformSettingsCubit extends Cubit<FlowState> {
  final AppPreferences _preferences;
  late PlatformSettingsModel settings;

  PlatformSettingsCubit(this._preferences) : super(const FlowState()) {
    settings = _preferences.platformSettings;
  }

  void onChartLineSizeChange(PickOption<double>? option) {
    settings = settings.copyWith(chartLineSize: option!.value);
    _saveSettings();
  }

  void toggleTradePositionNotification(bool value) {
    settings = settings.copyWith(tradePositionNotification: value);
    _saveSettings();
  }

  void toggleTradePositionNotificationSound(bool value) {
    settings = settings.copyWith(tradePositionNotificationSound: value);
    _saveSettings();
  }

  void togglePositionNotificationVibration(bool value) {
    settings = settings.copyWith(tradePositionNotificationVibration: value);
    _saveSettings();
  }

  void toggleTradeOrderNotification(bool value) {
    settings = settings.copyWith(tradeOrderNotification: value);
    _saveSettings();
  }

  void toggleTradeOrderNotificationSound(bool value) {
    settings = settings.copyWith(tradeOrderNotificationSound: value);
    _saveSettings();
  }

  void toggleTradeOrderNotificationVibration(bool value) {
    settings = settings.copyWith(tradeOrderNotificationVibration: value);
    _saveSettings();
  }

  void toggleShowAskLine(bool value) {
    settings = settings.copyWith(showAskLine: value);
    _saveSettings();
  }

  void updateChartThemeDarkColor(Color color) {
    settings = settings.copyWith(chartThemeDarkColor: color);
    _saveSettings();
  }

  void updateChartThemeLightColor(Color color) {
    settings = settings.copyWith(chartThemeLightColor: color);
    _saveSettings();
  }

  void updateAreaDarkColor(Color color) {
    settings = settings.copyWith(chartThemeDarkColor: color);
    _saveSettings();
  }

  void updateAreaLightColor(Color color) {
    settings = settings.copyWith(chartThemeLightColor: color);
    _saveSettings();
  }

  void updateAskDarkColor(Color color) {
    settings = settings.copyWith(askDarkColor: color);
    _saveSettings();
  }

  void updateAskLightColor(Color color) {
    settings = settings.copyWith(askLightColor: color);
    _saveSettings();
  }

  void updateBidDarkColor(Color color) {
    settings = settings.copyWith(bidDarkColor: color);
    _saveSettings();
  }

  void updateBidLightColor(Color color) {
    settings = settings.copyWith(bidLightColor: color);
    _saveSettings();
  }

  void updateStopLossDarkColor(Color color) {
    settings = settings.copyWith(stopLossDarkColor: color);
    _saveSettings();
  }

  void updateStopLossLightColor(Color color) {
    settings = settings.copyWith(stopLossLightColor: color);
    _saveSettings();
  }

  void updateTakeProfitDarkColor(Color color) {
    settings = settings.copyWith(takeProfitDarkColor: color);
    _saveSettings();
  }

  void updateTakeProfitLightColor(Color color) {
    settings = settings.copyWith(takeProfitLightColor: color);
    _saveSettings();
  }

  void updateChartGridDarkColor(Color color) {
    settings = settings.copyWith(chartGridDarkColor: color);
    _saveSettings();
  }

  void updateChartGridLightColor(Color color) {
    settings = settings.copyWith(chartGridLightColor: color);
    _saveSettings();
  }

  void updateTradeDarkColor(Color color) {
    settings = settings.copyWith(tradeDarkColor: color);
    _saveSettings();
  }

  void updateTradeLightColor(Color color) {
    settings = settings.copyWith(tradeLightColor: color);
    _saveSettings();
  }

  void updateCursorDarkColor(Color color) {
    settings = settings.copyWith(cursorDarkColor: color);
    _saveSettings();
  }

  void updateCursorLightColor(Color color) {
    settings = settings.copyWith(cursorLightColor: color);
    _saveSettings();
  }

  void updateCandleUpLightColor(Color color) {
    settings = settings.copyWith(candleUpLightColor: color);
    _saveSettings();
  }

  void updateCandleUpDarkColor(Color color) {
    settings = settings.copyWith(candleUpDarkColor: color);
    _saveSettings();
  }

  void updateCandleDownLightColor(Color color) {
    settings = settings.copyWith(candleDownLightColor: color);
    _saveSettings();
  }

  void updateCandleDownDarkColor(Color color) {
    settings = settings.copyWith(candleDownDarkColor: color);
    _saveSettings();
  }

  void _saveSettings() {
    _preferences.setPlatformSettings(settings);
    emit(state.copyWith(data: settings));
    debugPrint(settings.toString());
  }
}
