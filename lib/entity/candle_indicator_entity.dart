import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:isar/isar.dart';

part 'candle_indicator_entity.g.dart';

@embedded
class CandleIndicatorEntity {
  String name;
  int shift, period;
  double? deviations, maximum, steps;
  @enumerated
  IndicatorType type = IndicatorType.SMA_MA;
  Ichimoku? ichimoku;
  MACD? macd;
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

  String? color, secondColor, levelsColor;
  List<double> levels = [];

  double value = 0;
  double? up;
  double? dn;
  double? tenkanSen;
  double? kijunSen;
  double? senkouSpanA;
  double? senkouSpanB;
  double? chikouSpan;
  double? shortEMA;
  double? longEMA;
  int windowId = 0;

  CandleIndicatorEntity({
    this.name = '',
    this.shift = 0,
    this.period = 5,
    this.windowId = 0,
    this.type = IndicatorType.SMA_MA,
    this.dn,
    this.up,
    this.chikouSpan,
    this.senkouSpanB,
    this.longEMA,
    this.shortEMA,
    this.senkouSpanA,
    this.levels = const [],
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
    this.levelsColor,
    this.macd,
  }) {
    color ??= Colors.green.toHexString();
    secondColor ??= Colors.deepOrange.toHexString();
    levelsColor ??= Colors.black.toHexString();
  }

  CandleIndicatorEntity copy({
    name,
    shift,
    period,
    shortEMA,
    windowId,
    method,
    double? value,
    applyTo,
    rsi,
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
    levelsColor,
    chikouSpan,
    longEMA,
    senkouSpanB,
    senkouSpanA,
    kijunSen,
    tenkanSen,
    levels,
    secondColor,
    isMain,
    isSecondary,
  }) {
    return CandleIndicatorEntity(
      period: period ?? this.period,
      shortEMA: shortEMA ?? this.shortEMA,
      value: value ?? this.value,
      type: method ?? this.type,
      name: name ?? this.name,
      dn: dn ?? this.dn,
      macd: macd ?? this.macd,
      isMain: isMain ?? this.isMain,
      isSecondary: isSecondary ?? this.isSecondary,
      windowId: windowId ?? this.windowId,
      levels: levels ?? this.levels,
      levelsColor: levelsColor ?? this.levelsColor,
      up: up ?? this.up,
      longEMA: longEMA ?? this.longEMA,
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
