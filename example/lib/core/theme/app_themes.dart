// ignore_for_file: depend_on_referenced_packages

import 'package:example/app.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/theme/app_color_scheme.dart';
import 'package:flash/flash.dart';
import 'package:flutter/scheduler.dart';

class AppThemes {
  static final appColorScheme = AppColorScheme();

  static ThemeData get light {
    return ThemeData(
      fontFamily: Fonts.ar,
      scaffoldBackgroundColor: appColorScheme.light.surface,
      appBarTheme: AppBarTheme(backgroundColor: appColorScheme.light.surface),
      colorScheme: appColorScheme.light,
      brightness: Brightness.light,
      iconTheme: IconThemeData(color: appColorScheme.light.onSurfaceVariant),
      textTheme: TextTheme(
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Color(0xFF020000),
        ),
        titleSmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xFF020000),
        ),
        bodyMedium: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: Color(0xFF020000),
        ),
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(appColorScheme.light.outline),
      ),
    ).extendsOptions;
  }

  static ThemeData get dark {
    return ThemeData(
      fontFamily: Fonts.ar,
      scaffoldBackgroundColor: appColorScheme.dark.surface,
      appBarTheme: AppBarTheme(backgroundColor: appColorScheme.dark.surface),
      colorScheme: appColorScheme.dark,
      brightness: Brightness.dark,
      iconTheme: IconThemeData(color: appColorScheme.dark.onSurfaceVariant),
      textTheme: TextTheme(
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Color(0xFFFEFEFE),
        ),
        bodyMedium: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: Color(0xFFFEFEFE),
        ),
        titleSmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xFFFEFEFE),
        ),
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(appColorScheme.dark.outline),
      ),
    ).extendsOptions;
  }
}

extension OnTheme on ThemeData {
  ThemeData get extendsOptions {
    return copyWith(
      extensions: [const FlashToastTheme(), const FlashBarTheme()],
    );
  }
}

enum AppThemeMode { light, dark, system }

extension AppThemeModeExtension on AppThemeMode {
  int get index {
    switch (this) {
      case AppThemeMode.light:
        return 0;
      case AppThemeMode.dark:
        return 1;
      case AppThemeMode.system:
        return 2;
    }
  }

  ThemeData get data {
    switch (this) {
      case AppThemeMode.light:
        return AppThemes.light;
      case AppThemeMode.dark:
        return AppThemes.dark;
      case AppThemeMode.system:
        return _getThemeBySystemDefaults();
    }
  }

  String get icon {
    switch (this) {
      case AppThemeMode.light:
        return Svgs.lightMode;
      case AppThemeMode.dark:
        return Svgs.darkMode;
      case AppThemeMode.system:
        return Svgs.settings;
    }
  }

  String get name {
    switch (this) {
      case AppThemeMode.light:
        return SkyTrading.tr.light;
      case AppThemeMode.dark:
        return SkyTrading.tr.dark;
      case AppThemeMode.system:
        return SkyTrading.tr.defaultSystem;
    }
  }

  ThemeData _getThemeBySystemDefaults() {
    final Brightness systemBrightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    if (systemBrightness == Brightness.dark) return AppThemes.dark;
    return AppThemes.light;
  }

  bool get isDarkTheme => data.brightness == Brightness.dark;
}

AppThemeMode getAppThemeModeFromIndex(int index) {
  switch (index) {
    case 0:
      return AppThemeMode.light;
    case 1:
      return AppThemeMode.dark;
    case 2:
      return AppThemeMode.system;
    default:
      return AppThemeMode.light;
  }
}
