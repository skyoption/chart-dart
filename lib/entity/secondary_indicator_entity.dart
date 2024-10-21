import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:isar/isar.dart';

part 'secondary_indicator_entity.g.dart';

@collection
class SecondaryIndicatorEntity {
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
  bool drawAsBackground;
  @enumerated
  LineStyle style = LineStyle.normal;
  String? color = Colors.green.toHexString(),
      secondColor = Colors.deepOrange.toHexString();
  double value = 0;
  double? up;
  double? dn;

  SecondaryIndicatorEntity({
    this.name = '',
    this.shift = 0,
    this.period = 5,
    this.type = IndicatorType.MACD,
    this.dn,
    this.up,
    this.value = 0,
    this.deviations,
    this.maximum,
    this.steps,
    this.drawAsBackground = false,
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

  SecondaryIndicatorEntity copy({
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
    return SecondaryIndicatorEntity(
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
      deviations: deviations ?? this.deviations,
      shift: shift ?? this.shift,
      style: style ?? this.style,
      maximum: maximum ?? this.maximum,
      timeframe: timeframe ?? this.timeframe,
      secondColor: secondColor ?? this.secondColor,
      drawAsBackground: drawAsBackground ?? this.drawAsBackground,
    );
  }
}
