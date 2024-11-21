import 'package:candle_chart/entity/line_entity.dart';
import 'package:candle_chart/renderer/chart_details.dart';
import 'package:candle_chart/utils/kprint.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../base_chart_renderer.dart';

mixin DrawHorizontalLines on ChartDetails {
  late final ChartPosition chartPosition;
  late final ChartStyle chartStyle;
  late Paint pricePaint, dot;
  late double mTranslateX;
  late double mWidth;
  late double scaleX;
  late final ChartColors chartColors;
  late double mMainHighMaxValue, mMainLowMinValue;
  late int fixedLength;

  void drawHorizontalLines(Canvas canvas, Size size) {
    final horizontalLines = chartProperties.horizontalLines;
    if (horizontalLines.isEmpty) {
      return;
    }
    for (int i = 0; i < horizontalLines.length; i++) {
      double value = horizontalLines[i].value;
      if (horizontalLines[i].dy1 == 0) {
        horizontalLines[i].dy1 = getMainY(horizontalLines[i].value);
      }
      if (value <= this.chartPosition.topPrice &&
          value >= this.chartPosition.bottomPrice) {
        double y = getMainY(value);
        //view display area boundary value drawing
        // if (y > getMainY(mMainLowMinValue)) {
        //   y = getMainY(mMainLowMinValue);
        // }
        //
        // if (y < getMainY(mMainHighMaxValue)) {
        //   y = getMainY(mMainHighMaxValue);
        // }
        if (horizontalLines[i].currentEditIndex == i) {
          value = getYPositionValue(horizontalLines[i].dy1);
          y = getMainY(value);
          // if (y > getMainY(mMainLowMinValue)) {
          //   y = getMainY(mMainLowMinValue);
          // }
          // if (y < getMainY(mMainHighMaxValue)) {
          //   y = getMainY(mMainHighMaxValue);
          // }
          horizontalLines[i].value = value;
        }
        pricePaint
          ..color = colorFromHex(horizontalLines[i].color!)!
          ..strokeWidth = horizontalLines[i].height;
        //first draw the horizontal line
        double startX = 0;
        final max = -mTranslateX + mWidth / scaleX;
        double space = 0.0;
        if (horizontalLines[i].style == LineStyle.longDash) {
          space = this.chartStyle.priceLineLongSpan +
              this.chartStyle.priceLineLength;
        } else {
          space =
              this.chartStyle.priceLineSpan + this.chartStyle.priceLineLength;
        }
        if (horizontalLines[i].style == LineStyle.dash ||
            horizontalLines[i].style == LineStyle.longDash) {
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
            5.0,
            dot,
          );
          canvas.drawCircle(
            Offset(max, y),
            5.0,
            dot,
          );
        }
        //repaint the background and text
        TextPainter tp = getTextPainter(
          value.toStringAsFixed(fixedLength),
          this.chartColors.priceTextColor,
        );

        // switch (verticalTextAlignment) {
        //   case VerticalTextAlignment.left:
        //     offsetX = mWidth - tp.width;
        //     break;
        //   case VerticalTextAlignment.right:
        //     offsetX = 0;
        //     break;
        // }

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
