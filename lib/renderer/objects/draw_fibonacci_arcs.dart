import 'dart:math';

import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/entity/object_entity.dart';
import 'package:candle_chart/renderer/chart_details.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../base_chart_renderer.dart';

mixin DrawFibonacciArcs on ChartDetails {
  late final ChartPosition chartPosition;
  late final ChartStyle chartStyle;
  late Paint dot;
  late double scaleX;
  late double mMainHighMaxValue, mMainLowMinValue;

  ObjectEntity? setFibonacciArcsOffset1(
    ObjectEntity item,
    Offset offset,
    List<KLineEntity> data,
  ) {
    final arcs = chartProperties.fibonacciArcs;
    final i = arcs.indexWhere((e) => e.id == item.id);
    if (i != -1) {
      arcs[i].currentEditIndex = item.currentEditIndex;
      arcs[i].dx1 = getX(mStartIndex) + (offset.dx / scaleX);
      arcs[i].datetime = getXTime(arcs[i].dx1, data);
      final value = getYPositionValue(offset.dy);
      if (mMainLowMinValue >= value) {
        arcs[i].value = mMainLowMinValue;
      } else if (mMainHighMaxValue <= value) {
        arcs[i].value = mMainHighMaxValue;
      } else {
        arcs[i].value = value;
      }
      double? y = getMainY(arcs[i].value);
      if (y == null) return null;
      arcs[i].dy1 = y;
      return arcs[i];
    }
    return null;
  }

  ObjectEntity? setFibonacciArcsOffset2(
    ObjectEntity item,
    Offset offset,
    List<KLineEntity> data,
  ) {
    final arcs = chartProperties.fibonacciArcs;
    final i = arcs.indexWhere((e) => e.id == item.id);
    if (i != -1) {
      arcs[i].currentEditIndex = item.currentEditIndex;
      arcs[i].dx2 = getX(mStartIndex) + (offset.dx / scaleX);
      arcs[i].datetime2 = getXTime(arcs[i].dx2, data);
      final value = getYPositionValue(offset.dy);
      if (mMainLowMinValue >= value) {
        arcs[i].value2 = mMainLowMinValue;
      } else if (mMainHighMaxValue <= value) {
        arcs[i].value2 = mMainHighMaxValue;
      } else {
        arcs[i].value2 = value;
      }
      double? y = getMainY(arcs[i].value2);
      if (y == null) return null;
      arcs[i].dy2 = y;
      return arcs[i];
    }
    return null;
  }

  void drawFibonacciArcs(
    Canvas canvas,
    Size size,
    bool isBackground,
    List<KLineEntity> data,
  ) {
    final arcs = chartProperties.fibonacciArcs;
    if (arcs.isEmpty) {
      return;
    }

    for (int i = 0; i < arcs.length; i++) {
      final item = arcs[i];
      if (item.drawAsBackground != isBackground) continue;

      double x1 = getXFromTime(item.datetime, data);
      double x2 = getXFromTime(item.datetime2, data);
      double? y1 = getMainY(item.value);
      double? y2 = getMainY(item.value2);
      if (y1 == null || y2 == null) continue;
      if (x1 == x2 && y1 == y2) continue;

      double strokeWidth = (item.height / scaleX).clamp(0.1, 1.0);
      final color = colorFromHex(item.color!)!;
      final isDash = item.style == ObjectStyle.dash;
      final ellipse = item.isFill; // "Ellipse" toggle → full closed curve.

      final linePaint = Paint()
        ..filterQuality = FilterQuality.high
        ..isAntiAlias = true
        ..strokeWidth = strokeWidth
        ..color = color;

      // Trend line between the two anchor points.
      if (isDash) {
        _drawDashLine(canvas, Offset(x1, y1), Offset(x2, y2), linePaint);
      } else {
        canvas.drawLine(Offset(x1, y1), Offset(x2, y2), linePaint);
      }

      // Screen-space distance and direction from the center (point 2) to
      // the first point, so the arcs render as true circles on screen.
      final dxScreen = (x1 - x2) * scaleX;
      final dyScreen = (y1 - y2);
      final dScreen = sqrt(dxScreen * dxScreen + dyScreen * dyScreen);
      if (dScreen == 0) continue;
      final theta = atan2(dyScreen, dxScreen);

      // Arcs are drawn in a screen-pixel frame (scaleX cancelled), so the
      // stroke width is expressed directly in screen pixels.
      final arcPaint = Paint()
        ..style = PaintingStyle.stroke
        ..filterQuality = FilterQuality.high
        ..isAntiAlias = true
        ..strokeWidth = item.height.clamp(0.8, 2.5)
        ..color = color;

      for (int l = 0; l < kFibonacciArcLevels.length; l++) {
        final ratio = kFibonacciArcLevels[l];
        final rScreen = dScreen * ratio;
        final levelColor = fibonacciLevelColor(l);
        arcPaint.color = levelColor;

        // Work in screen pixels around the center by cancelling scaleX.
        canvas.save();
        canvas.translate(x2, y2);
        canvas.scale(1 / scaleX, 1.0);
        final rect = Rect.fromCircle(center: Offset.zero, radius: rScreen);
        if (ellipse) {
          canvas.drawArc(rect, 0, 2 * pi, false, arcPaint);
        } else {
          // Semicircle centered on the direction toward point 1.
          canvas.drawArc(rect, theta - pi / 2, pi, false, arcPaint);
        }
        canvas.restore();

        // Level label where the arc meets the trend line.
        final lx = x2 + (x1 - x2) * ratio;
        final ly = y2 + (y1 - y2) * ratio;
        final tp = getTextPainter(
          ratio.toStringAsFixed(3),
          levelColor,
          fontWeight: FontWeight.w500,
        );
        canvas.save();
        canvas.translate(lx + 2, ly - tp.height - 1);
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
