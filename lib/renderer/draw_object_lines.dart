import 'package:candle_chart/entity/line_entity.dart';
import 'package:candle_chart/renderer/chart_details.dart';
import 'package:flutter/material.dart';

import 'base_chart_renderer.dart';

mixin DrawObjectLines on ChartDetails {
  late final List<LineEntity> linesPrice;
  late final ChartPosition chartPosition;
  late final ChartStyle chartStyle;
  late Paint pricePaint;
  late double mTranslateX;
  late double mWidth;
  late double scaleX;
  late final ChartColors chartColors;
  late double mMainHighMaxValue, mMainLowMinValue;
  late int fixedLength;

  void drawLinePrice(Canvas canvas, Size size) {
    if (linesPrice.isEmpty) {
      return;
    }
    for (int i = 0; i < linesPrice.length; i++) {
      double value = linesPrice[i].value;
      if (linesPrice[i].dy == 0) {
        linesPrice[i].dy = getMainY(linesPrice[i].value);
      }
      if (value <= this.chartPosition.topPrice &&
          value >= this.chartPosition.bottomPrice) {
        double y = getMainY(value);
        //view display area boundary value drawing
        if (y > getMainY(mMainLowMinValue)) {
          y = getMainY(mMainLowMinValue);
        }

        if (y < getMainY(mMainHighMaxValue)) {
          y = getMainY(mMainHighMaxValue);
        }

        if (linesPrice[i].editable) {
          value = getYPositionValue(linesPrice[i].dy);
          y = getMainY(value);
          if (y > getMainY(mMainLowMinValue)) {
            y = getMainY(mMainLowMinValue);
          }
          if (y < getMainY(mMainHighMaxValue)) {
            y = getMainY(mMainHighMaxValue);
          }
        }

        pricePaint
          ..color = linesPrice[i].color
          ..strokeWidth = linesPrice[i].height;
        //first draw the horizontal line
        double startX = 0;
        final max = -mTranslateX + mWidth / scaleX;
        double space = 0.0;
        if (linesPrice[i].style == LineStyle.longDash) {
          space = this.chartStyle.priceLineLongSpan +
              this.chartStyle.priceLineLength;
        } else {
          space =
              this.chartStyle.priceLineSpan + this.chartStyle.priceLineLength;
        }
        if (linesPrice[i].style == LineStyle.dash ||
            linesPrice[i].style == LineStyle.longDash) {
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
