import 'package:flutter/material.dart';

class LineEntity {
  final int id;
  final Color color;
  final double value;
  final bool editable;
  final String type;
  final String Function(double value) title;

  LineEntity({
    required this.id,
    required this.color,
    required this.value,
    required this.title,
    this.type = '',
    this.editable = false,
  });
}
