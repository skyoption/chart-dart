import 'dart:ui';

import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/entity/object_entity.dart';
import 'package:candle_chart/renderer/base_chart_renderer.dart';
import 'package:candle_chart/renderer/chart_details.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';

mixin UpdatePointPosition on ChartCalc {
  late final ChartPosition chartPosition;
  late final ChartStyle chartStyle;
  late final BaseChartRenderer mMainRenderer;
  late final double screenHeight;
  late final Rect mMainRect;
  late double scaleX;
  late double scaleY;

  NearObject findNearOffset({
    required Offset offset,
    List<KLineEntity> data = const [],
  }) {
    final nearObject = NearObject();
    int horizontalCount = 0,
        verticalCount = 0,
        positionCount = 0,
        rectangleCount = 0,
        trendCount = 0,
        fibonacciCount = 0,
        timeZoneCount = 0,
        fanCount = 0,
        arcsCount = 0,
        channelCount = 0,
        expansionCount = 0;
    for (var item in chartProperties.tPAndSLLines) item.currentEditIndex = -1;
    for (var item in chartProperties.objects) item.currentEditIndex = -1;
    final objects = [
      ...chartProperties.objects,
      ...chartProperties.tPAndSLLines
    ];

    // Handle X must be derived from the point's datetime (same as drawing), not
    // the stored dx — after a restart/reload the candle array can re-index, so
    // the stored dx goes stale while getXFromTime stays correct. Falls back to
    // the stored dx when no data is available.
    double handleX(int datetime, double storedDx) =>
        data.isEmpty ? storedDx : getXFromTime(datetime, data);

    for (int i = 0; i < objects.length; i++) {
      var object = objects[i];
      if (object.type == ObjectType.Horizontal) {
        final dy1 = offset.dy;
        final dy2 = getMainY(object.value);
        if (dy2 == null) {
          horizontalCount++;
          continue;
        }
        final disDy = dy2 - dy1;
        if (disDy.abs() <= 20) {
          object.currentEditIndex = horizontalCount;
          nearObject.object = object;
          nearObject.isSecondPoint = false;
          return nearObject;
        }
        horizontalCount++;
      } else if (object.type == ObjectType.Position) {
        final dy1 = offset.dy;
        // Hit-test the Y the line is actually drawn at: a TP/SL whose price sits
        // outside the visible high/low window is pinned to the nearest edge, so
        // testing the raw price would put the grab zone off screen.
        final dy2 = getMainY(object.value.clamp(
          chartPosition.bottomPrice,
          chartPosition.topPrice,
        ));
        if (dy2 == null) {
          positionCount++;
          continue;
        }
        final disDy = dy2 - dy1;
        if (disDy.abs() <= 20) {
          object.currentEditIndex = positionCount;
          nearObject.object = object;
          nearObject.isSecondPoint = false;
          return nearObject;
        }
        positionCount++;
      } else if (object.type == ObjectType.Vertical) {
        final dx1 = getX(mStartIndex) + (offset.dx / scaleX);
        final dx2 = handleX(object.datetime, object.dx1);
        final disDx = dx2 - dx1;
        if (disDx.abs() <= 20) {
          object.currentEditIndex = verticalCount;
          nearObject.object = object;
          nearObject.isSecondPoint = false;
          return nearObject;
        }
        verticalCount++;
      } else if (object.type == ObjectType.Fibonacci) {
        // Fibonacci is defined by two horizontal boundary levels (0.0 and 1.0).
        // Allow grabbing the top point (value) or bottom point (value2) by
        // vertical proximity anywhere along the full width of the level line.
        final dy0 = offset.dy;
        final y1 = getMainY(object.value);
        final y2 = getMainY(object.value2);
        if (y1 == null || y2 == null) {
          fibonacciCount++;
          continue;
        }
        final disDy1 = (y1 - dy0).abs();
        final disDy2 = (y2 - dy0).abs();
        if (disDy1 <= 20 || disDy2 <= 20) {
          object.currentEditIndex = fibonacciCount;
          nearObject.object = object;
          // Grab whichever boundary point is closer to the tap.
          nearObject.isSecondPoint = disDy2 < disDy1;
          return nearObject;
        }
        fibonacciCount++;
      } else if (object.type == ObjectType.FibonacciTimeZones) {
        // Two anchor points define the unit interval; grab either one.
        final dx0 = getX(mStartIndex) + (offset.dx / scaleX);
        final dy0 = offset.dy;
        final y1 = getMainY(object.value);
        final y2 = getMainY(object.value2);
        final near1 = y1 != null &&
            (handleX(object.datetime, object.dx1) - dx0).abs() <= 20 &&
            (y1 - dy0).abs() <= 20;
        final near2 = y2 != null &&
            (handleX(object.datetime2, object.dx2) - dx0).abs() <= 20 &&
            (y2 - dy0).abs() <= 20;
        if (near1) {
          object.currentEditIndex = timeZoneCount;
          nearObject.object = object;
          nearObject.isSecondPoint = false;
          return nearObject;
        } else if (near2) {
          object.currentEditIndex = timeZoneCount;
          nearObject.object = object;
          nearObject.isSecondPoint = true;
          return nearObject;
        }
        timeZoneCount++;
      } else if (object.type == ObjectType.FibonacciFan) {
        // Two anchor points define the fan; grab either one.
        final dx0 = getX(mStartIndex) + (offset.dx / scaleX);
        final dy0 = offset.dy;
        final y1 = getMainY(object.value);
        final y2 = getMainY(object.value2);
        final near1 = y1 != null &&
            (handleX(object.datetime, object.dx1) - dx0).abs() <= 20 &&
            (y1 - dy0).abs() <= 20;
        final near2 = y2 != null &&
            (handleX(object.datetime2, object.dx2) - dx0).abs() <= 20 &&
            (y2 - dy0).abs() <= 20;
        if (near1) {
          object.currentEditIndex = fanCount;
          nearObject.object = object;
          nearObject.isSecondPoint = false;
          return nearObject;
        } else if (near2) {
          object.currentEditIndex = fanCount;
          nearObject.object = object;
          nearObject.isSecondPoint = true;
          return nearObject;
        }
        fanCount++;
      } else if (object.type == ObjectType.FibonacciArcs) {
        // Two anchor points define the arcs; grab either one.
        final dx0 = getX(mStartIndex) + (offset.dx / scaleX);
        final dy0 = offset.dy;
        final y1 = getMainY(object.value);
        final y2 = getMainY(object.value2);
        final near1 = y1 != null &&
            (handleX(object.datetime, object.dx1) - dx0).abs() <= 20 &&
            (y1 - dy0).abs() <= 20;
        final near2 = y2 != null &&
            (handleX(object.datetime2, object.dx2) - dx0).abs() <= 20 &&
            (y2 - dy0).abs() <= 20;
        if (near1) {
          object.currentEditIndex = arcsCount;
          nearObject.object = object;
          nearObject.isSecondPoint = false;
          return nearObject;
        } else if (near2) {
          object.currentEditIndex = arcsCount;
          nearObject.object = object;
          nearObject.isSecondPoint = true;
          return nearObject;
        }
        arcsCount++;
      } else if (object.type == ObjectType.FibonacciChannel) {
        // Three draggable points: base start, base end, and width point.
        // Pick the CLOSEST point to the tap (not a priority order), so the
        // end/width point can be grabbed even when it sits near another point.
        // A point off the visible price range (getMainY == null) is skipped
        // rather than blocking the others.
        final dx0 = getX(mStartIndex) + (offset.dx / scaleX);
        final dy0 = offset.dy;
        final y1 = getMainY(object.value);
        final y2 = getMainY(object.value2);
        final y3 = getMainY(object.value3);

        double? dist(double? y, double dxp) {
          if (y == null) return null;
          final ddx = (dxp - dx0).abs();
          final ddy = (y - dy0).abs();
          if (ddx > 20 || ddy > 20) return null;
          return ddx + ddy;
        }

        final d1 = dist(y1, handleX(object.datetime, object.dx1));
        final d2 = dist(y2, handleX(object.datetime2, object.dx2));
        final d3 = dist(y3, handleX(object.datetime3, object.dx3));
        if (d1 != null || d2 != null || d3 != null) {
          int best = 0;
          double bestD = double.infinity;
          if (d1 != null && d1 < bestD) {
            best = 0;
            bestD = d1;
          }
          if (d2 != null && d2 < bestD) {
            best = 1;
            bestD = d2;
          }
          if (d3 != null && d3 < bestD) {
            best = 2;
            bestD = d3;
          }
          object.currentEditIndex = channelCount;
          nearObject.object = object;
          nearObject.isSecondPoint = best == 1;
          nearObject.isWidthPoint = best == 2;
          return nearObject;
        }
        channelCount++;
      } else if (object.type == ObjectType.FibonacciExpansion) {
        // Three draggable points (two waves); pick the closest to the tap.
        final dx0 = getX(mStartIndex) + (offset.dx / scaleX);
        final dy0 = offset.dy;
        final y1 = getMainY(object.value);
        final y2 = getMainY(object.value2);
        final y3 = getMainY(object.value3);

        double? dist(double? y, double dxp) {
          if (y == null) return null;
          final ddx = (dxp - dx0).abs();
          final ddy = (y - dy0).abs();
          if (ddx > 20 || ddy > 20) return null;
          return ddx + ddy;
        }

        final d1 = dist(y1, handleX(object.datetime, object.dx1));
        final d2 = dist(y2, handleX(object.datetime2, object.dx2));
        final d3 = dist(y3, handleX(object.datetime3, object.dx3));
        if (d1 != null || d2 != null || d3 != null) {
          int best = 0;
          double bestD = double.infinity;
          if (d1 != null && d1 < bestD) {
            best = 0;
            bestD = d1;
          }
          if (d2 != null && d2 < bestD) {
            best = 1;
            bestD = d2;
          }
          if (d3 != null && d3 < bestD) {
            best = 2;
            bestD = d3;
          }
          object.currentEditIndex = expansionCount;
          nearObject.object = object;
          nearObject.isSecondPoint = best == 1;
          nearObject.isWidthPoint = best == 2;
          return nearObject;
        }
        expansionCount++;
      } else if (object.type == ObjectType.Rectangle ||
          object.type == ObjectType.Trend) {
        final dx0 = getX(mStartIndex) + (offset.dx / scaleX);
        final dy0 = offset.dy;
        final dy1 = getMainY(object.value);
        final dy2 = getMainY(object.value2);
        if (dy1 == null || dy2 == null) {
          if (object.type == ObjectType.Rectangle) {
            rectangleCount++;
          } else {
            trendCount++;
          }
          continue;
        }
        final dx1 = handleX(object.datetime, object.dx1);
        final dx2 = handleX(object.datetime2, object.dx2);

        final disDx1 = dx1 - dx0;
        final disDx2 = dx2 - dx0;
        final disDy1 = dy1 - dy0;
        final disDy2 = dy2 - dy0;

        if (disDx1.abs() <= 20 && disDy1.abs() <= 20) {
          if (object.type == ObjectType.Rectangle) {
            object.currentEditIndex = rectangleCount;
          } else if (object.type == ObjectType.Trend) {
            object.currentEditIndex = trendCount;
          }
          nearObject.object = object;
          nearObject.isSecondPoint = false;
          return nearObject;
        } else if (disDx2.abs() <= 20 && disDy2.abs() <= 20) {
          if (object.type == ObjectType.Rectangle) {
            object.currentEditIndex = rectangleCount;
          } else if (object.type == ObjectType.Trend) {
            object.currentEditIndex = trendCount;
          }
          nearObject.object = object;
          nearObject.isSecondPoint = true;
          return nearObject;
        }
        if (object.type == ObjectType.Rectangle) {
          rectangleCount++;
        } else if (object.type == ObjectType.Trend) {
          trendCount++;
        }
      }
    }
    return nearObject;
  }
}

class NearObject {
  bool isSecondPoint;
  bool isWidthPoint;
  ObjectEntity? object;

  NearObject({
    this.isSecondPoint = false,
    this.isWidthPoint = false,
    this.object,
  });
}
