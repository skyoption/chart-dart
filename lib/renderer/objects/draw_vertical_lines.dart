import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/entity/object_entity.dart';
import 'package:candle_chart/renderer/chart_details.dart';
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

  ObjectEntity? setVerticalLineOffset(
    ObjectEntity item,
    Offset offset,
    List<KLineEntity> data,
  ) {
    final verticalLines = chartProperties.verticalLines;
    final i = verticalLines.indexWhere((e) => e.id == item.id);
    if (i != -1) {
      verticalLines[i].currentEditIndex = item.currentEditIndex;
      verticalLines[i].dx1 = getX(mStartIndex) + (offset.dx / scaleX);
      verticalLines[i].datetime = getXTime(verticalLines[i].dx1, data);
      return verticalLines[i];
    }
    return null;
  }

  void drawVerticalLines(
    Canvas canvas,
    Size size,
    bool isBackground,
    List<KLineEntity> data,
  ) {
    final verticalLines = chartProperties.verticalLines;
    if (verticalLines.isEmpty) {
      return;
    }
    for (int i = 0; i < verticalLines.length; i++) {
      double x = getXFromTime(verticalLines[i].datetime, data);
      double strokeWidth = (verticalLines[i].height / scaleX).clamp(1, 4.0);
      final pricePaint = Paint()
        ..filterQuality = FilterQuality.high
        ..isAntiAlias = true
        ..strokeWidth = strokeWidth
        ..color = colorFromHex(verticalLines[i].color!)!;

      if (verticalLines[i].style == ObjectStyle.dash) {
        double startY = this.chartStyle.topPadding;
        final max = fDisplayHeight!;
        double space =
            this.chartStyle.priceLineSpan + this.chartStyle.lineLength;
        while (startY < max) {
          canvas.drawLine(
            Offset(x, startY),
            Offset(x, startY + this.chartStyle.lineLength),
            pricePaint,
          );
          startY += space;
        }
      } else {
        canvas.drawLine(
          Offset(x, this.chartStyle.topPadding),
          Offset(x, fDisplayHeight!),
          pricePaint,
        );
      }
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
