// ignore_for_file: non_constant_identifier_names,library_prefixes,unused_import,camel_case_types
import 'package:candle_chart/entity/candle_indicator_entity.dart';
import 'package:candle_chart/entity/indicator_entity.dart';

mixin CandleEntity {
  late double open;
  late double high;
  late double low;
  late double close;

  ///MA
  List<CandleIndicatorEntity>? emaMaValues;
  List<CandleIndicatorEntity>? smaMaValues;
  List<CandleIndicatorEntity>? lwmaMaValues;
  List<CandleIndicatorEntity>? smmaMaValues;

  ///Envelops
  List<CandleIndicatorEntity>? emaEnvelopsValues;
  List<CandleIndicatorEntity>? smaEnvelopsValues;
  List<CandleIndicatorEntity>? lwmaEnvelopsValues;
  List<CandleIndicatorEntity>? smmaEnvelopsValues;

  ///BOLL
  List<CandleIndicatorEntity>? bollValues;

  ///Parabolic
  List<CandleIndicatorEntity>? parabolicValues;
  /// Ichimoku
  List<CandleIndicatorEntity>? ichimokuValues;
  /// RSI
  List<CandleIndicatorEntity>? rsiValues;
  /// MACD
  List<CandleIndicatorEntity>? macdValues;
  List<CandleIndicatorEntity>? macdSignalValues;
}
