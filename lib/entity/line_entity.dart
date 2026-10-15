import 'package:flutter/material.dart';

import 'position_card_info.dart';

class LineEntity {
  final int id;
  final Color color;
  final double value;
  final bool editable;
  final String type;
  final String Function(double value) title;

  /// Optional card details (side badge, subtitle, live P/L).
  final PositionCardInfo? card;

  LineEntity({
    required this.id,
    required this.color,
    required this.value,
    required this.title,
    this.type = '',
    this.editable = false,
    this.card,
  });
}
