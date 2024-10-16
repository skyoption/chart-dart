import 'package:candle_chart/components/kprint.dart';
import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/entity/line_entity.dart';
import 'package:flutter/material.dart';

import '../entity/candle_entity.dart';
import '../k_chart_widget.dart' show IndicatorType;
import 'base_chart_painter.dart';
import 'base_chart_renderer.dart';

enum VerticalTextAlignment { left, right }

//For TrendLine
double? trendLineMax;
double? trendLineScale;
double? trendLineContentRec;

class MainRenderer extends BaseChartRenderer<CandleEntity> {
  late double mCandleWidth;
  late double mCandleLineWidth;
  bool isLine;

  //绘制的内容区域
  late Rect _contentRect;
  double _contentPadding = 5.0;

  final ChartStyle chartStyle;
  final ChartPosition chartPositions;
  final ChartColors chartColors;
  final double mLineStrokeWidth = 1.0;
  double scaleX;
  late Paint mLinePaint;
  final VerticalTextAlignment verticalTextAlignment;

  final List<IndicatorEntity> indicators;

  MainRenderer(
    Rect mainRect,
    double maxValue,
    double minValue,
    double topPadding,
    this.chartPositions,
    this.isLine,
    int fixedLength,
    this.chartStyle,
    this.chartColors,
    this.scaleX,
    this.verticalTextAlignment,
    this.indicators,
  ) : super(
            chartRect: mainRect,
            maxValue: maxValue,
            minValue: minValue,
            topPadding: topPadding,
            fixedLength: fixedLength,
            gridColor: chartColors.gridColor) {
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
        chartRect.bottom - _contentPadding);
    if (maxValue == minValue) {
      maxValue *= 1.5;
      minValue /= 2;
    }
    scaleY = _contentRect.height / (maxValue - minValue);
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

  @override
  void drawChart(
    CandleEntity lastPoint,
    CandleEntity curPoint,
    double lastX,
    double curX,
    Size size,
    Canvas canvas,
  ) {
    if (isLine) {
      drawPolyline(
        lastPoint.close,
        curPoint.close,
        canvas,
        lastX,
        curX,
      );
    }
    drawCandle(curPoint, canvas, curX);
    drawIndicators(
      lastPoint,
      curPoint,
      lastX,
      curX,
      size,
      canvas,
      false,
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
  ) {
    for (var item in indicators) {
      if (item.type == IndicatorType.EMA_MA &&
          item.drawAsBackground == drawAsBackground) {
        drawEMA_MA(
          lastPoint,
          curPoint,
          canvas,
          lastX,
          curX,
          item.period,
        );
      } else if (item.type == IndicatorType.LINEAR_MA &&
          item.drawAsBackground == drawAsBackground) {
        drawLINEAR_MA(
          lastPoint,
          curPoint,
          canvas,
          lastX,
          curX,
          item.period,
        );
      } else if (item.type == IndicatorType.SMA_MA &&
          item.drawAsBackground == drawAsBackground) {
        drawSMA_MA(
          lastPoint,
          curPoint,
          canvas,
          lastX,
          curX,
          item.period,
        );
      } else if (item.type == IndicatorType.SMMA_MA &&
          item.drawAsBackground == drawAsBackground) {
        drawSMMA_MA(
          lastPoint,
          curPoint,
          canvas,
          lastX,
          curX,
          item.period,
        );
      } else if (item.type == IndicatorType.EMA_ENVELOPS &&
          item.drawAsBackground == drawAsBackground) {
        drawEMA_ENVELOPS(
          lastPoint,
          curPoint,
          canvas,
          lastX,
          curX,
          item.period,
        );
      } else if (item.type == IndicatorType.LINEAR_ENVELOPS &&
          item.drawAsBackground == drawAsBackground) {
        drawLINEAR_ENVELOPS(
          lastPoint,
          curPoint,
          canvas,
          lastX,
          curX,
          item.period,
        );
      } else if (item.type == IndicatorType.SMA_ENVELOPS &&
          item.drawAsBackground == drawAsBackground) {
        drawSMA_ENVELOPS(
          lastPoint,
          curPoint,
          canvas,
          lastX,
          curX,
          item.period,
        );
      } else if (item.type == IndicatorType.SMMA_ENVELOPS &&
          item.drawAsBackground == drawAsBackground) {
        drawSMMA_ENVELOPS(
          lastPoint,
          curPoint,
          canvas,
          lastX,
          curX,
          item.period,
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
  ) {
    for (int i = 0; i < (curPoint.emaMaValues?.length ?? 0); i++) {
      if ((lastPoint.emaMaValues?.length ?? 0) - 1 >= i &&
          lastPoint.emaMaValues?[i] != 0 &&
          period == curPoint.emaMaValues?[i].period) {
        drawLine(
          lastPoint.emaMaValues?[i].value,
          curPoint.emaMaValues?[i].value,
          canvas,
          lastX,
          curX,
          curPoint.emaMaValues![i].color,
          lineStyle: curPoint.emaMaValues![i].style,
          strokeWidth: curPoint.emaMaValues![i].strokeWidth,
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
  ) {
    for (int i = 0; i < (curPoint.lwmaMaValues?.length ?? 0); i++) {
      if ((lastPoint.lwmaMaValues?.length ?? 0) - 1 >= i &&
          lastPoint.lwmaMaValues?[i] != 0 &&
          period == curPoint.lwmaMaValues?[i].period) {
        drawLine(
          lastPoint.lwmaMaValues?[i].value,
          curPoint.lwmaMaValues?[i].value,
          canvas,
          lastX,
          curX,
          curPoint.lwmaMaValues![i].color,
          lineStyle: curPoint.lwmaMaValues![i].style,
          strokeWidth: curPoint.lwmaMaValues![i].strokeWidth,
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
  ) {
    for (int i = 0; i < (curPoint.smaMaValues?.length ?? 0); i++) {
      if ((lastPoint.smaMaValues?.length ?? 0) - 1 >= i &&
          lastPoint.smaMaValues?[i] != 0 &&
          period == curPoint.smaMaValues?[i].period) {
        drawLine(
          lastPoint.smaMaValues?[i].value,
          curPoint.smaMaValues?[i].value,
          canvas,
          lastX,
          curX,
          curPoint.smaMaValues![i].color,
          lineStyle: curPoint.smaMaValues![i].style,
          strokeWidth: curPoint.smaMaValues![i].strokeWidth,
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
  ) {
    for (int i = 0; i < (curPoint.smmaMaValues?.length ?? 0); i++) {
      if ((lastPoint.smmaMaValues?.length ?? 0) - 1 >= i &&
          lastPoint.smmaMaValues?[i] != 0 &&
          period == curPoint.smmaMaValues?[i].period) {
        drawLine(
          lastPoint.smmaMaValues?[i].value,
          curPoint.smmaMaValues?[i].value,
          canvas,
          lastX,
          curX,
          curPoint.smmaMaValues![i].color,
          lineStyle: curPoint.smmaMaValues![i].style,
          strokeWidth: curPoint.smmaMaValues![i].strokeWidth,
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
  ) {
    for (int i = 0; i < (curPoint.parabolicValues?.length ?? 0); i++) {
      drawLine(
        lastPoint.parabolicValues?[i].value,
        curPoint.parabolicValues?[i].value,
        canvas,
        lastX,
        curX,
        curPoint.parabolicValues![i].color,
        lineStyle: curPoint.parabolicValues![i].style,
        strokeWidth: 4.0,
        isDot: true,
      );
    }
  }

  void drawIchimokuLine(
    CandleEntity lastPoint,
    CandleEntity curPoint,
    Canvas canvas,
    double lastX,
    double curX,
    int period,
  ) {
    ///-- for drawing background of SpanA and SpanB
    for (int i = 0; i < (curPoint.ichimokuValues?.length ?? 0); i++) {
      List<Offset> senkouSpanAOffsets = [], senkouSpanBOffsets = [];
      if (curPoint.ichimokuValues != null &&
          lastPoint.ichimokuValues != null &&
          curPoint.ichimokuValues![i].senkouSpanA != null) {
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
      drawLine(
        lastPoint.ichimokuValues?[i].tenkanSen,
        curPoint.ichimokuValues?[i].tenkanSen,
        canvas,
        lastX,
        curX,
        curPoint.ichimokuValues![i].ichimoku!.tenkanSenColor,
        lineStyle: curPoint.ichimokuValues![i].style,
        strokeWidth: curPoint.ichimokuValues![i].strokeWidth,
      );
      drawLine(
        lastPoint.ichimokuValues?[i].chikouSpan,
        curPoint.ichimokuValues?[i].chikouSpan,
        canvas,
        lastX,
        curX,
        curPoint.ichimokuValues![i].ichimoku!.chikouSpanColor,
        lineStyle: curPoint.ichimokuValues![i].style,
        strokeWidth: curPoint.ichimokuValues![i].strokeWidth,
      );
      drawLine(
        lastPoint.ichimokuValues?[i].kijunSen,
        curPoint.ichimokuValues?[i].kijunSen,
        canvas,
        lastX,
        curX,
        curPoint.ichimokuValues![i].ichimoku!.kijuSenColor,
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
            ? curPoint.ichimokuValues![i].ichimoku!.downKumoColor
            : curPoint.ichimokuValues![i].ichimoku!.upKumoColor;

        /// ----
        drawDashLine(
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
        curPoint.ichimokuValues![i].ichimoku!.upKumoColor,
        lineStyle: curPoint.ichimokuValues![i].style,
        strokeWidth: curPoint.ichimokuValues![i].strokeWidth,
      );

      drawLine(
        lastPoint.ichimokuValues?[i].senkouSpanB,
        curPoint.ichimokuValues?[i].senkouSpanB,
        canvas,
        lastX,
        curX,
        curPoint.ichimokuValues![i].ichimoku!.downKumoColor,
        lineStyle: curPoint.ichimokuValues![i].style,
        strokeWidth: curPoint.ichimokuValues![i].strokeWidth,
      );
    }
  }

  void drawEMA_ENVELOPS(
    CandleEntity lastPoint,
    CandleEntity curPoint,
    Canvas canvas,
    double lastX,
    double curX,
    int period,
  ) {
    for (int i = 0; i < (curPoint.emaEnvelopsValues?.length ?? 0); i++) {
      if ((lastPoint.emaEnvelopsValues?.length ?? 0) - 1 >= i &&
          lastPoint.emaEnvelopsValues?[i].up != 0 &&
          period == curPoint.emaEnvelopsValues?[i].period) {
        drawLine(
          lastPoint.emaEnvelopsValues?[i].up,
          curPoint.emaEnvelopsValues?[i].up,
          canvas,
          lastX,
          curX,
          curPoint.emaEnvelopsValues![i].color,
        );
      }

      if ((lastPoint.emaEnvelopsValues?.length ?? 0) - 1 >= i &&
          lastPoint.emaEnvelopsValues?[i].dn != 0 &&
          period == curPoint.emaEnvelopsValues?[i].period) {
        drawLine(
          lastPoint.emaEnvelopsValues?[i].dn,
          curPoint.emaEnvelopsValues?[i].dn,
          canvas,
          lastX,
          curX,
          curPoint.emaEnvelopsValues![i].secondColor,
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
  ) {
    for (int i = 0; i < (curPoint.smaEnvelopsValues?.length ?? 0); i++) {
      if ((lastPoint.smaEnvelopsValues?.length ?? 0) - 1 >= i &&
          lastPoint.smaEnvelopsValues?[i].up != 0 &&
          period == curPoint.smaEnvelopsValues?[i].period) {
        drawLine(
          lastPoint.smaEnvelopsValues?[i].up,
          curPoint.smaEnvelopsValues?[i].up,
          canvas,
          lastX,
          curX,
          curPoint.smaEnvelopsValues![i].color,
        );
      }

      if ((lastPoint.smaEnvelopsValues?.length ?? 0) - 1 >= i &&
          lastPoint.smaEnvelopsValues?[i].dn != 0 &&
          period == curPoint.smaEnvelopsValues?[i].period) {
        drawLine(
          lastPoint.smaEnvelopsValues?[i].dn,
          curPoint.smaEnvelopsValues?[i].dn,
          canvas,
          lastX,
          curX,
          curPoint.smaEnvelopsValues![i].secondColor,
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
  ) {
    for (int i = 0; i < (curPoint.smmaEnvelopsValues?.length ?? 0); i++) {
      if ((lastPoint.smmaEnvelopsValues?.length ?? 0) - 1 >= i &&
          lastPoint.smmaEnvelopsValues?[i].up != 0 &&
          period == curPoint.smmaEnvelopsValues?[i].period) {
        drawLine(
          lastPoint.smmaEnvelopsValues?[i].up,
          curPoint.smmaEnvelopsValues?[i].up,
          canvas,
          lastX,
          curX,
          curPoint.smmaEnvelopsValues![i].color,
        );
      }

      if ((lastPoint.smmaEnvelopsValues?.length ?? 0) - 1 >= i &&
          lastPoint.smmaEnvelopsValues?[i].dn != 0 &&
          period == curPoint.smmaEnvelopsValues?[i].period) {
        drawLine(
          lastPoint.smmaEnvelopsValues?[i].dn,
          curPoint.smmaEnvelopsValues?[i].dn,
          canvas,
          lastX,
          curX,
          curPoint.smmaEnvelopsValues![i].secondColor,
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
  ) {
    for (int i = 0; i < (curPoint.lwmaEnvelopsValues?.length ?? 0); i++) {
      if ((lastPoint.lwmaEnvelopsValues?.length ?? 0) - 1 >= i &&
          lastPoint.lwmaEnvelopsValues?[i].up != 0 &&
          period == curPoint.lwmaEnvelopsValues?[i].period) {
        drawLine(
          lastPoint.lwmaEnvelopsValues?[i].up,
          curPoint.lwmaEnvelopsValues?[i].up,
          canvas,
          lastX,
          curX,
          curPoint.lwmaEnvelopsValues![i].color,
        );
      }

      if ((lastPoint.lwmaEnvelopsValues?.length ?? 0) - 1 >= i &&
          lastPoint.lwmaEnvelopsValues?[i].dn != 0 &&
          period == curPoint.lwmaEnvelopsValues?[i].period) {
        drawLine(
          lastPoint.lwmaEnvelopsValues?[i].dn,
          curPoint.lwmaEnvelopsValues?[i].dn,
          canvas,
          lastX,
          curX,
          curPoint.lwmaEnvelopsValues![i].secondColor,
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
  ) {
    for (int i = 0; i < (curPoint.bollValues?.length ?? 0); i++) {
      if ((lastPoint.bollValues?.length ?? 0) - 1 >= i &&
          lastPoint.bollValues?[i].up != 0) {
        drawLine(
          lastPoint.bollValues?[i].up,
          curPoint.bollValues?[i].up,
          canvas,
          lastX,
          curX,
          this.chartColors.ma10Color,
        );
      }
      if ((lastPoint.bollValues?.length ?? 0) - 1 >= i &&
          lastPoint.bollValues?[i].value != 0) {
        drawLine(
          lastPoint.bollValues?[i].value,
          curPoint.bollValues?[i].value,
          canvas,
          lastX,
          curX,
          curPoint.bollValues![i].color,
        );
      }
      if ((lastPoint.bollValues?.length ?? 0) - 1 >= i &&
          lastPoint.bollValues?[i].dn != 0) {
        drawLine(
          lastPoint.bollValues?[i].dn,
          curPoint.bollValues?[i].dn,
          canvas,
          lastX,
          curX,
          this.chartColors.ma30Color,
        );
      }
    }
  }

  Shader? mLineFillShader;
  Path? mLinePath, mLineFillPath;
  Paint mLineFillPaint = Paint()
    ..style = PaintingStyle.fill
    ..isAntiAlias = true;

//画折线图
  drawPolyline(double lastPrice, double curPrice, Canvas canvas, double lastX,
      double curX) {
    mLinePath ??= Path();
    if (lastX == curX) lastX = 0;
    mLinePath!.moveTo(lastX, getY(lastPrice));
    mLinePath!.cubicTo((lastX + curX) / 2, getY(lastPrice), (lastX + curX) / 2,
        getY(curPrice), curX, getY(curPrice));

    mLineFillShader ??= LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      tileMode: TileMode.clamp,
      colors: [
        this.chartColors.lineFillColor,
        this.chartColors.lineFillInsideColor
      ],
    ).createShader(Rect.fromLTRB(
        chartRect.left, chartRect.top, chartRect.right, chartRect.bottom));
    mLineFillPaint..shader = mLineFillShader;

    mLineFillPath ??= Path();

    mLineFillPath!.moveTo(lastX, chartRect.height + chartRect.top);
    mLineFillPath!.lineTo(lastX, getY(lastPrice));
    mLineFillPath!.cubicTo((lastX + curX) / 2, getY(lastPrice),
        (lastX + curX) / 2, getY(curPrice), curX, getY(curPrice));
    mLineFillPath!.lineTo(curX, chartRect.height + chartRect.top);
    mLineFillPath!.close();

    canvas.drawPath(mLineFillPath!, mLineFillPaint);
    mLineFillPath!.reset();

    canvas.drawPath(mLinePath!,
        mLinePaint..strokeWidth = (mLineStrokeWidth / scaleX).clamp(0.1, 1.0));
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
          offsetX = 0;
          break;
        case VerticalTextAlignment.right:
          offsetX = chartRect.width -
              tp.width -
              this.chartStyle.rightPadding +
              this.chartStyle.priceWidth;
          break;
      }

      if (i == 0 && this.chartStyle.isShowLeftTopicPoint) {
        tp.paint(canvas, Offset(offsetX, topPadding));
      } else {
        if (this.chartStyle.isShowLeftTopicPoint || i > 0)
          tp.paint(
              canvas, Offset(offsetX, rowSpace * i - tp.height + topPadding));
      }
    }
  }

  @override
  void drawGrid(Canvas canvas, int gridRows, int gridColumns) {
    double rowSpace = chartRect.height / gridRows;
    for (int i = 0; i <= gridRows; i++) {
      canvas.drawLine(Offset(0, rowSpace * i + topPadding),
          Offset(chartRect.rWidth, rowSpace * i + topPadding), gridPaint);
    }
    double columnSpace = chartRect.rWidth / gridColumns;
    for (int i = 0; i <= columnSpace; i++) {
      canvas.drawLine(Offset(columnSpace * i, topPadding / 3),
          Offset(columnSpace * i, chartRect.bottom), gridPaint);
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

// void drawMaLine(CandleEntity lastPoint, CandleEntity curPoint, Canvas canvas,
//     double lastX, double curX) {
//   for (int i = 0; i < (curPoint.maValues?.length ?? 0); i++) {
//     if (i == 3) {
//       break;
//     }
//     if (lastPoint.maValues?[i] != 0) {
//       drawLine(lastPoint.maValues?[i], curPoint.maValues?[i], canvas,
//           lastX, curX, this.chartColors.getMAColor(i));
//     }
//   }
// }

//
// List<InlineSpan> _createMATextSpan(CandleEntity data) {
//   List<InlineSpan> result = [];
//   for (int i = 0; i < (data.maValues?.length ?? 0); i++) {
//     if (data.maValues?[i] != 0) {
//       String value = '${format(data.maValues![i])}';
//       //
//       // var item = TextSpan(
//       //     text: "MA${maDayList[i]}:$value    ",
//       //     style: getTextStyle(this.chartColors.getMAColor(i)));
//
//       //科学计算 下标
//       List<InlineSpan> children = [];
//
//       TextSpan span = TextSpan(
//           text: "MA${maDayList[i]}:",
//           style: getTextStyle(this.chartColors.getMAColor(i)));
//       final spanS = formatValueSpan(
//           (double.tryParse('${data.maValues![i]}') ?? 0.0),
//           getTextStyle(this.chartColors.getMAColor(i)));
//       children.add(span);
//       children.add(spanS);
//       TextSpan? item = TextSpan(children: children);
//
//       result.add(item);
//       if (value.length > 13 && i > 0 && i % 1 == 0)
//         result.add(TextSpan(text: '\n'));
//     }
//   }
//   return result;
// }

// //EMA
//   List<InlineSpan> _createEMATextSpan(CandleEntity data) {
//     List<InlineSpan> result = [];
//     for (int i = 0; i < (data.emaValues?.length ?? 0); i++) {
//       if (data.emaValues?[i] != 0) {
//         // String value = '${format(data.emaValues![i])}';
//         String value = '${format(data.emaValues![i])}';
//         // var item = TextSpan(
//         //     text: "EMA${emaValues[i]}:$value    ",
//         //     style: getTextStyle(this.chartColors.getEMAColor(i)));
//
//         //科学计算 下标
//         List<InlineSpan> children = [];
//
//         TextSpan span = TextSpan(
//             text: "EMA${emaValues[i]}:",
//             style: getTextStyle(this.chartColors.getEMAColor(i)));
//         final spanS = formatValueSpan(
//             (double.tryParse('${data.emaValues![i]}') ?? 0.0),
//             getTextStyle(this.chartColors.getEMAColor(i)));
//         children.add(span);
//         children.add(spanS);
//         TextSpan? item = TextSpan(children: children);
//
//         if ((value.length > 13 && i > 0 && i % 2 == 0) ||
//             (value.length <= 13 && i > 2)) result.add(TextSpan(text: '\n'));
//         result.add(item);
//         // if (i == 2) {
//         //   result.add(TextSpan(text: '\n'));
//         // }
//       }
//     }
//     return result;
//   }

// // 添加EMA计算函数
// //EMA
// List<double> calculateEMA(List<double> prices, int period) {
//   List<double> ema = [];
//   double multiplier = 2 / (period + 1);
//
//   double sum = 0;
//   for (int i = 0; i < period; i++) {
//     sum += prices[i];
//   }
//   ema.add(sum / period);
//
//   for (int i = period; i < prices.length; i++) {
//     double value = (prices[i] - ema.last) * multiplier + ema.last;
//     ema.add(value);
//   }
//
//   return ema;
// }
}
