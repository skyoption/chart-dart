import 'dart:math';

import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/renderer/chart_details.dart';
import 'package:flutter/material.dart';

mixin DrawTradeLines on ChartDetails {
  late double scaleX;
  late double mMainHighMaxValue, mMainLowMinValue;

  void drawTradeLines(
    Canvas canvas,
    Size size,
    bool isBackground,
    List<KLineEntity> data,
  ) {
    if (data.isEmpty) return;

    Map<
        int,
        ({
          double x,
          double y,
          Color color,
          int closeTime,
          double closePrice,
        })> openPositions = {};

    // First pass: collect all open positions from visible candles
    for (var item in data) {
      final curPoint = item;
      if (curPoint.tradeEntities == null) continue;

      double curX = getX(data.indexOf(curPoint));

      for (var trade in curPoint.tradeEntities!) {
        // Check if this candle matches the open time
        if (curPoint.time == trade.openTime) {
          final openY = getMainY(trade.openPrice);
          if (openY == null) continue;

          // Determine color based on trade direction
          final color = trade.isBuy ? Colors.blue : Colors.redAccent;

          // Store open position if there's a close position
          if (trade.closeTime != null && trade.closePrice != null) {
            openPositions[trade.id] = (
              x: curX,
              y: openY,
              color: color,
              closeTime: trade.closeTime!,
              closePrice: trade.closePrice!,
            );
          }
        }
      }
    }

    // Second pass: find close positions and draw trend lines
    for (var item in data) {
      final curPoint = item;
      if (curPoint.tradeEntities == null) continue;

      double curX = getX(data.indexOf(curPoint));

      for (var trade in curPoint.tradeEntities!) {
        // Check if this candle matches the close time
        if (trade.closeTime != null &&
            trade.closePrice != null &&
            curPoint.time == trade.closeTime) {
          final closeY = getMainY(trade.closePrice!);
          if (closeY == null) continue;

          // Find matching open position
          final openPos = openPositions[trade.id];
          if (openPos != null) {
            // Draw trend line from open to close
            final paint = Paint()
              ..color = openPos.color
              ..strokeWidth = 1.5
              ..style = PaintingStyle.stroke
              ..isAntiAlias = true
              ..filterQuality = FilterQuality.high;

            drawDashLine(
              canvas,
              Offset(openPos.x, openPos.y),
              Offset(curX, closeY),
              paint,
            );
          }
        }
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
