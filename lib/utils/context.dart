import 'package:candle_chart/l10n/chart_localizations.dart';
import 'package:flutter/material.dart';

extension LocalizationExtension on BuildContext {
  ChartLocalizations get tr => ChartLocalizations.of(this);
  ColorScheme get scheme => Theme.of(this).colorScheme;
  TextTheme get text => Theme.of(this).textTheme;

  double get h => MediaQuery.of(this).size.height;

  double get bottomPadding => 32.0;
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
