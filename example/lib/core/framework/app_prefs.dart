import 'package:example/core/consts/constants.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/features/settings/models/platform_settings_model.dart';

@injectable
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

  AppThemeMode get appThemeMode {
    int savedIndex = getData(Constants.THEME, AppThemeMode.light.index);
    return AppThemeMode.values[savedIndex];
  }

  set appThemeMode(AppThemeMode appThemeMode) {
    putData(Constants.THEME, appThemeMode.index);
  }

  String get language => getData(Constants.LANG, Constants.DEFAULT_LANGUAGE);

  set language(String value) {
    putData(Constants.LANG, value);
  }

  PlatformSettingsModel get platformSettings {
    final defaultSettings =
        jsonEncode(PlatformSettingsModel.defaultSettings().toJson());
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
