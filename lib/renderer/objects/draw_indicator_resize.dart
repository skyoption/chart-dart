import 'dart:ui';

import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/renderer/chart_details.dart';
import 'package:candle_chart/renderer/rects/render_rect.dart';
import 'package:flutter/material.dart';

mixin DrawIndicatorResize on ChartDetails {
  late final ChartPosition chartPosition;
  late final ChartStyle chartStyle;
  late Paint dot;
  late double scaleX;
  late double mMainHighMaxValue, mMainLowMinValue;

  /// Draw the resize handle for indicators
  void drawIndicatorResizeHandles(
    Canvas canvas,
    Size size,
    List<RenderRect> secondaryRects,
    Map<int, List<IndicatorEntity>> secondaryIndicators,
  ) {
    if (secondaryRects.isEmpty) return;

    final handlePaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    int rectIndex = 0;
    for (var items in secondaryIndicators.values) {
      for (int i = 0; i < items.length; i++) {
        if (rectIndex >= secondaryRects.length) break;

        final rect = secondaryRects[rectIndex];
        final indicator = items[i];

        // Only show X button for indicators that don't have edit mode
        // Check if this is a simple indicator that can be deleted
        if (_canShowDeleteButton(indicator)) {
          // Draw resize handle at the top-right of each secondary rect
          final handleSize = 21.0;
          final handleRect = Rect.fromLTWH(
            rect.mRect.right - handleSize - 8, // 8px from right edge
            rect.mRect.top + 8, // 8px from top edge
            handleSize,
            handleSize,
          );

          // Draw red background with rounded corners
          final roundedRect = RRect.fromRectAndRadius(
            handleRect,
            const Radius.circular(8),
          );
          canvas.drawRRect(roundedRect, handlePaint);

          // Draw clear icon (X)
          final textPainter = TextPainter(
            text: const TextSpan(
              text: '×',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            textDirection: TextDirection.ltr,
          );
          textPainter.layout();

          final textOffset = Offset(
            handleRect.left + (handleSize - textPainter.width) / 2,
            handleRect.top + (handleSize - textPainter.height) / 2,
          );
          textPainter.paint(canvas, textOffset);
        }

        rectIndex++;
      }
    }
  }
  // Implementation of DrawIndicatorResize mixin methods

  int? findSecondaryRectIndex(
      Offset offset, List<RenderRect> mSecondaryRectList) {
    for (int i = 0; i < mSecondaryRectList.length; i++) {
      final rect = mSecondaryRectList[i];
      if (rect.mRect.contains(offset)) {
        return i;
      }
    }
    return null;
  }

  IndicatorEntity? getIndicatorForRectIndex(
      int rectIndex,
      List<RenderRect> mSecondaryRectList,
      Map<int, List<IndicatorEntity>> secondaryIndicators) {
    if (rectIndex >= mSecondaryRectList.length) return null;

    int currentIndex = 0;
    for (final entry in secondaryIndicators.entries) {
      final indicators = entry.value;
      for (final indicator in indicators) {
        if (currentIndex == rectIndex) {
          return indicator;
        }
        currentIndex++;
      }
    }
    return null;
  }

  /// Draw indicator resize handles when in resize mode
  void drawIndicatorResizeHandlesIfNeeded(
      Canvas canvas,
      Size size,
      List<RenderRect> mSecondaryRectList,
      Map<int, List<IndicatorEntity>> secondaryIndicators,
      bool isIndicatorResizeMode,
      bool hideIndicators) {
    if (isIndicatorResizeMode &&
        !hideIndicators &&
        mSecondaryRectList.isNotEmpty) {
      drawIndicatorResizeHandles(
          canvas, size, mSecondaryRectList, secondaryIndicators);
    }
  }

  /// Check if the indicator can show a delete button
  bool _canShowDeleteButton(IndicatorEntity indicator) {
    // Show delete button for simple indicators that don't have complex edit modes
    // This includes basic indicators like RSI, MACD, etc.
    return indicator.type == IndicatorType.RSI ||
        indicator.type == IndicatorType.MACD ||
        indicator.type == IndicatorType.ATR ||
        indicator.type == IndicatorType.WPR ||
        indicator.type == IndicatorType.DEM ||
        indicator.type == IndicatorType.CCI ||
        indicator.type == IndicatorType.MFI ||
        indicator.type == IndicatorType.SO_EMA ||
        indicator.type == IndicatorType.SO_LINEAR ||
        indicator.type == IndicatorType.SO_SMA ||
        indicator.type == IndicatorType.SO_SMMA ||
        indicator.type == IndicatorType.MOM;
  }
}
