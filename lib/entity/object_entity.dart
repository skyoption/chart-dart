import 'package:candle_chart/k_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:isar_community/isar.dart';

part 'object_entity.g.dart';

enum ObjectStyle { dash, normal }

enum ObjectType { Vertical, Horizontal, Position, Trend, Rectangle, Cursor }

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
