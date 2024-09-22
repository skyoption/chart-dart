import 'package:candle_chart/indectors/ma_methods_screen.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:flutter/material.dart';

enum ApplyTo { Close, Open }

enum Levels { None }

enum Timeframes { All_Timeframes, None }

class IndicatorEntity {
  final String name;
  final int shift, period;
  final MaMethods? method;
  final ApplyTo applyTo;
  final Levels level;
  final Timeframes timeframe;
  final Color color;
  final double lineHeight;
  final LineStyle style;
  List<double>? values;

  IndicatorEntity({
    this.name = '',
    this.shift = 0,
    this.period = 5,
    this.method,
    this.values,
    this.applyTo = ApplyTo.Close,
    this.lineHeight = 1.2,
    this.style = LineStyle.normal,
    this.level = Levels.None,
    this.timeframe = Timeframes.All_Timeframes,
    this.color = Colors.black,
  });
}
