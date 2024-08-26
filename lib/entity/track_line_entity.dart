import 'dart:ui';

enum LineType { dash, normal }

class TrackLineEntity {
  final double value;
  final Color color;
  final LineType type;
  final double height;

  TrackLineEntity({
    required this.value,
    required this.color,
    this.height = 1.2,
    this.type = LineType.normal,
  });
}
