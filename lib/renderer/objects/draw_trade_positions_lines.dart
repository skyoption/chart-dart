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
      final curOpenX = getXFromTime(openTime, data);
      final cutOpenY = getMainY(position.openPrice);
      final isBuy = position.isBuy;
      // Blue arrow up for open positions
      _drawArrowUp(
        canvas,
        curOpenX,
        cutOpenY!,
        Colors.blue,
      );
      final closeTime = position.closeTimeInMilliseconds;
      if (closeTime != null) {
        final curCloseX = getXFromTime(closeTime, data);
        final cutCloseY = getMainY(position.closePrice!);
        final fillPaint = Paint()
          ..color = isBuy ? Colors.redAccent : Colors.blue
          ..style = PaintingStyle.fill
          ..isAntiAlias = true
          ..filterQuality = FilterQuality.high;
        drawDashLine(
          canvas,
          Offset(curOpenX, cutOpenY),
          Offset(curCloseX, cutCloseY!),
          fillPaint,
        );
        // Red arrow down for close positions
        _drawArrowDown(
          canvas,
          curCloseX,
          cutCloseY,
          Colors.redAccent,
        );
      }
    }
  }

  void _drawArrowUp(Canvas canvas, double x, double y, Color color) {
    // Draw a filled upward-pointing triangle arrow (like in the image)
    // Arrow size scales with zoom but has minimum/maximum bounds for visibility
    final baseSize = (8.0 / scaleX).clamp(8.0, 10.0);
    final baseWidth = (8.0 / scaleX).clamp(8.0, 12.0);
    final arrowHeight = baseSize;
    final arrowWidth = baseWidth;
    y = y + arrowHeight;
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
  }

  void _drawArrowDown(Canvas canvas, double x, double y, Color color) {
    // Draw a filled downward-pointing triangle arrow (like in the image)
    // Arrow size scales with zoom but has minimum/maximum bounds for visibility
    final baseSize = (8.0 / scaleX).clamp(8.0, 10.0);
    final baseWidth = (8.0 / scaleX).clamp(8.0, 12.0);
    final arrowHeight = baseSize;
    final arrowWidth = baseWidth;

    y = y - arrowHeight;
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
