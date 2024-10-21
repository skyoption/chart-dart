import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:isar/isar.dart';

part 'line_entity.g.dart';

enum LineStyle { dash, normal, longDash }

enum LineType { vertical, horizontal, trend }

@collection
class LineEntity {
  Id id = Isar.autoIncrement;
  double dy, newDy;
  double value;
  String? color = Colors.black.toHexString();
  @enumerated
  LineStyle style;
  @enumerated
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
    this.color,
    this.name = '',
    this.symbol = '',
    this.height = 1.2,
    this.style = LineStyle.normal,
    this.type = LineType.horizontal,
    this.drawAsBackground = false,
  }) {
    color = Colors.black.toHexString();
  }
}
