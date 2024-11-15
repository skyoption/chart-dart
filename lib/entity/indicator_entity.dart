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
  First_Indicator,
  Last_Indicator,
}

enum Levels { None }

enum Timeframes { All_Timeframes, None }

@collection
class IndicatorEntity {
  int windowId = 0;
  Id id = Isar.autoIncrement;
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

  IndicatorEntity({
    this.name = '',
    this.shift = 0,
    this.windowId = 0,
    this.period = 5,
    this.type = IndicatorType.SMA_MA,
    this.dn,
    this.up,
    this.levels = const [],
    this.chikouSpan,
    this.senkouSpanB,
    this.senkouSpanA,
    this.kijunSen,
    this.tenkanSen,
    this.longEMA,
    this.shortEMA,
    this.value = 0,
    this.deviations,
    this.macd,
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
  }) {
    color ??= Colors.green.toHexString();
    secondColor ??= Colors.deepOrange.toHexString();
    levelsColor ??= Colors.black.toHexString();
  }

  CandleIndicatorEntity copyToCandle({
    name,
    shift,
    period,
    method,
    double? value,
    applyTo,
    shortEMA,
    lineHeight,
    style,
    level,
    timeframe,
    levelsColor,
    deviations,
    ichimoku,
    windowId,
    macd,
    steps,
    longEMA,
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
    levels,
    isMain,
    secondColor,
    isSecondary,
  }) {
    return CandleIndicatorEntity(
      period: period ?? this.period,
      value: value ?? this.value,
      type: method ?? this.type,
      name: name ?? this.name,
      longEMA: longEMA ?? this.longEMA,
      shortEMA: shortEMA ?? this.shortEMA,
      dn: dn ?? this.dn,
      windowId: windowId ?? this.windowId,
      macd: macd ?? this.macd,
      up: up ?? this.up,
      levels: levels ?? this.levels,
      levelsColor: levelsColor ?? this.levelsColor,
      strokeWidth: lineHeight ?? this.strokeWidth,
      applyTo: applyTo ?? this.applyTo,
      color: color ?? this.color,
      level: level ?? this.level,
      isMain: isMain ?? this.isMain,
      isSecondary: isSecondary ?? this.isSecondary,
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
  String? tenkanSenColor,
      kijuSenColor,
      chikouSpanColor,
      upKumoColor,
      downKumoColor;

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
    tenkanSenColor ??= Colors.red.toHexString();
    kijuSenColor ??= Colors.blue.toHexString();
    chikouSpanColor ??= Colors.green.toHexString();
    upKumoColor ??= Colors.orange.toHexString();
    downKumoColor ??= Colors.brown.toHexString();
  }
}

@embedded
class MACD {
  String? mainColor, signalColor;

  int fastEma = 12, slowEma = 26, macdSma = 9;

  MACD({
    this.fastEma = 12,
    this.slowEma = 26,
    this.macdSma = 9,
    this.mainColor,
    this.signalColor,
  }) {
    mainColor ??= Colors.red.toHexString();
    signalColor ??= Colors.blue.toHexString();
  }
}
