// ignore_for_file: non_constant_identifier_names,library_prefixes,unused_import,camel_case_types
import 'package:candle_chart/entity/indicator_entity.dart';

mixin CandleEntity {
  late double open;
  late double high;
  late double low;
  late double close;



  //EMA
  List<IndicatorEntity>? emaValues;
  //SMA
  List<IndicatorEntity>? smaValues;
  //LWMA
  List<IndicatorEntity>? lwmaValues;
  //SMMA
  List<IndicatorEntity>? smmaValues;

//  上轨线
  double? up;

//  中轨线
  double? mb;

//  下轨线
  double? dn;

  double? BOLLMA;
}
