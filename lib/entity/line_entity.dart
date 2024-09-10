import 'dart:ui';

import 'package:flutter/material.dart';

enum LineStyle { dash, normal, longDash }

enum LineType { vertical, horizontal, trend }

class LineEntity {
  double dy,newDy;
  double value;
  Color color;
  LineStyle style;
  LineType type;
  double height;
  String name;
  String symbol;
  bool drawAsBackground;
  bool editable;

  LineEntity({
    this.value = 50559.50,
    this.dy = 0,
    this.newDy = 0,
    this.editable = false,
    this.color = Colors.black,
    this.name = '',
    this.symbol = '',
    this.height = 1.2,
    this.style = LineStyle.normal,
    this.type = LineType.horizontal,
    this.drawAsBackground = false,
  });
}
