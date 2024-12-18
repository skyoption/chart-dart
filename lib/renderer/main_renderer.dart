import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/renderer/rects/render_rect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../entity/candle_entity.dart';
import '../k_chart_widget.dart' show IndicatorType;
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

  final ChartStyle chartStyle;
  final ChartPosition chartPositions;
  final ChartColors chartColors;
  final double mLineStrokeWidth = 1.0;
  final double scaleX;
  double scaleY;
  late Paint mLinePaint;
  final VerticalTextAlignment verticalTextAlignment;
  final List<IndicatorEntity> indicators;
  late final SubMainRenderer subMainRenderer;

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
    this.verticalTextAlignment,
    this.indicators,
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
    );

    mCandleWidth = this.chartStyle.candleWidth;
    mCandleLineWidth = this.chartStyle.candleLineWidth;
    mLinePaint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke
      ..strokeWidth = mLineStrokeWidth
      ..color = this.chartColors.kLineColor;
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
    drawCandle(curPoint, canvas, curX);
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
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawRect(rect, paint);

    for (var i = 0; i <= gridRows; ++i) {
      double value = (gridRows - i) * rowSpace / scaleY + minValue;

      if (i == 0) {
        chartPositions.topPrice = value;
      }
      if (i == gridRows) {
        chartPositions.bottomPrice = value;
      }
      final realStyle = getTextStyle(chartColors.maxColor);
      TextSpan span = formatValueSpan(value, realStyle);

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
  void drawGrid(Canvas canvas, int gridRows, int gridColumns) {
    double rowSpace = (chartRect.height / gridRows);
    for (int i = 0; i <= gridRows; i++) {
      canvas.drawLine(Offset(0, rowSpace * i + topPadding),
          Offset(chartRect.rWidth, rowSpace * i + topPadding), gridPaint);
    }
    double columnSpace = chartRect.rWidth / gridColumns;
    for (int i = 0; i <= columnSpace; i++) {
      canvas.drawLine(
        Offset(columnSpace * i, topPadding),
        Offset(columnSpace * i, chartRect.bottom),
        gridPaint,
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

  SubMainRenderer(
    Rect mainRect,
    double maxValue,
    double minValue,
    double topPadding,
    int fixedLength,
    this.chartStyle,
    this.chartColors,
    this.indicators,
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
          strokeWidth: curPoint.maEmaValues![i].strokeWidth,
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
          strokeWidth: curPoint.maLwmaValues![i].strokeWidth,
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
          strokeWidth: curPoint.maSmaValues![i].strokeWidth,
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
          strokeWidth: curPoint.maSmmaValues![i].strokeWidth,
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
          strokeWidth: 4.0,
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
          Colors.green.withOpacity(0.15),
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
          strokeWidth: curPoint.ichimokuValues![i].strokeWidth,
        );
        drawLine(
          lastPoint.ichimokuValues?[i].chikouSpan,
          curPoint.ichimokuValues?[i].chikouSpan,
          canvas,
          lastX,
          curX,
          colorFromHex(curPoint.ichimokuValues![i].ichimoku!.chikouSpanColor!)!,
          lineStyle: curPoint.ichimokuValues![i].style,
          strokeWidth: curPoint.ichimokuValues![i].strokeWidth,
        );
        drawLine(
          lastPoint.ichimokuValues?[i].kijunSen,
          curPoint.ichimokuValues?[i].kijunSen,
          canvas,
          lastX,
          curX,
          colorFromHex(curPoint.ichimokuValues![i].ichimoku!.kijuSenColor!)!,
          lineStyle: curPoint.ichimokuValues![i].style,
          strokeWidth: curPoint.ichimokuValues![i].strokeWidth,
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
            strokeWidth: 0.5,
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
          strokeWidth: curPoint.ichimokuValues![i].strokeWidth,
        );

        drawLine(
          lastPoint.ichimokuValues?[i].senkouSpanB,
          curPoint.ichimokuValues?[i].senkouSpanB,
          canvas,
          lastX,
          curX,
          colorFromHex(curPoint.ichimokuValues![i].ichimoku!.downKumoColor!)!,
          lineStyle: curPoint.ichimokuValues![i].style,
          strokeWidth: curPoint.ichimokuValues![i].strokeWidth,
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
          strokeWidth: curPoint.envelopsEmaValues![i].strokeWidth,
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
          strokeWidth: curPoint.envelopsEmaValues![i].strokeWidth,
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
          strokeWidth: curPoint.envelopsSmaValues![i].strokeWidth,
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
          strokeWidth: curPoint.envelopsSmaValues![i].strokeWidth,
          colorFromHex(curPoint.envelopsSmaValues![i].secondColor!)!,
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
          strokeWidth: curPoint.envelopsSmmaValues![i].strokeWidth,
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
          strokeWidth: curPoint.envelopsSmmaValues![i].strokeWidth,
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
          strokeWidth: curPoint.envelopsLwmaValues![i].strokeWidth,
          colorFromHex(curPoint.envelopsLwmaValues![i].color!)!,
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
          strokeWidth: curPoint.envelopsLwmaValues![i].strokeWidth,
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
          strokeWidth: curPoint.bollValues![i].strokeWidth,
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
          strokeWidth: curPoint.bollValues![i].strokeWidth,
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
          strokeWidth: curPoint.bollValues![i].strokeWidth,
        );
      }
    }
  }

  @override
  void drawVerticalText(canvas, textStyle, int gridRows) {}

  @override
  void drawGrid(Canvas canvas, int gridRows, int gridColumns) {}

  @override
  void drawText(Canvas canvas, CandleEntity data, double x) {}
}
