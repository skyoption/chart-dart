import 'package:candle_chart/entity/line_entity.dart';
import 'package:candle_chart/renderer/chart_details.dart';
import 'package:candle_chart/utils/kprint.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../base_chart_renderer.dart';

mixin DrawVerticalLines on ChartDetails {
  late final ChartPosition chartPosition;
  late final ChartStyle chartStyle;
  late Paint pricePaint, dot;
  double? fDisplayHeight;

  double last = -1;

  void drawVerticalLines(Canvas canvas, Size size, double lastX, double curX) {
    final verticalLines = chartProperties.verticalLines;
    if (verticalLines.isEmpty) {
      return;
    }
    for (int i = 0; i < verticalLines.length; i++) {
      pricePaint
        ..color = colorFromHex(verticalLines[i].color!)!
        ..strokeWidth = verticalLines[i].height;

      if (verticalLines[i].style == LineStyle.dash ||
          verticalLines[i].style == LineStyle.longDash) {
      } else {
        if (verticalLines[i].currentEditIndex == i &&
            verticalLines[i].dx1 != verticalLines[i].dx2) {
          chartProperties.verticalLines[i].dx2 =
              getX(mStartIndex) + verticalLines[i].dx1;
        }
        double x = chartProperties.verticalLines[i].dx2;
        canvas.drawLine(
          Offset(x, this.chartStyle.topPadding),
          Offset(x, fDisplayHeight!),
          pricePaint,
        );
        if (verticalLines[i].currentEditIndex != -1) {
          canvas.drawCircle(
            Offset(x, this.chartStyle.topPadding),
            5.0,
            dot,
          );
          canvas.drawCircle(
            Offset(x, fDisplayHeight!),
            5.0,
            dot,
          );
        }
      }
    }
  }
}
