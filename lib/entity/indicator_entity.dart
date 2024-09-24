import 'package:candle_chart/k_chart_plus.dart';
import 'package:flutter/material.dart';

enum ApplyTo { Close, Open, High, Low }

enum Levels { None }

enum Timeframes { All_Timeframes, None }

class IndicatorEntity {
  final String name;
  final int shift, period;
  final IndicatorType? type;
  final ApplyTo applyTo;
  final Levels level;
  final Timeframes timeframe;
  final Color color;
  final double lineHeight;
  final LineStyle style;
  double value = 0;

  IndicatorEntity({
    this.name = '',
    this.shift = 0,
    this.period = 5,
    this.type = IndicatorType.EMA,
    this.value = 0,
    this.applyTo = ApplyTo.Close,
    this.lineHeight = 1.2,
    this.style = LineStyle.normal,
    this.level = Levels.None,
    this.timeframe = Timeframes.All_Timeframes,
    this.color = Colors.black,
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
    color,
  }) {
    return IndicatorEntity(
      period: period ?? this.period,
      value: value ?? this.value,
      type: method ?? this.type,
      name: name ?? this.name,
      lineHeight: lineHeight ?? this.lineHeight,
      applyTo: applyTo ?? this.applyTo,
      color: color ?? this.color,
      level: level ?? this.level,
      shift: shift ?? this.shift,
      style: style ?? this.style,
      timeframe: timeframe ?? this.timeframe,
    );
  }
}
