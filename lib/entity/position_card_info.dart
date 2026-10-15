import 'package:flutter/material.dart';

/// Extra details shown on the chart card of a position or pending order.
/// Closures are read on every repaint, so values tick with the quotes.
class PositionCardInfo {
  /// Side label, e.g. `BUY` / `SELL LIMIT`.
  final String badge;
  final Color badgeColor;

  /// Second row, e.g. `Open 4102.16 · SL 4090.00 · TP 4120.00`.
  final String Function() subtitle;

  /// Highlighted value on the first row, e.g. the floating P/L.
  final String Function()? trailing;
  final Color Function()? trailingColor;

  const PositionCardInfo({
    required this.badge,
    required this.badgeColor,
    required this.subtitle,
    this.trailing,
    this.trailingColor,
  });
}
