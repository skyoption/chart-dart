import 'dart:math' as math;

import 'package:candle_chart/entity/object_entity.dart';
import 'package:candle_chart/entity/position_card_info.dart';
import 'package:candle_chart/renderer/chart_details.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../base_chart_renderer.dart';

mixin DrawTPAndSLLines on ChartDetails {
  late final ChartPosition chartPosition;
  late final ChartStyle chartStyle;
  late Paint dot;
  late double mTranslateX;
  late double mWidth;
  late double scaleX;
  late final ChartColors chartColors;
  late double mMainHighMaxValue, mMainLowMinValue;
  late int fixedLength;

  ObjectEntity? setTPAndSLLineValue(ObjectEntity item, double value) {
    final tPAndSLLines = chartProperties.tPAndSLLines;
    final i = tPAndSLLines.indexWhere((e) => e.id == item.id);
    if (i != -1) {
      tPAndSLLines[i].currentEditIndex = -1;
      double? y = getMainY(value);
      if (y == null) return null;
      tPAndSLLines[i].dy1 = y;
      tPAndSLLines[i].value = value;
      return tPAndSLLines[i];
    }
    return null;
  }

  ObjectEntity? setTPAndSLLineOffset(ObjectEntity item, Offset offset) {
    final tPAndSLLines = chartProperties.tPAndSLLines;
    final i = tPAndSLLines.indexWhere((e) => e.id == item.id);
    if (i != -1) {
      tPAndSLLines[i].currentEditIndex = item.currentEditIndex;
      final value = getYPositionValue(offset.dy);
      if (mMainLowMinValue >= value) {
        tPAndSLLines[i].value = mMainLowMinValue;
        double? y = getMainY(mMainLowMinValue);
        if (y == null) return null;
        tPAndSLLines[i].dy1 = y;
      } else if (mMainHighMaxValue <= value) {
        tPAndSLLines[i].value = mMainHighMaxValue;
        double? y = getMainY(mMainHighMaxValue);
        if (y == null) return null;
        tPAndSLLines[i].dy1 = y;
      } else {
        double? y = getMainY(value);
        if (y == null) return null;
        tPAndSLLines[i].dy1 = y;
        tPAndSLLines[i].value = value;
      }
      return tPAndSLLines[i];
    }
    return null;
  }

  void drawTPAndSLLines(Canvas canvas, Size size, bool isBackground) {
    final tPAndSLLines = chartProperties.tPAndSLLines;
    if (tPAndSLLines.isEmpty) {
      return;
    }
    for (int i = 0; i < tPAndSLLines.length; i++) {
      if (tPAndSLLines[i].drawAsBackground != isBackground) continue;
      final double? y = pinnedY(tPAndSLLines[i].value);
      if (y == null) continue;
      final pricePaint = Paint()
        ..filterQuality = FilterQuality.high
        ..isAntiAlias = true
        ..strokeWidth = tPAndSLLines[i].height
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..color = colorFromHex(tPAndSLLines[i].color!)!.withAlpha(200);

      double startX = 0;
      final max = -mTranslateX + (mWidth + 20) / scaleX;
      final strokeWidth = (this.chartStyle.lineLength / scaleX).clamp(1, 10.0);
      if (tPAndSLLines[i].style == ObjectStyle.dash) {
        while (startX < max) {
          canvas.drawLine(
            Offset(startX, y),
            Offset(startX + strokeWidth, y),
            pricePaint,
          );
          startX += strokeWidth * 2;
        }
      } else {
        canvas.drawLine(Offset(startX, y), Offset(max, y), pricePaint);
      }
    }
  }

  /// Y for [value] pinned to the visible price range. A position/TP/SL whose
  /// price has scrolled outside the candles' high/low window stays parked on
  /// the nearest edge instead of vanishing — which also keeps its label on
  /// screen. Both the line and the title use this, so they never drift apart.
  double? pinnedY(double value) {
    if (value <= mMainLowMinValue) return getMainY(mMainLowMinValue);
    if (value >= mMainHighMaxValue) return getMainY(mMainHighMaxValue);
    return getMainY(value);
  }

  void drawTPAndSLTitles(Canvas canvas, Size size) {
    final tPAndSLLines = chartProperties.tPAndSLLines;
    if (tPAndSLLines.isEmpty) {
      return;
    }
    for (int i = 0; i < tPAndSLLines.length; i++) {
      double value = tPAndSLLines[i].value;
      final double? y = pinnedY(value);
      if (y == null) continue;
      double startX = 0;
      final max = -mTranslateX + (mWidth + 20) / scaleX;

      if (tPAndSLLines[i].currentEditIndex == i) {
        canvas.drawCircle(
          Offset(startX, y),
          2.5,
          dot,
        );
        canvas.drawCircle(
          Offset(max, y),
          2.5,
          dot,
        );
      }
      _drawChip(
        canvas,
        y: y,
        color: colorFromHex(tPAndSLLines[i].color!)!,
        title: tPAndSLLines[i].title?.call(value) ?? '',
        price: value.toStringAsFixed(fixedLength),
        card: tPAndSLLines[i].card,
      );
    }
  }

  /// One right-aligned chip per line: a tinted label with the title joined to a
  /// solid price tag, both fully rounded. Sits next to the price column so it
  /// never collides with the live price pill on the left.
  void _drawChip(
    Canvas canvas, {
    required double y,
    required Color color,
    required String title,
    required String price,
    PositionCardInfo? card,
  }) {
    if (card != null) {
      _drawCard(canvas,
          y: y, color: color, title: title, price: price, card: card);
      return;
    }
    final priceTp = getTextPainter(
      price,
      Colors.white,
      sizeText: 10.0,
      fontWeight: FontWeight.w700,
    );
    final titleTp = title.isEmpty
        ? null
        : getTextPainter(
            title,
            Colors.white,
            sizeText: 10.0,
            fontWeight: FontWeight.w600,
          );
    const padH = 9.0, gap = 1.0;
    final h = priceTp.height + 10;
    final priceW = priceTp.width + padH * 2;
    final titleW = titleTp == null ? 0.0 : titleTp.width + padH * 2;
    final right = mWidth + chartStyle.priceWidth - 4;
    final priceRect = Rect.fromLTWH(right - priceW, y - h / 2, priceW, h);
    final radius = Radius.circular(h / 2);

    // Soft shadow under the whole chip.
    final chipLeft = priceRect.left - (titleTp == null ? 0 : titleW + gap);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(chipLeft, priceRect.top, right, priceRect.bottom)
            .shift(const Offset(0, 2)),
        radius,
      ),
      Paint()
        ..color = const Color(0x40000000)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );

    if (titleTp != null) {
      final titleRect = Rect.fromLTWH(
        priceRect.left - gap - titleW,
        priceRect.top,
        titleW + h / 2, // tucks under the price tag's rounded end
        h,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(titleRect, radius),
        Paint()
          ..color = Color.alphaBlend(color.withAlpha(120), chartColors.bgColor),
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(titleRect, radius),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1
          ..color = color.withAlpha(160),
      );
      titleTp.paint(
        canvas,
        Offset(titleRect.left + padH, y - titleTp.height / 2),
      );
    }
    canvas.drawRRect(
        RRect.fromRectAndRadius(priceRect, radius), Paint()..color = color);
    priceTp.paint(
      canvas,
      Offset(priceRect.left + padH, y - priceTp.height / 2),
    );
  }

  /// Two-row card for positions and pending orders: side badge, id and live
  /// P/L on top; the price (bold) and the other details underneath.
  void _drawCard(
    Canvas canvas, {
    required double y,
    required Color color,
    required String title,
    required String price,
    required PositionCardInfo card,
  }) {
    const padH = 10.0, padV = 7.0, rowGap = 4.0;
    final badgeTp = getTextPainter(
      card.badge,
      Colors.white,
      sizeText: 9.0,
      fontWeight: FontWeight.w800,
    );
    final titleTp = getTextPainter(
      title,
      Colors.white,
      sizeText: 10.0,
      fontWeight: FontWeight.w700,
    );
    final trailingText = card.trailing?.call() ?? '';
    final trailingTp = trailingText.isEmpty
        ? null
        : getTextPainter(
            trailingText,
            card.trailingColor?.call() ?? Colors.white,
            sizeText: 11.0,
            fontWeight: FontWeight.w800,
          );
    final subTp = getTextPainter(
      card.subtitle(),
      Colors.white.withAlpha(190),
      sizeText: 9.0,
      fontWeight: FontWeight.w500,
    );
    final priceTp = getTextPainter(
      price,
      Colors.white,
      sizeText: 10.0,
      fontWeight: FontWeight.w800,
    );

    final badgeW = badgeTp.width + 10, badgeH = badgeTp.height + 3;
    final row1H = math.max(badgeH, titleTp.height);
    final row1W = badgeW +
        6 +
        titleTp.width +
        (trailingTp == null ? 0 : 14 + trailingTp.width);
    const subGap = 8.0;
    final row2W = priceTp.width + (subTp.width == 0 ? 0 : subGap + subTp.width);
    final contentW = math.max(row1W, row2W);
    final cardW = contentW + padH * 2;
    final row2H = math.max(priceTp.height, subTp.height);
    final cardH = padV * 2 + row1H + rowGap + row2H;

    final right = mWidth + chartStyle.priceWidth - 4;
    final cardRect = Rect.fromLTWH(right - cardW, y - cardH / 2, cardW, cardH);
    final cardRRect =
        RRect.fromRectAndRadius(cardRect, const Radius.circular(12));

    canvas.drawRRect(
      cardRRect.shift(const Offset(0, 3)),
      Paint()
        ..color = const Color(0x4D000000)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
    );
    canvas.drawRRect(
      cardRRect,
      Paint()
        ..color = Color.alphaBlend(color.withAlpha(90), chartColors.bgColor),
    );
    canvas.drawRRect(
      cardRRect,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = color.withAlpha(170),
    );

    // Row 1: badge, id, P/L (right aligned).
    final top = cardRect.top + padV;
    final badgeRect = Rect.fromLTWH(
      cardRect.left + padH,
      top + (row1H - badgeH) / 2,
      badgeW,
      badgeH,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(badgeRect, Radius.circular(badgeH / 2)),
      Paint()..color = card.badgeColor,
    );
    badgeTp.paint(canvas, Offset(badgeRect.left + 5, badgeRect.top + 1.5));
    titleTp.paint(
      canvas,
      Offset(badgeRect.right + 6, top + (row1H - titleTp.height) / 2),
    );
    if (trailingTp != null) {
      trailingTp.paint(
        canvas,
        Offset(
          cardRect.left + padH + contentW - trailingTp.width,
          top + (row1H - trailingTp.height) / 2,
        ),
      );
    }
    // Row 2: the price, then the other details.
    final row2Top = top + row1H + rowGap;
    priceTp.paint(
      canvas,
      Offset(cardRect.left + padH, row2Top + (row2H - priceTp.height) / 2),
    );
    subTp.paint(
      canvas,
      Offset(
        cardRect.left + padH + priceTp.width + subGap,
        row2Top + (row2H - subTp.height) / 2,
      ),
    );
  }
}
