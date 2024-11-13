import 'package:candle_chart/entity/candle_entity.dart';
import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/k_chart_widget.dart';
import 'package:candle_chart/renderer/rects/render_rect.dart';
import 'package:candle_chart/renderer/main_renderer.dart';
import 'package:candle_chart/utils/kprint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'base_chart_renderer.dart';

class SecondaryRenderer extends BaseChartRenderer<CandleEntity> {
  late double mMACDWidth;
  final IndicatorEntity indicator;
  final List<IndicatorEntity> subIndicators;
  final List<IndicatorEntity> indicators;
  final ChartStyle chartStyle;
  final ChartColors chartColors;
  int index = -1;
  late final bool isMain, isLast;
  final List<RenderRect> mSecondaryRectList;
  double scaleX;
  late final SubMainRenderer subMainRenderer;

  SecondaryRenderer(
    this.mSecondaryRectList,
    Rect mainRect,
    double maxValue,
    double minValue,
    double topPadding,
    this.indicator,
    this.indicators,
    this.subIndicators,
    int i,
    int fixedLength,
    this.chartStyle,
    this.chartColors,
    this.scaleX,
  ) : super(
          chartRect: mainRect,
          maxValue: maxValue,
          minValue: minValue,
          chartStyle: chartStyle,
          topPadding: topPadding,
          fixedLength: fixedLength,
          gridColor: chartColors.gridColor,
        ) {
    isMain = i == 0;
    index = indicators
        .where((element) => element.type == indicator.type)
        .toList()
        .indexWhere((element) => element.id == indicator.id);
    mMACDWidth = this.chartStyle.macdWidth;
    subMainRenderer = SubMainRenderer(
      mainRect,
      maxValue,
      minValue,
      topPadding,
      fixedLength,
      chartStyle,
      chartColors,
      [indicator],
    );
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
    if (indicator.type == IndicatorType.RSI ||
        indicator.type == IndicatorType.MACD) {
      drawIndicators(
        lastPoint,
        curPoint,
        lastX,
        curX,
        size,
        canvas,
        false,
        false,
      );
    } else {
      subMainRenderer.drawIndicators(
        lastPoint,
        curPoint,
        lastX,
        curX,
        size,
        canvas,
        false,
        false,
      );
    }
  }

  @override
  void drawVerticalText(
    canvas,
    TextStyle textStyle,
    int gridRows,
  ) {
    double space = 17.0;
    if (isMain) {
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

      maxTp.paint(
        canvas,
        Offset(
          chartRect.rWidth + space,
          chartRect.top + topPadding - (maxTp.height / 2),
        ),
      );
      minTp.paint(
        canvas,
        Offset(
          chartRect.rWidth + space,
          chartRect.bottom - minTp.height,
        ),
      );
    }
    if (indicator.type == IndicatorType.MACD) {
      _setMACDLevels(canvas, textStyle, space);
    } else if (indicator.type == IndicatorType.RSI) {
      _setRSILevels(canvas, textStyle, space);
    }
  }

  @override
  void drawGrid(
    Canvas canvas,
    int gridRows,
    int gridColumns,
  ) {
    canvas.drawLine(
      Offset(0, chartRect.top),
      Offset(chartRect.rWidth, chartRect.top),
      darkPaint,
    ); //hidden line
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
        gridPaint,
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
    List<TextSpan> children = [];
    if (isMain) {
      for (int i = 0; i < subIndicators.length; i++) {
        final indicator = subIndicators[i];
        String values = '';
        if (i != 0) {
          if (indicator.type == IndicatorType.RSI) {
            values =
                '${format(mSecondaryRectList[i].mMinValue)}, ${indicator.levels.join(', ')}, ${format(mSecondaryRectList[i].mMaxValue)} ';
          } else {
            values =
                '${format(mSecondaryRectList[i].mMinValue)}, ${format(mSecondaryRectList[i].mMaxValue)} ';
          }
        }
        switch (indicator.type) {
          case IndicatorType.MACD:
            children.add(
              TextSpan(
                text:
                    'MACD(${indicator.macd!.fastEma},${indicator.macd!.slowEma},${indicator.macd!.macdSma}) $values',
                style:
                    getTextStyle(colorFromHex(indicator.macd!.signalColor!)!),
              ),
            );
            break;
          case IndicatorType.KDJ:
            children = [
              // TextSpan(
              //   text: "KDJ(9,1,3)    ",
              //   style: getTextStyle(this.chartColors.defaultTextColor),
              // ),
              // if (data.macd != 0)
              //   TextSpan(
              //     text: "K:${format(data.k)}    ",
              //     style: getTextStyle(this.chartColors.kColor),
              //   ),
              // if (data.dif != 0)
              //   TextSpan(
              //     text: "D:${format(data.d)}    ",
              //     style: getTextStyle(this.chartColors.dColor),
              //   ),
              // if (data.dea != 0)
              //   TextSpan(
              //     text: "J:${format(data.j)}    ",
              //     style: getTextStyle(this.chartColors.jColor),
              //   ),
            ];
            break;
          case IndicatorType.RSI:
            children.add(
              TextSpan(
                text: "RSI(${indicator.period}) $values",
                style: getTextStyle(colorFromHex(indicator.color!)!),
              ),
            );
            break;
          case IndicatorType.WR:
            children = [
              // TextSpan(
              //   text: "WR(14):${format(data.r)}    ",
              //   style: getTextStyle(this.chartColors.rsiColor),
              // ),
            ];
            break;
          case IndicatorType.CCI:
            children = [
              // TextSpan(
              //   text: "CCI(14):${format(data.cci)}    ",
              //   style: getTextStyle(this.chartColors.rsiColor),
              // ),
            ];
            break;
          default:
            break;
        }
      }
      TextPainter tp = TextPainter(
        text: TextSpan(children: children),
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(canvas, Offset(x, chartRect.top - topPadding));
    }
  }

  void drawMACD(
    CandleEntity curPoint,
    Canvas canvas,
    double curX,
    CandleEntity lastPoint,
    double lastX,
  ) {
    if (lastPoint.macdValues == null) return;
    // for (int i = 0; i < (curPoint.macdValues?.length ?? 0); i++) {
    final macd = curPoint.macdValues?[index].value ?? 0;
    double macdY = getY(macd);
    double r = mMACDWidth / 2;
    double zeroy = getY(0);
    if (macd > 0) {
      canvas.drawRect(
        Rect.fromLTRB(curX - r, macdY, curX + r, zeroy),
        chartPaint
          ..color = colorFromHex(curPoint.macdValues![index].macd!.mainColor!)!,
      );
    } else {
      canvas.drawRect(
        Rect.fromLTRB(curX - r, zeroy, curX + r, macdY),
        chartPaint
          ..color = colorFromHex(curPoint.macdValues![index].macd!.mainColor!)!,
      );
    }

    // for (int i = 0; i < (curPoint.macdSignalValues?.length ?? 0); i++) {
    if (lastPoint.macdSignalValues?[index].value != 0) {
      drawLine(
        lastPoint.macdSignalValues?[index].value,
        curPoint.macdSignalValues?[index].value,
        canvas,
        lastX,
        curX,
        colorFromHex(curPoint.macdValues![index].macd!.signalColor!)!,
      );
    }
    // }
    // }
  }

  void _setMACDLevels(canvas, TextStyle textStyle, double space) {
    if (isMain) {
      TextPainter tp = TextPainter(
        text: TextSpan(
          text: "${format(0)}",
          style: textStyle.copyWith(color: Colors.black),
        ),
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      final dy = getY(0);
      if (!minValue.toString().contains('e-')) {
        tp.paint(
          canvas,
          Offset(
            chartRect.rWidth + space,
            dy - (tp.height / 2),
          ),
        );
      }
    }
    drawHDashLine(
      0,
      0,
      canvas,
      0,
      chartRect.rWidth,
      Colors.black,
      strokeWidth: 0.4,
    );
  }

  void drawRSI(
    CandleEntity curPoint,
    Canvas canvas,
    double curX,
    CandleEntity lastPoint,
    double lastX,
  ) {
    if (curPoint.rsiValues == null) return;
    // for (int i = 0; i < (curPoint.rsiValues?.length ?? 0); i++) {
    if (lastPoint.rsiValues?[index].value != 0) {
      drawLine(
        lastPoint.rsiValues?[index].value,
        curPoint.rsiValues?[index].value,
        canvas,
        lastX,
        curX,
        colorFromHex(this.indicator.color!)!,
      );
    }
    // }
  }

  void _setRSILevels(canvas, TextStyle textStyle, double space) {
    for (var item in indicator.levels) {
      if (isMain) {
        TextPainter tp = TextPainter(
          text: TextSpan(
            text: "${format(item.toDouble())}",
            style: textStyle.copyWith(color: Colors.black),
          ),
          textDirection: TextDirection.ltr,
        );
        tp.layout();
        final dy = getY(item.toDouble());
        tp.paint(
          canvas,
          Offset(
            chartRect.rWidth + space,
            dy - (tp.height / 2),
          ),
        );
      }
      drawHDashLine(
        item.toDouble(),
        item.toDouble(),
        canvas,
        0,
        chartRect.rWidth,
        colorFromHex(this.indicator.levelsColor!)!,
        strokeWidth: 0.4,
      );
    }
  }
}
