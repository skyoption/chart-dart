// ignore_for_file: non_constant_identifier_names,library_prefixes,unused_import,camel_case_types
import 'package:candle_chart/entity/candle_indicator_entity.dart';
import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/entity/trade_entity.dart';
import 'package:candle_chart/entity/trade_point_entity.dart';
import 'package:isar_community/isar.dart';

mixin CandleEntity {
  late double open;
  late double high;
  late double low;
  late double close;

  ///MA
  @ignore
  List<CandleIndicatorEntity>? maEmaValues;
  @ignore
  List<CandleIndicatorEntity>? maSmaValues;
  @ignore
  List<CandleIndicatorEntity>? maLwmaValues;
  @ignore
  List<CandleIndicatorEntity>? maSmmaValues;

  ///Envelops
  @ignore
  List<CandleIndicatorEntity>? envelopsEmaValues;
  @ignore
  List<CandleIndicatorEntity>? envelopsSmaValues;
  @ignore
  List<CandleIndicatorEntity>? envelopsLwmaValues;
  @ignore
  List<CandleIndicatorEntity>? envelopsSmmaValues;

  ///BOLL
  @ignore
  List<CandleIndicatorEntity>? bollValues;

  ///Parabolic
  @ignore
  List<CandleIndicatorEntity>? parabolicValues;

  /// Ichimoku
  @ignore
  List<CandleIndicatorEntity>? ichimokuValues;

  /// RSI
  @ignore
  List<CandleIndicatorEntity>? rsiValues;

  /// MACD
  @ignore
  List<CandleIndicatorEntity>? macdValues;
  @ignore
  List<CandleIndicatorEntity>? macdSignalValues;

  /// ATR
  @ignore
  List<CandleIndicatorEntity>? atrValues;

  /// CCI
  @ignore
  List<CandleIndicatorEntity>? cciValues;

  /// DeM
  @ignore
  List<CandleIndicatorEntity>? deMarkerValues;

  /// MOM
  @ignore
  List<CandleIndicatorEntity>? momentumValues;

  /// WPR
  @ignore
  List<CandleIndicatorEntity>? wprValues;

  /// MFI
  @ignore
  List<CandleIndicatorEntity>? mfiValues;

  /// SO
  @ignore
  List<CandleIndicatorEntity>? stochasticValues;

  /// Trade Positions
  @ignore
  List<TradePointEntity>? tradePositionsValues;

  /// Trade Entities
  @ignore
  List<TradeEntity>? tradeEntities;
}
