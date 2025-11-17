import 'package:flutter/material.dart';

import '../entity/k_line_entity.dart';
import '../utils/date_format_util.dart';
import 'base_chart_renderer.dart';

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
    TextPainter tp =
        TextPainter(text: spanAll, textDirection: TextDirection.ltr);
    tp.layout();
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
      return mMainRenderer.getY(y);
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

  double getYPositionValue(double dy) {
    final scope = this.chartPosition.topPrice - this.chartPosition.bottomPrice;
    double perPixel = scope / mMainRect.height;
    final value = this.chartPosition.topPrice - (dy * perPixel);
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
    const candleSpace = 10.0;
    final lowTime = data[0].time;
    final topTime = data.last.time;
    int timeDiff = topTime - lowTime;
    double pixelTime = timeDiff /
        (getX(data.length) -
            (candleSpace * (scaleX < 1 ? 2.0 : 1.5)) / scaleX.clamp(0.5, 1));
    double currentTime = lowTime + x * pixelTime;
    return currentTime.toInt();
  }

  double getXFromTime(int time, List<KLineEntity> data) {
    if (data.isEmpty) return 0;
    const candleSpace = 10.0;
    final lowTime = data[0].time;
    final topTime = data.last.time;
    int timeDiff = topTime - lowTime;
    double pixelTime = timeDiff /
        (getX(data.length) -
            (candleSpace * (scaleX < 1 ? 2.0 : 1.5)) / scaleX.clamp(0.5, 1));

    return (time - lowTime) / pixelTime;
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
