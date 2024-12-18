import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:isar/isar.dart';

import '../utils/date_util.dart';

part 'object_entity.g.dart';

enum ObjectStyle { dash, normal }

enum ObjectType { Vertical, Horizontal, Trend, Rectangle }

@collection
class ObjectEntity {
  Id id = Isar.autoIncrement;
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
  int datetime, datetime2;
  String symbol;
  bool drawAsBackground;
  bool isFill;
  bool rayRight;
  bool rayLift;
  int currentEditIndex;

  ObjectEntity({
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
    this.height = 0.8,
    this.style = ObjectStyle.normal,
    this.type = ObjectType.Horizontal,
    this.frame = CandleTimeFormat.H4,
    this.drawAsBackground = false,
    this.isFill = false,
    this.rayRight = false,
    this.rayLift = false,
  }) {
    color ??= Colors.blue.toHexString();
  }
}
