import 'dart:math';

import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/entity/object_entity.dart';
import 'package:candle_chart/renderer/chart_details.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../base_chart_renderer.dart';

mixin DrawFibonacciFan on ChartDetails {
  late final ChartPosition chartPosition;
  late final ChartStyle chartStyle;
  late Paint dot;
  late double scaleX;
  late double mMainHighMaxValue, mMainLowMinValue;

  ObjectEntity? setFibonacciFanOffset1(
    ObjectEntity item,
    Offset offset,
    List<KLineEntity> data,
  ) {
    final fans = chartProperties.fibonacciFans;
    final i = fans.indexWhere((e) => e.id == item.id);
    if (i != -1) {
      fans[i].currentEditIndex = item.currentEditIndex;
      fans[i].dx1 = getX(mStartIndex) + (offset.dx / scaleX);
      fans[i].datetime = getXTime(fans[i].dx1, data);
      final value = getYPositionValue(offset.dy);
      if (mMainLowMinValue >= value) {
        fans[i].value = mMainLowMinValue;
      } else if (mMainHighMaxValue <= value) {
        fans[i].value = mMainHighMaxValue;
      } else {
        fans[i].value = value;
      }
      double? y = getMainY(fans[i].value);
      if (y == null) return null;
      fans[i].dy1 = y;
      return fans[i];
    }
    return null;
  }

  ObjectEntity? setFibonacciFanOffset2(
    ObjectEntity item,
    Offset offset,
    List<KLineEntity> data,
  ) {
    final fans = chartProperties.fibonacciFans;
    final i = fans.indexWhere((e) => e.id == item.id);
    if (i != -1) {
      fans[i].currentEditIndex = item.currentEditIndex;
      fans[i].dx2 = getX(mStartIndex) + (offset.dx / scaleX);
      fans[i].datetime2 = getXTime(fans[i].dx2, data);
      final value = getYPositionValue(offset.dy);
      if (mMainLowMinValue >= value) {
        fans[i].value2 = mMainLowMinValue;
      } else if (mMainHighMaxValue <= value) {
        fans[i].value2 = mMainHighMaxValue;
      } else {
        fans[i].value2 = value;
      }
      double? y = getMainY(fans[i].value2);
      if (y == null) return null;
      fans[i].dy2 = y;
      return fans[i];
    }
    return null;
  }

  void drawFibonacciFan(
    Canvas canvas,
    Size size,
    bool isBackground,
    List<KLineEntity> data,
  ) {
    final fans = chartProperties.fibonacciFans;
    if (fans.isEmpty) {
      return;
    }

    for (int i = 0; i < fans.length; i++) {
      final item = fans[i];
      if (item.drawAsBackground != isBackground) continue;

      double x1 = getXFromTime(item.datetime, data);
      double x2 = getXFromTime(item.datetime2, data);
      double? y1 = getMainY(item.value);
      double? y2 = getMainY(item.value2);
      if (y1 == null || y2 == null) continue;
      if (x2 == x1) continue;

      double strokeWidth = (item.height / scaleX).clamp(0.1, 1.0);
      final color = colorFromHex(item.color!)!;
      final isDash = item.style == ObjectStyle.dash;
      final linePaint = Paint()
        ..filterQuality = FilterQuality.high
        ..isAntiAlias = true
        ..strokeWidth = strokeWidth
        ..color = color;

      // The main trendline drawn as a segment between the two draggable
      // points (start = point 1, end = point 2).
      if (isDash) {
        _drawDashLine(canvas, Offset(x1, y1), Offset(x2, y2), linePaint);
      } else {
        canvas.drawLine(Offset(x1, y1), Offset(x2, y2), linePaint);
      }

      // Fan rays: from point 1 through the level points on the invisible
      // vertical line at x2 (yL = y1 + (y2 - y1) * level).
      for (int l = 0; l < kFibonacciFanLevels.length; l++) {
        final level = kFibonacciFanLevels[l];
        final yL = y1 + (y2 - y1) * level;

        // Each level ray gets its own distinct color.
        final levelColor = fibonacciLevelColor(l);
        linePaint.color = levelColor;
        _drawRay(canvas, x1, y1, x2, yL, linePaint, isDash);

        // Level label near the intersection on the invisible vertical line.
        final tp = getTextPainter(
          level.toStringAsFixed(3),
          levelColor,
          fontWeight: FontWeight.w500,
        );
        canvas.save();
        canvas.translate(x2 + 2, yL - tp.height - 1);
        canvas.scale(1 / scaleX, 1.0);
        tp.paint(canvas, Offset.zero);
        canvas.restore();
      }

      // Start/end handles on the main line — always visible so they can be
      // grabbed and dragged.
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

  /// Draws a ray starting at (x1,y1), passing through (x2,y2) and extending
  /// far beyond the second point in the same direction.
  void _drawRay(
    Canvas canvas,
    double x1,
    double y1,
    double x2,
    double y2,
    Paint paint,
    bool isDash,
  ) {
    final slope = (y2 - y1) / (x2 - x1);
    final dir = x2 >= x1 ? 1 : -1;
    final xEnd = x1 + dir * 10000000;
    final yEnd = y1 + slope * (xEnd - x1);
    if (isDash) {
      _drawDashLine(canvas, Offset(x1, y1), Offset(xEnd, yEnd), paint);
    } else {
      canvas.drawLine(Offset(x1, y1), Offset(xEnd, yEnd), paint);
    }
  }

  void _drawDashLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    const dashWidth = 5.0;
    const dashSpace = 4.0;
    final dx = end.dx - start.dx;
    final dy = end.dy - start.dy;
    final length = sqrt(dx * dx + dy * dy);
    if (length == 0) return;
    final count = length / (dashWidth + dashSpace);
    final xStep = dx / count;
    final yStep = dy / count;
    var cx = start.dx;
    var cy = start.dy;
    for (int i = 0; i < count; i++) {
      final ex = cx + xStep * (dashWidth / (dashWidth + dashSpace));
      final ey = cy + yStep * (dashWidth / (dashWidth + dashSpace));
      canvas.drawLine(Offset(cx, cy), Offset(ex, ey), paint);
      cx += xStep;
      cy += yStep;
    }
  }
}
