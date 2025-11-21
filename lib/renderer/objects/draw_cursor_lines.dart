import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/entity/object_entity.dart';
import 'package:candle_chart/renderer/chart_details.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../base_chart_renderer.dart';

mixin DrawCursorLines on ChartDetails {
  late final ChartPosition chartPosition;
  late final ChartStyle chartStyle;
  late Paint dot;
  late double mTranslateX;
  double? fDisplayHeight;
  late double mWidth;
  late double scaleX;
  late final ChartColors chartColors;
  late double mMainHighMaxValue, mMainLowMinValue;
  late int fixedLength;

  void addCursorOffset(
    ObjectEntity? item,
    Offset offset,
    List<KLineEntity> data,
  ) {
    final cursor = item;
    if (cursor != null) {
      chartProperties.cursor = item;
      cursor.dx1 = getX(mStartIndex) + (offset.dx / scaleX);
      cursor.datetime = getXTime(cursor.dx1, data);
      final value = getYPositionValue(offset.dy);
      if (mMainLowMinValue >= value) {
        cursor.value = mMainLowMinValue;
        double? y = getMainY(mMainLowMinValue);
        if (y == null) return;
        cursor.dy1 = y;
      } else if (mMainHighMaxValue <= value) {
        cursor.value = mMainHighMaxValue;
        double? y = getMainY(mMainLowMinValue);
        if (y == null) return;
        cursor.dy1 = y;
      } else {
        double? y = getMainY(cursor.value);
        if (y == null) return;
        cursor.dy1 = y;
        cursor.value = value;
      }
    }
  }

  void updateCursorOffset(Offset offset, List<KLineEntity> data) {
    final cursor = chartProperties.cursor;
    if (cursor != null) {
      cursor.dx1 = getX(mStartIndex) + (offset.dx / scaleX);
      cursor.datetime = getXTime(cursor.dx1, data);
      final value = getYPositionValue(offset.dy);
      if (mMainLowMinValue >= value) {
        cursor.value = mMainLowMinValue;
        double? y = getMainY(mMainLowMinValue);
        if (y == null) return;
        cursor.dy1 = y;
      } else if (mMainHighMaxValue <= value) {
        cursor.value = mMainHighMaxValue;
        double? y = getMainY(mMainLowMinValue);
        if (y == null) return;
        cursor.dy1 = y;
      } else {
        double? y = getMainY(cursor.value);
        if (y == null) return;
        cursor.dy1 = y;
        cursor.value = value;
      }
    }
  }

  void drawCursorLines(Canvas canvas, Size size, List<KLineEntity> data) {
    final cursor = chartProperties.cursor;
    if (cursor == null) return;
    double? y = getMainY(cursor.value);
    if (y == null) return;

    if (mMainLowMinValue >= cursor.value) {
      double? y = getMainY(mMainLowMinValue);
      if (y == null) return;
      y = y;
    } else if (mMainHighMaxValue <= cursor.value) {
      y = getMainY(mMainHighMaxValue);
    }
    if (y == null) return;
    // Draw horizontal line
    final pricePaint = Paint()
      ..filterQuality = FilterQuality.high
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = (0.5 / scaleX).clamp(0.1, 1.0)
      ..strokeJoin = StrokeJoin.round
      ..color = colorFromHex(cursor.color!)!;

    double startX = 0;
    final max = -mTranslateX + (mWidth + 20) / scaleX;
    // Make stroke width responsive to scaling
    final strokeWidth = (this.chartStyle.lineLength / scaleX).clamp(1.0, 8.0);

    if (cursor.style == ObjectStyle.dash) {
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

    // Set small stroke width for vertical line

    // Draw vertical line
    double x = getXFromTime(cursor.datetime, data);
    if (cursor.style == ObjectStyle.dash) {
      double startY = this.chartStyle.topPadding;
      final max = fDisplayHeight!;
      double space = this.chartStyle.priceLineSpan + this.chartStyle.lineLength;
      while (startY < max) {
        canvas.drawLine(
          Offset(x, startY),
          Offset(x, startY + this.chartStyle.lineLength),
          pricePaint,
        );
        startY += space;
      }
    } else {
      canvas.drawLine(
        Offset(x, this.chartStyle.topPadding),
        Offset(x, fDisplayHeight!),
        pricePaint,
      );
    }

    // Draw vertical line title (datetime) - now handled by drawCursorDate method
  }

  void drawCursorDate(Canvas canvas, Size size, List<KLineEntity> data) {
    final cursor = chartProperties.cursor;
    if (cursor == null) return;

    TextPainter dateTitle = getTextPainter(
      getDate(cursor.datetime),
      this.chartColors.priceTextColor,
    );

    double x = getXFromTime(cursor.datetime, data);

    // Calculate y position like drawDate method
    double y = size.height -
        (this.chartStyle.bottomPadding - dateTitle.height) / 2 -
        dateTitle.height;

    // Convert x position to screen coordinates like drawDate
    double screenX = translateXtoX(x);

    // Center the text by subtracting half the text width
    double centeredX = screenX - (dateTitle.width / 2);

    // Prevent text from going out of canvas bounds
    if (centeredX < 0) centeredX = 0;
    if (centeredX > size.width - dateTitle.width)
      centeredX = size.width - dateTitle.width;

    // Draw background rounded rectangle
    final datePaint = Paint()
      ..color = colorFromHex(cursor.color!)!
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(
          centeredX + this.chartStyle.leftPadding - 8,
          y - 2,
          centeredX + this.chartStyle.leftPadding + dateTitle.width + 8,
          y + dateTitle.height + 2,
        ),
        const Radius.circular(8.0),
      ),
      datePaint,
    );

    dateTitle.paint(
      canvas,
      Offset(centeredX + this.chartStyle.leftPadding, y),
    );
  }

  void drawCursorTitles(Canvas canvas, Size size, List<KLineEntity> data) {
    final cursor = chartProperties.cursor;
    if (cursor == null) {
      return;
    }
    double value = cursor.value;
    double? y = getMainY(value);
    if (y == null) return;
    double startX = 0;

    final pricePaint = Paint()
      ..color = colorFromHex(cursor.color!)!
      ..strokeWidth = cursor.height;

    // Draw horizontal line title
    if (cursor.title != null && cursor.title!(value).isNotEmpty) {
      TextPainter title = getTextPainter(
        cursor.title!(value),
        colorFromHex(cursor.color!)!,
        fontWeight: FontWeight.w600,
      );

      title.paint(canvas, Offset(startX, y - title.height * 2.0));
    }

    // Draw price value
    TextPainter tp = getTextPainter(
      value.toStringAsFixed(fixedLength),
      this.chartColors.priceTextColor,
    );

    double offsetX = mWidth -
        tp.width +
        this.chartStyle.priceWidth -
        this.chartStyle.leftPadding * 2;

    double top = y - tp.height / 2;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(
          offsetX - 12.0,
          top - 2.0,
          offsetX + tp.width * 1.2,
          top + tp.height + 2.0,
        ),
        const Radius.circular(12.0),
      ),
      pricePaint,
    );
    tp.paint(canvas, Offset(offsetX - 2.0, top));
  }
}
