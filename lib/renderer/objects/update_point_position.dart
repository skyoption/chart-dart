import 'dart:ui';

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

  NearObject findNearOffset({required Offset offset}) {
    final nearObject = NearObject();
    int horizontalCount = 0,
        verticalCount = 0,
        positionCount = 0,
        rectangleCount = 0,
        trendCount = 0,
        fibonacciCount = 0,
        timeZoneCount = 0,
        fanCount = 0;
    for (var item in chartProperties.tPAndSLLines) item.currentEditIndex = -1;
    for (var item in chartProperties.objects) item.currentEditIndex = -1;
    final objects = [
      ...chartProperties.objects,
      ...chartProperties.tPAndSLLines
    ];

    for (int i = 0; i < objects.length; i++) {
      var object = objects[i];
      if (object.type == ObjectType.Horizontal) {
        final dy1 = offset.dy;
        final dy2 = getMainY(object.value);
        if (dy2 == null) return nearObject;
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
        final dy2 = getMainY(object.value);
        if (dy2 == null) return nearObject;
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
        final dx2 = object.dx1;
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
        if (y1 == null || y2 == null) return nearObject;
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
        if (y1 == null || y2 == null) return nearObject;
        final disDx1 = (object.dx1 - dx0).abs();
        final disDx2 = (object.dx2 - dx0).abs();
        final disDy1 = (y1 - dy0).abs();
        final disDy2 = (y2 - dy0).abs();
        if (disDx1 <= 20 && disDy1 <= 20) {
          object.currentEditIndex = timeZoneCount;
          nearObject.object = object;
          nearObject.isSecondPoint = false;
          return nearObject;
        } else if (disDx2 <= 20 && disDy2 <= 20) {
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
        if (y1 == null || y2 == null) return nearObject;
        final disDx1 = (object.dx1 - dx0).abs();
        final disDx2 = (object.dx2 - dx0).abs();
        final disDy1 = (y1 - dy0).abs();
        final disDy2 = (y2 - dy0).abs();
        if (disDx1 <= 20 && disDy1 <= 20) {
          object.currentEditIndex = fanCount;
          nearObject.object = object;
          nearObject.isSecondPoint = false;
          return nearObject;
        } else if (disDx2 <= 20 && disDy2 <= 20) {
          object.currentEditIndex = fanCount;
          nearObject.object = object;
          nearObject.isSecondPoint = true;
          return nearObject;
        }
        fanCount++;
      } else if (object.type == ObjectType.Rectangle ||
          object.type == ObjectType.Trend) {
        final dx0 = getX(mStartIndex) + (offset.dx / scaleX);
        final dy0 = offset.dy;
        final dy1 = getMainY(object.value);
        if (dy1 == null) return nearObject;
        final dy2 = getMainY(object.value2);
        if (dy2 == null) return nearObject;
        final dx1 = object.dx1;
        final dx2 = object.dx2;

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
  ObjectEntity? object;

  NearObject({this.isSecondPoint = false, this.object});
}
