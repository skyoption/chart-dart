import 'dart:async' show StreamSink;

import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/entity/line_entity.dart';
import 'package:candle_chart/renderer/chart_details.dart';
import 'package:candle_chart/renderer/objects/draw_horizontal_lines.dart';
import 'package:candle_chart/renderer/objects/draw_rectangle_lines.dart';
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
        DrawRectangleLines,
        UpdatePointPosition,
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
  final double screenHeight;
  double mMainHighMaxValue = double.minPositive,
      mMainLowMinValue = double.maxFinite;
  final double scaleX;
  final double scaleY;
  final GraphStyle graphStyle;
  final List<LineEntity> askAndBid;

  ChartPainter(
    this.chartStyle,
    this.chartColors, {
    required this.screenHeight,
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
  void initChartRenderer(double height) {
    if (data != null && data!.isNotEmpty) {
      var t = data![0];
      fixedLength =
          NumberUtil.getMaxDecimalLength(t.open, t.close, t.high, t.low);
    }
    if (secondaryIndicators.isNotEmpty) {
      this.chartStyle.gridRows = 24 ~/ secondaryIndicators.length;
    } else {
      this.chartStyle.gridRows = 18;
    }
    mMainRenderer = MainRenderer(
      mMainRect,
      mainRect!.mMainMaxValue / scaleY,
      mainRect!.mMainMinValue * scaleY,
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
    );

    if (mVolRect != null) {
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
    mMainRenderer.drawGrid(canvas, mGridRows ~/ 2, mGridColumns);
    mVolRenderer?.drawGrid(canvas, mGridRows ~/ 2, mGridColumns);
    mSecondaryRendererList.forEach((element) {
      element.drawGrid(canvas, mGridRows ~/ 2, mGridColumns);
    });
    // }
  }

  @override
  void drawChart(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(mTranslateX * scaleX + this.chartStyle.leftPadding, 0.0);
    canvas.scale(scaleX, 1.0);

    drawHorizontalLines(canvas, size, true);
    drawVerticalLines(canvas, size, true, data ?? []);
    drawTrendLines(canvas, size, true, data ?? []);
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
    drawVerticalLines(canvas, size, false, data ?? []);
    drawTrendLines(canvas, size, false, data ?? []);
    drawRectangles(canvas, size, false, data ?? []);

    canvas.restore();
  }

  @override
  void drawVerticalText(canvas) {
    var textStyle = getTextStyle(this.chartColors.black);
    mMainRenderer.drawVerticalText(canvas, textStyle, mGridRows);
    mVolRenderer?.drawVerticalText(canvas, textStyle, mGridRows);
    mSecondaryRendererList.forEach((element) {
      element.drawVerticalText(canvas, textStyle, mGridRows);
    });
  }

  @override
  void drawDate(Canvas canvas, Size size) {
    if (data == null) return;

    double columnSpace = size.rWidth / mGridColumns;
    double startX = getX(mStartIndex) - mPointWidth / 2;
    double stopX = getX(mStopIndex) + mPointWidth / 2;
    double x = 0.0;
    double y = 0.0;
    const candleSpace = 10.0;
    for (var i = 0; i < mGridColumns; ++i) {
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
            (tpSpaceCenter / (mGridColumns - i));
        if (mGridColumns - 1 == i) {
          x -= tpSpaceCenter / mGridColumns;
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
    double y = getMainY(point.close);
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
    // if (isLine == true) return;
    if (!this.chartStyle.isShowHighOrLowPoint) return;
    //plot maxima and minima
    double x = translateXtoX(getX(mainRect!.mMainMinIndex));
    double y = getMainY(mMainLowMinValue);
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
      _lineForm(canvas, item.color, item.value);
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

  void drawLine(
    Canvas canvas,
    Paint paint,
    double price,
  ) {
    if (price <= this.chartPosition.topPrice &&
        price >= this.chartPosition.bottomPrice) {
      double y = getMainY(price);
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

      // switch (verticalTextAlignment) {
      //   case VerticalTextAlignment.left:
      //     offsetX = mWidth - tp.width;
      //     break;
      //   case VerticalTextAlignment.right:
      //     offsetX = 0;
      //     break;
      // }

      double offsetX = mWidth - tp.width + this.chartStyle.priceWidth + 4;

      double top = y - tp.height / 2;
      canvas.drawRect(
        Rect.fromLTRB(
            offsetX - 12, top - 2, offsetX + tp.width, top + tp.height + 3),
        paint,
      );
      tp.paint(canvas, Offset(offsetX - 6, top + 2));
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
    double y = getMainY(point.close);

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
