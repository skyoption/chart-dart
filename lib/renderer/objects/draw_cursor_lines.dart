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
        cursor.dy1 = getMainY(mMainLowMinValue);
      } else if (mMainHighMaxValue <= value) {
        cursor.value = mMainHighMaxValue;
        cursor.dy1 = getMainY(mMainLowMinValue);
      } else {
        cursor.dy1 = getMainY(cursor.value);
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
        cursor.dy1 = getMainY(mMainLowMinValue);
      } else if (mMainHighMaxValue <= value) {
        cursor.value = mMainHighMaxValue;
        cursor.dy1 = getMainY(mMainLowMinValue);
      } else {
        cursor.dy1 = getMainY(cursor.value);
        cursor.value = value;
      }
    }
  }

  void drawCursorLines(Canvas canvas, Size size, List<KLineEntity> data) {
    final cursor = chartProperties.cursor;
    if (cursor == null) return;
    double y = getMainY(cursor.value);

    if (mMainLowMinValue >= cursor.value) {
      y = getMainY(mMainLowMinValue);
    } else if (mMainHighMaxValue <= cursor.value) {
      y = getMainY(mMainHighMaxValue);
    }

    // Draw horizontal line
    final pricePaint = Paint()
      ..filterQuality = FilterQuality.high
      ..isAntiAlias = true
      ..strokeWidth = cursor.height
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = colorFromHex(cursor.color!)!;

    double startX = 0;
    final max = -mTranslateX + (mWidth + 20) / scaleX;
    final strokeWidth = (this.chartStyle.lineLength / scaleX).clamp(1, 10.0);

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

    // Draw vertical line title (datetime)
    TextPainter dateTitle = getTextPainter(
      getDate(cursor.datetime),
      this.chartColors.priceTextColor,
    );

    final datePaint = Paint()
      ..color = colorFromHex(cursor.color!)!
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(
          x - (dateTitle.width / 2) - 8,
          fDisplayHeight! - 5,
          x + (dateTitle.width / 2) + 8,
          fDisplayHeight! + dateTitle.height,
        ),
        const Radius.circular(12.0),
      ),
      datePaint,
    );

    dateTitle.paint(
      canvas,
      Offset(
        x - dateTitle.width / 2,
        fDisplayHeight! - 2,
      ),
    );
  }

  void drawCursorTitles(Canvas canvas, Size size, List<KLineEntity> data) {
    final cursor = chartProperties.cursor;
    if (cursor == null) {
      return;
    }
    double value = cursor.value;
    double y = getMainY(value);

    double startX = 0;

    final pricePaint = Paint()
      ..color = colorFromHex(cursor.color!)!
      ..strokeWidth = cursor.height;

    // Draw horizontal line title
    if (cursor.title.isNotEmpty) {
      TextPainter title = getTextPainter(
        cursor.title,
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
