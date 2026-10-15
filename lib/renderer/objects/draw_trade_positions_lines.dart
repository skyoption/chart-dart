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
      final cutOpenY =
          (getMainY(position.openPrice) ?? getMainYInChart(position.openPrice));
      final isBuy = position.isBuy;
      // Buy badges sit below the price point, sell badges above it.
      final double side = isBuy ? 1.0 : -1.0;
      final double yOffset = cutOpenY + side * 15.5;
      // Blue arrow up for open positions
      final openOffset = Offset(curOpenX, yOffset);

      final closeTime = position.closeTimeInMilliseconds;
      if (closeTime != null) {
        final curCloseX = getXFromTime(closeTime, data);
        final cutCloseY = (getMainY(position.closePrice!) ??
            getMainYInChart(position.closePrice!));
        // Red arrow down for close positions

        final double yOffsetClose = cutCloseY + side * 15.5;

        final fillPaint = Paint()
          ..color = isBuy ? chartColors.upColor : chartColors.dnColor
          ..style = PaintingStyle.fill
          ..isAntiAlias = true
          ..strokeWidth = 1.2
          ..strokeCap = StrokeCap.round
          ..filterQuality = FilterQuality.high;

        final closeOffset = Offset(curCloseX, yOffsetClose);
        drawDashLine(
          canvas,
          openOffset,
          closeOffset,
          fillPaint,
        );
        _drawPostion(
          canvas,
          curCloseX,
          cutCloseY,
          false,
          isBuy,
        );
      }
      _drawPostion(
        canvas,
        curOpenX,
        cutOpenY,
        true,
        isBuy,
      );
    }
  }

  /// Buy trades use the up color and point up when opened; sell trades use the
  /// down color and point down. The close marker flips the direction.
  Offset _drawPostion(
      Canvas canvas, double x, double y, bool isOpen, bool isBuy) {
    final color = isBuy ? chartColors.upColor : chartColors.dnColor;
    return _drawBadge(canvas, x, y, color, up: isOpen == isBuy, above: !isBuy);
  }

  /// Pin-style marker: a glowing gradient badge with an arrow, a short pointer
  /// and an anchor dot on the exact price. Buy badges hang below the price,
  /// sell badges sit above it.
  Offset _drawBadge(
    Canvas canvas,
    double x,
    double y,
    Color color, {
    required bool up,
    bool above = false,
  }) {
    const radius = 9.5;
    const reach = radius + 6.0; // distance from the price to the badge center
    final d = above ? -1.0 : 1.0;

    // The canvas is scaled horizontally by the zoom; undo it around the marker
    // so the badge stays a circle at every zoom level.
    canvas.save();
    canvas.translate(x, 0);
    canvas.scale(1 / scaleX, 1.0);
    final center = Offset(0, y + d * reach);

    // Soft glow.
    canvas.drawCircle(
      center,
      radius + 2,
      Paint()
        ..color = color.withAlpha(110)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
    );

    // Pointer from the badge to the price.
    final tail = Path()
      ..moveTo(-4.5, center.dy - d * (radius - 2))
      ..lineTo(0, y + d * 1.0)
      ..lineTo(4.5, center.dy - d * (radius - 2))
      ..close();
    canvas.drawPath(tail, Paint()..color = color);

    // Badge: light-to-solid gradient with a fine highlight ring.
    final badgeRect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color.lerp(color, Colors.white, 0.28)!, color],
        ).createShader(badgeRect),
    );
    canvas.drawCircle(
      center,
      radius - 0.5,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = Colors.white.withAlpha(120)
        ..isAntiAlias = true,
    );

    // Arrow icon.
    final k = up ? -1.0 : 1.0;
    final arrow = Path()
      ..moveTo(center.dx, center.dy + k * 4.2)
      ..lineTo(center.dx, center.dy - k * 4.2)
      ..moveTo(center.dx - 3.6, center.dy - k * 0.7)
      ..lineTo(center.dx, center.dy - k * 4.4)
      ..lineTo(center.dx + 3.6, center.dy - k * 0.7);
    canvas.drawPath(
      arrow,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.2
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..color = Colors.white
        ..isAntiAlias = true,
    );

    // Anchor dot on the exact price.
    canvas.drawCircle(Offset(0, y), 3.2, Paint()..color = Colors.white);
    canvas.drawCircle(
      Offset(0, y),
      3.2,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5
        ..color = color,
    );
    canvas.restore();
    return Offset(x, center.dy + d * radius);
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
