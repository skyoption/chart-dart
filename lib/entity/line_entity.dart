import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:isar/isar.dart';

part 'line_entity.g.dart';

enum LineStyle { dash, normal, longDash }

enum LineType { vertical, horizontal, trend }

@collection
class LineEntity {
  Id id = Isar.autoIncrement;
  double value;
  String? color = Colors.black.toHexString();
  @enumerated
  LineStyle style;
  @enumerated
  LineType type;
  double height;
  double dx1,dx2,dy1,dy2;
  String name;
  int datetime;
  String symbol;
  bool drawAsBackground;
  int currentEditIndex;

  LineEntity({
    this.value = 50559.50,
    this.dx1 = 0,
    this.dx2 = 0,
    this.dy1 = 0,
    this.dy2 = 0,
    this.currentEditIndex = -1,
    this.color,
    this.name = '',
    this.datetime = 0,
    this.symbol = '',
    this.height = 1.2,
    this.style = LineStyle.normal,
    this.type = LineType.horizontal,
    this.drawAsBackground = false,
  }) {
    color = Colors.black.toHexString();
  }
}
