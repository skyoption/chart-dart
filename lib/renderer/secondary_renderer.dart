import 'package:candle_chart/entity/candle_entity.dart';
import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/k_chart_widget.dart';
import 'package:candle_chart/renderer/main_renderer.dart';
import 'package:candle_chart/renderer/rects/render_rect.dart';
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
  late final bool isMain, isLast, hideGrid;
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
    this.hideGrid,
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
        indicator.type == IndicatorType.MACD ||
        indicator.type == IndicatorType.ATR ||
        indicator.type == IndicatorType.WPR ||
        indicator.type == IndicatorType.DEM ||
        indicator.type == IndicatorType.CCI ||
        indicator.type == IndicatorType.MFI ||
        indicator.type == IndicatorType.SO_EMA ||
        indicator.type == IndicatorType.SO_LINEAR ||
        indicator.type == IndicatorType.SO_SMA ||
        indicator.type == IndicatorType.SO_SMMA ||
        indicator.type == IndicatorType.MOM) {
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
            style: textStyle.copyWith(color: chartColors.maxColor)),
        textDirection: TextDirection.ltr,
      );
      maxTp.layout();
      TextPainter minTp = TextPainter(
        text: TextSpan(
            text: "${format(minValue)}",
            style: textStyle.copyWith(color: chartColors.maxColor)),
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
    _setLevels(canvas, textStyle, space);
  }

  @override
  void drawGrid(Canvas canvas, int gridRows, int gridColumns, double width,
      double height) {
    if (!hideGrid) {
      double cellSize = height / gridRows;
      double columnSpace = cellSize;
      int gridColumns = (width / cellSize).floor() + 1;
      double startX = width - (gridColumns * cellSize);

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
      for (int i = 0; i <= gridColumns; i++) {
        double xPos = startX + (columnSpace * i);
        canvas.drawLine(
          Offset(xPos, chartRect.top),
          Offset(xPos, chartRect.bottom),
          gridPaint,
        );
      }
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
    if (indicator.type == IndicatorType.MACD) {
      drawMACD(
        curPoint,
        canvas,
        curX,
        lastPoint,
        lastX,
      );
    } else if (indicator.type == IndicatorType.RSI) {
      drawRSI(
        curPoint,
        canvas,
        curX,
        lastPoint,
        lastX,
      );
    } else if (indicator.type == IndicatorType.ATR) {
      drawATR(
        curPoint,
        canvas,
        curX,
        lastPoint,
        lastX,
      );
    } else if (indicator.type == IndicatorType.CCI) {
      drawCCI(
        curPoint,
        canvas,
        curX,
        lastPoint,
        lastX,
      );
    } else if (indicator.type == IndicatorType.DEM) {
      drawDEM(
        curPoint,
        canvas,
        curX,
        lastPoint,
        lastX,
      );
    } else if (indicator.type == IndicatorType.MOM) {
      drawMOM(
        curPoint,
        canvas,
        curX,
        lastPoint,
        lastX,
      );
    } else if (indicator.type == IndicatorType.WPR) {
      drawWPR(
        curPoint,
        canvas,
        curX,
        lastPoint,
        lastX,
      );
    } else if (indicator.type == IndicatorType.MFI) {
      drawMFI(
        curPoint,
        canvas,
        curX,
        lastPoint,
        lastX,
      );
    } else if (indicator.type == IndicatorType.SO_SMMA ||
        indicator.type == IndicatorType.SO_LINEAR ||
        indicator.type == IndicatorType.SO_SMA ||
        indicator.type == IndicatorType.SO_EMA) {
      drawSO(
        curPoint,
        canvas,
        curX,
        lastPoint,
        lastX,
      );
    }
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
          case IndicatorType.RSI:
            children.add(
              TextSpan(
                text: "RSI(${indicator.period}) $values",
                style: getTextStyle(colorFromHex(indicator.color!)!),
              ),
            );
            break;
          case IndicatorType.CCI:
            children = [
              TextSpan(
                text: "CCI(${indicator.period}) $values",
                style: getTextStyle(colorFromHex(indicator.color!)!),
              ),
            ];
            break;
          case IndicatorType.ATR:
            children = [
              TextSpan(
                text: "ATR(${indicator.period}) $values",
                style: getTextStyle(colorFromHex(indicator.color!)!),
              ),
            ];
            break;
          case IndicatorType.DEM:
            children = [
              TextSpan(
                text: "DeM(${indicator.period}) $values",
                style: getTextStyle(colorFromHex(indicator.color!)!),
              ),
            ];
            break;
          case IndicatorType.MOM:
            children = [
              TextSpan(
                text: "Momentum(${indicator.period}) $values",
                style: getTextStyle(colorFromHex(indicator.color!)!),
              ),
            ];
            break;
          default:
            children = [
              TextSpan(
                text: "${indicator.type.name}(${indicator.period}) $values",
                style: getTextStyle(colorFromHex(indicator.color!)!),
              ),
            ];
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

    if (lastPoint.macdSignalValues != null &&
        curPoint.macdValues != null &&
        lastPoint.macdSignalValues?[index].value != 0) {
      drawLine(
        lastPoint.macdSignalValues?[index].value,
        curPoint.macdSignalValues?[index].value,
        canvas,
        lastX,
        curX,
        colorFromHex(curPoint.macdValues![index].macd!.signalColor!)!,
      );
    }
  }

  void drawDEM(
    CandleEntity curPoint,
    Canvas canvas,
    double curX,
    CandleEntity lastPoint,
    double lastX,
  ) {
    if (curPoint.deMarkerValues == null) return;
    if (lastPoint.deMarkerValues?[index].value != 0) {
      drawLine(
        lastPoint.deMarkerValues?[index].value,
        curPoint.deMarkerValues?[index].value,
        canvas,
        lastX,
        curX,
        colorFromHex(this.indicator.color!)!,
      );
    }
  }

  void drawMOM(
    CandleEntity curPoint,
    Canvas canvas,
    double curX,
    CandleEntity lastPoint,
    double lastX,
  ) {
    if (curPoint.momentumValues == null) return;
    if (lastPoint.momentumValues?[index].value != 0) {
      drawLine(
        lastPoint.momentumValues?[index].value,
        curPoint.momentumValues?[index].value,
        canvas,
        lastX,
        curX,
        colorFromHex(this.indicator.color!)!,
      );
    }
  }

  void drawWPR(
    CandleEntity curPoint,
    Canvas canvas,
    double curX,
    CandleEntity lastPoint,
    double lastX,
  ) {
    if (curPoint.wprValues == null) return;
    if (lastPoint.wprValues?[index].value != 0) {
      drawLine(
        lastPoint.wprValues?[index].value,
        curPoint.wprValues?[index].value,
        canvas,
        lastX,
        curX,
        colorFromHex(this.indicator.color!)!,
      );
    }
  }

  void drawMFI(
    CandleEntity curPoint,
    Canvas canvas,
    double curX,
    CandleEntity lastPoint,
    double lastX,
  ) {
    if (curPoint.mfiValues == null) return;
    if (lastPoint.mfiValues?[index].value != 0) {
      drawLine(
        lastPoint.mfiValues?[index].value,
        curPoint.mfiValues?[index].value,
        canvas,
        lastX,
        curX,
        colorFromHex(this.indicator.color!)!,
      );
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
  }

  void drawATR(
    CandleEntity curPoint,
    Canvas canvas,
    double curX,
    CandleEntity lastPoint,
    double lastX,
  ) {
    if (curPoint.atrValues == null) return;
    if (lastPoint.atrValues?[index].value != 0) {
      drawLine(
        lastPoint.atrValues?[index].value,
        curPoint.atrValues?[index].value,
        canvas,
        lastX,
        curX,
        colorFromHex(this.indicator.color!)!,
      );
    }
  }

  void drawCCI(
    CandleEntity curPoint,
    Canvas canvas,
    double curX,
    CandleEntity lastPoint,
    double lastX,
  ) {
    if (curPoint.cciValues == null) return;
    if (lastPoint.cciValues != null &&
        lastPoint.cciValues?[index].value != 0 &&
        !lastPoint.cciValues![index].value.isNaN) {
      drawLine(
        lastPoint.cciValues?[index].value,
        curPoint.cciValues?[index].value,
        canvas,
        lastX,
        curX,
        colorFromHex(this.indicator.color!)!,
      );
    }
  }

  void drawSO(
    CandleEntity curPoint,
    Canvas canvas,
    double curX,
    CandleEntity lastPoint,
    double lastX,
  ) {
    if (curPoint.stochasticValues == null) return;
    if (lastPoint.stochasticValues != null) {
      drawLine(
        lastPoint.stochasticValues?[index].kValue,
        curPoint.stochasticValues?[index].kValue,
        canvas,
        lastX,
        curX,
        colorFromHex(curPoint.stochasticValues![index].stochastic!.mainColor!)!,
      );
      drawLine(
        lastPoint.stochasticValues?[index].dValue,
        curPoint.stochasticValues?[index].dValue,
        canvas,
        lastX,
        curX,
        colorFromHex(
            curPoint.stochasticValues![index].stochastic!.signalColor!)!,
      );
    }
  }

  void _setLevels(canvas, TextStyle textStyle, double space) {
    for (var item in indicator.levels) {
      if (item >= minValue && item <= maxValue) {
        if (isMain) {
          TextPainter tp = TextPainter(
            text: TextSpan(
              text: "${format(item.toDouble())}",
              style: textStyle.copyWith(color: chartColors.maxColor),
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
}
