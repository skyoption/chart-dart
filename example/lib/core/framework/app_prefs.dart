import 'package:example/core/consts/constants.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/theme/app_themes.dart';
import 'package:example/features/platform_settings/models/platform_settings_model.dart';

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<bool> putData(String key, dynamic value) async {
    if (value is String) return await _sharedPreferences.setString(key, value);
    if (value is int) return await _sharedPreferences.setInt(key, value);
    return await _sharedPreferences.setBool(key, value);
  }

  dynamic getData(String key, dynamic def) {
    var value = _sharedPreferences.get(key);
    return value ?? def;
  }

  Future<bool> remove(String key) async {
    return await _sharedPreferences.remove(key);
  }

  String get language => getData(Constants.LANG, Constants.DEFAULT_LANGUAGE);

  bool get isArabic => language == Constants.AR_CODE;

  set language(String value) {
    putData(Constants.LANG, value);
  }

  AppThemeMode get appThemeMode {
    int savedIndex = getData(Constants.THEME, AppThemeMode.system.index);
    return AppThemeMode.values[savedIndex];
  }

  set appThemeMode(AppThemeMode appThemeMode) {
    putData(Constants.THEME, appThemeMode.index);
  }

  bool get isFirstStartUp => getData(Constants.IS_FIRST_START_UP, true);

  set isFirstStartUp(bool value) {
    putData(Constants.IS_FIRST_START_UP, value);
  }

  bool get chartOnboardingCompleted =>
      getData(Constants.CHART_ONBOARDING_COMPLETED, false);

  set chartOnboardingCompleted(bool value) {
    putData(Constants.CHART_ONBOARDING_COMPLETED, value);
  }

  bool get tradeOnboardingCompleted =>
      getData(Constants.TRADE_ONBOARDING_COMPLETED, false);

  set tradeOnboardingCompleted(bool value) {
    putData(Constants.TRADE_ONBOARDING_COMPLETED, value);
  }

  PlatformSettingsModel get platformSettings {
    final defaultSettings = jsonEncode(
      PlatformSettingsModel.defaultSettings().toJson(),
    );
    final jsonString = getData(Constants.PLATFORM_SETTINGS, defaultSettings);
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    return PlatformSettingsModel.fromJson(json);
  }

  Future<bool> setPlatformSettings(PlatformSettingsModel settings) async {
    final jsonString = jsonEncode(settings.toJson());
    return putData(Constants.PLATFORM_SETTINGS, jsonString);
  }

  bool get isUserLoggedIn {
    final jsonString = getData(Constants.USERCACHED, '');
    return jsonString != null && jsonString.isNotEmpty;
  }
}
