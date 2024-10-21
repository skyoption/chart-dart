import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/entity/secondary_indicator_entity.dart';
import 'package:candle_chart/k_chart_widget.dart';
import 'package:flutter/material.dart';

import '../entity/macd_entity.dart';
import 'base_chart_renderer.dart';

class SecondaryRenderer extends BaseChartRenderer<MACDEntity> {
  late double mMACDWidth;
  final SecondaryIndicatorEntity indicator;
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
    MACDEntity lastPoint,
    MACDEntity curPoint,
    double lastX,
    double curX,
    Size size,
    Canvas canvas,
  ) {}

  void drawMACD(
    MACDEntity curPoint,
    Canvas canvas,
    double curX,
    MACDEntity lastPoint,
    double lastX,
  ) {
    final macd = curPoint.macd ?? 0;
    double macdY = getY(macd);
    double r = mMACDWidth / 2;
    double zeroy = getY(0);
    if (macd > 0) {
      canvas.drawRect(Rect.fromLTRB(curX - r, macdY, curX + r, zeroy),
          chartPaint..color = this.chartColors.upColor);
    } else {
      canvas.drawRect(Rect.fromLTRB(curX - r, zeroy, curX + r, macdY),
          chartPaint..color = this.chartColors.dnColor);
    }
    if (lastPoint.dif != 0) {
      drawLine(lastPoint.dif, curPoint.dif, canvas, lastX, curX,
          this.chartColors.difColor);
    }
    if (lastPoint.dea != 0) {
      drawLine(lastPoint.dea, curPoint.dea, canvas, lastX, curX,
          this.chartColors.deaColor);
    }
  }

  @override
  void drawVerticalText(
    canvas,
    textStyle,
    int gridRows,
  ) {
    TextPainter maxTp = TextPainter(
      text: TextSpan(text: "${format(maxValue)}", style: textStyle),
      textDirection: TextDirection.ltr,
    );
    maxTp.layout();
    TextPainter minTp = TextPainter(
      text: TextSpan(text: "${format(minValue)}", style: textStyle),
      textDirection: TextDirection.ltr,
    );
    minTp.layout();

    maxTp.paint(
      canvas,
      Offset(
        chartRect.rWidth - maxTp.width,
        chartRect.top - topPadding,
      ),
    );
    minTp.paint(
      canvas,
      Offset(
        chartRect.rWidth - minTp.width,
        chartRect.bottom - minTp.height,
      ),
    );
  }

  @override
  void drawGrid(
    Canvas canvas,
    int gridRows,
    int gridColumns,
  ) {
    // canvas.drawLine(Offset(0, chartRect.top), Offset(chartRect.rWidth, chartRect.top), gridPaint); //hidden line
    canvas.drawLine(
      Offset(0, chartRect.bottom),
      Offset(chartRect.rWidth, chartRect.bottom),
      gridPaint,
    );
    double columnSpace = chartRect.rWidth / gridColumns;
    for (int i = 0; i <= columnSpace; i++) {
      //mSecondaryRect
      canvas.drawLine(
        Offset(columnSpace * i, chartRect.top - topPadding),
        Offset(columnSpace * i, chartRect.bottom),
        gridPaint,
      );
    }
  }

  @override
  void drawIndicators(
    MACDEntity lastPoint,
    MACDEntity curPoint,
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
      drawLine(
        lastPoint.k,
        curPoint.k,
        canvas,
        lastX,
        curX,
        this.chartColors.kColor,
      );
      drawLine(
        lastPoint.j,
        curPoint.j,
        canvas,
        lastX,
        curX,
        this.chartColors.jColor,
      );
    } else if (indicator.type == IndicatorType.RSI) {
      drawLine(
        lastPoint.rsi,
        curPoint.rsi,
        canvas,
        lastX,
        curX,
        this.chartColors.rsiColor,
      );
    } else if (indicator.type == IndicatorType.WR) {
      drawLine(
        lastPoint.r,
        curPoint.r,
        canvas,
        lastX,
        curX,
        this.chartColors.rsiColor,
      );
    } else if (indicator.type == IndicatorType.CCI) {
      drawLine(
        lastPoint.cci,
        curPoint.cci,
        canvas,
        lastX,
        curX,
        this.chartColors.rsiColor,
      );
    }
    // }
  }

  @override
  void drawText(
    Canvas canvas,
    MACDEntity data,
    double x,
  ) {
    List<TextSpan>? children;
    switch (indicator.type) {
      case IndicatorType.MACD:
        children = [
          TextSpan(
              text: "MACD(12,26,9)    ",
              style: getTextStyle(this.chartColors.defaultTextColor)),
          if (data.macd != 0)
            TextSpan(
                text: "MACD:${format(data.macd)}    ",
                style: getTextStyle(this.chartColors.macdColor)),
          if (data.dif != 0)
            TextSpan(
              text: "DIF:${format(data.dif)}    ",
              style: getTextStyle(this.chartColors.difColor),
            ),
          if (data.dea != 0)
            TextSpan(
              text: "DEA:${format(data.dea)}    ",
              style: getTextStyle(this.chartColors.deaColor),
            ),
        ];
        break;
      case IndicatorType.KDJ:
        children = [
          TextSpan(
            text: "KDJ(9,1,3)    ",
            style: getTextStyle(this.chartColors.defaultTextColor),
          ),
          if (data.macd != 0)
            TextSpan(
              text: "K:${format(data.k)}    ",
              style: getTextStyle(this.chartColors.kColor),
            ),
          if (data.dif != 0)
            TextSpan(
              text: "D:${format(data.d)}    ",
              style: getTextStyle(this.chartColors.dColor),
            ),
          if (data.dea != 0)
            TextSpan(
              text: "J:${format(data.j)}    ",
              style: getTextStyle(this.chartColors.jColor),
            ),
        ];
        break;
      case IndicatorType.RSI:
        children = [
          TextSpan(
            text: "RSI(14):${format(data.rsi)}    ",
            style: getTextStyle(this.chartColors.rsiColor),
          ),
        ];
        break;
      case IndicatorType.WR:
        children = [
          TextSpan(
            text: "WR(14):${format(data.r)}    ",
            style: getTextStyle(this.chartColors.rsiColor),
          ),
        ];
        break;
      case IndicatorType.CCI:
        children = [
          TextSpan(
            text: "CCI(14):${format(data.cci)}    ",
            style: getTextStyle(this.chartColors.rsiColor),
          ),
        ];
        break;
      default:
        break;
    }
    TextPainter tp = TextPainter(
      text: TextSpan(children: children ?? []),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, Offset(x, chartRect.top - topPadding));
  }
}
