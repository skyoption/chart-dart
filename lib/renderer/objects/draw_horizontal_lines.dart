import 'package:candle_chart/entity/object_entity.dart';
import 'package:candle_chart/renderer/chart_details.dart';
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
      final value = getYPositionValue(offset.dy);
      if (mMainLowMinValue >= value) {
        horizontalLines[i].value = mMainLowMinValue;
        horizontalLines[i].dy1 = getMainY(mMainLowMinValue);
      } else if (mMainHighMaxValue <= value) {
        horizontalLines[i].value = mMainHighMaxValue;
        horizontalLines[i].dy1 = getMainY(mMainLowMinValue);
      } else {
        horizontalLines[i].dy1 = getMainY(horizontalLines[i].value);
        horizontalLines[i].value = value;
      }
      return horizontalLines[i];
    }
    return null;
  }

  void drawHorizontalLines(Canvas canvas, Size size, bool isBackground) {
    final horizontalLines = chartProperties.horizontalLines;
    if (horizontalLines.isEmpty) {
      return;
    }
    for (int i = 0; i < horizontalLines.length; i++) {
      if (horizontalLines[i].drawAsBackground != isBackground) continue;
      double value = horizontalLines[i].value;

      if (value <= this.chartPosition.topPrice &&
          value >= this.chartPosition.bottomPrice) {
        double y = getMainY(value);
        if (mMainLowMinValue >= value) {
          y = getMainY(mMainLowMinValue);
        } else if (mMainHighMaxValue <= value) {
          y = getMainY(mMainHighMaxValue);
        }
        final pricePaint = Paint()
          ..color = colorFromHex(horizontalLines[i].color!)!
          ..strokeWidth = horizontalLines[i].height;

        double startX = 0;
        final max = -mTranslateX + (mWidth + 20) / scaleX;
        double space =
            this.chartStyle.priceLineSpan + this.chartStyle.lineLength;
        if (horizontalLines[i].style == ObjectStyle.dash) {
          while (startX < max) {
            canvas.drawLine(Offset(startX, y),
                Offset(startX + this.chartStyle.lineLength, y), pricePaint);
            startX += space;
          }
        } else {
          canvas.drawLine(Offset(startX, y), Offset(max, y), pricePaint);
        }
      }
    }
  }

  void drawHorizontalLinesTitles(Canvas canvas, Size size) {
    final horizontalLines = chartProperties.horizontalLines;
    if (horizontalLines.isEmpty) {
      return;
    }

    for (int i = 0; i < horizontalLines.length; i++) {
      double value = horizontalLines[i].value;
      if (mMainLowMinValue >= value) continue;
      double y = getMainY(value);
      double strokeWidth = (horizontalLines[i].height / scaleX).clamp(1, 4.0);
      final pricePaint = Paint()
        ..filterQuality = FilterQuality.high
        ..isAntiAlias = true
        ..strokeWidth = strokeWidth
        ..color = colorFromHex(horizontalLines[i].color!)!;

      double startX = 0;
      final max = -mTranslateX + (mWidth + 20) / scaleX;

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

      if (horizontalLines[i].title.isNotEmpty) {
        TextPainter title = getTextPainter(
          horizontalLines[i].title,
          colorFromHex(horizontalLines[i].color!)!,
          fontWeight: FontWeight.w600,
        );

        title.paint(canvas, Offset(startX, y - title.height * 1.2));
      }

      TextPainter tp = getTextPainter(
        value.toStringAsFixed(fixedLength),
        this.chartColors.priceTextColor,
      );

      double offsetX = mWidth -
          tp.width +
          this.chartStyle.priceWidth -
          this.chartStyle.leftPadding * 2;

      double top = y - tp.height / 2;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTRB(
            offsetX - 12,
            top - 2,
            offsetX + tp.width * 1.5,
            top + tp.height + 3,
          ),
          const Radius.circular(8.0),
        ),
        pricePaint,
      );
      tp.paint(canvas, Offset(offsetX, top + 2));
    }
  }
}
