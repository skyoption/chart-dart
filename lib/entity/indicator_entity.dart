import 'package:candle_chart/entity/candle_indicator_entity.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:isar/isar.dart';

part 'indicator_entity.g.dart';

enum ApplyTo {
  Close,
  Open,
  High,
  Low,
  Median_Price_HL__2,
  Middle_Price_OC__2,
  Typical_Price_HLC__3,
  Weighted_Close_HLCC__4,
}

enum Levels { None }

enum Timeframes { All_Timeframes, None }

@collection
class IndicatorEntity {
  Id id = Isar.autoIncrement;
  String name;
  int shift, period;
  double? deviations, maximum, steps;
  @enumerated
  IndicatorType type = IndicatorType.SMA_MA;
  Ichimoku? ichimoku;
  @enumerated
  ApplyTo applyTo = ApplyTo.Close;
  @enumerated
  Levels level = Levels.None;
  @enumerated
  Timeframes timeframe = Timeframes.All_Timeframes;
  double strokeWidth;
  bool drawAsBackground, isMain, isSecondary;
  @enumerated
  LineStyle style = LineStyle.normal;

  String? color = Colors.green.toHexString(),
      secondColor = Colors.deepOrange.toHexString();

  double value = 0;
  double? up;
  double? dn;
  double? tenkanSen;
  double? kijunSen;
  double? senkouSpanA;
  double? senkouSpanB;
  double? chikouSpan;

  IndicatorEntity({
    this.name = '',
    this.shift = 0,
    this.period = 5,
    this.type = IndicatorType.SMA_MA,
    this.dn,
    this.up,
    this.chikouSpan,
    this.senkouSpanB,
    this.senkouSpanA,
    this.kijunSen,
    this.tenkanSen,
    this.value = 0,
    this.deviations,
    this.maximum,
    this.steps,
    this.ichimoku,
    this.drawAsBackground = false,
    this.isMain = false,
    this.isSecondary = false,
    this.applyTo = ApplyTo.Close,
    this.strokeWidth = 1.0,
    this.style = LineStyle.normal,
    this.level = Levels.None,
    this.timeframe = Timeframes.All_Timeframes,
    this.color,
    this.secondColor,
  }) {
    color = Colors.green.toHexString();
    secondColor = Colors.deepOrange.toHexString();
  }

  CandleIndicatorEntity copyToCandle({
    name,
    shift,
    period,
    method,
    double? value,
    applyTo,
    lineHeight,
    style,
    level,
    timeframe,
    deviations,
    ichimoku,
    steps,
    color,
    drawAsBackground,
    maximum,
    dn,
    sar,
    mb,
    up,
    chikouSpan,
    senkouSpanB,
    senkouSpanA,
    kijunSen,
    tenkanSen,
    secondColor,
  }) {
    return CandleIndicatorEntity(
      period: period ?? this.period,
      value: value ?? this.value,
      type: method ?? this.type,
      name: name ?? this.name,
      dn: dn ?? this.dn,
      up: up ?? this.up,
      strokeWidth: lineHeight ?? this.strokeWidth,
      applyTo: applyTo ?? this.applyTo,
      color: color ?? this.color,
      level: level ?? this.level,
      steps: level ?? this.steps,
      ichimoku: ichimoku ?? this.ichimoku,
      deviations: deviations ?? this.deviations,
      shift: shift ?? this.shift,
      style: style ?? this.style,
      maximum: maximum ?? this.maximum,
      timeframe: timeframe ?? this.timeframe,
      secondColor: secondColor ?? this.secondColor,
      tenkanSen: tenkanSen ?? this.tenkanSen,
      chikouSpan: chikouSpan ?? this.chikouSpan,
      kijunSen: kijunSen ?? this.kijunSen,
      senkouSpanA: senkouSpanA ?? this.senkouSpanA,
      senkouSpanB: senkouSpanB ?? this.senkouSpanB,
      drawAsBackground: drawAsBackground ?? this.drawAsBackground,
    );
  }
}

@embedded
class Ichimoku {
  String? tenkanSenColor = Colors.red.toHexString(),
      kijuSenColor = Colors.blue.toHexString(),
      chikouSpanColor = Colors.green.toHexString(),
      upKumoColor = Colors.orange.toHexString(),
      downKumoColor = Colors.brown.toHexString();

  int tenkanSen = 9, kijuSen = 26, senkouSpan = 52;

  Ichimoku({
    this.tenkanSen = 9,
    this.kijuSen = 26,
    this.senkouSpan = 52,
    this.tenkanSenColor,
    this.kijuSenColor,
    this.chikouSpanColor,
    this.upKumoColor,
    this.downKumoColor,
  }) {
    tenkanSenColor = Colors.red.toHexString();
    kijuSenColor = Colors.blue.toHexString();
    chikouSpanColor = Colors.green.toHexString();
    upKumoColor = Colors.orange.toHexString();
    downKumoColor = Colors.brown.toHexString();
  }
}
