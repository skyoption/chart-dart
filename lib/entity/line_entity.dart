import 'package:flutter/material.dart';

class LineEntity {
  final int id;
  final Color color;
  final double value;
  final bool editable;
  final String title, type;

  LineEntity({
    required this.id,
    required this.color,
    required this.value,
    this.title = '',
    this.type = '',
    this.editable = false,
  });
}
