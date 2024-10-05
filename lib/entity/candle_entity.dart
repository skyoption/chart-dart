// ignore_for_file: non_constant_identifier_names,library_prefixes,unused_import,camel_case_types
import 'package:candle_chart/entity/indicator_entity.dart';

mixin CandleEntity {
  late double open;
  late double high;
  late double low;
  late double close;

  ///MA
  List<IndicatorEntity>? emaMaValues;
  List<IndicatorEntity>? smaMaValues;
  List<IndicatorEntity>? lwmaMaValues;
  List<IndicatorEntity>? smmaMaValues;

  ///Envelops
  List<IndicatorEntity>? emaEnvelopsValues;
  List<IndicatorEntity>? smaEnvelopsValues;
  List<IndicatorEntity>? lwmaEnvelopsValues;
  List<IndicatorEntity>? smmaEnvelopsValues;

  ///BOLL
  List<IndicatorEntity>? bollValues;

  ///Parabolic
  List<IndicatorEntity>? parabolicValues;
}
