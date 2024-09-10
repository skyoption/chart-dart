import 'dart:ui';

import 'package:candle_chart/chart_style.dart';
import 'package:candle_chart/entity/line_entity.dart';
import 'package:candle_chart/renderer/base_chart_renderer.dart';
import 'package:candle_chart/renderer/chart_details.dart';
import 'package:flutter/gestures.dart';

class UpdatePointPosition with ChartCalc {
  final ChartPosition chartPosition;
  final BaseChartRenderer mMainRenderer;
  final double screenHeight;
  final Rect mMainRect;

  UpdatePointPosition({
    required this.chartPosition,
    required this.screenHeight,
    required this.mMainRenderer,
    required this.mMainRect,
  });

  int updateLineOffsetPoint({
    required Offset offset,
    required List<LineEntity> linesPrice,
  }) {
    int index = -1;
    for (int i = 0; i < linesPrice.length; i++) {
      if (index == -1) {
        if (linesPrice[i].editable) {
          linesPrice[i].editable = false;
        } else {
          linesPrice[i].editable = (offset.dy + 5) <= linesPrice[i].dy ||
              (offset.dy - 5) >= linesPrice[i].dy;
          if (linesPrice[i].editable) {
            index = i;
          }
        }
      } else {
        linesPrice[i].editable = false;
      }
    }
    return index;
  }
}
