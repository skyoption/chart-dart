import 'dart:math';

import 'package:example/core/consts/constants.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/app_prefs.dart';

@singleton
class AppCubit extends Cubit<FlowState> {
  final AppPreferences _preferences;

  late Locale locale;
  late AppThemeMode appThemeMode;
  late ValueNotifier<bool> isArSelected;
  late bool isDarkTheme;

  AppCubit(this._preferences) : super(FlowState()) {
    locale = Locale(_preferences.language);
    appThemeMode = _preferences.appThemeMode;
    isDarkTheme = appThemeMode.data.brightness == Brightness.dark;
    isArSelected = ValueNotifier(_preferences.language == Constants.AR_CODE);
  }

  static int get randomInt => Random().nextInt(1000);

  String get selectedLang => _preferences.language;

  void changeLang(String lang) {
    locale = Locale(lang);
    _preferences.language = lang;
    isArSelected.value = _preferences.language == Constants.AR_CODE;
    emit(state.copyWith(data: randomInt));
  }

  void changeThemeMode(int index) {
    _preferences.appThemeMode = getAppThemeModeFromIndex(index);
    appThemeMode = _preferences.appThemeMode;
    emit(state.copyWith(data: randomInt));
  }

  void applyPlatformThemeMode() {
    if (appThemeMode == AppThemeMode.system) {
      emit(state.copyWith(data: randomInt));
    }
  }
}
