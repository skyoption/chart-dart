import 'dart:async' show StreamSink;
import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/entity/line_entity.dart';
import 'package:candle_chart/entity/trade_entity.dart';
import 'package:candle_chart/renderer/chart_details.dart';
import 'package:candle_chart/renderer/objects/draw_cursor_lines.dart';
import 'package:candle_chart/renderer/objects/draw_fibonacci_arcs.dart';
import 'package:candle_chart/renderer/objects/draw_fibonacci_channel.dart';
import 'package:candle_chart/renderer/objects/draw_fibonacci_expansion.dart';
import 'package:candle_chart/renderer/objects/draw_fibonacci_fan.dart';
import 'package:candle_chart/renderer/objects/draw_fibonacci_lines.dart';
import 'package:candle_chart/renderer/objects/draw_fibonacci_time_zones.dart';
import 'package:candle_chart/renderer/objects/draw_horizontal_lines.dart';
import 'package:candle_chart/renderer/objects/draw_indicator_resize.dart';
import 'package:candle_chart/renderer/objects/draw_rectangle_lines.dart';
import 'package:candle_chart/renderer/objects/draw_tp_and_sl_lines.dart';
import 'package:candle_chart/renderer/objects/draw_trade_positions_lines.dart';
import 'package:candle_chart/renderer/objects/draw_trend_lines.dart';
import 'package:candle_chart/renderer/objects/draw_vertical_lines.dart';
import 'package:candle_chart/renderer/objects/update_point_position.dart';
import 'package:candle_chart/renderer/rects/render_rect.dart';
import 'package:candle_chart/utils/number_util.dart';
import 'package:flutter/material.dart';
import '../entity/info_window_entity.dart';
import '../entity/k_line_entity.dart';
import '../k_chart_widget.dart';
import 'base_chart_painter.dart';
import 'base_chart_renderer.dart';
import 'base_dimension.dart';
import 'live/live_chart_animator.dart';
import 'live/smooth_path.dart';
import 'main_renderer.dart';
import 'secondary_renderer.dart';
import 'vol_renderer.dart';

class TrendLine {
  final Offset p1;
  final Offset p2;
  final double maxHeight;
  final double scale;

  TrendLine(this.p1, this.p2, this.maxHeight, this.scale);
}

double? trendLineX;

double getTrendLineX() {
  return trendLineX ?? 0;
}

int lastLength = 0;

class ChartPainter extends BaseChartPainter
    with
        ChartDetails,
        DrawHorizontalLines,
        DrawVerticalLines,
        DrawTrendLines,
        DrawFibonacciLines,
        DrawFibonacciTimeZones,
        DrawFibonacciFan,
        DrawFibonacciArcs,
        DrawFibonacciChannel,
        DrawFibonacciExpansion,
        DrawRectangleLines,
        UpdatePointPosition,
        DrawTPAndSLLines,
        DrawCursorLines,
        DrawIndicatorResize,
        DrawTradePositionsLines,
        ChartCalc {
  static get maxScrollX => BaseChartPainter.maxScrollX;
  late BaseChartRenderer mMainRenderer;
  BaseChartRenderer? mVolRenderer;
  Set<BaseChartRenderer> mSecondaryRendererList = {};
  StreamSink<InfoWindowEntity?> sink;
  Color? upColor, dnColor;
  Color? ma5Color, ma10Color, ma30Color;
  Color? volColor;
  Color? macdColor, difColor, deaColor, jColor;
  int fixedLength;
  final ChartColors chartColors;
  late Paint selectPointPaint, selectorBorderPaint, pricePaint, dot;
  final ChartStyle chartStyle;
  final bool hideGrid;
  final VerticalTextAlignment verticalTextAlignment;
  final BaseDimension baseDimension;
  final List<IndicatorEntity> indicators;
  final Map<int, List<IndicatorEntity>> secondaryIndicators;
  late final ChartPosition chartPosition;
  double mMainHighMaxValue = double.minPositive,
      mMainLowMinValue = double.maxFinite;
  final double scaleX;
  final double scaleY;
  final bool hideIndicators;
  final GraphStyle graphStyle;
  final List<LineEntity> askAndBid;
  final bool isIndicatorResizeMode;
  final int? currentResizeRectIndex;
  final List<TradeEntity> trades;

  /// Rect of the live price pill from the last paint; hints avoid it.
  Rect? _pillRect;

  @override
  bool get isLiveLineMode =>
      graphStyle == GraphStyle.line || graphStyle == GraphStyle.area;

  ChartPainter(
    this.chartStyle,
    this.chartColors, {
    required this.askAndBid,
    required this.sink,
    required this.scaleY,
    required this.scaleX,
    required data,
    required scrollX,
    required isLongPass,
    required selectX,
    required xFrontPadding,
    required this.baseDimension,
    required this.indicators,
    required this.secondaryIndicators,
    required this.graphStyle,
    isOnTap,
    isTapShowInfoDialog,
    required this.verticalTextAlignment,
    volHidden,
    bool isLine = false,
    this.hideGrid = false,
    this.fixedLength = 2,
    this.hideIndicators = false,
    this.isIndicatorResizeMode = false,
    this.currentResizeRectIndex,
    required this.trades,
    LiveChartAnimator? animator,
  }) : super(
          chartStyle,
          data: data,
          scaleX: scaleX,
          scrollX: scrollX,
          isLongPress: isLongPass,
          baseDimension: baseDimension,
          isOnTap: isOnTap,
          isTapShowInfoDialog: isTapShowInfoDialog,
          selectX: selectX,
          indicators: indicators,
          volHidden: volHidden,
          hideGrid: hideGrid,
          secondaryIndicators: secondaryIndicators,
          xFrontPadding: xFrontPadding,
          trades: trades,
          animator: animator,
        ) {
    chartPosition = ChartPosition();
    dot = Paint()..color = Colors.grey;
    selectPointPaint = Paint()
      ..isAntiAlias = true
      //EMA
      ..strokeWidth = 0.21
      ..color = this.chartColors.selectFillColor;
    selectorBorderPaint = Paint()
      ..isAntiAlias = true
      //EMA
      ..strokeWidth = 0.21
      ..style = PaintingStyle.stroke
      ..color = this.chartColors.selectBorderColor;

    pricePaint = Paint()
      ..strokeWidth = this.chartStyle.priceLineWidth
      ..isAntiAlias = true;
  }

  @override
  void resetFrameState() {
    mMainHighMaxValue = double.minPositive;
    mMainLowMinValue = double.maxFinite;
    mVolMaxValue = double.minPositive;
    mVolMinValue = double.maxFinite;
    _pillRect = null;
  }

  @override
  void initChartRenderer(double height) {
    if (data != null && data!.isNotEmpty) {
      var t = data![0];
      fixedLength =
          NumberUtil.getMaxDecimalLength(t.open, t.close, t.high, t.low);
    }
    if (!this.chartStyle.isSmallChart) {
      if (secondaryIndicators.isNotEmpty) {
        this.chartStyle.gridRows = 24 ~/ secondaryIndicators.length;
      } else {
        this.chartStyle.gridRows = 18;
      }
    }
    double maxV = mainRect!.mMainMaxValue, minV = mainRect!.mMainMinValue;
    if (isLiveStyle) {
      // Keep the live line, ask and bid inside the chart.
      final a = animator;
      if (a?.targetPrice != null) {
        maxV = math.max(maxV, a!.targetAsk ?? a.targetPrice!);
        minV = math.min(minV, a.targetBid ?? a.targetPrice!);
        maxV = math.max(maxV, a.targetPrice!);
        minV = math.min(minV, a.targetPrice!);
      }
      // Headroom for the hint tags.
      final pad = (maxV - minV) * chartStyle.liveVerticalPadding;
      maxV += pad;
      minV -= pad;
      if (a != null) (maxV, minV) = a.range.smooth(maxV, minV);
    }

    mMainRenderer = MainRenderer(
      mMainRect,
      maxV / scaleY,
      minV * scaleY,
      mTopPadding,
      chartPosition,
      fixedLength,
      this.chartStyle,
      this.chartColors,
      this.scaleX,
      this.scaleY,
      this.hideGrid,
      verticalTextAlignment,
      indicators,
      graphStyle,
      hideIndicators,
    );

    if (mVolRect != null && !hideIndicators) {
      mVolRenderer = VolRenderer(
        mVolRect!,
        mVolMaxValue,
        mVolMinValue,
        mChildPadding,
        fixedLength,
        this.chartStyle,
        this.chartColors,
      );
    }
    mSecondaryRendererList.clear();
    if (!hideIndicators) {
      int rectIndex = 0;
      List<IndicatorEntity> _indicators = [];
      for (int i = 0; i < secondaryIndicators.length; ++i) {
        final values = secondaryIndicators.entries.elementAt(i).value;
        _indicators.addAll(values);
        for (int index = 0; index < values.length; index++) {
          mSecondaryRendererList.add(
            SecondaryRenderer(
              mSecondaryRectList.sublist(i, i + values.length),
              mSecondaryRectList[rectIndex].mRect,
              mSecondaryRectList[rectIndex].mMaxValue,
              mSecondaryRectList[rectIndex].mMinValue,
              mChildPadding,
              values[index],
              _indicators,
              values.sublist(index, values.length),
              index,
              fixedLength,
              chartStyle,
              chartColors,
              this.scaleX,
              this.hideGrid,
            ),
          );
          rectIndex++;
        }
      }
    }
    final liveMain = mMainRenderer;
    if (liveMain is MainRenderer &&
        isLiveStyle &&
        !isLiveLineMode &&
        data != null &&
        data!.isNotEmpty) {
      // The forming candle follows the animated price.
      liveMain.liveCandle = data!.last;
      liveMain.livePrice = animator?.price;
    }
    scaleY = mMainRenderer.scaleY;
    mMainHighMaxValue = mMainRenderer.maxValue;
    mMainLowMinValue = mMainRenderer.minValue;
  }

  @override
  void drawBg(Canvas canvas, Size size) {
    Paint mBgPaint = Paint()..color = chartColors.bgColor;
    Rect mainRect = Rect.fromLTRB(
      0,
      0,
      mMainRect.rWidth,
      mMainRect.height + mTopPadding,
    );
    canvas.drawRect(mainRect, mBgPaint);
    // With labels on the left the price column is plain chart area; paint it.
    if (isLiveStyle) {
      canvas.drawRect(Offset.zero & size, mBgPaint);
    }

    if (mVolRect != null) {
      Rect volRect = Rect.fromLTRB(
        0,
        mVolRect!.top - mChildPadding,
        mVolRect!.rWidth,
        mVolRect!.bottom,
      );
      canvas.drawRect(volRect, mBgPaint);
    }

    for (int i = 0; i < mSecondaryRectList.length; ++i) {
      Rect? mSecondaryRect = mSecondaryRectList[i].mRect;
      Rect secondaryRect = Rect.fromLTRB(
        0,
        mSecondaryRect.top - mChildPadding,
        mSecondaryRect.rWidth,
        mSecondaryRect.bottom,
      );
      canvas.drawRect(secondaryRect, mBgPaint);
    }
    Rect dateRect = Rect.fromLTRB(
      0,
      size.height - mBottomPadding,
      size.rWidth,
      size.height,
    );
    canvas.drawRect(dateRect, mBgPaint);
  }

  @override
  void drawGrid(canvas) {
    // if (!hideGrid) {

    final rWidth = mMainRect.rWidth;
    final rHeight = mMainRect.height + mTopPadding;
    mMainRenderer.drawGrid(canvas, this.chartStyle.gridRows,
        this.chartStyle.gridColumns, rWidth, rHeight);
    mVolRenderer?.drawGrid(canvas, this.chartStyle.gridRows,
        this.chartStyle.gridColumns, rWidth, rHeight);
    mSecondaryRendererList.forEach((element) {
      element.drawGrid(canvas, this.chartStyle.gridRows,
          this.chartStyle.gridColumns, rWidth, rHeight);
    });
    // }
  }

  @override
  void drawChart(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(mTranslateX * scaleX + this.chartStyle.leftPadding, 0.0);
    canvas.scale(scaleX, 1.0);

    drawHorizontalLines(canvas, size, true);
    drawTPAndSLLines(canvas, size, true);
    drawVerticalLines(canvas, size, true, data ?? []);
    drawTrendLines(canvas, size, true, data ?? []);
    drawFibonacciLines(canvas, size, true, data ?? []);
    drawFibonacciTimeZones(canvas, size, true, data ?? []);
    drawFibonacciFan(canvas, size, true, data ?? []);
    drawFibonacciArcs(canvas, size, true, data ?? []);
    drawFibonacciChannel(canvas, size, true, data ?? []);
    drawFibonacciExpansion(canvas, size, true, data ?? []);
    drawRectangles(canvas, size, true, data ?? []);

    for (int i = mStartIndex; data != null && i <= mStopIndex; i++) {
      KLineEntity? curPoint = data?[i];
      if (curPoint == null) continue;
      KLineEntity lastPoint = i == 0 ? curPoint : data![i - 1];
      double curX = getX(i);
      double lastX = i == 0 ? curX : getX(i - 1);

      mMainRenderer.drawIndicators(
        lastPoint,
        curPoint,
        lastX,
        curX,
        size,
        canvas,
        true,
        true,
      );
    }

    if (isLiveLineMode) {
      // The line and its fill are drawn once, in screen space, so the stroke
      // keeps the same width at every zoom level.
      canvas.restore();
      drawLiveSeries(canvas, size);
      canvas.save();
      canvas.translate(mTranslateX * scaleX + this.chartStyle.leftPadding, 0.0);
      canvas.scale(scaleX, 1.0);
    }

    for (int i = mStartIndex; data != null && i <= mStopIndex; i++) {
      KLineEntity? curPoint = data?[i];
      if (curPoint == null) continue;
      KLineEntity lastPoint = i == 0 ? curPoint : data![i - 1];
      double curX = getX(i);
      double lastX = i == 0 ? curX : getX(i - 1);
      mMainRenderer.drawChart(lastPoint, curPoint, lastX, curX, size, canvas);
      mVolRenderer?.drawChart(lastPoint, curPoint, lastX, curX, size, canvas);
      mSecondaryRendererList.forEach((element) {
        element.drawChart(lastPoint, curPoint, lastX, curX, size, canvas);
      });
    }

    // if (this.chartStyle.isLongFocus &&
    //     ((isLongPress == true || (isTapShowInfoDialog && longPressTriggered)) &&
    //         isTrendLine == false)) {
    //   drawCrossLine(canvas, size);
    // } else if (!this.chartStyle.isLongFocus &&
    //     ((isLongPress == true || (isTapShowInfoDialog && isOnTap)) &&
    //         isTrendLine == false)) {
    //   drawCrossLine(canvas, size);
    // }
    // if (isTrendLine == true) drawTrendLines(canvas, size);

    drawHorizontalLines(canvas, size, false);
    drawTPAndSLLines(canvas, size, false);
    drawCursorLines(canvas, size, data ?? []);
    drawVerticalLines(canvas, size, false, data ?? []);
    drawTrendLines(canvas, size, false, data ?? []);
    drawFibonacciLines(canvas, size, false, data ?? []);
    drawFibonacciTimeZones(canvas, size, false, data ?? []);
    drawFibonacciFan(canvas, size, false, data ?? []);
    drawFibonacciArcs(canvas, size, false, data ?? []);
    drawFibonacciChannel(canvas, size, false, data ?? []);
    drawFibonacciExpansion(canvas, size, false, data ?? []);
    drawRectangles(canvas, size, false, data ?? []);
    drawTradePositions(canvas, size, false, data ?? [], trades);
    canvas.restore();
  }

  @override
  void drawVerticalText(canvas) {
    var textStyle = getTextStyle(this.chartColors.black);
    final main = mMainRenderer;
    if (main is MainRenderer) {
      final price = animator?.price;
      main.avoidY =
          (isLiveStyle && chartStyle.showLivePriceLine && price != null)
              ? getMainY(price)
              : null;
    }
    mMainRenderer.drawVerticalText(canvas, textStyle, this.chartStyle.gridRows);
    mVolRenderer?.drawVerticalText(canvas, textStyle, this.chartStyle.gridRows);
    mSecondaryRendererList.forEach((element) {
      element.drawVerticalText(canvas, textStyle, this.chartStyle.gridRows);
    });
  }

  @override
  void drawDate(Canvas canvas, Size size) {
    if (data == null) return;
    Rect topRect = Rect.fromLTRB(
      0,
      0,
      mMainRect.width + 5.0,
      30.0,
    );

    Rect bottomRect = Rect.fromLTWH(
      0,
      mMainRect.bottom + 1.0,
      mMainRect.width + 5,
      20.0,
    );

    Paint paint = Paint()
      ..color = chartColors.bgColor
      ..style = PaintingStyle.fill;

    canvas.drawRect(topRect, paint);
    if (mSecondaryRendererList.isEmpty) canvas.drawRect(bottomRect, paint);
    double columnSpace = size.rWidth / this.chartStyle.gridColumns;
    double startX = getX(mStartIndex) - mPointWidth / 2;
    double stopX = getX(mStopIndex) + mPointWidth / 2;
    double x = 0.0;
    double y = 0.0;
    const candleSpace = 10.0;
    for (var i = 0; i < this.chartStyle.gridColumns; ++i) {
      double translateX = xToTranslateX(columnSpace * i - candleSpace * i);
      if (translateX >= startX && translateX <= stopX) {
        int index = indexOfTranslateX(translateX);

        if (data?[index] == null) continue;
        final date = getDate(data![index].time);
        TextPainter tp = getTextPainter(date, null);
        y = size.height - (mBottomPadding - tp.height) / 2 - tp.height;

        final tpSpaceCenter = tp.width / 4;
        x = (columnSpace * i) -
            (tpSpaceCenter * i) +
            (tpSpaceCenter / (this.chartStyle.gridColumns - i));
        if (this.chartStyle.gridColumns - 1 == i) {
          x -= tpSpaceCenter / this.chartStyle.gridColumns;
        }
        // Prevent date text out of canvas
        if (x < 0) x = 0;
        if (x > size.rWidth - tp.width) x = size.rWidth - tp.width;
        tp.paint(canvas, Offset(x + this.chartStyle.leftPadding, y));
      }
    }

//    double translateX = xToTranslateX(0);
//    if (translateX >= startX && translateX <= stopX) {
//      TextPainter tp = getTextPainter(getDate(datas[mStartIndex].id));
//      tp.paint(canvas, Offset(0, y));
//    }
//    translateX = xToTranslateX(size.rWidth);
//    if (translateX >= startX && translateX <= stopX) {
//      TextPainter tp = getTextPainter(getDate(datas[mStopIndex].id));
//      tp.paint(canvas, Offset(size.rWidth - tp.width, y));
//    }
  }

  /// draw the cross line. when user focus
  @override
  void drawCrossLineText(Canvas canvas, Size size) {
    var index = calculateSelectedX(selectX);
    KLineEntity point = getItem(index);

    TextPainter tp = getTextPainter(point.close, chartColors.crossTextColor);
    double textHeight = tp.height;
    double textWidth = tp.width;

    double w1 = 5;
    double w2 = 3;
    double r = textHeight / 2 + w2;
    double? y = getMainY(point.close);
    if (y == null) return;
    double x;
    bool isLeft = false;
    if (translateXtoX(getX(index)) < mWidth / 2) {
      isLeft = false;
      x = 1;
      if (chartStyle.isFocusCloseText) {
        Path path = new Path();
        path.moveTo(x, y - r);
        path.lineTo(x, y + r);
        path.lineTo(textWidth + 2 * w1, y + r);
        path.lineTo(textWidth + 2 * w1 + w2, y);
        path.lineTo(textWidth + 2 * w1, y - r);
        path.close();
        canvas.drawPath(path, selectPointPaint);
        canvas.drawPath(path, selectorBorderPaint);
        tp.paint(canvas, Offset(x + w1, y - textHeight / 2));
      }
    } else {
      isLeft = true;
      x = mWidth - textWidth - 1 - 2 * w1 - w2;
      if (chartStyle.isFocusCloseText) {
        Path path = new Path();
        path.moveTo(x, y);
        path.lineTo(x + w2, y + r);
        path.lineTo(mWidth - 2, y + r);
        path.lineTo(mWidth - 2, y - r);
        path.lineTo(x + w2, y - r);
        path.close();
        canvas.drawPath(path, selectPointPaint);
        canvas.drawPath(path, selectorBorderPaint);
        tp.paint(canvas, Offset(x + w1 + w2, y - textHeight / 2));
      }
    }

    TextPainter dateTp =
        getTextPainter(getDate(point.time), chartColors.crossTextColor);
    textWidth = dateTp.width;
    r = textHeight / 2;
    x = translateXtoX(getX(index));
    y = size.height - mBottomPadding;

    if (x < textWidth + 2 * w1) {
      x = 1 + textWidth / 2 + w1;
    } else if (mWidth - x < textWidth + 2 * w1) {
      x = mWidth - 1 - textWidth / 2 - w1;
    }
    double baseLine = textHeight / 2;
    canvas.drawRect(
        Rect.fromLTRB(x - textWidth / 2 - w1, y, x + textWidth / 2 + w1,
            y + baseLine + r),
        selectPointPaint);
    canvas.drawRect(
        Rect.fromLTRB(x - textWidth / 2 - w1, y, x + textWidth / 2 + w1,
            y + baseLine + r),
        selectorBorderPaint);

    dateTp.paint(canvas, Offset(x - textWidth / 2, y));
    //Long press to display the details of this data
    sink.add(InfoWindowEntity(point, isLeft: isLeft));
  }

  @override
  void drawText(Canvas canvas, KLineEntity data, double x) {
    //Long press to display the data in the press
    if (this.chartStyle.isLongFocus &&
        (isLongPress || (isTapShowInfoDialog && longPressTriggered))) {
      var index = calculateSelectedX(selectX);
      data = getItem(index);
    } else if (!this.chartStyle.isLongFocus &&
        (isLongPress || (isTapShowInfoDialog && isOnTap))) {
      var index = calculateSelectedX(selectX);
      data = getItem(index);
    }
    //Release to display the last data
    mMainRenderer.drawText(canvas, data, x);
    mVolRenderer?.drawText(canvas, data, x);
    mSecondaryRendererList.forEach((element) {
      element.drawText(canvas, data, x);
    });
  }

  @override
  void drawMaxAndMin(Canvas canvas) {
    if (isLiveStyle) {
      _drawLiveHints(canvas);
      return;
    }
    if (!this.chartStyle.isShowHighOrLowPoint) return;
    //plot maxima and minima
    double x = translateXtoX(getX(mainRect!.mMainMinIndex));
    double? y = getMainY(mMainLowMinValue);
    if (y == null) return;
    if (x < mWidth / 2) {
      //draw right
      //EMA
      TextPainter tp = getTextPainter(
          // "── " + mMainLowMinValue.toStringAsFixed(fixedLength),
          //   "── " + formatValue(mMainLowMinValue),
          "── ",
          chartColors.minColor, addTextSpan: () {
        final realStyle = getTextStyle(chartColors.minColor);
        final span = formatValueSpan(
            (double.tryParse('${mMainLowMinValue}') ?? 0.0), realStyle);

        return span;
      }, isLeft: true);
      tp.paint(
          canvas, Offset(x + this.chartStyle.leftPadding, y - tp.height / 2));
    } else {
      //EMA
      TextPainter tp = getTextPainter(
          // mMainLowMinValue.toStringAsFixed(fixedLength) + " ──",
          //   formatValue(mMainLowMinValue) + " ──",
          " ──",
          // "",
          chartColors.minColor, addTextSpan: () {
        final realStyle = getTextStyle(chartColors.minColor);
        final span = formatValueSpan(
            (double.tryParse('${mMainLowMinValue}') ?? 0.0), realStyle);

        return span;
      }, isLeft: false);
      tp.paint(
          canvas,
          Offset(
              x + this.chartStyle.leftPadding - tp.width, y - tp.height / 2));
    }
    x = translateXtoX(getX(mainRect!.mMainMaxIndex));
    y = getMainY(mMainHighMaxValue);
    if (y == null) return;
    if (x < mWidth / 2) {
      //draw right
      //EMA
      TextPainter tp = getTextPainter(
          // "── " + mMainHighMaxValue.toStringAsFixed(fixedLength),
          //   "── " + formatValue(mMainHighMaxValue),
          "── ",
          chartColors.maxColor, addTextSpan: () {
        final realStyle = getTextStyle(chartColors.maxColor);
        TextSpan span = formatValueSpan(
            (double.tryParse('${mMainHighMaxValue}') ?? 0.0), realStyle);

        return span;
      }, isLeft: true);
      tp.paint(
          canvas, Offset(x + this.chartStyle.leftPadding, y - tp.height / 2));
    } else {
      //EMA
      TextPainter tp = getTextPainter(
          // mMainHighMaxValue.toStringAsFixed(fixedLength) + " ──",
          //   formatValue(mMainHighMaxValue) + " ──",
          " ──",
          chartColors.maxColor, addTextSpan: () {
        final realStyle = getTextStyle(chartColors.maxColor);
        final span = formatValueSpan(
            (double.tryParse('${mMainHighMaxValue}') ?? 0.0), realStyle);

        return span;
      }, isLeft: false);
      tp.paint(
          canvas,
          Offset(
              x + this.chartStyle.leftPadding - tp.width, y - tp.height / 2));
    }
  }

  void _lineForm(Canvas canvas, Color color, double value) {
    final linePaint = Paint()
      ..strokeWidth = this.chartStyle.nowPriceLineWidth
      ..color = color
      ..isAntiAlias = true;
    drawLine(canvas, linePaint, value);
  }

  @override
  void drawPositionsAndAskBidLines(Canvas canvas) {
    if (data == null) {
      return;
    }
    for (var item in askAndBid) {
      // In the live look ask and bid live on the single live price line.
      final t = item.type.toLowerCase();
      if (isLiveStyle &&
          chartStyle.showLivePriceLine &&
          (t == 'ask' || t == 'bid')) {
        continue;
      }
      _lineForm(canvas, item.color, item.value);
    }
    if (isLiveStyle && chartStyle.showLivePriceLine) {
      drawLivePriceLine(canvas);
    }
    return;
    //view display area boundary value drawing
    // if (y > getMainY(mMainLowMinValue)) {
    //   y = getMainY(mMainLowMinValue);
    // }
    //
    // if (y < getMainY(mMainHighMaxValue)) {
    //   y = getMainY(mMainHighMaxValue);
    // }

    // nowPricePaint
    //   ..color = value >= data!.last.open
    //       ? this.chartColors.nowPriceUpColor
    //       : this.chartColors.nowPriceDnColor;
    // //first draw the horizontal line
    // double startX = 0;
    // final max = -mTranslateX + mWidth / scaleX;
    // final space =
    //     this.chartStyle.nowPriceLineSpan + this.chartStyle.nowPriceLineLength;
    // while (startX < max) {
    //   canvas.drawLine(
    //       Offset(startX, y),
    //       Offset(startX + this.chartStyle.nowPriceLineLength, y),
    //       nowPricePaint);
    //   startX += space;
    // }
    //repaint the background and text
    // TextPainter tp = getTextPainter(
    //   value.toStringAsFixed(fixedLength),
    //   this.chartColors.nowPriceTextColor,
    // );

    // double offsetX;
    // switch (verticalTextAlignment) {
    //   case VerticalTextAlignment.left:
    //     offsetX = mWidth - tp.width;
    //     break;
    //   case VerticalTextAlignment.right:
    //     offsetX = 0;
    //     break;
    // }
    //
    // double offsetX = mWidth - tp.width + this.chartStyle.priceWidth + 4;
    // double top = y - tp.height / 2;
    // canvas.drawRect(
    //   Rect.fromLTRB(
    //       offsetX - 12, top - 2, offsetX + tp.width, top + tp.height + 3),
    //   nowPricePaint,
    // );
    // tp.paint(canvas, Offset(offsetX - 6, top + 2));
  }

  // ── Live line / area ─────────────────────────────────────────────────────

  double _closeAt(int i) => (i == data!.length - 1 && animator?.price != null)
      ? animator!.price!
      : data![i].close;

  /// Extremes used by the hint tags: closes in line/area mode, high/low for
  /// candles. The forming candle uses the animated price.
  double _hiAt(int i) {
    if (isLiveLineMode) return _closeAt(i);
    final h = data![i].high;
    return (i == data!.length - 1 && animator?.price != null)
        ? math.max(h, animator!.price!)
        : h;
  }

  double _loAt(int i) {
    if (isLiveLineMode) return _closeAt(i);
    final l = data![i].low;
    return (i == data!.length - 1 && animator?.price != null)
        ? math.min(l, animator!.price!)
        : l;
  }

  void drawLiveSeries(Canvas canvas, Size size) {
    final d = data!;
    if (d.isEmpty) return;
    final a = animator;
    final last = d.length - 1;
    final from = math.max(0, mStartIndex - 1);
    final to = math.min(last, mStopIndex + 1);

    var pts = <Offset>[];
    for (var i = from; i <= to; i++) {
      var x = getX(i);
      var v = d[i].close;
      if (i == last && a != null) {
        if (a.price != null) v = a.price!; // animated tick
        if (last > 0)
          x = lerpDouble(getX(last - 1), x, a.growT)!; // tip grows in
      }
      final y = getMainY(v);
      if (y == null || y.isNaN) continue;
      pts.add(Offset(translateXtoX(x) + chartStyle.leftPadding, y));
    }
    if (pts.length < 2) return;
    pts = decimate(pts);

    // Seconds frames draw straight segments, as in the reference video.
    final interp = (a?.driftActive ?? false)
        ? chartStyle.secondsLineInterpolation
        : chartStyle.lineInterpolation;
    final path = interp == LineInterpolation.monotone
        ? monotoneCubicPath(pts)
        : (Path()..addPolygon(pts, false));

    canvas.save();
    canvas.clipRect(Rect.fromLTRB(0, 0, mWidth, mMainRect.bottom));

    // Area fill: one polygon, one gradient.
    if (graphStyle == GraphStyle.area) {
      final fill = Path.from(path)
        ..lineTo(pts.last.dx, mMainRect.bottom)
        ..lineTo(pts.first.dx, mMainRect.bottom)
        ..close();
      final topY = pts.map((p) => p.dy).reduce(math.min);
      canvas.drawPath(
        fill,
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              chartColors.areaColor.withAlpha(71), // 0.28
              chartColors.areaColor.withAlpha(0),
            ],
          ).createShader(Rect.fromLTRB(0, topY, mWidth, mMainRect.bottom)),
      );
    }

    final w = chartStyle.areaLineWidth; // constant: no division by scaleX
    if (chartStyle.lineGlow) {
      canvas.drawPath(
        path,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = w + 3
          ..color = chartColors.lineChartColor.withAlpha(64)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
      );
    }
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = w
        ..strokeJoin = StrokeJoin.round
        ..strokeCap = StrokeCap.round
        ..isAntiAlias = true
        ..color = chartColors.lineChartColor,
    );

    // Live tip: pulsing halo + ring + white core (only on the live edge).
    if (to == last) {
      final tip = pts.last;
      if (chartStyle.pulseEndpoint && a != null) {
        final p = a.pulse;
        canvas.drawCircle(
          tip,
          5 + 11 * p,
          Paint()
            ..color = chartColors.lineChartColor
                .withAlpha((255 * 0.35 * (1 - p)).round()),
        );
      }
      canvas.drawCircle(tip, 4.5, Paint()..color = chartColors.lineChartColor);
      canvas.drawCircle(tip, 2.5, Paint()..color = const Color(0xFFFFFFFF));
    }
    canvas.restore();
  }

  void drawLivePriceLine(Canvas canvas) {
    final a = animator;
    final price = a?.price;
    if (a == null || price == null) return;
    final y = getMainY(price);
    if (y == null || y.isNaN) return;
    final c = chartColors;
    final fullW = mWidth + chartStyle.priceWidth;

    // 1. The single line.
    canvas.drawLine(
      Offset(0, y),
      Offset(fullW, y),
      Paint()
        ..color = c.lineChartColor
        ..strokeWidth = 1
        ..isAntiAlias = true,
    );

    // 2. Pill.
    final tp = getTextPainter(
      price.toStringAsFixed(chartStyle.digits),
      c.livePillTextColor,
      sizeText: chartStyle.sizeText + 2,
      fontWeight: FontWeight.w600,
    );
    final h = tp.height + 8, w = tp.width + 20;
    final onLeft = verticalTextAlignment == VerticalTextAlignment.left;
    final left = onLeft ? 4.0 : fullW - w - 4;
    final rect = Rect.fromLTWH(left, y - h / 2, w, h);
    final rr = RRect.fromRectAndRadius(rect, Radius.circular(h / 2));
    _pillRect = rect;

    Color pillColor = c.livePillColor;
    if (chartStyle.flashPillOnTick && a.direction != 0) {
      final flash = a.direction > 0 ? c.askTextColor : c.bidTextColor;
      pillColor = Color.lerp(flash, c.livePillColor, a.tickT)!;
    }
    canvas.drawRRect(
      rr.shift(const Offset(0, 2)),
      Paint()
        ..color = const Color(0x59000000)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );
    canvas.drawRRect(rr, Paint()..color = pillColor);
    tp.paint(canvas, Offset(left + (w - tp.width) / 2, y - tp.height / 2));

    // 3. Ask above, bid below.
    void side(String txt, Color color, bool above) {
      final t = getTextPainter(txt, color, fontWeight: FontWeight.w500);
      final x = onLeft ? rect.right + 6 : rect.left - 6 - t.width;
      final ty = above ? y - 2 - t.height : y + 2;
      t.paint(canvas, Offset(x, ty));
    }

    final dg = chartStyle.digits;
    if (a.ask != null) {
      side('▲ ${a.ask!.toStringAsFixed(dg)}', c.askTextColor, true);
    }
    if (a.bid != null) {
      side('▼ ${a.bid!.toStringAsFixed(dg)}', c.bidTextColor, false);
    }
  }

  void _drawLiveHints(Canvas canvas) {
    if (!chartStyle.showPriceHints || data == null || data!.isEmpty) return;
    int hi = mStartIndex, lo = mStartIndex;
    for (var i = mStartIndex; i <= mStopIndex; i++) {
      if (_hiAt(i) > _hiAt(hi)) hi = i;
      if (_loAt(i) < _loAt(lo)) lo = i;
    }
    _hintTag(canvas, hi, _hiAt(hi), above: true);
    if (lo != hi) _hintTag(canvas, lo, _loAt(lo), above: false);
  }

  void _hintTag(Canvas canvas, int i, double v, {required bool above}) {
    final y = getMainY(v);
    if (y == null || y.isNaN) return;
    final x = translateXtoX(getX(i)) + chartStyle.leftPadding;
    final tp = getTextPainter(
      v.toStringAsFixed(chartStyle.digits),
      chartColors.hintTextColor,
    );
    final w = tp.width + 10, h = tp.height + 4;
    final maxLeft = mWidth - w - 2;
    final left =
        maxLeft <= 2 ? 2.0 : (x - w / 2).clamp(2.0, maxLeft).toDouble();
    final top = above ? y - h - 8 : y + 8;
    final r = Rect.fromLTWH(left, top, w, h);
    if (_pillRect != null && _pillRect!.inflate(2).overlaps(r)) return;
    canvas.drawRRect(
      RRect.fromRectAndRadius(r, const Radius.circular(4)),
      Paint()..color = chartColors.hintBgColor,
    );
    tp.paint(canvas, Offset(left + 5, top + 2));
  }

  @override
  void drawExpiryLine(Canvas canvas, Size size) {
    final t = chartStyle.expiryTime;
    if (!isLiveStyle || t == null || data == null || data!.length < 2) {
      return;
    }
    final last = data!.length - 1;
    // Candle times are in seconds, the expiry is in milliseconds.
    final tSec = t / 1000;
    final interval = math.max(1, data![last].time - data![last - 1].time);
    final xData =
        getX(last) + (tSec - data![last].time) / interval * mPointWidth;
    final x = translateXtoX(xData) + chartStyle.leftPadding;
    if (x < 0 || x > mWidth) return;
    canvas.drawLine(
      Offset(x, mTopPadding),
      Offset(x, size.height - mBottomPadding),
      Paint()
        ..color = chartColors.expiryLineColor
        ..strokeWidth = 1,
    );
  }

  void drawLine(
    Canvas canvas,
    Paint paint,
    double price,
  ) {
    if (price <= this.chartPosition.topPrice &&
        price >= this.chartPosition.bottomPrice) {
      double? y = getMainY(price);
      if (y == null) return;
      //view display area boundary value drawing
      // if (y > getMainY(mMainLowMinValue)) {
      //   y = getMainY(mMainLowMinValue);
      // }
      //
      // if (y < getMainY(mMainHighMaxValue)) {
      //   y = getMainY(mMainHighMaxValue);
      // }

      double startX = 0;
      final max = -mTranslateX + mWidth / scaleX;
      canvas.drawLine(Offset(startX, y), Offset(max, y), paint);
      //repaint the background and text
      TextPainter tp = getTextPainter(
        price.toStringAsFixed(fixedLength),
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
            offsetX - 12,
            top - 2,
            offsetX + tp.width * 1.5,
            top + tp.height + 3,
          ),
          const Radius.circular(8.0),
        ),
        paint,
      );
      tp.paint(canvas, Offset(offsetX, top));
    }
  }

  void drawCrossLine(Canvas canvas, Size size) {
    var index = calculateSelectedX(selectX);
    KLineEntity point = getItem(index);
    Paint paintY = Paint()
      ..color = this.chartColors.vCrossColor
      ..strokeWidth = this.chartStyle.vCrossWidth
      ..isAntiAlias = true;
    double x = getX(index);
    double? y = getMainY(point.close);
    if (y == null) return;

    // Draw vertical dashed line
    drawDashedLine(canvas, Offset(x, mTopPadding),
        Offset(x, size.height - mBottomPadding), paintY);

    Paint paintX = Paint()
      ..color = this.chartColors.hCrossColor
      ..strokeWidth = this.chartStyle.hCrossWidth
      ..isAntiAlias = true;

    // Draw horizontal dashed line
    drawDashedLine(canvas, Offset(-mTranslateX, y),
        Offset(-mTranslateX + mWidth / scaleX, y), paintX);

    if (scaleX >= 1) {
      canvas.drawOval(
        Rect.fromCenter(center: Offset(x, y), height: 2.0 * scaleX, width: 2.0),
        paintX,
      );
    } else {
      canvas.drawOval(
        Rect.fromCenter(center: Offset(x, y), height: 2.0, width: 2.0 / scaleX),
        paintX,
      );
    }
  }

  void drawDashedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    const double dashWidth = 3;
    const double dashSpace = 2;
    double distance = (end - start).distance;
    double dashCount = (distance / (dashWidth + dashSpace)).floorToDouble();

    for (int i = 0; i < dashCount; ++i) {
      double startX = start.dx + (end.dx - start.dx) * (i / dashCount);
      double startY = start.dy + (end.dy - start.dy) * (i / dashCount);
      double endX = start.dx + (end.dx - start.dx) * ((i + 0.5) / dashCount);
      double endY = start.dy + (end.dy - start.dy) * ((i + 0.5) / dashCount);
      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
    }
  }
}
