import 'package:candle_chart/chart_translations.dart';
import 'package:flutter/widgets.dart';

extension ChartTranslationsMap on Map<String, ChartTranslations> {
  ChartTranslations of(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final languageTag = '${locale.languageCode}_${locale.countryCode}';

    return this[languageTag] ?? ChartTranslations();
  }
}
