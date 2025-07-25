import 'dart:math';

import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/entity/object_entity.dart';
import 'package:candle_chart/renderer/chart_details.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../base_chart_renderer.dart';

mixin DrawTrendLines on ChartDetails {
  late final ChartPosition chartPosition;
  late final ChartStyle chartStyle;
  late Paint dot;
  late double scaleX;
  late double mMainHighMaxValue, mMainLowMinValue;

  ObjectEntity? setTrendLineOffset1(
    ObjectEntity item,
    Offset offset,
    List<KLineEntity> data,
  ) {
    final trendLines = chartProperties.trendLines;
    final i = trendLines.indexWhere((e) => e.id == item.id);
    if (i != -1) {
      trendLines[i].currentEditIndex = item.currentEditIndex;
      trendLines[i].dx1 = getX(mStartIndex) + (offset.dx / scaleX);
      trendLines[i].datetime = getXTime(trendLines[i].dx1, data);
      final value = getYPositionValue(offset.dy);
      if (mMainLowMinValue >= value) {
        trendLines[i].value = mMainLowMinValue;
        trendLines[i].dy1 = getMainY(mMainLowMinValue);
      } else if (mMainHighMaxValue <= value) {
        trendLines[i].value = mMainHighMaxValue;
        trendLines[i].dy1 = getMainY(mMainLowMinValue);
      } else {
        trendLines[i].dy1 = getMainY(trendLines[i].value);
        trendLines[i].value = value;
      }
      return trendLines[i];
    }
    return null;
  }

  ObjectEntity? setTrendLineOffset2(
    ObjectEntity item,
    Offset offset,
    List<KLineEntity> data,
  ) {
    final trendLines = chartProperties.trendLines;
    final i = trendLines.indexWhere((e) => e.id == item.id);
    if (i != -1) {
      trendLines[i].currentEditIndex = item.currentEditIndex;
      trendLines[i].dx2 = getX(mStartIndex) + (offset.dx / scaleX);
      trendLines[i].value2 = getYPositionValue(offset.dy);
      trendLines[i].datetime2 = getXTime(trendLines[i].dx2, data);
      final value = getYPositionValue(offset.dy);
      if (mMainLowMinValue >= value) {
        trendLines[i].value2 = mMainLowMinValue;
        trendLines[i].dy2 = getMainY(mMainLowMinValue);
      } else if (mMainHighMaxValue <= value) {
        trendLines[i].value2 = mMainHighMaxValue;
        trendLines[i].dy2 = getMainY(mMainLowMinValue);
      } else {
        trendLines[i].dy2 = getMainY(trendLines[i].value2);
        trendLines[i].value2 = value;
      }
      return trendLines[i];
    }
    return null;
  }

  void drawTrendLines(
    Canvas canvas,
    Size size,
    bool isBackground,
    List<KLineEntity> data,
  ) {
    final trendLines = chartProperties.trendLines;
    if (trendLines.isEmpty) {
      return;
    }

    for (int i = 0; i < trendLines.length; i++) {
      if (trendLines[i].drawAsBackground != isBackground ||
          (mMainLowMinValue >= trendLines[i].value &&
              mMainLowMinValue >= trendLines[i].value2)) continue;

      double x1 = getXFromTime(trendLines[i].datetime, data);
      double x2 = getXFromTime(trendLines[i].datetime2, data);
      double y1 = getMainY(trendLines[i].value);
      double y2 = getMainY(trendLines[i].value2);

      if (mMainLowMinValue >= trendLines[i].value) {
        y1 = getMainY(mMainLowMinValue);
      } else if (mMainHighMaxValue <= trendLines[i].value) {
        y1 = getMainY(mMainHighMaxValue);
      }

      if (mMainLowMinValue >= trendLines[i].value2) {
        y2 = getMainY(mMainLowMinValue);
      } else if (mMainHighMaxValue <= trendLines[i].value2) {
        y2 = getMainY(mMainHighMaxValue);
      }

      double strokeWidth = (trendLines[i].height / scaleX).clamp(1, 4.0);
      final pricePaint = Paint()
        ..filterQuality = FilterQuality.high
        ..isAntiAlias = true
        ..strokeWidth = strokeWidth
        ..color = colorFromHex(trendLines[i].color!)!;

      if (trendLines[i].style == ObjectStyle.dash) {
        drawDashLine(
          canvas,
          Offset(x1, y1),
          Offset(x2, y2),
          pricePaint,
        );
        if (trendLines[i].rayRight) {
          final slope = (y2 - y1) / (x2 - x1);
          final double xInfinity = x2 + 1000;
          final double yInfinity = y1 + slope * (xInfinity - x1);
          drawDashLine(
            canvas,
            Offset(x1, y1),
            Offset(xInfinity, yInfinity),
            pricePaint,
          );
        }
        if (trendLines[i].rayLift) {
          final slope = (y2 - y1) / (x2 - x1);
          final double xNegative = -10;
          final double yNegative = y1 + slope * (xNegative - x1);
          drawDashLine(
            canvas,
            Offset(xNegative, yNegative),
            Offset(x2, y2),
            pricePaint,
          );
        }
      } else {
        canvas.drawLine(
          Offset(x1, y1),
          Offset(x2, y2),
          pricePaint,
        );
        if (trendLines[i].rayRight) {
          final slope = (y2 - y1) / (x2 - x1);
          final double xInfinity = 10000000;
          final double yInfinity = y1 + slope * (xInfinity - x1);
          canvas.drawLine(
            Offset(x1, y1),
            Offset(xInfinity, yInfinity),
            pricePaint,
          );
        }
        if (trendLines[i].rayLift) {
          final slope = (y2 - y1) / (x2 - x1);
          final double xNegative = -10000000;
          final double yNegative = y1 + slope * (xNegative - x1);

          canvas.drawLine(
            Offset(xNegative, yNegative),
            Offset(x2, y2),
            pricePaint,
          );
        }
      }
      if (trendLines[i].currentEditIndex == i || trendLines[i].rayRight) {
        canvas.drawCircle(
          Offset(x1, y1),
          2.5,
          dot,
        );
      }
      if (trendLines[i].currentEditIndex == i || trendLines[i].rayLift) {
        canvas.drawCircle(
          Offset(x2, y2),
          2.5,
          dot,
        );
      }
    }
  }

  void drawDashLine(
    Canvas canvas,
    Offset start,
    Offset end,
    Paint paint,
  ) {
    double dashWidth = 5.0;
    double dashSpace = 4.0;
    double dx = end.dx - start.dx;
    double dy = end.dy - start.dy;
    double distance = sqrt(dx * dx + dy * dy);
    double dashCount = distance / (dashWidth + dashSpace);

    double xStep = dx / dashCount;
    double yStep = dy / dashCount;

    double currentX = start.dx;
    double currentY = start.dy;

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
}
