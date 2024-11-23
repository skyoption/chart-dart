import 'package:candle_chart/entity/object_entity.dart';
import 'package:candle_chart/renderer/chart_details.dart';
import 'package:candle_chart/utils/kprint.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../base_chart_renderer.dart';

mixin DrawVerticalLines on ChartDetails {
  late final ChartPosition chartPosition;
  late final ChartStyle chartStyle;
  late Paint dot;
  late double scaleX;
  double? fDisplayHeight;

  void setVerticalLineOffset(ObjectEntity item, Offset offset) {
    final verticalLines = chartProperties.verticalLines;
    final i = verticalLines.indexWhere((e) => e.id == item.id);
    if (i != -1) {
      verticalLines[i].dx1 = getX(mStartIndex) + (offset.dx / scaleX);
    }
  }

  void drawVerticalLines(Canvas canvas, Size size, double lastX, double curX) {
    final verticalLines = chartProperties.verticalLines;
    if (verticalLines.isEmpty) {
      return;
    }
    for (int i = 0; i < verticalLines.length; i++) {
      // if (verticalLines[i].currentEditIndex == i &&
      //     verticalLines[i].dx1 != verticalLines[i].dx2) {
      //   chartProperties.verticalLines[i].dx2 =
      //       getX(mStartIndex) + verticalLines[i].dx1;
      // }

      double x = verticalLines[i].dx1;

      final pricePaint = Paint()
        ..color = colorFromHex(verticalLines[i].color!)!
        ..strokeWidth = verticalLines[i].height;

      if (verticalLines[i].style == ObjectStyle.dash) {
      } else {
        canvas.drawLine(
          Offset(x, this.chartStyle.topPadding),
          Offset(x, fDisplayHeight!),
          pricePaint,
        );
        if (verticalLines[i].currentEditIndex == i) {
          canvas.drawCircle(
            Offset(x, this.chartStyle.topPadding),
            2.5,
            dot,
          );
          canvas.drawCircle(
            Offset(x, fDisplayHeight!),
            2.5,
            dot,
          );
        }
      }
    }
  }
}
