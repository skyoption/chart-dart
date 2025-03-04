import 'package:candle_chart/l10n/chart_localizations.dart';
import 'package:flutter/widgets.dart';

extension LocalizationExtension on BuildContext {
  ChartLocalizations get tr => ChartLocalizations.of(this);
}
