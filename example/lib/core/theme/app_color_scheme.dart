import 'package:flutter/material.dart';

class AppColorScheme {
  ColorScheme light = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xff6D01BD),
    onPrimary: Color(0xFFFEFEFE),
    primaryContainer: Color(0xFF393140),
    onPrimaryContainer: Color(0xFFD8AAFF),
    secondary: Color(0xFF0FC3C3),
    onSecondary: Color(0xFFFEFEFE),
    secondaryContainer: Color(0xFF103939),
    onSecondaryContainer: Color(0xFFBFFDBF),
    tertiary: Color(0xFFFFD700),
    onTertiary: Color(0xFFFEFEFE),
    tertiaryContainer: Color(0xFFFF7F50),
    onTertiaryContainer: Color(0xFFFFFD9A),
    surface: Color(0xFFFDFDFD),
    onSurface: Color(0xFF020000),
    onSurfaceVariant: Color(0xFF71717A),
    error: Color(0xFFEC3036),
    onError: Color(0xFFFEFEFE),
    errorContainer: Color(0xFFFCEFEF),
    onErrorContainer: Color(0xFFB42318),
    outline: Color(0xFFE4E4E7),
    outlineVariant: Color(0xFFEFEFEF),
    shadow: Color(0xFF000000),
    scrim: Color(0xFFF8F8F8),
    inverseSurface: Color(0xFF111111),
    onInverseSurface: Color(0xFFF7F7F7),
    inversePrimary: Color(0xFFD5E3FF),
    surfaceTint: Color(0xFFFF6657),
    surfaceBright: Color(0xFF2BB6D9),
    surfaceDim: Color(0xFFDADADA),
    surfaceContainer: Color(0xFFF5F5F5),
    surfaceContainerLowest: Color(0xFFDEE9FF),
    surfaceContainerLow: Color(0xFFF0F0F0),
    surfaceContainerHigh: Color(0xFFF1F1F1),
    surfaceContainerHighest: Color(0xFFF9F9F9),
    primaryFixed: Color(0xFFFF6657),
    primaryFixedDim: Color(0xFFDD5B53),
    secondaryFixed: Color(0xFF3367B6),
    secondaryFixedDim: Color(0xFF274E8F),
    onSecondaryFixed: Color(0xFF0C2947),
    tertiaryFixed: Color(0xFF1B3F48),
  );

  ColorScheme dark = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xff6D01BD),
    onPrimary: Color(0xFFFEFEFE),
    primaryContainer: Color(0xFF393140),
    onPrimaryContainer: Color(0xFFD8AAFF),
    secondary: Color(0xFF0FC3C3),
    onSecondary: Color(0xFFFEFEFE),
    secondaryContainer: Color(0xFF103939),
    onSecondaryContainer: Color(0xFFBFFDBF),
    tertiary: Color(0xFFFFD700),
    onTertiary: Color(0xFFFEFEFE),
    tertiaryContainer: Color(0xFFFF7F50),
    onTertiaryContainer: Color(0xFFFFFD9A),
    error: Color(0xFFEC3036),
    onError: Color(0xFFFEFEFE),
    errorContainer: Color(0xFFFCEFEF),
    onErrorContainer: Color(0xFFB42318),
    surface: Color(0xFF121212),
    onSurface: Color(0xFFFEFEFE),
    onSurfaceVariant: Color(0xFFB2B2B2),
    outline: Color(0xFF3E3E3E),
    outlineVariant: Color(0xFF313131),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF1B1C1D),
    inverseSurface: Color(0xFFF4F4F4),
    onInverseSurface: Color(0xFF181818),
    inversePrimary: Color(0xFF1A2335),
    surfaceTint: Color(0xFFFF6657),
    surfaceBright: Color(0xFF1E1E1E),
    surfaceDim: Color(0xFF2D2D2D),
    surfaceContainer: Color(0xFF1E1E1E),
    surfaceContainerLow: Color(0xFF222222),
    surfaceContainerLowest: Color(0xFF1A2335),
    surfaceContainerHigh: Color(0xFF17191B),
    surfaceContainerHighest: Color(0xFF0B0B0B),
    primaryFixed: Color(0xFFFF6657),
    primaryFixedDim: Color(0xFFDD5B53),
    secondaryFixed: Color(0xFF42BDA9),
    secondaryFixedDim: Color(0xFF317A6F),
    onSecondaryFixed: Color(0xFF002621),
    tertiaryFixed: Color(0xFF092038),
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
