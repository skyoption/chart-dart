// ignore_for_file: non_constant_identifier_names,library_prefixes,unused_import,camel_case_types
import 'package:candle_chart/entity/candle_indicator_entity.dart';
import 'package:candle_chart/entity/indicator_entity.dart';

mixin CandleEntity {
  late double open;
  late double high;
  late double low;
  late double close;

  ///MA
  List<CandleIndicatorEntity>? maEmaValues;
  List<CandleIndicatorEntity>? maSmaValues;
  List<CandleIndicatorEntity>? maLwmaValues;
  List<CandleIndicatorEntity>? maSmmaValues;

  ///Envelops
  List<CandleIndicatorEntity>? envelopsEmaValues;
  List<CandleIndicatorEntity>? envelopsSmaValues;
  List<CandleIndicatorEntity>? envelopsLwmaValues;
  List<CandleIndicatorEntity>? envelopsSmmaValues;

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

  /// ATR
  List<CandleIndicatorEntity>? atrValues;

  /// CCI
  List<CandleIndicatorEntity>? cciValues;

  /// DeM
  List<CandleIndicatorEntity>? deMarkerValues;

  /// MOM
  List<CandleIndicatorEntity>? momentumValues;

  /// WPR
  List<CandleIndicatorEntity>? wprValues;

  /// MFI
  List<CandleIndicatorEntity>? mfiValues;

  /// SO
  List<CandleIndicatorEntity>? stochasticValues;
}
