import 'package:flutter/material.dart';

import '../entity/k_line_entity.dart';
import '../utils/date_format_util.dart';
import 'base_chart_renderer.dart';

/// Laying out text is the main per-frame cost of the live chart; axis labels
/// and prices repeat a lot, so identical (text, style) pairs are reused.
final Map<(String, TextStyle), TextPainter> _textPainterCache = {};

mixin ChartDetails on ChartCalc {
  late final ChartPosition chartPosition;
  late final ChartStyle chartStyle;
  late final ChartColors chartColors;
  late BaseChartRenderer mMainRenderer;

  /// Rectangle box of main chart
  late Rect mMainRect;
  late List<String> mFormats;

  TextPainter getTextPainter(
    text,
    color, {
    addTextSpan,
    isLeft,
    double? sizeText,
    FontWeight? fontWeight,
  }) {
    if (color == null) {
      color = this.chartColors.defaultTextColor;
    }

    TextSpan? spanAll;

    TextSpan span = TextSpan(
      text: "$text",
      style: getTextStyle(
        color,
        sizeText: sizeText,
        fontWeight: fontWeight,
      ),
    );
    if (addTextSpan != null) {
      TextSpan spanS = addTextSpan();
      List<InlineSpan> children = [];
      if (isLeft != null && isLeft) {
        children.add(span);
        children.add(spanS);
      } else {
        children.add(spanS);
        children.add(span);
      }
      spanAll = TextSpan(children: children);
    } else {
      List<InlineSpan> children = [];
      children.add(span);
      spanAll = TextSpan(children: children);
    }
    final cacheable = addTextSpan == null;
    final style = span.style!;
    if (cacheable) {
      final cached = _textPainterCache[("$text", style)];
      if (cached != null) return cached;
    }
    TextPainter tp =
        TextPainter(text: spanAll, textDirection: TextDirection.ltr);
    tp.layout();
    if (cacheable) {
      if (_textPainterCache.length > 300) _textPainterCache.clear();
      _textPainterCache[("$text", style)] = tp;
    }
    return tp;
  }

  String getDate(int? date) {
    final d = dateFormat(
      DateTime.fromMillisecondsSinceEpoch(date! * 1000),
      mFormats,
    );
    return d;
  }

  /// define text style
  TextStyle getTextStyle(
    Color color, {
    double? sizeText,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontSize: sizeText ?? chartStyle.sizeText,
      color: color,
      fontWeight: fontWeight,
    );
  }
}

mixin ChartCalc {
  late final ChartPosition chartPosition;
  late BaseChartRenderer mMainRenderer;
  late Rect mMainRect;
  late double mTranslateX;
  late int mStartIndex, mStopIndex;
  late int mItemCount;
  late double mPointWidth;
  late double mWidth;
  late double mDataLen;
  late final ChartStyle chartStyle;

  // late double xFrontPadding;
  late double scaleX;

  // List<KLineEntity>? data;

  double? getMainY(double y) {
    try {
      final res = mMainRenderer.getY(y);
      return res;
    } catch (e) {
      return null;
    }
  }

  double getMainYInChart(double y) => mMainRenderer.getYInChart(y);

  /// Whether the point is in the SecondaryRect
  // bool isInSecondaryRect(Offset point) {
  //   // return mSecondaryRect.contains(point) == true);
  //   return false;
  // }

  /// Inverse of [getMainY]. The main rect starts at [mMainRect.top] (the top
  /// padding), so that offset has to come out of dy before scaling — without it
  /// every dragged object lands topPadding pixels away from the finger.
  double getYPositionValue(double dy) {
    final scope = this.chartPosition.topPrice - this.chartPosition.bottomPrice;
    double perPixel = scope / mMainRect.height;
    final value =
        this.chartPosition.topPrice - ((dy - mMainRect.top) * perPixel);
    return value;
  }

  double getYValue(double d) {
    final scope = this.chartPosition.topPrice - this.chartPosition.bottomPrice;
    double perValue = (mMainRect.height / scope);

    final value = (perValue * d) / 1000;
    return value;
  }

  /// Whether the point is in MainRect
  bool isInMainRect(Offset point) {
    return mMainRect.contains(point);
  }

  /// Get x coordinate based on index
  /// + mPointWidth / 2 to prevent the first and last K-line from displaying incorrectly
  /// @param position index value

  int getXTime(double x, List<KLineEntity> data) {
    if (data.isEmpty) return 0;

    // Find which candle index this X coordinate corresponds to
    // getX(i) = i * mPointWidth + mPointWidth / 2
    // So: i = (x - mPointWidth / 2) / mPointWidth

    // Calculate the index from X coordinate
    double index = (x - mPointWidth / 2) / mPointWidth;
    int lowerIndex = index.floor().clamp(0, data.length - 1);
    int upperIndex = (index.ceil()).clamp(0, data.length - 1);

    // If exactly on a candle
    if (lowerIndex == upperIndex) {
      return data[lowerIndex].time;
    }

    // Interpolate between the two candles
    final lowerX = getX(lowerIndex);
    final upperX = getX(upperIndex);

    if (upperX == lowerX) {
      return data[lowerIndex].time;
    }

    final xRatio = (x - lowerX) / (upperX - lowerX);
    final lowerTime = data[lowerIndex].time;
    final upperTime = data[upperIndex].time;
    final timeDiff = upperTime - lowerTime;

    return (lowerTime + timeDiff * xRatio).toInt();
  }

  double getXFromTime(int time, List<KLineEntity> data) {
    if (data.isEmpty) return 0;

    // Find the closest candle by time
    int closestIndex = 0;
    int closestDiff = (data[0].time - time).abs();

    for (int i = 1; i < data.length; i++) {
      final diff = (data[i].time - time).abs();
      if (diff <= closestDiff) {
        closestDiff = diff;
        closestIndex = i;
        if (data[i].time - time > 0) {
          closestIndex--;
        }
      }
      // Data is sorted by time, so if diff starts increasing we can stop
      if (diff > closestDiff) break;
    }

    return getX(closestIndex);
  }

  // translate x
  double xToTranslateX(double x) => -mTranslateX + x / scaleX;

  int indexOfTranslateX(double translateX) {
    return _indexOfTranslateX(translateX, 0, mItemCount - 1);
  }

  /// Using binary search for the index of the current value
  int _indexOfTranslateX(double translateX, int start, int end) {
    if (end == start || end == -1) {
      return start;
    }
    if (end - start == 1) {
      double startValue = getX(start);
      double endValue = getX(end);
      return (translateX - startValue).abs() < (translateX - endValue).abs()
          ? start
          : end;
    }
    int mid = start + (end - start) ~/ 2;
    double midValue = getX(mid);
    if (translateX < midValue) {
      return _indexOfTranslateX(translateX, start, mid);
    } else if (translateX > midValue) {
      return _indexOfTranslateX(translateX, mid, end);
    } else {
      return mid;
    }
  }

  /// Get x coordinate based on index
  /// + mPointWidth / 2 to prevent the first and last K-line from displaying incorrectly
  /// @param position index value
  double getX(int position) => position * mPointWidth + mPointWidth / 2;

  /// calculate the value of x after long pressing and convert to [index]
  int calculateSelectedX(double selectX) {
    int mSelectedIndex = indexOfTranslateX(xToTranslateX(selectX));
    if (mSelectedIndex < mStartIndex) {
      mSelectedIndex = mStartIndex;
    }
    if (mSelectedIndex > mStopIndex) {
      mSelectedIndex = mStopIndex;
    }
    return mSelectedIndex;
  }

  // int indexOfX(double x) {
  //   double max = getX(mStopIndex);
  //   double min = getX(mStartIndex);
  //   if (mSelectedIndex < mStartIndex) {
  //     mSelectedIndex = mStartIndex;
  //   }
  //   if (mSelectedIndex > mStopIndex) {
  //     mSelectedIndex = mStopIndex;
  //   }
  //   return mSelectedIndex;
  // }

  /// calculate the value of x after long pressing and convert to [index]
  int calculateReversedSelectedX(double selectX) {
    int mSelectedIndex = indexOfTranslateX(xToTranslateX(selectX));
    if (mSelectedIndex < mStartIndex) {
      mSelectedIndex = mStartIndex;
    }
    if (mSelectedIndex > mStopIndex) {
      mSelectedIndex = mStopIndex;
    }
    return mStopIndex - mSelectedIndex;
  }

  /// translateX is converted to X in view
  double translateXtoX(double translateX) {
    return (translateX + mTranslateX) * scaleX;
  }
}
