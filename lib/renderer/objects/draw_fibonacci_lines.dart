import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/entity/object_entity.dart';
import 'package:candle_chart/renderer/chart_details.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../base_chart_renderer.dart';

mixin DrawFibonacciLines on ChartDetails {
  late final ChartPosition chartPosition;
  late final ChartStyle chartStyle;
  late final ChartColors chartColors;
  late Paint dot;
  late double scaleX;
  late double mMainHighMaxValue, mMainLowMinValue;
  late int fixedLength;

  ObjectEntity? setFibonacciOffset1(
    ObjectEntity item,
    Offset offset,
    List<KLineEntity> data,
  ) {
    final fibonaccis = chartProperties.fibonaccis;
    final i = fibonaccis.indexWhere((e) => e.id == item.id);
    if (i != -1) {
      fibonaccis[i].currentEditIndex = item.currentEditIndex;
      fibonaccis[i].dx1 = getX(mStartIndex) + (offset.dx / scaleX);
      fibonaccis[i].datetime = getXTime(fibonaccis[i].dx1, data);
      final value = getYPositionValue(offset.dy);
      if (mMainLowMinValue >= value) {
        fibonaccis[i].value = mMainLowMinValue;
        double? y = getMainY(mMainLowMinValue);
        if (y == null) return null;
        fibonaccis[i].dy1 = y;
      } else if (mMainHighMaxValue <= value) {
        fibonaccis[i].value = mMainHighMaxValue;
        double? y = getMainY(mMainLowMinValue);
        if (y == null) return null;
        fibonaccis[i].dy1 = y;
      } else {
        double? y = getMainY(fibonaccis[i].value);
        if (y == null) return null;
        fibonaccis[i].dy1 = y;
        fibonaccis[i].value = value;
      }
      return fibonaccis[i];
    }
    return null;
  }

  ObjectEntity? setFibonacciOffset2(
    ObjectEntity item,
    Offset offset,
    List<KLineEntity> data,
  ) {
    final fibonaccis = chartProperties.fibonaccis;
    final i = fibonaccis.indexWhere((e) => e.id == item.id);
    if (i != -1) {
      fibonaccis[i].currentEditIndex = item.currentEditIndex;
      fibonaccis[i].dx2 = getX(mStartIndex) + (offset.dx / scaleX);
      fibonaccis[i].value2 = getYPositionValue(offset.dy);
      fibonaccis[i].datetime2 = getXTime(fibonaccis[i].dx2, data);
      final value = getYPositionValue(offset.dy);
      if (mMainLowMinValue >= value) {
        fibonaccis[i].value2 = mMainLowMinValue;
        double? y = getMainY(mMainLowMinValue);
        if (y == null) return null;
        fibonaccis[i].dy2 = y;
      } else if (mMainHighMaxValue <= value) {
        fibonaccis[i].value2 = mMainHighMaxValue;
        double? y = getMainY(mMainLowMinValue);
        if (y == null) return null;
        fibonaccis[i].dy2 = y;
      } else {
        double? y = getMainY(fibonaccis[i].value2);
        if (y == null) return null;
        fibonaccis[i].dy2 = y;
        fibonaccis[i].value2 = value;
      }
      return fibonaccis[i];
    }
    return null;
  }

  void drawFibonacciLines(
    Canvas canvas,
    Size size,
    bool isBackground,
    List<KLineEntity> data,
  ) {
    final fibonaccis = chartProperties.fibonaccis;
    if (fibonaccis.isEmpty) {
      return;
    }

    for (int i = 0; i < fibonaccis.length; i++) {
      final item = fibonaccis[i];
      if (item.drawAsBackground != isBackground) continue;

      double x1 = getXFromTime(item.datetime, data);
      double x2 = getXFromTime(item.datetime2, data);
      double? y1 = getMainY(item.value);
      double? y2 = getMainY(item.value2);
      if (y1 == null || y2 == null) return;

      double strokeWidth = (item.height / scaleX).clamp(0.1, 1.0);
      final color = colorFromHex(item.color!)!;
      final linePaint = Paint()
        ..filterQuality = FilterQuality.high
        ..isAntiAlias = true
        ..strokeWidth = strokeWidth
        ..color = color;

      // Trend line connecting the two anchor points.
      final trendPaint = Paint()
        ..filterQuality = FilterQuality.high
        ..isAntiAlias = true
        ..strokeWidth = strokeWidth
        ..color = color.withOpacity(0.6);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), trendPaint);

      // Horizontal extent of the level lines.
      double left = x1 < x2 ? x1 : x2;
      double right = x1 > x2 ? x1 : x2;
      if (item.rayLift) left = -10000000;
      if (item.rayRight) right = 10000000;

      // ratio 0 -> value (point1), ratio 1 -> value2 (point2).
      final priceMove = item.value2 - item.value;

      final levels = effectiveLevels(item, kFibonacciLevels);
      for (int l = 0; l < levels.length; l++) {
        final ratio = levels[l];
        final levelPrice = item.value + priceMove * ratio;
        double? y = getMainY(levelPrice);
        if (y == null) continue;

        // Each level gets its own distinct color.
        final levelColor = fibonacciLevelColor(l);
        linePaint.color = levelColor;

        if (item.style == ObjectStyle.dash) {
          _drawDashLine(canvas, Offset(left, y), Offset(right, y), linePaint);
        } else {
          canvas.drawLine(Offset(left, y), Offset(right, y), linePaint);
        }

        // Level label: "ratio (price)".
        final label = '${ratio.toStringAsFixed(3)}';
        final tp =
            getTextPainter(label, levelColor, fontWeight: FontWeight.w500);
        // The canvas is scaled by scaleX horizontally; counter-scale the text
        // so it renders at its natural (unscaled) proportions.
        canvas.save();
        canvas.translate(left + 2, y - tp.height - 1);
        canvas.scale(1 / scaleX, 1.0);
        tp.paint(canvas, Offset.zero);
        canvas.restore();
      }

      // Always-visible draggable start/end handles.
      _drawHandle(canvas, Offset(x1, y1), color, item.currentEditIndex == i);
      _drawHandle(canvas, Offset(x2, y2), color, item.currentEditIndex == i);
    }
  }

  /// Draws a grab handle: a filled dot inside a ring. Enlarges when active.
  /// Counter-scales the horizontal canvas scale so the handle stays circular.
  void _drawHandle(Canvas canvas, Offset center, Color color, bool active) {
    final radius = active ? 4.5 : 3.5;
    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..isAntiAlias = true
      ..color = color;
    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..color = Colors.white;
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(1 / scaleX, 1.0);
    canvas.drawCircle(Offset.zero, radius, fillPaint);
    canvas.drawCircle(Offset.zero, radius, ringPaint);
    canvas.restore();
  }

  void _drawDashLine(
    Canvas canvas,
    Offset start,
    Offset end,
    Paint paint,
  ) {
    const double dashWidth = 5.0;
    const double dashSpace = 4.0;
    double startX = start.dx;
    while (startX < end.dx) {
      canvas.drawLine(
        Offset(startX, start.dy),
        Offset(startX + dashWidth, start.dy),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }
}
