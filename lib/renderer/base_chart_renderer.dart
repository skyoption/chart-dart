import 'dart:ui';

import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/entity/line_entity.dart';
import 'package:flutter/material.dart';

export '../chart_style.dart';

extension OnRect on Rect {
  double get rWidth => width;
}

extension OnSize on Size {
  double get rWidth => width;
}

abstract class BaseChartRenderer<T> {
  double maxValue, minValue;
  late double scaleY;
  double topPadding;
  Rect chartRect;
  int fixedLength;
  Paint chartPaint = Paint()
    ..isAntiAlias = true
    ..filterQuality = FilterQuality.high
    ..strokeWidth = 1.0
    ..color = Colors.red;
  Paint gridPaint = Paint()
    ..isAntiAlias = true
    ..filterQuality = FilterQuality.high
    //EMA
    ..strokeWidth = 0.21
    ..color = Color(0xff4c5c74);

  BaseChartRenderer({
    required this.chartRect,
    required this.maxValue,
    required this.minValue,
    required this.topPadding,
    required this.fixedLength,
    required Color gridColor,
  }) {
    if (maxValue == minValue) {
      maxValue *= 1.5;
      minValue /= 2;
    }
    scaleY = chartRect.height / (maxValue - minValue);
    gridPaint.color = gridColor;
    // print("maxValue=====" + maxValue.toString() + "====minValue===" + minValue.toString() + "==scaleY==" + scaleY.toString());
  }

  double getY(double y) => (maxValue - y) * scaleY + chartRect.top;

  double getYInChart(double y) => (maxValue - y) * scaleY + chartRect.top;

  String format(double? n, {isNotPoint = false}) {
    if (n == null || n.isNaN) {
      return "0.00";
    } else {
      if (isNotPoint) {
        return n.toStringAsFixed(2);
      }
      //EMA
      return formatValue(n);
      // if (fixedLength > 21) {
      //   return n.toStringAsFixed(fixedLength ~/ 2);
      // } else {
      //   return n.toStringAsFixed(fixedLength);
      // }
    }
  }

  // void main() {
  //   double value1 = 0.0000000002010;
  //   double value2 = 61210.543912929212;
  //   double value3 = 0.000123456;
  //   double value4 = 0.987654;
  //
  //   String formattedValue1 = formatValue(value1);
  //   String formattedValue2 = formatValue(value2);
  //   String formattedValue3 = formatValue(value3);
  //   String formattedValue4 = formatValue(value4);
  //
  //   print('Formatted Value1: $formattedValue1');
  //   print('Formatted Value2: $formattedValue2');
  //   print('Formatted Value3: $formattedValue3');
  //   print('Formatted Value4: $formattedValue4');
  // }

  int getDecimalPlaces(double number) {
    String numberString = number.toString();
    int decimalIndex = numberString.indexOf('.');
    if (decimalIndex == -1) {
      return 0; // 没有小数部分
    }
    return numberString.length - decimalIndex - 1;
  }

  void drawGrid(Canvas canvas, int gridRows, int gridColumns);

  void drawText(Canvas canvas, T data, double x);

  void drawVerticalText(canvas, textStyle, int gridRows);

  void drawChart(
    T lastPoint,
    T curPoint,
    double lastX,
    double curX,
    Size size,
    Canvas canvas,
  );

  void drawIndicators(
    T lastPoint,
    T curPoint,
    double lastX,
    double curX,
    Size size,
    Canvas canvas,
    bool drawAsBackground,
  );

  void drawRect(
    List<Offset> offsets,
    Color color,
    Canvas canvas,
  ) {
    if (offsets.isEmpty) return;
    final path = Path();
    path.moveTo(offsets[0].dx, offsets[0].dy);
    for (var offset in offsets.skip(1)) {
      path.lineTo(offset.dx, offset.dy);
    }
    path.close();
    canvas.drawPath(
      path,
      chartPaint
        ..color = color
        ..style = PaintingStyle.fill,
    );
  }

  void drawLine(
    double? lastPrice,
    double? curPrice,
    Canvas canvas,
    double lastX,
    double curX,
    Color color, {
    LineStyle lineStyle = LineStyle.normal,
    double strokeWidth = 1.0,
    bool isDot = false,
  }) {
    if (lastPrice == null || curPrice == null) {
      return;
    }
    _drawLine(
      lastPrice,
      curPrice,
      canvas,
      lastX,
      curX,
      color,
      lineStyle,
      strokeWidth,
      isDot: isDot,
    );
  }

  void drawDashLine(
    double? lastPrice,
    double? curPrice,
    Canvas canvas,
    double lastX,
    double curX,
    Color color, {
    double strokeWidth = 1.0,
  }) {
    if (lastPrice == null || curPrice == null) {
      return;
    }
    _drawDashLine(
      lastPrice,
      curPrice,
      canvas,
      lastX,
      curX,
      color,
      strokeWidth,
    );
  }

  void _drawLine(
    double? lastPrice,
    double? curPrice,
    Canvas canvas,
    double lastX,
    double curX,
    Color color,
    LineStyle style,
    double strokeWidth, {
    bool isDot = false,
  }) {
    if (lastPrice == null || curPrice == null) {
      return;
    }
    double lastY = getY(lastPrice);
    double curY = getY(curPrice);
    if (style == LineStyle.dash || style == LineStyle.longDash) {
      canvas.drawPoints(
        PointMode.points,
        [Offset(curX, curY)],
        chartPaint
          ..color = color
          ..strokeWidth = 3.0,
      );
    } else if (isDot) {
      canvas.drawCircle(
        Offset(curX, curY),
        strokeWidth / 2,
        chartPaint
          ..color = color
          ..style = PaintingStyle.fill,
      );
    } else {
      canvas.drawLine(
        Offset(lastX, lastY),
        Offset(curX, curY),
        chartPaint
          ..color = color
          ..strokeWidth = strokeWidth,
      );
    }
  }

  void _drawDashLine(
    double? lastPrice,
    double? curPrice,
    Canvas canvas,
    double lastX,
    double curX,
    Color color,
    double strokeWidth,
  ) {
    if (lastPrice == null || curPrice == null) {
      return;
    }
    double lastY = getY(lastPrice);
    double curY = getY(curPrice);
    while (lastY < curY - 2) {
      canvas.drawPoints(
        PointMode.lines,
        [
          Offset(lastX, lastY),
          Offset(curX, lastY + 1.0),
        ],
        chartPaint
          ..color = color
          ..strokeWidth = strokeWidth,
      );
      lastY += 2.0;
    }
    while (curY < lastY - 2) {
      canvas.drawPoints(
        PointMode.lines,
        [
          Offset(lastX, curY),
          Offset(curX, curY + 1.0),
        ],
        chartPaint
          ..color = color
          ..strokeWidth = strokeWidth,
      );
      curY += 2.0;
    }
  }

  TextStyle getTextStyle(Color color) {
    return TextStyle(fontSize: 10.0, color: color);
  }
}

//EMA
String formatValue(double? value) {
  if (value == null) {
    return '';
  }
  if (value < 1e-6) {
    // 对于非常小的数值，显示足够多的小数位
    return value
        .toStringAsFixed(13)
        .replaceAll(RegExp(r'0*$'), '')
        .replaceAll(RegExp(r'\.$'), '');
  } else if (value < 0.0001) {
    // 对于小于0.0001的数值，显示13位小数
    return value
        .toStringAsFixed(13)
        .replaceAll(RegExp(r'0*$'), '')
        .replaceAll(RegExp(r'\.$'), '');
    // return value.toString();
  } else if (value < 1) {
    // 对于小于1但不非常小的数值，显示最多6位小数
    return value
        .toStringAsFixed(6)
        .replaceAll(RegExp(r'0*$'), '')
        .replaceAll(RegExp(r'\.$'), '');
  } else if (value < 1000) {
    // 对于大于等于1且小于1000的数值，保留2位小数
    return value
        .toStringAsFixed(2)
        .replaceAll(RegExp(r'0*$'), '')
        .replaceAll(RegExp(r'\.$'), '');
  } else {
    // 对于大于等于1000的数值，保留1位小数
    return value
        .toStringAsFixed(1)
        .replaceAll(RegExp(r'0*$'), '')
        .replaceAll(RegExp(r'\.$'), '');
  }
}

// String formatValue(double? valueOrigin) {
//   Decimal? value = Decimal.fromJson('${valueOrigin?? 0.0}');
//   if (value == null) return '-';
//   if (value < Decimal.parse('0.01')) {
//     final temp = value.toString().split('.');
//     if (temp.length != 2) {
//       return value.dollarValue(2);
//     }
//     var index = 0;
//     for (; index < temp[1].length; index++) {
//       if (temp[1][index] != '0') {
//         break;
//       }
//     }
//     final remain = temp[1].replaceRange(0, index, '');
//     return '\$0.0${index}${remain.substring(0, min(remain.length, 4))}';
//   }
//   if (value >= Decimal.fromInt(1000000000)) {
//     return '${(value / Decimal.fromInt(1000000000)).toDecimal().dollarValue(2)}B';
//   } else if (value >= Decimal.fromInt(1000000)) {
//     return '${(value / Decimal.fromInt(1000000)).toDecimal().dollarValue(2)}M';
//   } else if (value >= Decimal.fromInt(1000)) {
//     return '${(value / Decimal.fromInt(1000)).toDecimal().dollarValue(2)}K';
//   } else {
//     return value.dollarValue(2);
//   }
// }
