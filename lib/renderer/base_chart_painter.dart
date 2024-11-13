import 'dart:math';

import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/renderer/draw_object_lines.dart';
import 'package:candle_chart/renderer/rects/main_rect.dart';
import 'package:candle_chart/renderer/rects/render_rect.dart';
import 'package:candle_chart/renderer/rects/secondary_rect.dart';

import '../entity/k_line_entity.dart';
import 'base_dimension.dart';
export 'package:flutter/material.dart'
    show Color, required, TextStyle, Rect, Canvas, Size, CustomPainter;

/// BaseChartPainter
abstract class BaseChartPainter extends CustomPainter
    implements DrawObjectLines {
  static double maxScrollX = 0.0;
  List<KLineEntity>? data; // data of chart
  List<LineEntity> linesPrice; // data of chart

  final List<IndicatorEntity> indicators;

  final Map<int, List<IndicatorEntity>> secondaryIndicators;

  bool volHidden;
  bool isTapShowInfoDialog;
  double scaleX = 1.0, scrollX = 0.0, selectX;
  bool isLongPress = false;
  bool isOnTap;
  bool isLine;

  /// Rectangle box of main chart
  late Rect mMainRect;

  /// Rectangle box of the vol chart
  Rect? mVolRect;

  /// Secondary list support
  List<RenderRect> mSecondaryRectList = [];
  late double mDisplayHeight, mWidth;

  // padding
  double mTopPadding = 30.0,
      mBottomPadding = 20.0,
      mChildPadding = 12.0,
      mSecondaryTopPadding = 28.0;

  // grid: rows - columns
  int mGridRows = 12, mGridColumns = 4;
  int mStartIndex = 0, mStopIndex = 0;
  double mVolMaxValue = double.minPositive, mVolMinValue = double.maxFinite;
  double mTranslateX = double.minPositive;

  int mItemCount = 0;
  double mDataLen = 0.0; // the data occupies the total length of the screen
  final ChartStyle chartStyle;
  late double mPointWidth;

  // format time
  List<String> mFormats = [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn];
  double xFrontPadding;

  /// base dimension
  final BaseDimension baseDimension;
    MainRect? mainRect;
    SecondaryRect? secondaryRect;

  /// constructor BaseChartPainter
  ///
  BaseChartPainter(
    this.chartStyle, {
    this.data,
    this.linesPrice = const [],
    required this.scaleX,
    required this.scrollX,
    required this.isLongPress,
    required this.selectX,
    required this.xFrontPadding,
    required this.baseDimension,
    this.isOnTap = false,
    this.indicators = const [],
    this.volHidden = false,
    this.isTapShowInfoDialog = false,
    this.secondaryIndicators = const {},
    this.isLine = false,
  }) {
    mItemCount = data?.length ?? 0;
    mPointWidth = this.chartStyle.pointWidth;
    mTopPadding = this.chartStyle.topPadding;
    mBottomPadding = this.chartStyle.bottomPadding;
    mChildPadding = this.chartStyle.childPadding;
    mGridRows = this.chartStyle.gridRows;
    mGridColumns = this.chartStyle.gridColumns;
    mDataLen = mItemCount * mPointWidth;
    initFormats();
  }

  /// init format time
  void initFormats() {
    if (this.chartStyle.dateTimeFormat != null) {
      mFormats = this.chartStyle.dateTimeFormat!;
      return;
    }

    if (mItemCount < 2) {
      mFormats = [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn];
      return;
    }

    int firstTime = data!.first.time ?? 0;
    int secondTime = data![1].time ?? 0;
    int time = secondTime - firstTime;
    time ~/= 1000;
    // monthly line
    if (time >= 24 * 60 * 60 * 28) {
      mFormats = [yyyy, '-', mm];
    } else if (time >= 24 * 60 * 60) {
      // daily line
      mFormats = [yyyy, '-', mm, '-', dd];
    } else {
      // hour line
      mFormats = [M, '-', dd, ' ', HH, ':', nn];
    }
  }

  bool isInitial = false;

  /// paint chart
  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTRB(0, 0, size.width, size.height));
    mDisplayHeight = size.height - mTopPadding - mBottomPadding;
    mWidth = size.width - this.chartStyle.priceWidth;
    initRect(size);
    calculateValue();
    initChartRenderer(size.height);

    canvas.save();
    canvas.scale(1, 1);
    drawBg(canvas, size);
    drawGrid(canvas);
    if (data != null && data!.isNotEmpty) {
      drawChart(canvas, size);
      drawVerticalText(canvas);
      drawDate(canvas, size);

      drawText(canvas, data!.last, 5);
      drawMaxAndMin(canvas);
      // drawNowPrice(canvas);
      drawLinePrice(canvas, size);
      if (this.chartStyle.isLongFocus &&
          (isLongPress == true ||
              (isTapShowInfoDialog && longPressTriggered))) {
        drawCrossLineText(canvas, size);
      } else if (!this.chartStyle.isLongFocus &&
          (isLongPress == true || (isTapShowInfoDialog && isOnTap))) {
        drawCrossLineText(canvas, size);
      }
    }
    canvas.restore();
  }

  /// init chart renderer
  void initChartRenderer(double height);

  /// draw the background of chart
  void drawBg(Canvas canvas, Size size);

  /// draw the grid of chart
  void drawGrid(canvas);

  /// draw chart
  void drawChart(Canvas canvas, Size size);

  /// draw vertical text
  void drawVerticalText(canvas);

  /// draw date
  void drawDate(Canvas canvas, Size size);

  /// draw text
  void drawText(Canvas canvas, KLineEntity data, double x);

  /// draw maximum and minimum values
  void drawMaxAndMin(Canvas canvas);

  /// draw the current price
  void drawNowPrice(Canvas canvas);

  /// draw the line price
  void drawLinePrice(Canvas canvas, Size size);

  /// draw cross line
  void drawCrossLine(Canvas canvas, Size size);

  /// draw text of the cross line
  void drawCrossLineText(Canvas canvas, Size size);

  /// init the rectangle box to draw chart
  void initRect(Size size) {
    double volHeight = baseDimension.mVolumeHeight;
    double secondaryHeight = baseDimension.mSecondaryHeight;

    double mainHeight = mDisplayHeight;
    mainHeight -= volHeight;
    mainHeight -= secondaryHeight;

    mMainRect = Rect.fromLTRB(0, mTopPadding, mWidth, mTopPadding + mainHeight);

    if (volHidden != true) {
      mVolRect = Rect.fromLTRB(
        0,
        mMainRect.bottom + mChildPadding,
        mWidth,
        mMainRect.bottom + volHeight,
      );
    }

    mSecondaryRectList.clear();
    // double rowSpace = ((mDisplayHeight * 0.85) / mGridRows);
    double _secondaryHeight = 0;
    for (int i = 0; i < secondaryIndicators.length; ++i) {
      final secondary = baseDimension.getSecondaryHeight(
          HighLevelIndicator.getHigh(secondaryIndicators, i));
      for (int index = 0;
          index < secondaryIndicators.entries.elementAt(i).value.length;
          index++) {
        mSecondaryRectList.add(
          RenderRect(
            Rect.fromLTRB(
              0,
              mMainRect.bottom + volHeight + _secondaryHeight,
              mWidth,
              mMainRect.bottom + volHeight + _secondaryHeight + secondary,
            ),
          ),
        );
      }
      _secondaryHeight += secondary;
    }
    mainRect = MainRect(
      indicators: indicators,
      isLine: isLine,
      mMainHighMaxValue: mMainHighMaxValue,
      mMainLowMinValue: mMainLowMinValue,
    );
    secondaryRect = SecondaryRect(
      mSecondaryRectList: mSecondaryRectList,
      secondaryIndicators: secondaryIndicators,
    );
  }

  /// calculate values
  calculateValue() {
    if (data == null) return;
    if (data!.isEmpty) return;
    maxScrollX = getMinTranslateX().abs();
    setTranslateXFromScrollX(scrollX);
    mStartIndex = indexOfTranslateX(xToTranslateX(0));
    mStopIndex = indexOfTranslateX(xToTranslateX(mWidth));
    for (int i = mStartIndex; i <= mStopIndex; i++) {
      var item = data![i];
      mainRect?.getMainMaxMinValue(item, i);
      getVolMaxMinValue(item);
      int rectIndex = 0;
      for (int i = 0; i < secondaryIndicators.length; ++i) {
        final length = secondaryIndicators.entries.elementAt(i).value.length;
        for (int index = 0; index < length; index++) {
          secondaryRect?.getSecondaryMaxMinValue(i, index, rectIndex, item);
          rectIndex++;
        }
      }
    }
  }

  // get the maximum and minimum of the Vol value
  void getVolMaxMinValue(KLineEntity item) {
    mVolMaxValue = max(
      mVolMaxValue,
      max(item.vol, max(item.MA5Volume ?? 0, item.MA10Volume ?? 0)),
    );
    mVolMinValue = min(
      mVolMinValue,
      min(item.vol, min(item.MA5Volume ?? 0, item.MA10Volume ?? 0)),
    );
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

  KLineEntity getItem(int position) {
    return data![position];
    // if (datas != null) {
    //   return datas[position];
    // } else {
    //   return null;
    // }
  }

  /// scrollX convert to TranslateX
  void setTranslateXFromScrollX(double scrollX) {
    mTranslateX = scrollX + getMinTranslateX();
  }

  /// get the minimum value of translation
  double getMinTranslateX() {
    var x = -mDataLen + mWidth / scaleX - mPointWidth / 2 - xFrontPadding;
    return x >= 0 ? 0.0 : x;
  }

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

  /// translateX is converted to X in view
  double translateXtoX(double translateX) {
    return (translateX + mTranslateX) * scaleX;
  }

  @override
  bool shouldRepaint(BaseChartPainter oldDelegate) {
    return true;
  }
}

class HighLevelIndicator {
  static IndicatorEntity getHigh(
    Map<int, List<IndicatorEntity>> values,
    int index,
  ) {
    return values.entries.elementAt(index).value.first;
  }

  static IndicatorEntity getIndicator(
    Map<int, List<IndicatorEntity>> values,
    int index,
    int i,
  ) {
    return values.entries.elementAt(index).value[i];
  }
}
