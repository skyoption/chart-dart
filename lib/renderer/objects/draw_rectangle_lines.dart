import 'dart:math';
import 'dart:ui';

import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/entity/object_entity.dart';
import 'package:candle_chart/renderer/chart_details.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../base_chart_renderer.dart';

mixin DrawRectangleLines on ChartDetails {
  late final ChartPosition chartPosition;
  late final ChartStyle chartStyle;
  late Paint dot;
  late double scaleX;
  late double mMainHighMaxValue, mMainLowMinValue;

  ObjectEntity? setRectangleOffset1(
    ObjectEntity item,
    Offset offset,
    List<KLineEntity> data,
  ) {
    final rectangles = chartProperties.rectangles;
    final i = rectangles.indexWhere((e) => e.id == item.id);
    if (i != -1) {
      rectangles[i].currentEditIndex = item.currentEditIndex;
      rectangles[i].dx1 = getX(mStartIndex) + (offset.dx / scaleX);
      rectangles[i].datetime = getXTime(rectangles[i].dx1, data);
      final value = getYPositionValue(offset.dy);
      if (mMainLowMinValue >= value) {
        rectangles[i].value = mMainLowMinValue;
        double? y = getMainY(mMainLowMinValue);
        if (y == null) return null;
        rectangles[i].dy1 = y;
      } else if (mMainHighMaxValue <= value) {
        rectangles[i].value = mMainHighMaxValue;
        double? y = getMainY(mMainLowMinValue);
        if (y == null) return null;
        rectangles[i].dy1 = y;
      } else {
        double? y = getMainY(rectangles[i].value);
        if (y == null) return null;
        rectangles[i].dy1 = y;
        rectangles[i].value = value;
      }
      return rectangles[i];
    }
    return null;
  }

  ObjectEntity? setRectangleOffset2(
    ObjectEntity item,
    Offset offset,
    List<KLineEntity> data,
  ) {
    final rectangles = chartProperties.rectangles;
    final i = rectangles.indexWhere((e) => e.id == item.id);
    if (i != -1) {
      rectangles[i].currentEditIndex = item.currentEditIndex;
      rectangles[i].dx2 = getX(mStartIndex) + (offset.dx / scaleX);
      rectangles[i].datetime2 = getXTime(rectangles[i].dx2, data);
      final value = getYPositionValue(offset.dy);
      if (mMainLowMinValue >= value) {
        rectangles[i].value2 = mMainLowMinValue;
        double? y = getMainY(mMainLowMinValue);
        if (y == null) return null;
        rectangles[i].dy2 = y;
      } else if (mMainHighMaxValue <= value) {
        rectangles[i].value2 = mMainHighMaxValue;
        double? y = getMainY(mMainLowMinValue);
        if (y == null) return null;
        rectangles[i].dy2 = y;
      } else {
        double? y = getMainY(rectangles[i].value2);
        if (y == null) return null;
        rectangles[i].dy2 = y;
        rectangles[i].value2 = value;
      }
      return rectangles[i];
    }
    return null;
  }

  void drawRectangles(
    Canvas canvas,
    Size size,
    bool isBackground,
    List<KLineEntity> data,
  ) {
    final rectangles = chartProperties.rectangles;
    if (rectangles.isEmpty) {
      return;
    }

    for (int i = 0; i < rectangles.length; i++) {
      if (rectangles[i].drawAsBackground != isBackground ||
          (mMainLowMinValue >= rectangles[i].value &&
              mMainLowMinValue >= rectangles[i].value2)) continue;
      double x1 = getXFromTime(rectangles[i].datetime, data);
      double x2 = getXFromTime(rectangles[i].datetime2, data);
      double? y1 = getMainY(rectangles[i].value);
      if (y1 == null) return;
      double? y2 = getMainY(rectangles[i].value2);
      if (y2 == null) return;

      if (mMainLowMinValue >= rectangles[i].value) {
        y1 = getMainY(mMainLowMinValue);
      } else if (mMainHighMaxValue <= rectangles[i].value) {
        y1 = getMainY(mMainHighMaxValue);
      }

      if (mMainLowMinValue >= rectangles[i].value2) {
        y2 = getMainY(mMainLowMinValue);
      } else if (mMainHighMaxValue <= rectangles[i].value2) {
        y2 = getMainY(mMainHighMaxValue);
      }
      double strokeWidth = (rectangles[i].height / scaleX).clamp(1, 4.0);
      final pricePaint = Paint()
        ..filterQuality = FilterQuality.high
        ..isAntiAlias = true
        ..strokeWidth = strokeWidth;
      if (y1 == null || y2 == null) return;
      if (rectangles[i].isFill) {
        pricePaint.color = colorFromHex(rectangles[i].color!)!
            .withAlpha(rectangles[i].drawAsBackground ? 100 : 80);
        canvas.drawRect(
          Rect.fromLTRB(x1, y1, x2, y2),
          pricePaint,
        );
      } else {
        pricePaint.color = colorFromHex(rectangles[i].color!)!;
        if (rectangles[i].style == ObjectStyle.dash) {
          dashLine(
            canvas,
            size,
            pricePaint,
            Offset(x1, y1),
            Offset(x2, y1),
          );
          dashVerticalLine(
            canvas,
            size,
            pricePaint,
            Offset(x2, y1),
            Offset(x2, y2),
          );
          dashLine(
            canvas,
            size,
            pricePaint,
            Offset(x2, y2),
            Offset(x1, y2),
          );
          dashVerticalLine(
            canvas,
            size,
            pricePaint,
            Offset(x1, y2),
            Offset(x1, y1),
          );
        } else {
          canvas.drawPoints(
            PointMode.polygon,
            [
              Offset(x1, y1),
              Offset(x2, y1),
              Offset(x2, y2),
              Offset(x1, y2),
              Offset(x1, y1),
            ],
            pricePaint,
          );
        }
      }
      if (rectangles[i].currentEditIndex == i) {
        canvas.drawCircle(
          Offset(x1, y1),
          2.5,
          dot,
        );
        canvas.drawCircle(
          Offset(x2, y2),
          2.5,
          dot,
        );
      }
    }
  }

  void dashLine(
    Canvas canvas,
    Size size,
    Paint paint,
    Offset offset1,
    Offset offset2,
  ) {
    double dashWidth = 5.0;
    double dashSpace = 4.0;
    double dx = offset2.dx - offset1.dx;
    double dy = offset2.dy - offset2.dy;
    double distance = sqrt(dx * dx + dy * dy);
    double dashCount = distance / (dashWidth + dashSpace);

    double xStep = dx / dashCount;
    double yStep = dy / dashCount;

    double currentX = offset1.dx;
    double currentY = offset1.dy;

    for (int i = 0; i < dashCount; i++) {
      final xEnd = currentX + xStep * (dashWidth / (dashWidth + dashSpace));
      final yEnd = currentY + yStep * (dashWidth / (dashWidth + dashSpace));

      canvas.drawLine(
        Offset(currentX, currentY),
        Offset(xEnd, yEnd),
        paint,
      );

      currentX += xStep;
      currentY += yStep;
    }
  }

  void dashVerticalLine(
    Canvas canvas,
    Size size,
    Paint paint,
    Offset offset1,
    Offset offset2,
  ) {
    Paint p = Paint();
    p = paint;
    p..strokeWidth = paint.strokeWidth * 1.05;
    double startY = offset1.dy < offset2.dy ? offset1.dy : offset2.dy;
    final max = offset1.dy > offset2.dy ? offset1.dy : offset2.dy;
    double space = 4.0;
    while (startY < max - 2) {
      canvas.drawLine(
        Offset(offset1.dx, startY),
        Offset(offset2.dx, startY + space),
        p,
      );
      startY += space * 2.0;
    }
  }
}
