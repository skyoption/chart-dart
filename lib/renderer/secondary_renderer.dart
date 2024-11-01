import 'package:candle_chart/entity/candle_entity.dart';
import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/entity/line_entity.dart';
import 'package:candle_chart/k_chart_widget.dart';
import 'package:candle_chart/utils/kprint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../entity/macd_entity.dart';
import 'base_chart_renderer.dart';

class SecondaryRenderer extends BaseChartRenderer<CandleEntity> {
  late double mMACDWidth;
  final IndicatorEntity indicator;
  final ChartStyle chartStyle;
  final ChartColors chartColors;

  SecondaryRenderer(
    Rect mainRect,
    double maxValue,
    double minValue,
    double topPadding,
    this.indicator,
    int fixedLength,
    this.chartStyle,
    this.chartColors,
  ) : super(
          chartRect: mainRect,
          maxValue: maxValue,
          minValue: minValue,
          topPadding: topPadding,
          fixedLength: fixedLength,
          gridColor: chartColors.gridColor,
        ) {
    mMACDWidth = this.chartStyle.macdWidth;
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
  void drawVerticalText(
    canvas,
    TextStyle textStyle,
    int gridRows,
  ) {
    TextPainter maxTp = TextPainter(
      text: TextSpan(
          text: "${format(maxValue)}",
          style: textStyle.copyWith(color: Colors.black)),
      textDirection: TextDirection.ltr,
    );
    maxTp.layout();
    TextPainter minTp = TextPainter(
      text: TextSpan(
          text: "${format(minValue)}",
          style: textStyle.copyWith(color: Colors.black)),
      textDirection: TextDirection.ltr,
    );
    minTp.layout();
    TextPainter zeroTp = TextPainter(
      text: TextSpan(text: "0", style: textStyle.copyWith(color: Colors.black)),
      textDirection: TextDirection.ltr,
    );
    zeroTp.layout();
    double space1 = 45, space2 = 45;
    if (minValue < 0) {
      space2 = 50;
    } else {
      space2 = 45;
    }
    if (maxValue < 0) {
      space1 = 50;
    } else {
      space1 = 45;
    }
    maxTp.paint(
      canvas,
      Offset(
        chartRect.rWidth + space1 + -maxTp.width,
        chartRect.top - topPadding - (maxTp.height / 2),
      ),
    );
    minTp.paint(
      canvas,
      Offset(
        chartRect.rWidth + space2 - minTp.width,
        chartRect.bottom - (minTp.height / 2),
      ),
    );
    // zeroTp.paint(
    //   canvas,
    //   Offset(
    //     chartRect.rWidth + space2 - zeroTp.width,
    //     chartRect.centerLeft.dy,
    //   ),
    // );
  }

  @override
  void drawGrid(
    Canvas canvas,
    int gridRows,
    int gridColumns,
  ) {
    canvas.drawLine(
        Offset(0, chartRect.top - topPadding),
        Offset(chartRect.rWidth, chartRect.top - topPadding),
        darkPaint); //hidden line
    canvas.drawLine(
      Offset(0, chartRect.bottom),
      Offset(chartRect.rWidth, chartRect.bottom),
      darkPaint,
    );
    double columnSpace = chartRect.rWidth / gridColumns;
    for (int i = 0; i <= columnSpace; i++) {
      //mSecondaryRect
      canvas.drawLine(
        Offset(columnSpace * i, chartRect.top - topPadding - 60),
        Offset(columnSpace * i, chartRect.bottom),
        (i == 0 || i == columnSpace) ? darkPaint : gridPaint,
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
  ) {
    // for (var item in indicators) {
    if (indicator.type == IndicatorType.MACD) {
      drawMACD(
        curPoint,
        canvas,
        curX,
        lastPoint,
        lastX,
      );
    } else if (indicator.type == IndicatorType.KDJ) {
      // drawLine(
      //   lastPoint.k,
      //   curPoint.k,
      //   canvas,
      //   lastX,
      //   curX,
      //   this.chartColors.kColor,
      // );
      // drawLine(
      //   lastPoint.j,
      //   curPoint.j,
      //   canvas,
      //   lastX,
      //   curX,
      //   this.chartColors.jColor,
      // );
    } else if (indicator.type == IndicatorType.RSI) {
      drawRSI(
        curPoint,
        canvas,
        curX,
        lastPoint,
        lastX,
      );
    } else if (indicator.type == IndicatorType.WR) {
      // drawLine(
      //   lastPoint.r,
      //   curPoint.r,
      //   canvas,
      //   lastX,
      //   curX,
      //   this.chartColors.rsiColor,
      // );
    } else if (indicator.type == IndicatorType.CCI) {
      // drawLine(
      //   lastPoint.cci,
      //   curPoint.cci,
      //   canvas,
      //   lastX,
      //   curX,
      //   this.chartColors.rsiColor,
      // );
    }
    // }
  }

  @override
  void drawText(
    Canvas canvas,
    CandleEntity data,
    double x,
  ) {
    return;
    // List<TextSpan>? children;
    // switch (indicator.type) {
    //   case IndicatorType.MACD:
    //     children = [
    //       TextSpan(
    //           text: "MACD(12,26,9)    ",
    //           style: getTextStyle(this.chartColors.defaultTextColor)),
    //       if (data.macd != 0)
    //         TextSpan(
    //             text: "MACD:${format(data.macd)}    ",
    //             style: getTextStyle(this.chartColors.macdColor)),
    //       if (data.dif != 0)
    //         TextSpan(
    //           text: "DIF:${format(data.dif)}    ",
    //           style: getTextStyle(this.chartColors.difColor),
    //         ),
    //       if (data.dea != 0)
    //         TextSpan(
    //           text: "DEA:${format(data.dea)}    ",
    //           style: getTextStyle(this.chartColors.deaColor),
    //         ),
    //     ];
    //     break;
    //   case IndicatorType.KDJ:
    //     children = [
    //       TextSpan(
    //         text: "KDJ(9,1,3)    ",
    //         style: getTextStyle(this.chartColors.defaultTextColor),
    //       ),
    //       if (data.macd != 0)
    //         TextSpan(
    //           text: "K:${format(data.k)}    ",
    //           style: getTextStyle(this.chartColors.kColor),
    //         ),
    //       if (data.dif != 0)
    //         TextSpan(
    //           text: "D:${format(data.d)}    ",
    //           style: getTextStyle(this.chartColors.dColor),
    //         ),
    //       if (data.dea != 0)
    //         TextSpan(
    //           text: "J:${format(data.j)}    ",
    //           style: getTextStyle(this.chartColors.jColor),
    //         ),
    //     ];
    //     break;
    //   case IndicatorType.RSI:
    //     children = [
    //       TextSpan(
    //         text: "RSI(14):${format(data.rsi)}    ",
    //         style: getTextStyle(this.chartColors.rsiColor),
    //       ),
    //     ];
    //     break;
    //   case IndicatorType.WR:
    //     children = [
    //       TextSpan(
    //         text: "WR(14):${format(data.r)}    ",
    //         style: getTextStyle(this.chartColors.rsiColor),
    //       ),
    //     ];
    //     break;
    //   case IndicatorType.CCI:
    //     children = [
    //       TextSpan(
    //         text: "CCI(14):${format(data.cci)}    ",
    //         style: getTextStyle(this.chartColors.rsiColor),
    //       ),
    //     ];
    //     break;
    //   default:
    //     break;
    // }
    // TextPainter tp = TextPainter(
    //   text: TextSpan(children: children ?? []),
    //   textDirection: TextDirection.ltr,
    // );
    // tp.layout();
    // tp.paint(canvas, Offset(x, chartRect.top - topPadding));
  }

  void drawMACD(
    CandleEntity curPoint,
    Canvas canvas,
    double curX,
    CandleEntity lastPoint,
    double lastX,
  ) {
    if (lastPoint.macdValues == null) return;
    for (int i = 0; i < (curPoint.macdValues?.length ?? 0); i++) {
      final macd = curPoint.macdValues?[i].value ?? 0;
      double macdY = getY(macd);
      double r = mMACDWidth / 2;
      double zeroy = getY(0);

      if (macd > 0) {
        canvas.drawRect(
          Rect.fromLTRB(curX - r, macdY, curX + r, zeroy),
          chartPaint..color = this.chartColors.upColor,
        );
      } else {
        canvas.drawRect(
          Rect.fromLTRB(curX - r, zeroy, curX + r, macdY),
          chartPaint..color = this.chartColors.dnColor,
        );
      }
    }
    for (int i = 0; i < (curPoint.macdSignalValues?.length ?? 0); i++) {
      if (lastPoint.macdSignalValues?[i].value != 0) {
        drawLine(
          lastPoint.macdSignalValues?[i].value,
          curPoint.macdSignalValues?[i].value,
          canvas,
          lastX,
          curX,
          colorFromHex(curPoint.macdValues![i].color!)!,
        );
      }
    }
  }

  void drawRSI(
    CandleEntity curPoint,
    Canvas canvas,
    double curX,
    CandleEntity lastPoint,
    double lastX,
  ) {
    if (curPoint.rsiValues == null) return;
    drawHorizontalDashLine(
      100,
      100,
      canvas,
      lastX,
      curX,
      colorFromHex(curPoint.rsiValues![0].levelsColor!)!,
      strokeWidth: 1.0,
    );
    drawHorizontalDashLine(
      0,
      0,
      canvas,
      lastX,
      curX,
      colorFromHex(curPoint.rsiValues![0].levelsColor!)!,
      strokeWidth: 1.0,
    );
    for (var level in curPoint.rsiValues![0].levels) {
      drawHorizontalDashLine(
        level.toDouble(),
        level.toDouble(),
        canvas,
        lastX,
        curX,
        colorFromHex(curPoint.rsiValues![0].levelsColor!)!,
        strokeWidth: 1.0,
      );
    }
    for (int i = 0; i < (curPoint.rsiValues?.length ?? 0); i++) {
      if (lastPoint.rsiValues?[i].value != 0) {
        drawLine(
          lastPoint.rsiValues?[i].value,
          curPoint.rsiValues?[i].value,
          canvas,
          lastX,
          curX,
          colorFromHex(curPoint.rsiValues![i].color!)!,
        );
      }
    }
  }
}
