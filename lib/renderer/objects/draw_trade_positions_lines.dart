import 'dart:math';

import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/entity/trade_entity.dart';
import 'package:candle_chart/renderer/chart_details.dart';
import 'package:flutter/material.dart';

mixin DrawTradePositionsLines on ChartDetails {
  late double scaleX;
  late double mMainHighMaxValue, mMainLowMinValue;

  void drawTradePositions(
    Canvas canvas,
    Size size,
    bool isBackground,
    List<KLineEntity> data,
    List<TradeEntity> trades,
  ) {
    // Process current point for trade positions
    for (int i = 0; i < trades.length; i++) {
      final position = trades[i];
      final openTime = position.openTimeInMilliseconds;
      if (openTime == null) continue;
      final curOpenX = getXFromTime(openTime, data);
      final cutOpenY = getMainYInChart(position.openPrice);
      final isBuy = position.isBuy;
      // Blue arrow up for open positions
      final openOffset = _drawPostion(
        canvas,
        curOpenX,
        cutOpenY,
        true,
      );
      final closeTime = position.closeTimeInMilliseconds;
      if (closeTime != null) {
        final curCloseX = getXFromTime(closeTime, data);
        final cutCloseY = getMainYInChart(position.closePrice!);
        // Red arrow down for close positions

        final fillPaint = Paint()
          ..color = isBuy ? Colors.redAccent : Colors.blue
          ..style = PaintingStyle.fill
          ..isAntiAlias = true
          ..strokeWidth = 1.5
          ..filterQuality = FilterQuality.high;

        final closeOffset = _drawPostion(
          canvas,
          curCloseX,
          cutCloseY,
          false,
        );
        drawDashLine(
          canvas,
          openOffset,
          closeOffset,
          fillPaint,
        );
      }
    }
  }

  Offset _drawPostion(Canvas canvas, double x, double y, bool isOpen) {
    if (isOpen) {
      return _drawArrowUp(
        canvas,
        x,
        y,
        Colors.blue,
      );
    } else {
      return _drawArrowDown(
        canvas,
        x,
        y,
        Colors.redAccent,
      );
    }
  }

  Offset _drawArrowUp(Canvas canvas, double x, double y, Color color) {
    // Draw a filled upward-pointing triangle arrow (like in the image)
    // Arrow size scales with zoom but has minimum/maximum bounds for visibility
    final baseSize = 8.0;
    final baseWidth = 12.0;
    final arrowHeight = baseSize;
    final arrowWidth = baseWidth;
    x = x - arrowWidth * 1.5;
    y = y + arrowHeight * 1.5;
    final path = Path();
    // Start at the top point (tip) of the arrow
    path.moveTo(x, y - arrowHeight);
    // Draw to bottom-left corner
    path.lineTo(x - arrowWidth, y);
    // Draw to bottom-right corner
    path.lineTo(x + arrowWidth, y);
    // Close the path back to the top
    path.close();

    // Draw filled arrow
    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..filterQuality = FilterQuality.high;

    canvas.drawPath(path, fillPaint);

    // Draw border for better definition (slightly darker)
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..isAntiAlias = true
      ..filterQuality = FilterQuality.high;

    canvas.drawPath(path, borderPaint);
    return Offset(x, y);
  }

  Offset _drawArrowDown(Canvas canvas, double x, double y, Color color) {
    // Draw a filled downward-pointing triangle arrow (like in the image)
    // Arrow size scales with zoom but has minimum/maximum bounds for visibility
    final baseSize = 8.0;
    final baseWidth = 12.0;
    final arrowHeight = baseSize;
    final arrowWidth = baseWidth;
    x = x - arrowWidth * 1.5;
    y = y + arrowHeight * 1.5;
    final path = Path();
    // Start at the top-left corner of the arrow base
    path.moveTo(x - arrowWidth, y);
    // Draw to bottom point (tip)
    path.lineTo(x, y + arrowHeight);
    // Draw to top-right corner
    path.lineTo(x + arrowWidth, y);
    // Close the path back to the start
    path.close();

    // Draw filled arrow
    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..filterQuality = FilterQuality.high;

    canvas.drawPath(path, fillPaint);

    // Draw border for better definition (slightly darker)
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..isAntiAlias = true
      ..filterQuality = FilterQuality.high;

    canvas.drawPath(path, borderPaint);
    return Offset(x, y);
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
