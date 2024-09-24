import 'package:candle_chart/entity/indicator_entity.dart';
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
  void drawChart(CandleEntity lastPoint, CandleEntity curPoint, double lastX,
      double curX, Size size, Canvas canvas) {
    if (isLine) {
      drawPolyline(lastPoint.close, curPoint.close, canvas, lastX, curX);
    } else {
      drawCandle(curPoint, canvas, curX);
      for (var item in indicators) {
        if (item.type == IndicatorType.BOLL) {
          drawBollLine(lastPoint, curPoint, canvas, lastX, curX);
        } else if (item.type == IndicatorType.EMA) {
          drawEmaLine(lastPoint, curPoint, canvas, lastX, curX);
        } else if (item.type == IndicatorType.LINEARMA) {
          drawLINEARMALine(lastPoint, curPoint, canvas, lastX, curX);
        } else if (item.type == IndicatorType.SMA) {
          drawSmaLine(lastPoint, curPoint, canvas, lastX, curX);
        } else if (item.type == IndicatorType.SMMA) {
          drawSmmaLine(lastPoint, curPoint, canvas, lastX, curX);
        }
      }
    }
  }

  // 实现EMA绘制函数
  //EMA
  void drawEmaLine(CandleEntity lastPoint, CandleEntity curPoint, Canvas canvas,
      double lastX, double curX) {
    for (int i = 0; i < (curPoint.emaValues?.length ?? 0); i++) {
      if (i == 4) {
        break;
      }
      if (lastPoint.emaValues?[i] != 0) {
        drawLine(
          lastPoint.emaValues?[i].value,
          curPoint.emaValues?[i].value,
          canvas,
          lastX,
          curX,
          curPoint.emaValues![i].color,
        );
      }
    }
  }

  // 实现EMA绘制函数
  //LINEARMA
  void drawLINEARMALine(CandleEntity lastPoint, CandleEntity curPoint,
      Canvas canvas, double lastX, double curX) {
    for (int i = 0; i < (curPoint.lwmaValues?.length ?? 0); i++) {
      if (i == 4) {
        break;
      }
      if (lastPoint.lwmaValues?[i] != 0) {
        drawLine(
          lastPoint.lwmaValues?[i].value,
          curPoint.lwmaValues?[i].value,
          canvas,
          lastX,
          curX,
          curPoint.lwmaValues![i].color,
        );
      }
    }
  }

  // 实现SMA绘制函数
  //SMA
  void drawSmaLine(CandleEntity lastPoint, CandleEntity curPoint, Canvas canvas,
      double lastX, double curX) {
    for (int i = 0; i < (curPoint.smaValues?.length ?? 0); i++) {
      if (i == 4) {
        break;
      }
      if (lastPoint.smaValues?[i] != 0) {
        drawLine(
          lastPoint.smaValues?[i].value,
          curPoint.smaValues?[i].value,
          canvas,
          lastX,
          curX,
          curPoint.smaValues![i].color,
        );
      }
    }
  }

  // 实现SMMA绘制函数
  //SMMA
  void drawSmmaLine(CandleEntity lastPoint, CandleEntity curPoint,
      Canvas canvas, double lastX, double curX) {
    for (int i = 0; i < (curPoint.smmaValues?.length ?? 0); i++) {
      if (i == 4) {
        break;
      }
      if (lastPoint.smmaValues?[i] != 0) {
        drawLine(
          lastPoint.smmaValues?[i].value,
          curPoint.smmaValues?[i].value,
          canvas,
          lastX,
          curX,
          curPoint.smmaValues![i].color,
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
//    drawLine(lastPrice + 100, curPrice + 100, canvas, lastX, curX, ChartColors.kLineColor);
    mLinePath ??= Path();

//    if (lastX == curX) {
//      mLinePath.moveTo(lastX, getY(lastPrice));
//    } else {
////      mLinePath.lineTo(curX, getY(curPrice));
//      mLinePath.cubicTo(
//          (lastX + curX) / 2, getY(lastPrice), (lastX + curX) / 2, getY(curPrice), curX, getY(curPrice));
//    }
    if (lastX == curX) lastX = 0; //起点位置填充
    mLinePath!.moveTo(lastX, getY(lastPrice));
    mLinePath!.cubicTo((lastX + curX) / 2, getY(lastPrice), (lastX + curX) / 2,
        getY(curPrice), curX, getY(curPrice));

    //画阴影
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

  void drawBollLine(CandleEntity lastPoint, CandleEntity curPoint,
      Canvas canvas, double lastX, double curX) {
    if (lastPoint.up != 0) {
      drawLine(lastPoint.up, curPoint.up, canvas, lastX, curX,
          this.chartColors.ma10Color);
    }
    if (lastPoint.mb != 0) {
      drawLine(lastPoint.mb, curPoint.mb, canvas, lastX, curX,
          this.chartColors.ma5Color);
    }
    if (lastPoint.dn != 0) {
      drawLine(lastPoint.dn, curPoint.dn, canvas, lastX, curX,
          this.chartColors.ma30Color);
    }
  }

  void drawCandle(CandleEntity curPoint, Canvas canvas, double curX) {
    var high = getY(curPoint.high);
    var low = getY(curPoint.low);
    var open = getY(curPoint.open);
    var close = getY(curPoint.close);
    double r = mCandleWidth / 2;
    double lineR = mCandleLineWidth / 2;
    if (open >= close) {
      // 实体高度>= CandleLineWidth
      if (open - close < mCandleLineWidth) {
        open = close + mCandleLineWidth;
      }
      chartPaint.color = this.chartColors.upColor;
      canvas.drawRect(
          Rect.fromLTRB(curX - r, close, curX + r, open), chartPaint);
      canvas.drawRect(
          Rect.fromLTRB(curX - lineR, high, curX + lineR, low), chartPaint);
    } else if (close > open) {
      // 实体高度>= CandleLineWidth
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
      // TextSpan span = TextSpan(
      //     text: "${format(value, isNotPoint: this.chartStyle.isNotPoint)}",
      //     style: textStyle);

      //右侧文字科学计数
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
//    final int gridRows = 4, gridColumns = 4;
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
    //For TrendLine
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
