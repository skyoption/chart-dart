import 'dart:math';

import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/entity/object_entity.dart';
import 'package:candle_chart/renderer/chart_details.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../base_chart_renderer.dart';

mixin DrawFibonacciExpansion on ChartDetails {
  late final ChartPosition chartPosition;
  late final ChartStyle chartStyle;
  late Paint dot;
  late double scaleX;
  late double mMainHighMaxValue, mMainLowMinValue;

  ObjectEntity? _setPoint(
    ObjectEntity item,
    Offset offset,
    List<KLineEntity> data,
    int point,
  ) {
    final list = chartProperties.fibonacciExpansions;
    final i = list.indexWhere((e) => e.id == item.id);
    if (i == -1) return null;
    final c = list[i];
    c.currentEditIndex = item.currentEditIndex;

    final dx = getX(mStartIndex) + (offset.dx / scaleX);
    final time = getXTime(dx, data);
    var value = getYPositionValue(offset.dy);
    if (mMainLowMinValue >= value) {
      value = mMainLowMinValue;
    } else if (mMainHighMaxValue <= value) {
      value = mMainHighMaxValue;
    }
    final y = getMainY(value);
    if (y == null) return null;

    if (point == 0) {
      c.dx1 = dx;
      c.datetime = time;
      c.value = value;
      c.dy1 = y;
    } else if (point == 1) {
      c.dx2 = dx;
      c.datetime2 = time;
      c.value2 = value;
      c.dy2 = y;
    } else {
      c.dx3 = dx;
      c.datetime3 = time;
      c.value3 = value;
      c.dy3 = y;
    }
    return c;
  }

  ObjectEntity? setFibonacciExpansionOffset1(
          ObjectEntity item, Offset offset, List<KLineEntity> data) =>
      _setPoint(item, offset, data, 0);

  ObjectEntity? setFibonacciExpansionOffset2(
          ObjectEntity item, Offset offset, List<KLineEntity> data) =>
      _setPoint(item, offset, data, 1);

  ObjectEntity? setFibonacciExpansionOffset3(
          ObjectEntity item, Offset offset, List<KLineEntity> data) =>
      _setPoint(item, offset, data, 2);

  void drawFibonacciExpansion(
    Canvas canvas,
    Size size,
    bool isBackground,
    List<KLineEntity> data,
  ) {
    final list = chartProperties.fibonacciExpansions;
    if (list.isEmpty) {
      return;
    }

    for (int i = 0; i < list.length; i++) {
      final item = list[i];
      if (item.drawAsBackground != isBackground) continue;

      final x1 = getXFromTime(item.datetime, data);
      final x2 = getXFromTime(item.datetime2, data);
      final x3 = getXFromTime(item.datetime3, data);
      final y1 = getMainY(item.value);
      final y2 = getMainY(item.value2);
      final y3 = getMainY(item.value3);
      if (y1 == null || y2 == null || y3 == null) continue;

      final strokeWidth = (item.height / scaleX).clamp(0.1, 1.0);
      final color = colorFromHex(item.color!)!;
      final isDash = item.style == ObjectStyle.dash;

      // Wave 1 (p1->p2) and wave 2 (p2->p3) guide lines.
      final wavePaint = Paint()
        ..filterQuality = FilterQuality.high
        ..isAntiAlias = true
        ..strokeWidth = strokeWidth
        ..color = color.withOpacity(0.6);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), wavePaint);
      canvas.drawLine(Offset(x2, y2), Offset(x3, y3), wavePaint);

      // Unit interval = first wave height; levels projected from the reference
      // point (p3) as horizontal lines.
      final unit = item.value2 - item.value;

      double left = [x1, x2, x3].reduce(min);
      double right = [x1, x2, x3].reduce(max);
      if (item.rayLift) left = -10000000;
      if (item.rayRight) right = 10000000;

      final linePaint = Paint()
        ..filterQuality = FilterQuality.high
        ..isAntiAlias = true
        ..strokeWidth = strokeWidth;

      final levels = effectiveLevels(item, kFibonacciExpansionLevels);
      for (int l = 0; l < levels.length; l++) {
        final ratio = levels[l];
        final levelPrice = item.value3 + unit * ratio;
        final y = getMainY(levelPrice);
        if (y == null) continue;

        final levelColor = fibonacciLevelColor(l);
        linePaint.color = levelColor;
        if (isDash) {
          _drawDashLine(canvas, Offset(left, y), Offset(right, y), linePaint);
        } else {
          canvas.drawLine(Offset(left, y), Offset(right, y), linePaint);
        }

        final tp = getTextPainter(
          'FE ${(ratio * 100).toStringAsFixed(1)}',
          levelColor,
          fontWeight: FontWeight.w500,
        );
        canvas.save();
        canvas.translate(left + 2, y - tp.height - 1);
        canvas.scale(1 / scaleX, 1.0);
        tp.paint(canvas, Offset.zero);
        canvas.restore();
      }

      // Draggable handles for the three points.
      final active = item.currentEditIndex == i;
      _drawHandle(canvas, Offset(x1, y1), color, active);
      _drawHandle(canvas, Offset(x2, y2), color, active);
      _drawHandle(canvas, Offset(x3, y3), color, active);
    }
  }

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

  void _drawDashLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    const dashWidth = 5.0;
    const dashSpace = 4.0;
    final dx = end.dx - start.dx;
    final dy = end.dy - start.dy;
    final dist = sqrt(dx * dx + dy * dy);
    if (dist == 0) return;
    final count = dist / (dashWidth + dashSpace);
    final xStep = dx / count;
    final yStep = dy / count;
    var cx = start.dx;
    var cy = start.dy;
    for (int k = 0; k < count; k++) {
      final ex = cx + xStep * (dashWidth / (dashWidth + dashSpace));
      final ey = cy + yStep * (dashWidth / (dashWidth + dashSpace));
      canvas.drawLine(Offset(cx, cy), Offset(ex, ey), paint);
      cx += xStep;
      cy += yStep;
    }
  }
}
