import 'package:candle_chart/entity/object_entity.dart';
import 'package:candle_chart/renderer/chart_details.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../base_chart_renderer.dart';

mixin DrawTPAndSLLines on ChartDetails {
  late final ChartPosition chartPosition;
  late final ChartStyle chartStyle;
  late Paint dot;
  late double mTranslateX;
  late double mWidth;
  late double scaleX;
  late final ChartColors chartColors;
  late double mMainHighMaxValue, mMainLowMinValue;
  late int fixedLength;

  ObjectEntity? setTPAndSLLineValue(ObjectEntity item, double value) {
    final tPAndSLLines = chartProperties.tPAndSLLines;
    final i = tPAndSLLines.indexWhere((e) => e.id == item.id);
    if (i != -1) {
      tPAndSLLines[i].currentEditIndex = -1;
      double? y = getMainY(value);
      if (y == null) return null;
      tPAndSLLines[i].dy1 = y;
      tPAndSLLines[i].value = value;
      return tPAndSLLines[i];
    }
    return null;
  }

  ObjectEntity? setTPAndSLLineOffset(ObjectEntity item, Offset offset) {
    final tPAndSLLines = chartProperties.tPAndSLLines;
    final i = tPAndSLLines.indexWhere((e) => e.id == item.id);
    if (i != -1) {
      tPAndSLLines[i].currentEditIndex = item.currentEditIndex;
      final value = getYPositionValue(offset.dy);
      if (mMainLowMinValue >= value) {
        tPAndSLLines[i].value = mMainLowMinValue;
        double? y = getMainY(mMainLowMinValue);
        if (y == null) return null;
        tPAndSLLines[i].dy1 = y;
      } else if (mMainHighMaxValue <= value) {
        tPAndSLLines[i].value = mMainHighMaxValue;
        double? y = getMainY(mMainLowMinValue);
        if (y == null) return null;
        tPAndSLLines[i].dy1 = y;
      } else {
        double? y = getMainY(tPAndSLLines[i].value);
        if (y == null) return null;
        tPAndSLLines[i].dy1 = y;
        tPAndSLLines[i].value = value;
      }
      return tPAndSLLines[i];
    }
    return null;
  }

  void drawTPAndSLLines(Canvas canvas, Size size, bool isBackground) {
    final tPAndSLLines = chartProperties.tPAndSLLines;
    if (tPAndSLLines.isEmpty) {
      return;
    }
    for (int i = 0; i < tPAndSLLines.length; i++) {
      if (tPAndSLLines[i].drawAsBackground != isBackground) continue;
      double value = tPAndSLLines[i].value;
      if (value <= this.chartPosition.topPrice &&
          value >= this.chartPosition.bottomPrice) {
        double? y = getMainY(value);
        if (y == null) return;
        if (mMainLowMinValue >= value) {
          y = getMainY(mMainLowMinValue);
        } else if (mMainHighMaxValue <= value) {
          y = getMainY(mMainHighMaxValue);
        }
        if (y == null) return;
        final pricePaint = Paint()
          ..filterQuality = FilterQuality.high
          ..isAntiAlias = true
          ..strokeWidth = tPAndSLLines[i].height
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..color = colorFromHex(tPAndSLLines[i].color!)!;

        double startX = 0;
        final max = -mTranslateX + (mWidth + 20) / scaleX;
        final strokeWidth =
            (this.chartStyle.lineLength / scaleX).clamp(1, 10.0);
        if (tPAndSLLines[i].style == ObjectStyle.dash) {
          while (startX < max) {
            canvas.drawLine(
              Offset(startX, y),
              Offset(startX + strokeWidth, y),
              pricePaint,
            );
            startX += strokeWidth * 2;
          }
        } else {
          canvas.drawLine(Offset(startX, y), Offset(max, y), pricePaint);
        }
      }
    }
  }

  void drawTPAndSLTitles(Canvas canvas, Size size) {
    final tPAndSLLines = chartProperties.tPAndSLLines;
    if (tPAndSLLines.isEmpty) {
      return;
    }
    for (int i = 0; i < tPAndSLLines.length; i++) {
      double value = tPAndSLLines[i].value;
      if (mMainLowMinValue >= value) continue;
      double? y = getMainY(value);
      if (y == null) return;
      if (mMainLowMinValue >= value || mMainHighMaxValue <= value) {
        return;
      }

      double startX = 0;
      final max = -mTranslateX + (mWidth + 20) / scaleX;

      final pricePaint = Paint()
        ..color = colorFromHex(tPAndSLLines[i].color!)!
        ..strokeWidth = tPAndSLLines[i].height;

      if (tPAndSLLines[i].currentEditIndex == i) {
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
      if (tPAndSLLines[i].title != null &&
          tPAndSLLines[i].title!(value).isNotEmpty) {
        TextPainter title = getTextPainter(
          tPAndSLLines[i].title!(value),
          colorFromHex(tPAndSLLines[i].color!)!,
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
