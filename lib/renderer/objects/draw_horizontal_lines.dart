import 'package:candle_chart/entity/object_entity.dart';
import 'package:candle_chart/renderer/chart_details.dart';
import 'package:candle_chart/utils/kprint.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../base_chart_renderer.dart';

mixin DrawHorizontalLines on ChartDetails {
  late final ChartPosition chartPosition;
  late final ChartStyle chartStyle;
  late Paint dot;
  late double mTranslateX;
  late double mWidth;
  late double scaleX;
  late final ChartColors chartColors;
  late double mMainHighMaxValue, mMainLowMinValue;
  late int fixedLength;

  ObjectEntity? setHorizontalLineOffset(ObjectEntity item, Offset offset) {
    final horizontalLines = chartProperties.horizontalLines;
    final i = horizontalLines.indexWhere((e) => e.id == item.id);
    if (i != -1) {
      horizontalLines[i].currentEditIndex = item.currentEditIndex;
      horizontalLines[i].value = getYPositionValue(offset.dy);
      horizontalLines[i].dy1 = getMainY(horizontalLines[i].value);
      return horizontalLines[i];
    }
    return null;
  }

  void drawHorizontalLines(Canvas canvas, Size size) {
    final horizontalLines = chartProperties.horizontalLines;
    if (horizontalLines.isEmpty) {
      return;
    }
    for (int i = 0; i < horizontalLines.length; i++) {
      double value = horizontalLines[i].value;

      if (value <= this.chartPosition.topPrice &&
          value >= this.chartPosition.bottomPrice) {
        double y = getMainY(value);

        final pricePaint = Paint()
          ..color = colorFromHex(horizontalLines[i].color!)!
          ..strokeWidth = horizontalLines[i].height;

        double startX = 0;
        final max = -mTranslateX + mWidth / scaleX;
        double space =
            this.chartStyle.priceLineSpan + this.chartStyle.priceLineLength;
        if (horizontalLines[i].style == ObjectStyle.dash) {
          while (startX < max) {
            canvas.drawLine(
                Offset(startX, y),
                Offset(startX + this.chartStyle.priceLineLength, y),
                pricePaint);
            startX += space;
          }
        } else {
          canvas.drawLine(Offset(startX, y), Offset(max, y), pricePaint);
        }

        if (horizontalLines[i].currentEditIndex == i) {
          canvas.drawCircle(
            Offset(startX, y),
            2.5,
            dot,
          );
          canvas.drawCircle(
            Offset(max, y),
            2.5,
            dot,
          );
        }

        TextPainter tp = getTextPainter(
          value.toStringAsFixed(fixedLength),
          this.chartColors.priceTextColor,
        );

        double offsetX = mWidth - tp.width + this.chartStyle.priceWidth + 4;

        double top = y - tp.height / 2;
        canvas.drawRect(
            Rect.fromLTRB(
                offsetX - 12, top - 2, offsetX + tp.width, top + tp.height + 3),
            pricePaint);
        tp.paint(canvas, Offset(offsetX - 6, top + 2));
      }
    }
  }
}
