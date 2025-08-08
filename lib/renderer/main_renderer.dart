import 'dart:ui';

import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/renderer/rects/render_rect.dart';
import 'package:candle_chart/utils/kprint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../entity/candle_entity.dart';
import '../k_chart_widget.dart' show GraphStyle, IndicatorType;
import 'base_chart_renderer.dart';

enum VerticalTextAlignment { left, right }

//For TrendLine
double? trendLineMax;
double? trendLineScale;
double? trendLineContentRec;

class MainRenderer extends BaseChartRenderer<CandleEntity> {
  late double mCandleWidth;
  late double mCandleLineWidth;

  late Rect _contentRect;
  double _contentPadding = 5.0;

  final bool hideGrid;
  final ChartStyle chartStyle;
  final ChartPosition chartPositions;
  final ChartColors chartColors;
  final double scaleX;
  double scaleY;
  late Paint mLinePaint;
  final VerticalTextAlignment verticalTextAlignment;
  final List<IndicatorEntity> indicators;
  late final SubMainRenderer subMainRenderer;
  final GraphStyle graphStyle;
  final bool hideIndicators;

  MainRenderer(
    Rect mainRect,
    double maxValue,
    double minValue,
    double topPadding,
    this.chartPositions,
    int fixedLength,
    this.chartStyle,
    this.chartColors,
    this.scaleX,
    this.scaleY,
    this.hideGrid,
    this.verticalTextAlignment,
    this.indicators,
    this.graphStyle,
    this.hideIndicators,
  ) : super(
            chartRect: mainRect,
            maxValue: maxValue,
            chartStyle: chartStyle,
            minValue: minValue,
            topPadding: topPadding,
            fixedLength: fixedLength,
            gridColor: chartColors.gridColor) {
    chartPositions.bottomPrice = minValue;
    chartPositions.topPrice = maxValue;
    subMainRenderer = SubMainRenderer(
      mainRect,
      maxValue,
      minValue,
      topPadding,
      fixedLength,
      chartStyle,
      chartColors,
      indicators,
      scaleX,
    );

    mCandleWidth = this.chartStyle.candleWidth;
    mCandleLineWidth = this.chartStyle.candleLineWidth;
    mLinePaint = Paint()
      ..isAntiAlias = true
      ..filterQuality = FilterQuality.high
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square
      ..strokeJoin = StrokeJoin.miter
      ..color = this.chartColors.lineChartColor;
    _contentRect = Rect.fromLTRB(
      chartRect.left,
      chartRect.top + _contentPadding,
      chartRect.right,
      chartRect.bottom - _contentPadding,
    );

    if (maxValue == minValue) {
      maxValue *= 1.5;
      minValue /= 2;
    }
    scaleY = _contentRect.height / (maxValue - minValue);
    maxValue *= scaleY;
    minValue /= scaleY;
  }

  @override
  void drawChart(
    CandleEntity lastPoint,
    CandleEntity curPoint,
    double lastX,
    double curX,
    Size size,
    Canvas canvas,
  ) {
    if (graphStyle == GraphStyle.candles) {
      drawCandle(curPoint, canvas, curX);
    } else {
      drawPolyline(lastPoint.close, curPoint.close, canvas, lastX, curX);
    }
    if (!hideIndicators) {
      drawIndicators(
        lastPoint,
        curPoint,
        lastX,
        curX,
        size,
        canvas,
        false,
        true,
      );
    }
  }

  @override
  void drawIndicators(
    CandleEntity lastPoint,
    CandleEntity curPoint,
    double lastX,
    double curX,
    Size size,
    Canvas canvas,
    bool drawAsBackground,
    bool isMain,
  ) {
    subMainRenderer.drawIndicators(
      lastPoint,
      curPoint,
      lastX,
      curX,
      size,
      canvas,
      drawAsBackground,
      isMain,
    );
  }

  Shader? mLineFillShader;
  Path? mLinePath, mLineFillPath;
  Paint mLineFillPaint = Paint()
    ..style = PaintingStyle.fill
    ..isAntiAlias = true
    ..filterQuality = FilterQuality.high;

  /// Draws a polyline chart (line or area chart)
  ///
  /// This method ensures:
  /// - Consistent stroke width across zoom levels (no scaling by scaleX)
  /// - Smooth, even thickness everywhere (StrokeCap.round, StrokeJoin.round)
  void drawPolyline(
    double lastPrice,
    double curPrice,
    Canvas canvas,
    double lastX,
    double curX,
  ) {
    double baseWidth = chartStyle.areaLineWidth; // e.g., 2.0
    double strokeWidth = (baseWidth / scaleX).clamp(0.7, 4.0);
    mLinePath ??= Path();
    if (lastX == curX) lastX = 0;
    mLinePath!.moveTo(lastX, getY(lastPrice));
    mLinePath!.cubicTo(
      (lastX + curX) / 2,
      getY(lastPrice),
      (lastX + curX) / 2,
      getY(curPrice),
      curX,
      getY(curPrice),
    );

    if (graphStyle == GraphStyle.area) {
      mLineFillShader ??= LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        tileMode: TileMode.clamp,
        colors: [
          this.chartColors.areaColor.withAlpha(95),
          this.chartColors.areaColor.withAlpha(1),
        ],
      ).createShader(Rect.fromLTRB(
          chartRect.left, chartRect.top, chartRect.right, chartRect.bottom));
      mLineFillPaint..shader = mLineFillShader;

      mLineFillPath ??= Path();
      mLineFillPath!.moveTo(lastX, chartRect.height + chartRect.top);
      mLineFillPath!.lineTo(lastX, getY(lastPrice));
      mLineFillPath!.cubicTo(
        (lastX + curX) / 2,
        getY(lastPrice),
        (lastX + curX) / 2,
        getY(curPrice),
        curX,
        getY(curPrice),
      );
      mLineFillPath!.lineTo(curX, chartRect.height + chartRect.top);
      mLineFillPath!.close();

      canvas.drawPath(mLineFillPath!, mLineFillPaint);
      mLineFillPath!.reset();
    }
    mLinePaint..strokeWidth = strokeWidth;
    canvas.drawPath(mLinePath!, mLinePaint);
    mLinePath!.reset();
  }

  void drawCandle(CandleEntity curPoint, Canvas canvas, double curX) {
    var high = getY(curPoint.high);
    var low = getY(curPoint.low);
    var open = getY(curPoint.open);
    var close = getY(curPoint.close);
    double r = mCandleWidth / 2;
    double lineR = mCandleLineWidth / 2;
    if (open >= close) {
      if (open - close < mCandleLineWidth) {
        open = close + mCandleLineWidth;
      }
      chartPaint.color = this.chartColors.upColor;
      canvas.drawRect(
          Rect.fromLTRB(curX - r, close, curX + r, open), chartPaint);
      canvas.drawRect(
          Rect.fromLTRB(curX - lineR, high, curX + lineR, low), chartPaint);
    } else if (close > open) {
      if (close - open < mCandleLineWidth) {
        open = close - mCandleLineWidth;
      }
      chartPaint.color = this.chartColors.dnColor;
      canvas.drawRect(
          Rect.fromLTRB(curX - r, open, curX + r, close), chartPaint);
      canvas.drawRect(
          Rect.fromLTRB(curX - lineR, high, curX + lineR, low), chartPaint);
    }
  }

  @override
  void drawVerticalText(canvas, textStyle, int gridRows) {
    double rowSpace = chartRect.height / gridRows;

    Rect rect = Rect.fromLTWH(
      chartRect.width,
      topPadding,
      100.0,
      chartRect.height,
    );

    Paint paint = Paint()
      ..color = chartColors.bgColor
      ..style = PaintingStyle.fill;

    canvas.drawRect(rect, paint);

    for (var i = 0; i <= gridRows; ++i) {
      double price = (gridRows - i) * rowSpace / scaleY + minValue;
      String value = '$price';
      if (value.split('.').last.length < chartStyle.digits) {
        value = '${value}000000001';
        price = double.parse(value);
      }
      if (i == 0) {
        chartPositions.topPrice = price;
      }
      if (i == gridRows) {
        chartPositions.bottomPrice = price;
      }
      final realStyle = getTextStyle(chartColors.maxColor);
      TextSpan span = formatValueSpan(price, realStyle);

      TextPainter tp =
          TextPainter(text: span, textDirection: TextDirection.ltr);
      tp.layout();

      double offsetX;
      switch (verticalTextAlignment) {
        case VerticalTextAlignment.left:
          offsetX = this.chartStyle.leftPadding;
          break;
        case VerticalTextAlignment.right:
          offsetX = chartRect.width -
              tp.width -
              this.chartStyle.rightPadding +
              this.chartStyle.priceWidth;
          break;
      }

      if (i == 0 && this.chartStyle.isShowLeftTopicPoint) {
        tp.paint(canvas, Offset(offsetX, 23.0));
      } else {
        if (this.chartStyle.isShowLeftTopicPoint || i > 0)
          tp.paint(canvas,
              Offset(offsetX, rowSpace * i - (tp.height * 0.7) + topPadding));
      }
    }
  }

  @override
  void drawGrid(Canvas canvas, int gridRows, int gridColumns, double width,
      double height) {
    if (!hideGrid) {
      double cellSize = height / gridRows;
      double rowSpace = cellSize;
      double columnSpace = cellSize;

      int gridColumns = (width / cellSize).floor() + 1;

      double startX = width - (gridColumns * cellSize);

      for (int i = 0; i < gridRows; i++) {
        double yPos = chartRect.bottom - (rowSpace * i);
        canvas.drawLine(
          Offset(startX, yPos),
          Offset(width, yPos),
          gridPaint,
        );
      }

      for (int i = 0; i <= gridColumns; i++) {
        double xPos = startX + (columnSpace * i);
        canvas.drawLine(
          Offset(xPos, chartRect.top),
          Offset(xPos, chartRect.bottom),
          gridPaint,
        );
      }
    } else {
      // Draw border lines when grid is hidden
    
      // Bottom border
      canvas.drawLine(
        Offset(chartRect.left, chartRect.bottom),
        Offset(chartRect.right, chartRect.bottom),
        gridPaint..strokeWidth = 1,
      );

      // Left border
      canvas.drawLine(
        Offset(chartRect.left, chartRect.top),
        Offset(chartRect.left, chartRect.bottom),
        gridPaint..strokeWidth = 1,
      );

      // Right border
      canvas.drawLine(
        Offset(chartRect.right, chartRect.top),
        Offset(chartRect.right, chartRect.bottom),
        gridPaint..strokeWidth = 1,
      );
    }
  }

  @override
  double getY(double y) {
    updateTrendLineData();
    return (maxValue - y) * scaleY + _contentRect.top;
  }

  void updateTrendLineData() {
    trendLineMax = maxValue;
    trendLineScale = scaleY;
    trendLineContentRec = _contentRect.top;
  }

  @override
  void drawText(Canvas canvas, CandleEntity data, double x) {
    return;
    // if (isLine == true) return;
    // TextSpan? span;
    // if (state == MainState.MA) {
    //   // span = TextSpan(
    //   //   children: _createMATextSpan(data),
    //   // );
    //   String value = '${format((data.maValues ?? [0])[0])}';
    //   span = TextSpan(
    //     children: [
    //       TextSpan(
    //         children: _createMATextSpan(data),
    //       ),
    //       if (this.chartStyle.isShowEma && value.length <= 13)
    //         //EMA
    //         TextSpan(text: '\n'),
    //       if (this.chartStyle.isShowEma)
    //         TextSpan(
    //           children: _createEMATextSpan(data),
    //         ),
    //     ],
    //   );
    // } else if (state == MainState.BOLL) {
    //   span = TextSpan(
    //     children: [
    //       if (data.up != 0)
    //         TextSpan(
    //             text: "BOLL:${format(data.mb)}    ",
    //             style: getTextStyle(this.chartColors.ma5Color)),
    //       if (data.mb != 0)
    //         TextSpan(
    //             text: "UB:${format(data.up)}    ",
    //             style: getTextStyle(this.chartColors.ma10Color)),
    //       if (data.dn != 0)
    //         TextSpan(
    //             text: "LB:${format(data.dn)}    ",
    //             style: getTextStyle(this.chartColors.ma30Color)),
    //     ],
    //   );
    // }
    // if (span == null) return;
    // TextPainter tp = TextPainter(text: span, textDirection: TextDirection.ltr);
    // tp.layout();
    // if (this.chartStyle.isShowStrategyTypeTop) {
    //   tp.paint(canvas, Offset(x, chartRect.top - topPadding));
    // }
  }
}

class SubMainRenderer extends BaseChartRenderer<CandleEntity> {
  final ChartStyle chartStyle;
  final ChartColors chartColors;
  final List<IndicatorEntity> indicators;
  final double scaleX;
  SubMainRenderer(
    Rect mainRect,
    double maxValue,
    double minValue,
    double topPadding,
    int fixedLength,
    this.chartStyle,
    this.chartColors,
    this.indicators,
    this.scaleX,
  ) : super(
          chartRect: mainRect,
          maxValue: maxValue,
          chartStyle: chartStyle,
          minValue: minValue,
          topPadding: topPadding,
          fixedLength: fixedLength,
          gridColor: chartColors.gridColor,
        );

  @override
  void drawChart(
    CandleEntity lastPoint,
    CandleEntity curPoint,
    double lastX,
    double curX,
    Size size,
    Canvas canvas,
  ) {
    drawIndicators(
      lastPoint,
      curPoint,
      lastX,
      curX,
      size,
      canvas,
      false,
      true,
    );
  }

  @override
  void drawIndicators(
    CandleEntity lastPoint,
    CandleEntity curPoint,
    double lastX,
    double curX,
    Size size,
    Canvas canvas,
    bool drawAsBackground,
    bool isMain,
  ) {
    for (var item in indicators) {
      if (item.type == IndicatorType.MA_EMA &&
          item.drawAsBackground == drawAsBackground) {
        drawEMA_MA(
          lastPoint,
          curPoint,
          canvas,
          lastX,
          curX,
          item.period,
          item.windowId,
        );
      } else if (item.type == IndicatorType.MA_LINEAR &&
          item.drawAsBackground == drawAsBackground) {
        drawLINEAR_MA(
          lastPoint,
          curPoint,
          canvas,
          lastX,
          curX,
          item.period,
          item.windowId,
        );
      } else if (item.type == IndicatorType.MA_SMA &&
          item.drawAsBackground == drawAsBackground) {
        drawSMA_MA(
          lastPoint,
          curPoint,
          canvas,
          lastX,
          curX,
          item.period,
          item.windowId,
        );
      } else if (item.type == IndicatorType.MA_SMMA &&
          item.drawAsBackground == drawAsBackground) {
        drawSMMA_MA(
          lastPoint,
          curPoint,
          canvas,
          lastX,
          curX,
          item.period,
          item.windowId,
        );
      } else if (item.type == IndicatorType.ENVELOPS_EMA &&
          item.drawAsBackground == drawAsBackground) {
        drawEMA_ENVELOPS(
          lastPoint,
          curPoint,
          canvas,
          lastX,
          curX,
          item.period,
          item.windowId,
        );
      } else if (item.type == IndicatorType.ENVELOPS_LINEAR &&
          item.drawAsBackground == drawAsBackground) {
        drawLINEAR_ENVELOPS(
          lastPoint,
          curPoint,
          canvas,
          lastX,
          curX,
          item.period,
          item.windowId,
        );
      } else if (item.type == IndicatorType.ENVELOPS_SMA &&
          item.drawAsBackground == drawAsBackground) {
        drawSMA_ENVELOPS(
          lastPoint,
          curPoint,
          canvas,
          lastX,
          curX,
          item.period,
          item.windowId,
        );
      } else if (item.type == IndicatorType.ENVELOPS_SMMA &&
          item.drawAsBackground == drawAsBackground) {
        drawSMMA_ENVELOPS(
          lastPoint,
          curPoint,
          canvas,
          lastX,
          curX,
          item.period,
          item.windowId,
        );
      } else if (item.type == IndicatorType.BOLL &&
          item.drawAsBackground == drawAsBackground) {
        drawBollLine(
          lastPoint,
          curPoint,
          canvas,
          lastX,
          curX,
          item.period,
          item.windowId,
        );
      } else if (item.type == IndicatorType.PARABOLIC &&
          item.drawAsBackground == drawAsBackground) {
        drawParabolicLine(
          lastPoint,
          curPoint,
          canvas,
          lastX,
          curX,
          item.period,
          item.windowId,
        );
      } else if (item.type == IndicatorType.ICHIMOKU &&
          item.drawAsBackground == drawAsBackground) {
        drawIchimokuLine(
          lastPoint,
          curPoint,
          canvas,
          lastX,
          curX,
          item.period,
          item.windowId,
        );
      }
    }
  }

  void drawEMA_MA(
    CandleEntity lastPoint,
    CandleEntity curPoint,
    Canvas canvas,
    double lastX,
    double curX,
    int period,
    int id,
  ) {
    for (int i = 0; i < (curPoint.maEmaValues?.length ?? 0); i++) {
      final isShow = id == curPoint.maEmaValues![i].windowId;
      if ((lastPoint.maEmaValues?.length ?? 0) - 1 >= i &&
          lastPoint.maEmaValues?[i].value != 0 &&
          period == curPoint.maEmaValues?[i].period &&
          isShow) {
        drawLine(
          lastPoint.maEmaValues?[i].value,
          curPoint.maEmaValues?[i].value,
          canvas,
          lastX,
          curX,
          colorFromHex(curPoint.maEmaValues![i].color!)!,
          lineStyle: curPoint.maEmaValues![i].style,
          baseStrokeWidth: curPoint.maEmaValues![i].strokeWidth,
          scaleX: scaleX,
        );
      }
    }
  }

  void drawLINEAR_MA(
    CandleEntity lastPoint,
    CandleEntity curPoint,
    Canvas canvas,
    double lastX,
    double curX,
    int period,
    int id,
  ) {
    for (int i = 0; i < (curPoint.maLwmaValues?.length ?? 0); i++) {
      final isShow = id == curPoint.maLwmaValues![i].windowId;
      if ((lastPoint.maLwmaValues?.length ?? 0) - 1 >= i &&
          lastPoint.maLwmaValues?[i].value != 0 &&
          period == curPoint.maLwmaValues?[i].period &&
          isShow) {
        drawLine(
          lastPoint.maLwmaValues?[i].value,
          curPoint.maLwmaValues?[i].value,
          canvas,
          lastX,
          curX,
          colorFromHex(curPoint.maLwmaValues![i].color!)!,
          lineStyle: curPoint.maLwmaValues![i].style,
          baseStrokeWidth: curPoint.maLwmaValues![i].strokeWidth,
          scaleX: scaleX,
        );
      }
    }
  }

  void drawSMA_MA(
    CandleEntity lastPoint,
    CandleEntity curPoint,
    Canvas canvas,
    double lastX,
    double curX,
    int period,
    int id,
  ) {
    for (int i = 0; i < (curPoint.maSmaValues?.length ?? 0); i++) {
      final isShow = id == curPoint.maSmaValues![i].windowId;
      if ((lastPoint.maSmaValues?.length ?? 0) - 1 >= i &&
          lastPoint.maSmaValues?[i].value != 0 &&
          period == curPoint.maSmaValues?[i].period &&
          isShow) {
        drawLine(
          lastPoint.maSmaValues?[i].value,
          curPoint.maSmaValues?[i].value,
          canvas,
          lastX,
          curX,
          colorFromHex(curPoint.maSmaValues![i].color!)!,
          lineStyle: curPoint.maSmaValues![i].style,
          baseStrokeWidth: curPoint.maSmaValues![i].strokeWidth,
          scaleX: scaleX,
        );
      }
    }
  }

  void drawSMMA_MA(
    CandleEntity lastPoint,
    CandleEntity curPoint,
    Canvas canvas,
    double lastX,
    double curX,
    int period,
    int id,
  ) {
    for (int i = 0; i < (curPoint.maSmmaValues?.length ?? 0); i++) {
      final isShow = id == curPoint.maSmmaValues![i].windowId;
      if ((lastPoint.maSmmaValues?.length ?? 0) - 1 >= i &&
          lastPoint.maSmmaValues?[i].value != 0 &&
          period == curPoint.maSmmaValues?[i].period &&
          isShow) {
        drawLine(
          lastPoint.maSmmaValues?[i].value,
          curPoint.maSmmaValues?[i].value,
          canvas,
          lastX,
          curX,
          colorFromHex(curPoint.maSmmaValues![i].color!)!,
          lineStyle: curPoint.maSmmaValues![i].style,
          baseStrokeWidth: curPoint.maSmmaValues![i].strokeWidth,
          scaleX: scaleX,
        );
      }
    }
  }

  void drawParabolicLine(
    CandleEntity lastPoint,
    CandleEntity curPoint,
    Canvas canvas,
    double lastX,
    double curX,
    int period,
    int id,
  ) {
    for (int i = 0; i < (curPoint.parabolicValues?.length ?? 0); i++) {
      final isShow = id == curPoint.parabolicValues?[i].windowId;
      if (isShow) {
        drawLine(
          lastPoint.parabolicValues?[i].value,
          curPoint.parabolicValues?[i].value,
          canvas,
          lastX,
          curX,
          colorFromHex(curPoint.parabolicValues![i].color!)!,
          lineStyle: curPoint.parabolicValues![i].style,
          baseStrokeWidth: 4.0,
          scaleX: scaleX,
          isDot: true,
        );
      }
    }
  }

  void drawIchimokuLine(
    CandleEntity lastPoint,
    CandleEntity curPoint,
    Canvas canvas,
    double lastX,
    double curX,
    int period,
    int id,
  ) {
    ///-- for drawing background of SpanA and SpanB
    for (int i = 0; i < (curPoint.ichimokuValues?.length ?? 0); i++) {
      final isShow = id == curPoint.ichimokuValues![i].windowId;
      List<Offset> senkouSpanAOffsets = [], senkouSpanBOffsets = [];
      if (curPoint.ichimokuValues != null &&
          lastPoint.ichimokuValues != null &&
          curPoint.ichimokuValues![i].senkouSpanA != null &&
          isShow) {
        double SpanAY = getY(curPoint.ichimokuValues![i].senkouSpanA!);
        double lastSpanAY = getY(lastPoint.ichimokuValues![i].senkouSpanA!);
        double SpanBY = getY(curPoint.ichimokuValues![i].senkouSpanB!);
        double lastSpanBY = getY(lastPoint.ichimokuValues![i].senkouSpanB!);
        senkouSpanAOffsets.addAll([
          Offset(curX, SpanAY),
          Offset(lastX, lastSpanAY),
        ]);
        senkouSpanBOffsets.addAll([
          Offset(lastX, lastSpanBY),
          Offset(curX, SpanBY),
        ]);
        drawRect(
          [...senkouSpanAOffsets, ...senkouSpanBOffsets],
          Colors.green.withAlpha(20),
          canvas,
        );
      }
    }

    ///--
    for (int i = 0; i < (curPoint.ichimokuValues?.length ?? 0); i++) {
      final isShow = id == curPoint.ichimokuValues![i].windowId;
      if (isShow) {
        drawLine(
          lastPoint.ichimokuValues?[i].tenkanSen,
          curPoint.ichimokuValues?[i].tenkanSen,
          canvas,
          lastX,
          curX,
          colorFromHex(curPoint.ichimokuValues![i].ichimoku!.tenkanSenColor!)!,
          lineStyle: curPoint.ichimokuValues![i].style,
          baseStrokeWidth: curPoint.ichimokuValues![i].strokeWidth,
          scaleX: scaleX,
        );
        drawLine(
          lastPoint.ichimokuValues?[i].chikouSpan,
          curPoint.ichimokuValues?[i].chikouSpan,
          canvas,
          lastX,
          curX,
          colorFromHex(curPoint.ichimokuValues![i].ichimoku!.chikouSpanColor!)!,
          lineStyle: curPoint.ichimokuValues![i].style,
          baseStrokeWidth: curPoint.ichimokuValues![i].strokeWidth,
          scaleX: scaleX,
        );
        drawLine(
          lastPoint.ichimokuValues?[i].kijunSen,
          curPoint.ichimokuValues?[i].kijunSen,
          canvas,
          lastX,
          curX,
          colorFromHex(curPoint.ichimokuValues![i].ichimoku!.kijuSenColor!)!,
          lineStyle: curPoint.ichimokuValues![i].style,
          baseStrokeWidth: curPoint.ichimokuValues![i].strokeWidth,
          scaleX: scaleX,
        );

        ///--
        if (lastPoint.ichimokuValues != null &&
            lastPoint.ichimokuValues![i].senkouSpanA != null) {
          /// ----
          final senkouSpanA = lastPoint.ichimokuValues![i].senkouSpanA!;
          final senkouSpanB = lastPoint.ichimokuValues![i].senkouSpanB!;
          final color = senkouSpanA < senkouSpanB
              ? colorFromHex(
                  curPoint.ichimokuValues![i].ichimoku!.downKumoColor!)!
              : colorFromHex(
                  curPoint.ichimokuValues![i].ichimoku!.upKumoColor!)!;

          /// ----
          drawVerticalDashLine(
            senkouSpanA,
            senkouSpanB,
            canvas,
            lastX,
            lastX,
            color,
            baseStrokeWidth: 0.5,
            scaleX: scaleX,
          );
        }

        drawLine(
          lastPoint.ichimokuValues?[i].senkouSpanA,
          curPoint.ichimokuValues?[i].senkouSpanA,
          canvas,
          lastX,
          curX,
          colorFromHex(curPoint.ichimokuValues![i].ichimoku!.upKumoColor!)!,
          lineStyle: curPoint.ichimokuValues![i].style,
          baseStrokeWidth: curPoint.ichimokuValues![i].strokeWidth,
          scaleX: scaleX,
        );

        drawLine(
          lastPoint.ichimokuValues?[i].senkouSpanB,
          curPoint.ichimokuValues?[i].senkouSpanB,
          canvas,
          lastX,
          curX,
          colorFromHex(curPoint.ichimokuValues![i].ichimoku!.downKumoColor!)!,
          lineStyle: curPoint.ichimokuValues![i].style,
          baseStrokeWidth: curPoint.ichimokuValues![i].strokeWidth,
          scaleX: scaleX,
        );
      }
    }
  }

  void drawEMA_ENVELOPS(
    CandleEntity lastPoint,
    CandleEntity curPoint,
    Canvas canvas,
    double lastX,
    double curX,
    int period,
    int id,
  ) {
    for (int i = 0; i < (curPoint.envelopsEmaValues?.length ?? 0); i++) {
      final isShow = id == curPoint.envelopsEmaValues![i].windowId;
      if ((lastPoint.envelopsEmaValues?.length ?? 0) - 1 >= i &&
          lastPoint.envelopsEmaValues?[i].up != 0 &&
          period == curPoint.envelopsEmaValues?[i].period &&
          isShow) {
        drawLine(
          lastPoint.envelopsEmaValues?[i].up,
          curPoint.envelopsEmaValues?[i].up,
          canvas,
          lastX,
          curX,
          colorFromHex(curPoint.envelopsEmaValues![i].color!)!,
          baseStrokeWidth: curPoint.envelopsEmaValues![i].strokeWidth,
          scaleX: scaleX,
        );
      }

      if ((lastPoint.envelopsEmaValues?.length ?? 0) - 1 >= i &&
          lastPoint.envelopsEmaValues?[i].dn != 0 &&
          period == curPoint.envelopsEmaValues?[i].period &&
          isShow) {
        drawLine(
          lastPoint.envelopsEmaValues?[i].dn,
          curPoint.envelopsEmaValues?[i].dn,
          canvas,
          lastX,
          curX,
          colorFromHex(curPoint.envelopsEmaValues![i].secondColor!)!,
          baseStrokeWidth: curPoint.envelopsEmaValues![i].strokeWidth,
          scaleX: scaleX,
        );
      }
    }
  }

  void drawSMA_ENVELOPS(
    CandleEntity lastPoint,
    CandleEntity curPoint,
    Canvas canvas,
    double lastX,
    double curX,
    int period,
    int id,
  ) {
    for (int i = 0; i < (curPoint.envelopsSmaValues?.length ?? 0); i++) {
      final isShow = id == curPoint.envelopsSmaValues![i].windowId;
      if ((lastPoint.envelopsSmaValues?.length ?? 0) - 1 >= i &&
          lastPoint.envelopsSmaValues?[i].up != 0 &&
          period == curPoint.envelopsSmaValues?[i].period &&
          isShow) {
        drawLine(
          lastPoint.envelopsSmaValues?[i].up,
          curPoint.envelopsSmaValues?[i].up,
          canvas,
          lastX,
          curX,
          colorFromHex(curPoint.envelopsSmaValues![i].color!)!,
          baseStrokeWidth: curPoint.envelopsSmaValues![i].strokeWidth,
          scaleX: scaleX,
        );
      }

      if ((lastPoint.envelopsSmaValues?.length ?? 0) - 1 >= i &&
          lastPoint.envelopsSmaValues?[i].dn != 0 &&
          period == curPoint.envelopsSmaValues?[i].period &&
          isShow) {
        drawLine(
          lastPoint.envelopsSmaValues?[i].dn,
          curPoint.envelopsSmaValues?[i].dn,
          canvas,
          lastX,
          curX,
          colorFromHex(curPoint.envelopsSmaValues![i].secondColor!)!,
          baseStrokeWidth: curPoint.envelopsSmaValues![i].strokeWidth,
          scaleX: scaleX,
        );
      }
    }
  }

  void drawSMMA_ENVELOPS(
    CandleEntity lastPoint,
    CandleEntity curPoint,
    Canvas canvas,
    double lastX,
    double curX,
    int period,
    int id,
  ) {
    for (int i = 0; i < (curPoint.envelopsSmmaValues?.length ?? 0); i++) {
      final isShow = id == curPoint.envelopsSmmaValues![i].windowId;
      if ((lastPoint.envelopsSmmaValues?.length ?? 0) - 1 >= i &&
          lastPoint.envelopsSmmaValues?[i].up != 0 &&
          period == curPoint.envelopsSmmaValues?[i].period &&
          isShow) {
        drawLine(
          lastPoint.envelopsSmmaValues?[i].up,
          curPoint.envelopsSmmaValues?[i].up,
          canvas,
          lastX,
          curX,
          colorFromHex(curPoint.envelopsSmmaValues![i].color!)!,
          baseStrokeWidth: curPoint.envelopsSmmaValues![i].strokeWidth,
          scaleX: scaleX,
        );
      }

      if ((lastPoint.envelopsSmmaValues?.length ?? 0) - 1 >= i &&
          lastPoint.envelopsSmmaValues?[i].dn != 0 &&
          period == curPoint.envelopsSmmaValues?[i].period &&
          isShow) {
        drawLine(
          lastPoint.envelopsSmmaValues?[i].dn,
          curPoint.envelopsSmmaValues?[i].dn,
          canvas,
          lastX,
          curX,
          colorFromHex(curPoint.envelopsSmmaValues![i].secondColor!)!,
          baseStrokeWidth: curPoint.envelopsSmmaValues![i].strokeWidth,
          scaleX: scaleX,
        );
      }
    }
  }

  void drawLINEAR_ENVELOPS(
    CandleEntity lastPoint,
    CandleEntity curPoint,
    Canvas canvas,
    double lastX,
    double curX,
    int period,
    int id,
  ) {
    for (int i = 0; i < (curPoint.envelopsLwmaValues?.length ?? 0); i++) {
      final isShow = id == curPoint.envelopsLwmaValues![i].windowId;
      if ((lastPoint.envelopsLwmaValues?.length ?? 0) - 1 >= i &&
          lastPoint.envelopsLwmaValues?[i].up != 0 &&
          period == curPoint.envelopsLwmaValues?[i].period &&
          isShow) {
        drawLine(
          lastPoint.envelopsLwmaValues?[i].up,
          curPoint.envelopsLwmaValues?[i].up,
          canvas,
          lastX,
          curX,
          baseStrokeWidth: curPoint.envelopsLwmaValues![i].strokeWidth,
          colorFromHex(curPoint.envelopsLwmaValues![i].color!)!,
          scaleX: scaleX,
        );
      }

      if ((lastPoint.envelopsLwmaValues?.length ?? 0) - 1 >= i &&
          lastPoint.envelopsLwmaValues?[i].dn != 0 &&
          period == curPoint.envelopsLwmaValues?[i].period &&
          isShow) {
        drawLine(
          lastPoint.envelopsLwmaValues?[i].dn,
          curPoint.envelopsLwmaValues?[i].dn,
          canvas,
          lastX,
          curX,
          colorFromHex(curPoint.envelopsLwmaValues![i].secondColor!)!,
          baseStrokeWidth: curPoint.envelopsLwmaValues![i].strokeWidth,
          scaleX: scaleX,
        );
      }
    }
  }

  void drawBollLine(
    CandleEntity lastPoint,
    CandleEntity curPoint,
    Canvas canvas,
    double lastX,
    double curX,
    int period,
    int id,
  ) {
    for (int i = 0; i < (curPoint.bollValues?.length ?? 0); i++) {
      final isShow = id == curPoint.bollValues![i].windowId;
      if ((lastPoint.bollValues?.length ?? 0) - 1 >= i &&
          lastPoint.bollValues?[i].up != 0 &&
          isShow) {
        drawLine(
          lastPoint.bollValues?[i].up,
          curPoint.bollValues?[i].up,
          canvas,
          lastX,
          curX,
          this.chartColors.ma10Color,
          baseStrokeWidth: curPoint.bollValues![i].strokeWidth,
          scaleX: scaleX,
        );
      }
      if ((lastPoint.bollValues?.length ?? 0) - 1 >= i &&
          lastPoint.bollValues?[i].value != 0 &&
          isShow) {
        drawLine(
          lastPoint.bollValues?[i].value,
          curPoint.bollValues?[i].value,
          canvas,
          lastX,
          curX,
          colorFromHex(curPoint.bollValues![i].color!)!,
          baseStrokeWidth: curPoint.bollValues![i].strokeWidth,
          scaleX: scaleX,
        );
      }
      if ((lastPoint.bollValues?.length ?? 0) - 1 >= i &&
          lastPoint.bollValues?[i].dn != 0 &&
          isShow) {
        drawLine(
          lastPoint.bollValues?[i].dn,
          curPoint.bollValues?[i].dn,
          canvas,
          lastX,
          curX,
          this.chartColors.ma30Color,
          baseStrokeWidth: curPoint.bollValues![i].strokeWidth,
          scaleX: scaleX,
        );
      }
    }
  }

  @override
  void drawVerticalText(canvas, textStyle, int gridRows) {}

  @override
  void drawGrid(Canvas canvas, int gridRows, int gridColumns, double width,
      double height) {}

  @override
  void drawText(Canvas canvas, CandleEntity data, double x) {}
}
