import 'dart:math';

import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/entity/object_entity.dart';
import 'package:candle_chart/renderer/chart_details.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../base_chart_renderer.dart';

mixin DrawFibonacciChannel on ChartDetails {
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
    final channels = chartProperties.fibonacciChannels;
    final i = channels.indexWhere((e) => e.id == item.id);
    if (i == -1) return null;
    final c = channels[i];
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

  ObjectEntity? setFibonacciChannelOffset1(
          ObjectEntity item, Offset offset, List<KLineEntity> data) =>
      _setPoint(item, offset, data, 0);

  ObjectEntity? setFibonacciChannelOffset2(
          ObjectEntity item, Offset offset, List<KLineEntity> data) =>
      _setPoint(item, offset, data, 1);

  ObjectEntity? setFibonacciChannelOffset3(
          ObjectEntity item, Offset offset, List<KLineEntity> data) =>
      _setPoint(item, offset, data, 2);

  void drawFibonacciChannel(
    Canvas canvas,
    Size size,
    bool isBackground,
    List<KLineEntity> data,
  ) {
    final channels = chartProperties.fibonacciChannels;
    if (channels.isEmpty) {
      return;
    }

    for (int i = 0; i < channels.length; i++) {
      final item = channels[i];
      if (item.drawAsBackground != isBackground) continue;

      final x1 = getXFromTime(item.datetime, data);
      final x2 = getXFromTime(item.datetime2, data);
      final x3 = getXFromTime(item.datetime3, data);
      final y1 = getMainY(item.value);
      final y2 = getMainY(item.value2);
      final y3 = getMainY(item.value3);
      if (y1 == null || y2 == null || y3 == null) continue;
      if (x1 == x2) continue;

      // Width vector: displacement from the base line to its parallel border.
      final wx = x3 - x1;
      final wy = y3 - y1;

      final strokeWidth = (item.height / scaleX).clamp(0.1, 1.0);
      final color = colorFromHex(item.color!)!;
      final isDash = item.style == ObjectStyle.dash;

      final linePaint = Paint()
        ..filterQuality = FilterQuality.high
        ..isAntiAlias = true
        ..strokeWidth = strokeWidth
        ..color = color;

      // Base line (offset 0).
      _drawChannelLine(canvas, x1, y1, x2, y2, linePaint, isDash,
          item.rayRight, item.rayLift);

      // Parallel Fibonacci offset lines.
      for (int l = 0; l < kFibonacciChannelLevels.length; l++) {
        final level = kFibonacciChannelLevels[l];
        final ax = x1 + wx * level;
        final ay = y1 + wy * level;
        final bx = x2 + wx * level;
        final by = y2 + wy * level;

        final levelColor = fibonacciLevelColor(l);
        linePaint.color = levelColor;
        _drawChannelLine(canvas, ax, ay, bx, by, linePaint, isDash,
            item.rayRight, item.rayLift);

        // Level label near the left end of the line.
        final tp = getTextPainter(
          level.toStringAsFixed(3),
          levelColor,
          fontWeight: FontWeight.w500,
        );
        canvas.save();
        canvas.translate(ax + 2, ay - tp.height - 1);
        canvas.scale(1 / scaleX, 1.0);
        tp.paint(canvas, Offset.zero);
        canvas.restore();
      }

      // Draggable handles: base start, base end, and the width point.
      final active = item.currentEditIndex == i;
      _drawHandle(canvas, Offset(x1, y1), color, active);
      _drawHandle(canvas, Offset(x2, y2), color, active);
      _drawHandle(canvas, Offset(x3, y3), color, active);
    }
  }

  void _drawChannelLine(
    Canvas canvas,
    double ax,
    double ay,
    double bx,
    double by,
    Paint paint,
    bool isDash,
    bool rayRight,
    bool rayLeft,
  ) {
    var sx = ax, sy = ay, ex = bx, ey = by;
    if (bx != ax) {
      final slope = (by - ay) / (bx - ax);
      if (rayLeft) {
        sx = -10000000;
        sy = ay + slope * (sx - ax);
      }
      if (rayRight) {
        ex = 10000000;
        ey = ay + slope * (ex - ax);
      }
    }
    if (isDash) {
      _drawDashLine(canvas, Offset(sx, sy), Offset(ex, ey), paint);
    } else {
      canvas.drawLine(Offset(sx, sy), Offset(ex, ey), paint);
    }
  }

  /// Draws a grab handle: a filled dot inside a ring. Enlarges when active.
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
