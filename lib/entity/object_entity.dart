import 'package:candle_chart/k_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:isar_community/isar.dart';

part 'object_entity.g.dart';

enum ObjectStyle { dash, normal }

enum ObjectType {
  Vertical,
  Horizontal,
  Position,
  Trend,
  Rectangle,
  Cursor,
  Fibonacci,
  FibonacciTimeZones,
  FibonacciFan,
}

/// Standard Fibonacci retracement levels (as ratios of the price move):
/// 0.0, 23.6, 38.2, 50, 61.8, 100, 161.8, 261.8, 423.6 percent.
const List<double> kFibonacciLevels = [
  0.0,
  0.236,
  0.382,
  0.5,
  0.618,
  1.0,
  1.618,
  2.618,
  4.236,
];

/// Fibonacci Time Zone levels — multiples of the unit interval following the
/// Fibonacci sequence: 0, 1, 2, 3, 5, 8, 13, 21, 34, 55.
const List<double> kFibonacciTimeZoneLevels = [
  0.0,
  1.0,
  2.0,
  3.0,
  5.0,
  8.0,
  13.0,
  21.0,
  34.0,
  55.0,
];

/// Fibonacci Fan levels — the fan rays cross the vertical through the second
/// point at 38.2%, 50% and 61.8% of the price range.
const List<double> kFibonacciFanLevels = [
  0.382,
  0.5,
  0.618,
];

/// Distinct colors used to render each Fibonacci level line, so levels are
/// visually separable instead of sharing the object's single color.
const List<Color> kFibonacciLevelColors = [
  Color(0xFF9E9E9E), // grey
  Color(0xFFEF5350), // red
  Color(0xFFFF9800), // orange
  Color(0xFF66BB6A), // green
  Color(0xFF26C6DA), // cyan
  Color(0xFF5C6BC0), // indigo
  Color(0xFFAB47BC), // purple
  Color(0xFFEC407A), // pink
  Color(0xFF8D6E63), // brown
  Color(0xFF9CCC65), // olive
];

/// Returns a distinct color for the Fibonacci level at [index] (cycles).
Color fibonacciLevelColor(int index) {
  return kFibonacciLevelColors[index % kFibonacciLevelColors.length];
}

@collection
class ObjectEntity {
  Id id;
  double value, value2;
  String? color;
  @enumerated
  ObjectStyle style;
  @enumerated
  ObjectType type;
  @enumerated
  CandleTimeFormat frame;
  double height;
  double dx1, dx2, dy1, dy2;
  String name;
  @ignore
  String Function(double value)? title;
  int datetime, datetime2;
  String symbol;
  bool drawAsBackground;
  bool isFill;
  bool editable;
  bool rayRight;
  bool rayLift;
  int currentEditIndex;

  ObjectEntity({
    this.id = Isar.autoIncrement,
    this.value = 0,
    this.value2 = 0,
    this.dx1 = 0,
    this.dx2 = 0,
    this.dy1 = 0,
    this.dy2 = 0,
    this.currentEditIndex = -1,
    this.color,
    this.name = '',
    this.datetime = 0,
    this.datetime2 = 0,
    this.symbol = '',
    this.title,
    this.height = 1.0,
    this.style = ObjectStyle.normal,
    this.type = ObjectType.Horizontal,
    this.frame = CandleTimeFormat.H4,
    this.drawAsBackground = false,
    this.isFill = false,
    this.rayRight = false,
    this.editable = false,
    this.rayLift = false,
  }) {
    color ??= Colors.blue.toHexString();
  }
}
