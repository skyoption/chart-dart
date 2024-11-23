import 'dart:ui';
import 'dart:math';
import 'package:candle_chart/entity/object_entity.dart';
import 'package:candle_chart/renderer/base_chart_renderer.dart';
import 'package:candle_chart/renderer/chart_details.dart';
import 'package:candle_chart/utils/kprint.dart';

mixin UpdatePointPosition on ChartCalc {
  late final ChartPosition chartPosition;
  late final ChartStyle chartStyle;
  late final BaseChartRenderer mMainRenderer;
  late final double screenHeight;
  late final Rect mMainRect;

  int updateOffsetPoint({
    required Offset offset,
    required List<ObjectEntity> linesPrice,
  }) {
    return findLineNearOffset(
      offset: offset,
      linesPrice: linesPrice,
    );
  }

  int findLineNearOffset({
    required Offset offset,
    required List<ObjectEntity> linesPrice,
  }) {
    for (int i = 0; i < linesPrice.length; i++) {
      var line = linesPrice[i];
      if (line.type == ObjectType.Horizontal) {
        final dy1 = offset.dy - 75.0 - (offset.dy < 150 ? 20 : 0);
        final dy2 = getMainY(line.value);
        final disDy = dy2 - dy1;
        if (disDy.abs() <= 20) {
          return i;
        }
      } else if (line.type == ObjectType.Vertical) {
        final dx1 = getX(mStartIndex) +
            offset.dx -
            chartStyle.leftPadding -
            chartStyle.rightPadding;
        final dx2 =  line.dx1;
        final disDx = dx2 - dx1;
        kPrint(disDx.abs());
        if (disDx.abs() <= 20) {
          return i;
        }
      }
    }
    return -1;
  }

  bool _isNearLine(
    Offset start,
    Offset end,
    Offset point, {
    double threshold = 30.0,
  }) {
    double distance = _distanceFromLine(start, end, point);
    return distance < threshold;
  }

  double _distanceFromLine(
    Offset start,
    Offset end,
    Offset point,
  ) {
    double px = end.dx - start.dx;
    double py = end.dy - start.dy;

    double norm = px * px + py * py;
    double u = ((point.dx - start.dx) * px + (point.dy - start.dy) * py) / norm;

    if (u > 1)
      u = 1;
    else if (u < 0) u = 0;

    double x = start.dx + u * px;
    double y = start.dy + u * py;

    double dx = x - point.dx;
    double dy = y - point.dy;

    return sqrt(dx * dx + dy * dy);
  }
}
