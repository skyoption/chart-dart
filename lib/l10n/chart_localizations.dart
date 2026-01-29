import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'chart_localizations_ar.dart';
import 'chart_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of ChartLocalizations
/// returned by `ChartLocalizations.of(context)`.
///
/// Applications need to include `ChartLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/chart_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ChartLocalizations.localizationsDelegates,
///   supportedLocales: ChartLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the ChartLocalizations.supportedLocales
/// property.
abstract class ChartLocalizations {
  ChartLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ChartLocalizations of(BuildContext context) {
    return Localizations.of<ChartLocalizations>(context, ChartLocalizations)!;
  }

  static const LocalizationsDelegate<ChartLocalizations> delegate =
      _ChartLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @properties.
  ///
  /// In en, this message translates to:
  /// **'Properties'**
  String get properties;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @period.
  ///
  /// In en, this message translates to:
  /// **'Period'**
  String get period;

  /// No description provided for @levels.
  ///
  /// In en, this message translates to:
  /// **'Levels'**
  String get levels;

  /// No description provided for @visualization.
  ///
  /// In en, this message translates to:
  /// **'Visualization'**
  String get visualization;

  /// No description provided for @timeframe.
  ///
  /// In en, this message translates to:
  /// **'Timeframe'**
  String get timeframe;

  /// No description provided for @all_timeframes.
  ///
  /// In en, this message translates to:
  /// **'All timeframes'**
  String get all_timeframes;

  /// No description provided for @style.
  ///
  /// In en, this message translates to:
  /// **'Style'**
  String get style;

  /// No description provided for @pixel.
  ///
  /// In en, this message translates to:
  /// **'Pixel'**
  String get pixel;

  /// No description provided for @applyTo.
  ///
  /// In en, this message translates to:
  /// **'Apply To'**
  String get applyTo;

  /// No description provided for @allTimeframes.
  ///
  /// In en, this message translates to:
  /// **'All timeframes'**
  String get allTimeframes;

  /// No description provided for @fast_ema.
  ///
  /// In en, this message translates to:
  /// **'Fast EMA'**
  String get fast_ema;

  /// No description provided for @slow_ema.
  ///
  /// In en, this message translates to:
  /// **'Slow EMA'**
  String get slow_ema;

  /// No description provided for @macd_sma.
  ///
  /// In en, this message translates to:
  /// **'MACD SMA'**
  String get macd_sma;

  /// No description provided for @main.
  ///
  /// In en, this message translates to:
  /// **'Main'**
  String get main;

  /// No description provided for @signal.
  ///
  /// In en, this message translates to:
  /// **'Signal'**
  String get signal;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @k_period.
  ///
  /// In en, this message translates to:
  /// **'%K Period'**
  String get k_period;

  /// No description provided for @d_period.
  ///
  /// In en, this message translates to:
  /// **'%D Period'**
  String get d_period;

  /// No description provided for @slowing.
  ///
  /// In en, this message translates to:
  /// **'Slowing'**
  String get slowing;

  /// No description provided for @tenkan_sen.
  ///
  /// In en, this message translates to:
  /// **'Tenkan-sen:'**
  String get tenkan_sen;

  /// No description provided for @kiju_sen.
  ///
  /// In en, this message translates to:
  /// **'Kiju-sen:'**
  String get kiju_sen;

  /// No description provided for @senkou_span_b.
  ///
  /// In en, this message translates to:
  /// **'Senkou-span B:'**
  String get senkou_span_b;

  /// No description provided for @chikou_span.
  ///
  /// In en, this message translates to:
  /// **'Chikou Span:'**
  String get chikou_span;

  /// No description provided for @up_kumo.
  ///
  /// In en, this message translates to:
  /// **'Up Kumo:'**
  String get up_kumo;

  /// No description provided for @down_kumo.
  ///
  /// In en, this message translates to:
  /// **'Down Kumo:'**
  String get down_kumo;

  /// No description provided for @parameters.
  ///
  /// In en, this message translates to:
  /// **'Parameters'**
  String get parameters;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @coordinates.
  ///
  /// In en, this message translates to:
  /// **'Coordinates'**
  String get coordinates;

  /// No description provided for @point.
  ///
  /// In en, this message translates to:
  /// **'Point'**
  String get point;

  /// No description provided for @symbol.
  ///
  /// In en, this message translates to:
  /// **'Symbol'**
  String get symbol;

  /// No description provided for @fill.
  ///
  /// In en, this message translates to:
  /// **'Fill'**
  String get fill;

  /// No description provided for @rayRight.
  ///
  /// In en, this message translates to:
  /// **'Ray Right'**
  String get rayRight;

  /// No description provided for @rayLift.
  ///
  /// In en, this message translates to:
  /// **'Ray Lift'**
  String get rayLift;

  /// No description provided for @point1.
  ///
  /// In en, this message translates to:
  /// **'Point 1'**
  String get point1;

  /// No description provided for @point2.
  ///
  /// In en, this message translates to:
  /// **'Point 2'**
  String get point2;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @shift.
  ///
  /// In en, this message translates to:
  /// **'Shift'**
  String get shift;

  /// No description provided for @deviations.
  ///
  /// In en, this message translates to:
  /// **'Deviations'**
  String get deviations;

  /// No description provided for @upper_band.
  ///
  /// In en, this message translates to:
  /// **'Upper Band'**
  String get upper_band;

  /// No description provided for @lower_band.
  ///
  /// In en, this message translates to:
  /// **'Lower Band'**
  String get lower_band;

  /// No description provided for @steps.
  ///
  /// In en, this message translates to:
  /// **'Steps'**
  String get steps;

  /// No description provided for @maximum.
  ///
  /// In en, this message translates to:
  /// **'Maximum'**
  String get maximum;

  /// No description provided for @drawAsBackground.
  ///
  /// In en, this message translates to:
  /// **'Draw as background'**
  String get drawAsBackground;

  /// No description provided for @method.
  ///
  /// In en, this message translates to:
  /// **'Method'**
  String get method;

  /// No description provided for @pixels.
  ///
  /// In en, this message translates to:
  /// **'Pixels'**
  String get pixels;

  /// No description provided for @indicators.
  ///
  /// In en, this message translates to:
  /// **'Indicators'**
  String get indicators;

  /// No description provided for @main_window.
  ///
  /// In en, this message translates to:
  /// **'Main Window'**
  String get main_window;

  /// No description provided for @window.
  ///
  /// In en, this message translates to:
  /// **'Window'**
  String get window;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @priceField.
  ///
  /// In en, this message translates to:
  /// **'Price Field'**
  String get priceField;

  /// No description provided for @add_indicator.
  ///
  /// In en, this message translates to:
  /// **'Add Indicator'**
  String get add_indicator;

  /// No description provided for @trend.
  ///
  /// In en, this message translates to:
  /// **'TREND'**
  String get trend;

  /// No description provided for @moving_average.
  ///
  /// In en, this message translates to:
  /// **'Moving Average'**
  String get moving_average;

  /// No description provided for @bollinger_bands.
  ///
  /// In en, this message translates to:
  /// **'Bollinger Bands'**
  String get bollinger_bands;

  /// No description provided for @envelops.
  ///
  /// In en, this message translates to:
  /// **'Envelops'**
  String get envelops;

  /// No description provided for @parabolic_sar.
  ///
  /// In en, this message translates to:
  /// **'Parabolic SAR'**
  String get parabolic_sar;

  /// No description provided for @ichimoku_kinko_hyo.
  ///
  /// In en, this message translates to:
  /// **'Ichimoku Kinko Hyo'**
  String get ichimoku_kinko_hyo;

  /// No description provided for @oscillators.
  ///
  /// In en, this message translates to:
  /// **'OSCILLATORS'**
  String get oscillators;

  /// No description provided for @stochastic_oscillator.
  ///
  /// In en, this message translates to:
  /// **'Stochastic Oscillator'**
  String get stochastic_oscillator;

  /// No description provided for @macd.
  ///
  /// In en, this message translates to:
  /// **'MACD'**
  String get macd;

  /// No description provided for @relative_strength_index.
  ///
  /// In en, this message translates to:
  /// **'Relative Strength Index'**
  String get relative_strength_index;

  /// No description provided for @average_true_range.
  ///
  /// In en, this message translates to:
  /// **'Average True Range'**
  String get average_true_range;

  /// No description provided for @commodity_channel_index.
  ///
  /// In en, this message translates to:
  /// **'Commodity Channel Index'**
  String get commodity_channel_index;

  /// No description provided for @demarker.
  ///
  /// In en, this message translates to:
  /// **'DeMarker'**
  String get demarker;

  /// No description provided for @momentum.
  ///
  /// In en, this message translates to:
  /// **'Momentum'**
  String get momentum;

  /// No description provided for @williams_percent_range.
  ///
  /// In en, this message translates to:
  /// **'Williams\' Percent Range'**
  String get williams_percent_range;

  /// No description provided for @volumes.
  ///
  /// In en, this message translates to:
  /// **'VOLUMES'**
  String get volumes;

  /// No description provided for @money_flow_index.
  ///
  /// In en, this message translates to:
  /// **'Money Flow Index'**
  String get money_flow_index;

  /// No description provided for @objects.
  ///
  /// In en, this message translates to:
  /// **'Objects'**
  String get objects;

  /// No description provided for @addLevel.
  ///
  /// In en, this message translates to:
  /// **'Add Level'**
  String get addLevel;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @addObject.
  ///
  /// In en, this message translates to:
  /// **'Add Object'**
  String get addObject;

  /// No description provided for @lines.
  ///
  /// In en, this message translates to:
  /// **'Lines'**
  String get lines;

  /// No description provided for @horizontalLine.
  ///
  /// In en, this message translates to:
  /// **'Horizontal Line'**
  String get horizontalLine;

  /// No description provided for @verticalLine.
  ///
  /// In en, this message translates to:
  /// **'Vertical Line'**
  String get verticalLine;

  /// No description provided for @trendLine.
  ///
  /// In en, this message translates to:
  /// **'Trend Line'**
  String get trendLine;

  /// No description provided for @shapes.
  ///
  /// In en, this message translates to:
  /// **'Shapes'**
  String get shapes;

  /// No description provided for @rectangle.
  ///
  /// In en, this message translates to:
  /// **'Rectangle'**
  String get rectangle;

  /// No description provided for @tools.
  ///
  /// In en, this message translates to:
  /// **'Tools'**
  String get tools;

  /// No description provided for @searchByIndicatorName.
  ///
  /// In en, this message translates to:
  /// **'Search by indicator name'**
  String get searchByIndicatorName;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @applied.
  ///
  /// In en, this message translates to:
  /// **'Applied'**
  String get applied;

  /// No description provided for @noIndicatorsAppliedYet.
  ///
  /// In en, this message translates to:
  /// **'No indicators applied yet'**
  String get noIndicatorsAppliedYet;

  /// No description provided for @noFavoritesAppliedYet.
  ///
  /// In en, this message translates to:
  /// **'No favorites applied yet'**
  String get noFavoritesAppliedYet;

  /// No description provided for @inputs.
  ///
  /// In en, this message translates to:
  /// **'Inputs'**
  String get inputs;

  /// No description provided for @visibility.
  ///
  /// In en, this message translates to:
  /// **'Visibility'**
  String get visibility;

  /// No description provided for @value.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get value;

  /// No description provided for @selectItem.
  ///
  /// In en, this message translates to:
  /// **'Select Item'**
  String get selectItem;

  /// No description provided for @pleaseChooseItem.
  ///
  /// In en, this message translates to:
  /// **'Please choose item'**
  String get pleaseChooseItem;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @objectSettings.
  ///
  /// In en, this message translates to:
  /// **'Object Settings'**
  String get objectSettings;
}

class _ChartLocalizationsDelegate
    extends LocalizationsDelegate<ChartLocalizations> {
  const _ChartLocalizationsDelegate();

  @override
  Future<ChartLocalizations> load(Locale locale) {
    return SynchronousFuture<ChartLocalizations>(
        lookupChartLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_ChartLocalizationsDelegate old) => false;
}

ChartLocalizations lookupChartLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return ChartLocalizationsAr();
    case 'en':
      return ChartLocalizationsEn();
  }

  throw FlutterError(
      'ChartLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
