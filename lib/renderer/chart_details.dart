import 'dart:async' show StreamSink;

import 'package:candle_chart/utils/kprint.dart';
import 'package:candle_chart/entity/line_entity.dart';
import 'package:candle_chart/renderer/draw_object_lines.dart';
import 'package:candle_chart/utils/number_util.dart';
import 'package:flutter/material.dart';

import '../entity/info_window_entity.dart';
import '../entity/k_line_entity.dart';
import '../k_chart_widget.dart';
import '../utils/date_format_util.dart';
import 'base_chart_painter.dart';
import 'base_chart_renderer.dart';
import 'base_dimension.dart';
import 'main_renderer.dart';
import 'secondary_renderer.dart';
import 'vol_renderer.dart';

mixin ChartDetails on ChartCalc {
  late final ChartPosition chartPosition;
  late final ChartStyle chartStyle;
  late final ChartColors chartColors;
  late BaseChartRenderer mMainRenderer;
  late final double screenHeight;

  /// Rectangle box of main chart
  late Rect mMainRect;
  late List<String> mFormats;

  TextPainter getTextPainter(text, color, {addTextSpan, isLeft}) {
    if (color == null) {
      color = this.chartColors.defaultTextColor;
    }

    TextSpan? spanAll;

    TextSpan span = TextSpan(text: "$text", style: getTextStyle(color));
    if (addTextSpan != null) {
      TextSpan spanS = addTextSpan();
      List<InlineSpan> children = [];
      if (isLeft != null && isLeft) {
        children.add(span);
        children.add(spanS);
      } else {
        children.add(spanS);
        children.add(span);
      }
      spanAll = TextSpan(children: children);
    } else {
      List<InlineSpan> children = [];
      children.add(span);
      spanAll = TextSpan(children: children);
    }
    TextPainter tp =
        TextPainter(text: spanAll, textDirection: TextDirection.ltr);
    tp.layout();
    return tp;
  }

  String getDate(int? date) {
    final d = dateFormat(
      DateTime.fromMillisecondsSinceEpoch(
        date ?? DateTime.now().millisecondsSinceEpoch,
      ), mFormats,
    );
    return d;
  }

  /// define text style
  TextStyle getTextStyle(Color color) {
    return TextStyle(
      fontSize: chartStyle.sizeText,
      color: color,
    );
  }
}

mixin ChartCalc {
  late final ChartPosition chartPosition;
  late BaseChartRenderer mMainRenderer;
  late final double screenHeight;
  late Rect mMainRect;

  double getMainY(double y) => mMainRenderer.getY(y);

  double getMainYInChart(double y) => mMainRenderer.getYInChart(y);

  /// Whether the point is in the SecondaryRect
  // bool isInSecondaryRect(Offset point) {
  //   // return mSecondaryRect.contains(point) == true);
  //   return false;
  // }

  double getYPositionValue(double dy) {
    final scope = this.chartPosition.topPrice - this.chartPosition.bottomPrice;
    double perPixel = scope / screenHeight;
    final value = this.chartPosition.topPrice - dy * perPixel;
    return value;
  }

  /// Whether the point is in MainRect
  bool isInMainRect(Offset point) {
    return mMainRect.contains(point);
  }
}
