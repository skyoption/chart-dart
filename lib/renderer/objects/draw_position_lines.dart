import 'package:candle_chart/entity/object_entity.dart';
import 'package:candle_chart/renderer/chart_details.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../base_chart_renderer.dart';

mixin DrawPositionLines on ChartDetails {
  late final ChartPosition chartPosition;
  late final ChartStyle chartStyle;
  late Paint dot;
  late double mTranslateX;
  late double mWidth;
  late double scaleX;
  late final ChartColors chartColors;
  late double mMainHighMaxValue, mMainLowMinValue;
  late int fixedLength;

  ObjectEntity? setPositionLineOffset(ObjectEntity item, Offset offset) {
    final positionLines = chartProperties.positionLines;
    final i = positionLines.indexWhere((e) => e.id == item.id);
    if (i != -1) {
      positionLines[i].currentEditIndex = item.currentEditIndex;
      final value = getYPositionValue(offset.dy);
      if (mMainLowMinValue >= value) {
        positionLines[i].value = mMainLowMinValue;
        positionLines[i].dy1 = getMainY(mMainLowMinValue);
      } else if (mMainHighMaxValue <= value) {
        positionLines[i].value = mMainHighMaxValue;
        positionLines[i].dy1 = getMainY(mMainLowMinValue);
      } else {
        positionLines[i].dy1 = getMainY(positionLines[i].value);
        positionLines[i].value = value;
      }
      return positionLines[i];
    }
    return null;
  }

  void drawPositionLines(Canvas canvas, Size size, bool isBackground) {
    final positionLines = chartProperties.positionLines;
    if (positionLines.isEmpty) {
      return;
    }
    for (int i = 0; i < positionLines.length; i++) {
      if (positionLines[i].drawAsBackground != isBackground) continue;
      double value = positionLines[i].value;

      if (value <= this.chartPosition.topPrice &&
          value >= this.chartPosition.bottomPrice) {
        double y = getMainY(value);
        if (mMainLowMinValue >= value) {
          y = getMainY(mMainLowMinValue);
        } else if (mMainHighMaxValue <= value) {
          y = getMainY(mMainHighMaxValue);
        }
        final pricePaint = Paint()
          ..color = colorFromHex(positionLines[i].color!)!
          ..strokeWidth = positionLines[i].height;

        double startX = 0;
        final max = -mTranslateX + (mWidth + 20) / scaleX;
        double space =
            this.chartStyle.priceLineSpan + this.chartStyle.priceLineLength;
        if (positionLines[i].style == ObjectStyle.dash) {
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
      }
    }
  }

  void drawPositionTitles(Canvas canvas, Size size) {
    final positionLines = chartProperties.positionLines;
    if (positionLines.isEmpty) {
      return;
    }
    for (int i = 0; i < positionLines.length; i++) {
      double value = positionLines[i].value;
      if (mMainLowMinValue >= value) continue;
      double y = getMainY(value);
      final pricePaint = Paint()
        ..color = colorFromHex(positionLines[i].color!)!
        ..strokeWidth = positionLines[i].height;

      double startX = 0;
      final max = -mTranslateX + (mWidth + 20) / scaleX;

      if (positionLines[i].currentEditIndex == i) {
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
          offsetX - 12,
          top - 2,
          offsetX + tp.width,
          top + tp.height + 3,
        ),
        pricePaint,
      );
      tp.paint(canvas, Offset(offsetX - 6, top + 2));
    }
  }
}
