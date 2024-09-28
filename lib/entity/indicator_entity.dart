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
  IndicatorType? type;
  ApplyTo applyTo;
  Levels level;
  Timeframes timeframe;
  Color color;
  double strokeWidth;
  LineStyle style;
  double value = 0;

  IndicatorEntity({
    this.name = '',
    this.shift = 0,
    this.period = 5,
    this.type = IndicatorType.SMA,
    this.value = 0,
    this.applyTo = ApplyTo.Close,
    this.strokeWidth = 1.2,
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
      strokeWidth: lineHeight ?? this.strokeWidth,
      applyTo: applyTo ?? this.applyTo,
      color: color ?? this.color,
      level: level ?? this.level,
      shift: shift ?? this.shift,
      style: style ?? this.style,
      timeframe: timeframe ?? this.timeframe,
    );
  }
}
