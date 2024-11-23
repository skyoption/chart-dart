import 'package:candle_chart/entity/object_entity.dart';
import 'package:candle_chart/renderer/chart_details.dart';
import 'package:candle_chart/utils/kprint.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../base_chart_renderer.dart';

mixin DrawTrendLines on ChartDetails {
  late final ChartPosition chartPosition;
  late final ChartStyle chartStyle;
  late Paint dot;
  late double scaleX;

  void setTrendLineOffset1(ObjectEntity item, Offset offset) {
    final trendLines = chartProperties.trendLines;
    final i = trendLines.indexWhere((e) => e.id == item.id);
    if (i != -1) {
      trendLines[i].dx1 = getX(mStartIndex)  + (offset.dx / scaleX);
      trendLines[i].value = getYPositionValue(offset.dy);
    }
  }

  void setTrendLineOffset2(ObjectEntity item, Offset offset) {
    final trendLines = chartProperties.trendLines;
    final i = trendLines.indexWhere((e) => e.id == item.id);
    if (i != -1) {
      trendLines[i].dx2 = getX(mStartIndex) + (offset.dx / scaleX);
      trendLines[i].value2 = getYPositionValue(offset.dy);
    }
  }

  void drawTrendLines(Canvas canvas, Size size, double lastX, double curX) {
    final trendLines = chartProperties.trendLines;
    if (trendLines.isEmpty) {
      return;
    }

    for (int i = 0; i < trendLines.length; i++) {
      double x1 = trendLines[i].dx1;
      double x2 = trendLines[i].dx2;
      double y1 = getMainY(trendLines[i].value);
      double y2 = getMainY(trendLines[i].value2);

      final pricePaint = Paint()
        ..color = colorFromHex(trendLines[i].color!)!
        ..strokeWidth = trendLines[i].height;

      if (trendLines[i].style == ObjectStyle.dash) {
      } else {
        canvas.drawLine(
          Offset(x1, y1),
          Offset(x2, y2),
          pricePaint,
        );
        if (trendLines[i].currentEditIndex == i) {
          canvas.drawCircle(
            Offset(x1, y1),
            2.5,
            dot,
          );
          canvas.drawCircle(
            Offset(x2, y2),
            2.5,
            dot,
          );
        }
      }
    }
  }
}