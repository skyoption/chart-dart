import 'package:candle_chart/k_chart_plus.dart';
import 'package:flutter/material.dart';

enum ApplyTo {
  Close,
  Open,
  High,
  Low,
  Median_Price_HL$2,
  Middle_Price_OC$2,
  Typical_Price_HLC$3,
  Weighted_Close_HLCC$4,
}

enum Levels { None }

enum Timeframes { All_Timeframes, None }

class IndicatorEntity {
  String name;
  int shift, period;
  double? deviations, maximum, steps;
  IndicatorType? type;
  Ichimoku? ichimoku;
  ApplyTo applyTo;
  Levels level;
  Timeframes timeframe;
  double strokeWidth;
  LineStyle style;
  Color color, secondColor;
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
    this.type,
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
    this.applyTo = ApplyTo.Close,
    this.strokeWidth = 1.0,
    this.style = LineStyle.normal,
    this.level = Levels.None,
    this.timeframe = Timeframes.All_Timeframes,
    this.color = Colors.green,
    this.secondColor = Colors.deepOrange,
  });

  IndicatorEntity copy({
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
    return IndicatorEntity(
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
    );
  }
}

class Ichimoku {
  Color tenkanSenColor,
      kijuSenColor,
      chikouSpanColor,
      upKumoColor,
      downKumoColor;
  int tenkanSen, kijuSen, senkouSpan;

  Ichimoku({
    this.tenkanSen = 9,
    this.kijuSen = 26,
    this.senkouSpan = 52,
    this.tenkanSenColor = Colors.red,
    this.kijuSenColor = Colors.blue,
    this.chikouSpanColor = Colors.green,
    this.upKumoColor = Colors.orange,
    this.downKumoColor = Colors.brown,
  });
}
