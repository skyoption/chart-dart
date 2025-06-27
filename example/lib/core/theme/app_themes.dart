// ignore_for_file: depend_on_referenced_packages

import 'package:flash/flash.dart';
import 'package:flutter/scheduler.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/main.dart';

class AppThemes {
  static ThemeData get light {
    return ThemeData(
      fontFamily: Fonts.ar,
      scaffoldBackgroundColor: AppColorScheme.light.surface,
      appBarTheme: AppBarTheme(backgroundColor: AppColorScheme.light.surface),
      colorScheme: AppColorScheme.light,
      brightness: Brightness.light,
      iconTheme: IconThemeData(
        color: AppColorScheme.light.onSurfaceVariant,
      ),
      textTheme: TextTheme(
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: AppColorScheme.dark.scrim,
        ),
        titleSmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColorScheme.dark.scrim,
        ),
        bodyMedium: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: AppColorScheme.dark.scrim,
        ),
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(AppColorScheme.light.outline),
      ),
    ).extendsOption;
  }

  static ThemeData get dark {
    return ThemeData(
      fontFamily: Fonts.ar,
      scaffoldBackgroundColor: AppColorScheme.dark.surface,
      appBarTheme: AppBarTheme(backgroundColor: AppColorScheme.dark.surface),
      colorScheme: AppColorScheme.dark,
      brightness: Brightness.dark,
      iconTheme: IconThemeData(
        color: AppColorScheme.dark.onSurfaceVariant,
      ),
      textTheme: TextTheme(
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: AppColorScheme.dark.scrim,
        ),
        bodyMedium: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: AppColorScheme.dark.scrim,
        ),
        titleSmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColorScheme.dark.scrim,
        ),
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(AppColorScheme.dark.outline),
      ),
    ).extendsOption;
  }
}

extension OnTheme on ThemeData {
  ThemeData get extendsOption {
    return copyWith(extensions: [
      const FlashToastTheme(),
      const FlashBarTheme(),
    ]);
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
        return Svgs.changeThemeIcon;
      case AppThemeMode.dark:
        return Svgs.darkModeIcon;
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
