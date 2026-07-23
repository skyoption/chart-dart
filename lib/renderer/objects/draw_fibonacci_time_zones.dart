import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/entity/object_entity.dart';
import 'package:candle_chart/renderer/chart_details.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../base_chart_renderer.dart';

mixin DrawFibonacciTimeZones on ChartDetails {
  late final ChartPosition chartPosition;
  late final ChartStyle chartStyle;
  late Paint dot;
  late double scaleX;
  late double mMainHighMaxValue, mMainLowMinValue;
  double? fDisplayHeight;

  ObjectEntity? setFibonacciTimeZoneOffset1(
    ObjectEntity item,
    Offset offset,
    List<KLineEntity> data,
  ) {
    final zones = chartProperties.fibonacciTimeZones;
    final i = zones.indexWhere((e) => e.id == item.id);
    if (i != -1) {
      zones[i].currentEditIndex = item.currentEditIndex;
      zones[i].dx1 = getX(mStartIndex) + (offset.dx / scaleX);
      zones[i].datetime = getXTime(zones[i].dx1, data);
      final value = getYPositionValue(offset.dy);
      if (mMainLowMinValue >= value) {
        zones[i].value = mMainLowMinValue;
      } else if (mMainHighMaxValue <= value) {
        zones[i].value = mMainHighMaxValue;
      } else {
        zones[i].value = value;
      }
      double? y = getMainY(zones[i].value);
      if (y == null) return null;
      zones[i].dy1 = y;
      return zones[i];
    }
    return null;
  }

  ObjectEntity? setFibonacciTimeZoneOffset2(
    ObjectEntity item,
    Offset offset,
    List<KLineEntity> data,
  ) {
    final zones = chartProperties.fibonacciTimeZones;
    final i = zones.indexWhere((e) => e.id == item.id);
    if (i != -1) {
      zones[i].currentEditIndex = item.currentEditIndex;
      zones[i].dx2 = getX(mStartIndex) + (offset.dx / scaleX);
      zones[i].datetime2 = getXTime(zones[i].dx2, data);
      final value = getYPositionValue(offset.dy);
      if (mMainLowMinValue >= value) {
        zones[i].value2 = mMainLowMinValue;
      } else if (mMainHighMaxValue <= value) {
        zones[i].value2 = mMainHighMaxValue;
      } else {
        zones[i].value2 = value;
      }
      double? y = getMainY(zones[i].value2);
      if (y == null) return null;
      zones[i].dy2 = y;
      return zones[i];
    }
    return null;
  }

  void drawFibonacciTimeZones(
    Canvas canvas,
    Size size,
    bool isBackground,
    List<KLineEntity> data,
  ) {
    final zones = chartProperties.fibonacciTimeZones;
    if (zones.isEmpty) {
      return;
    }

    final top = chartStyle.topPadding;
    final bottom = fDisplayHeight ?? size.height;

    for (int i = 0; i < zones.length; i++) {
      final item = zones[i];
      if (item.drawAsBackground != isBackground) continue;

      double x1 = getXFromTime(item.datetime, data);
      double x2 = getXFromTime(item.datetime2, data);
      final unit = x2 - x1;
      if (unit == 0) continue;

      double strokeWidth = (item.height / scaleX).clamp(0.1, 1.0);
      final color = colorFromHex(item.color!)!;
      final linePaint = Paint()
        ..filterQuality = FilterQuality.high
        ..isAntiAlias = true
        ..strokeWidth = strokeWidth
        ..color = color;

      // Unit-interval connector between the two anchor points.
      double? y1 = getMainY(item.value);
      double? y2 = getMainY(item.value2);
      if (y1 != null && y2 != null) {
        final connectorPaint = Paint()
          ..filterQuality = FilterQuality.high
          ..isAntiAlias = true
          ..strokeWidth = strokeWidth
          ..color = color.withOpacity(0.5);
        canvas.drawLine(Offset(x1, y1), Offset(x2, y2), connectorPaint);
      }

      // Vertical lines at Fibonacci multiples of the unit interval.
      for (final level in kFibonacciTimeZoneLevels) {
        final x = x1 + unit * level;

        if (item.style == ObjectStyle.dash) {
          double startY = top;
          const dashLen = 5.0;
          const dashGap = 4.0;
          while (startY < bottom) {
            canvas.drawLine(
              Offset(x, startY),
              Offset(x, (startY + dashLen).clamp(top, bottom)),
              linePaint,
            );
            startY += dashLen + dashGap;
          }
        } else {
          canvas.drawLine(Offset(x, top), Offset(x, bottom), linePaint);
        }

        // Level number label near the top, rendered at natural scale.
        final label = level.toStringAsFixed(0);
        final tp = getTextPainter(label, color, fontWeight: FontWeight.w500);
        canvas.save();
        canvas.translate(x + 2, top + 2);
        canvas.scale(1 / scaleX, 1.0);
        tp.paint(canvas, Offset.zero);
        canvas.restore();
      }

      if (item.currentEditIndex == i) {
        if (y1 != null) canvas.drawCircle(Offset(x1, y1), 2.5, dot);
        if (y2 != null) canvas.drawCircle(Offset(x2, y2), 2.5, dot);
      }
    }
  }
}
