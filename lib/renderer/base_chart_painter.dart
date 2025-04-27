import 'dart:math';

import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/renderer/objects/draw_horizontal_lines.dart';
import 'package:candle_chart/renderer/objects/draw_rectangle_lines.dart';
import 'package:candle_chart/renderer/objects/draw_tp_and_sl_lines.dart';
import 'package:candle_chart/renderer/objects/draw_trend_lines.dart';
import 'package:candle_chart/renderer/objects/draw_vertical_lines.dart';
import 'package:candle_chart/renderer/objects/update_point_position.dart';
import 'package:candle_chart/renderer/rects/main_rect.dart';
import 'package:candle_chart/renderer/rects/render_rect.dart';
import 'package:candle_chart/renderer/rects/secondary_rect.dart';

import '../entity/k_line_entity.dart';
import 'base_dimension.dart';

export 'package:flutter/material.dart'
    show Color, TextStyle, Rect, Canvas, Size, CustomPainter;

/// BaseChartPainter
abstract class BaseChartPainter extends CustomPainter
    implements
        DrawHorizontalLines,
        UpdatePointPosition,
        DrawTrendLines,
        DrawRectangleLines,
        DrawVerticalLines,
        DrawTPAndSLLines {
  static double maxScrollX = 0.0;
  List<KLineEntity>? data; // data of chart
  List<ObjectEntity> horizontalLines; // data of chart

  final List<IndicatorEntity> indicators;

  final Map<int, List<IndicatorEntity>> secondaryIndicators;

  bool volHidden;
  bool isTapShowInfoDialog;
  double scaleX = 1.0, scrollX = 0.0, selectX;
  bool isLongPress = false;
  bool isOnTap;
  bool hideGrid;

  /// Rectangle box of main chart
  late Rect mMainRect;

  /// Rectangle box of the vol chart
  Rect? mVolRect;

  /// Secondary list support
  List<RenderRect> mSecondaryRectList = [];
  late double mDisplayHeight, mWidth;
  double? fDisplayHeight;

  // padding
  double mTopPadding = 30.0,
      mBottomPadding = 20.0,
      mChildPadding = 12.0,
      mSecondaryTopPadding = 28.0;

  // grid: rows - columns
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
    this.horizontalLines = const [],
    required this.scaleX,
    required this.scrollX,
    required this.isLongPress,
    required this.selectX,
    required this.xFrontPadding,
    required this.baseDimension,
    this.isOnTap = false,
    this.indicators = const [],
    this.volHidden = false,
    this.hideGrid = false,
    this.isTapShowInfoDialog = false,
    this.secondaryIndicators = const {},
  }) {
    mItemCount = data?.length ?? 0;
    mPointWidth = this.chartStyle.pointWidth;
    mTopPadding = this.chartStyle.topPadding;
    mBottomPadding = this.chartStyle.bottomPadding;
    mChildPadding = this.chartStyle.childPadding;
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
    fDisplayHeight = size.height - mBottomPadding;
    initRect(size);
    calculateValue();
    initChartRenderer(size.height);

    canvas.save();
    canvas.scale(1, 1);
    drawBg(canvas, size);
    if (data != null && data!.isNotEmpty) {
      drawChart(canvas, size);
      drawVerticalText(canvas);
      drawDate(canvas, size);
      drawText(canvas, data!.last, 5);
      drawMaxAndMin(canvas);
      drawHorizontalLinesTitles(canvas, size);
      drawTPAndSLTitles(canvas, size);
      drawPositionsAndAskBidLines(canvas);
      if (this.chartStyle.isLongFocus &&
          (isLongPress == true ||
              (isTapShowInfoDialog && longPressTriggered))) {
        drawCrossLineText(canvas, size);
      } else if (!this.chartStyle.isLongFocus &&
          (isLongPress == true || (isTapShowInfoDialog && isOnTap))) {
        drawCrossLineText(canvas, size);
      }
    }
    drawGrid(canvas);
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
  void drawPositionsAndAskBidLines(Canvas canvas);

  /// draw the line price
  void drawHorizontalLines(Canvas canvas, Size size, bool isBackground);

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
