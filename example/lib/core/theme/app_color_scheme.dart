import 'package:flutter/material.dart';

class AppColorScheme {
  static const ColorScheme light = ColorScheme(
    brightness: Brightness.light,
    // Primary Color
    primary: Color(0xff580099),
    inversePrimary: Color(0xffb64aff),
    primaryFixed: Color(0xFFB3B3B3),
    primaryFixedDim: Color(0xFF000000),
    secondary: Color(0xFF580099),
    surfaceBright: Color(0xFF87CEEB),

    // Background Color
    surface: Color(0xFFFFFFFF),
    // Custom Black Color
    scrim: Color(0xFF43384D),
    // bottom sheet bg
    primaryContainer: Color(0xFFFFFFFF),
    // Secondary Card Color
    secondaryContainer: Color(0xFF43384D),
    surfaceContainer: Color(0xFFF9F9F9),
    // Text Color
    onSurface: Color(0xffB3B3B3),
    // Icon Color
    onSurfaceVariant: Color(0xFFFFFFFF),
    // Red Color
    error: Color(0xFFEC3036),
    // Border Color
    outline: Color(0xFFF1F1F1),
    // Third Text Color
    tertiary: Color(0xFFFEFEFE),

    onPrimary: Color(0xFFFFFFFF),
    onSecondary: Color(0xFFFFFFFF),
    onError: Color(0xFFFFFFFF),
    onPrimaryContainer: Color(0xFF3C0D72),
    onSecondaryContainer: Color(0xFF145C45),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFFFB3D5),
    onTertiaryContainer: Color(0xFF800039),
    errorContainer: Color(0xFFFF9999),
    onErrorContainer: Color(0xFF660000),
    secondaryFixed: Color(0xff686C76),
    surfaceContainerHighest: Color(0xFFE0DAE3),
    inverseSurface: Color(0xFF353238),
    onInverseSurface: Color(0xFFFFFFFF),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF003f7a),
    onSecondaryFixed: Color(0xff1B3F48),
    surfaceContainerLowest: Color(0xFFDEE9FF),
    surfaceContainerLow: Color(0xFFF0F0F0),
    outlineVariant: Color(0xFFAAB5BF),
    surfaceDim: Color(0xFFF8B84E),
    secondaryFixedDim: Color(0xFFFF9933),
    tertiaryFixed: Color(0xffDDA809),
  );

  static const ColorScheme dark = ColorScheme(
    brightness: Brightness.dark,
    // Primary Color
    primary: Color(0xFF580099),
    surfaceBright: Color(0xFF1EAEE9),
    secondary: Color(0xFFEBD1FF),
    inversePrimary: Color(0xffb64aff),
    primaryFixedDim: Color(0xFF000000),
    // Background Color
    primaryFixed: Color(0xFFB3B3B3),
    surface: Color(0xFF121212),
    // Custom Black
    scrim: Color(0xFFFEFEFE),
    // Card Color
    surfaceContainer: Color(0xFF252525),
    // bottom sheet bg
    primaryContainer: Color(0xff1E1E1E),
    // Secondary Card Color
    secondaryContainer: Color(0xFF9E9E9E),
    // Text Color
    onSurface: Color(0xFFB3B3B3),
    // Icon Color
    onSurfaceVariant: Color(0xFFFEFEFE),
    // Red Color
    error: Color(0xFFEC3036),
    // Border Color
    outline: Color(0xFF3E3E3E),
    // Third Text Color
    surfaceContainerLow: Color(0xFF222222),
    surfaceContainerLowest: Color(0xFF1A2335),
    tertiary: Color(0xFFFEFEFE),
    secondaryFixed: Color(0xff686C76),
    onSecondaryFixed: Color(0xff1B3F48),
    onPrimary: Color(0xFFFFFFFF),
    onSecondary: Color(0xFFFFFFFF),
    onError: Color(0xFFFFFFFF),
    onPrimaryContainer: Color(0xFF27B588),
    onSecondaryContainer: Color(0xFF1D0637),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFF800039),
    onTertiaryContainer: Color(0xFFFFDBEB),
    errorContainer: Color(0xFF660000),
    onErrorContainer: Color(0xFFFFCCCC),
    surfaceContainerHighest: Color(0xFF190024),
    inverseSurface: Color(0xFFFFFFFF),
    onInverseSurface: Color(0xFF353238),
    shadow: Color(0xFF132428),
    surfaceTint: Color(0xFF003f7a),
    outlineVariant: Color(0xFFAAB5BF),
    surfaceDim: Color(0xFFF8B84E),
    secondaryFixedDim: Color(0xFFFF9933),
    tertiaryFixed: Color(0xffDDA809),
  );
}

extension ColorSchemeExt on ColorScheme {
  bool isLightMode() => brightness == Brightness.light;

  Color get success => const Color(0xFF27AE60);

  Color get onSuccess => const Color(0xFFFEFEFE);

  Color get successContainer => const Color(0xFFBFE9D1);

  Color get onSuccessContainer => const Color(0xFFC1FFEC);

  Color get warning => const Color(0xFFFF9933);

  Color get onWarning => const Color(0xFFFEFEFE);

  Color get warningContainer => const Color(0xFFFFF4D6);

  Color get onWarningContainer => const Color(0xFFDC6803);

  Color get surfaceDisabled =>
      isLightMode() ? const Color(0xFFD8D8D8) : const Color(0xFF2F2F2F);

  Color get onSurfaceDisabled =>
      isLightMode() ? const Color(0xFFB3B3B3) : const Color(0xFF717178);

  Color get border =>
      isLightMode() ? const Color(0xFFD5D5D5) : const Color(0xFF414141);

  Color get lightBorder =>
      isLightMode() ? const Color(0xFFE8E8E8) : const Color(0xFF363636);

  Color get surfaceVariant =>
      isLightMode() ? const Color(0xFFF8F8F8) : const Color(0xFF1B1C1D);
}
