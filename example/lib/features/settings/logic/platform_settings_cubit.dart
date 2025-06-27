import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/app_prefs.dart';
import 'package:example/core/framework/pick_option.dart';
import 'package:example/features/settings/models/platform_settings_model.dart';

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

  void toggleTradeNotification(bool value) {
    settings = settings.copyWith(tradeNotification: value);
    _saveSettings();
  }

  void toggleTradeNotificationSound(bool value) {
    settings = settings.copyWith(tradeNotificationSound: value);
    _saveSettings();
  }

  void toggleNotificationVibration(bool value) {
    settings = settings.copyWith(tradeNotificationVibration: value);
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

  void _saveSettings() {
    _preferences.setPlatformSettings(settings);
    emit(state.copyWith(data: settings));
    debugPrint(settings.toString());
  }
}
