import 'dart:ui';
import 'dart:math';
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

  NearObject findNearOffset({required Offset offset}) {
    final nearObject = NearObject();
    int horizontalCount = 0,
        verticalCount = 0,
        rectangleCount = 0,
        trendCount = 0;
    for (int i = 0; i < chartProperties.objects.length; i++) {
      var object = chartProperties.objects[i];
      if (object.type == ObjectType.Horizontal) {
        final dy1 = offset.dy - 75.0 - (offset.dy < 150 ? 20 : 0);
        final dy2 = getMainY(object.value);
        final disDy = dy2 - dy1;
        if (disDy.abs() <= 20) {
          object.currentEditIndex = horizontalCount;
          nearObject.object = object;
          nearObject.isSecondPoint = false;
          return nearObject;
        }
        horizontalCount++;
      } else if (object.type == ObjectType.Vertical) {
        final dx1 = getX(mStartIndex) + offset.dx;
        final dx2 = object.dx1;
        final disDx = dx2 - dx1;
        if (disDx.abs() <= 20) {
          object.currentEditIndex = verticalCount;
          nearObject.object = object;
          nearObject.isSecondPoint = false;
          return nearObject;
        }
        verticalCount++;
      } else if (object.type == ObjectType.Rectangle ||
          object.type == ObjectType.Trend) {
        final dx0 = getX(mStartIndex) + offset.dx;
        final dy0 = offset.dy - 75.0 - (offset.dy < 150 ? 20 : 0);
        final dy1 = getMainY(object.value);
        final dy2 = getMainY(object.value2);
        final dx1 = object.dx1;
        final dx2 = object.dx2;

        final disDx1 = dx1 - dx0;
        final disDx2 = dx2 - dx0;
        final disDy1 = dy1 - dy0;
        final disDy2 = dy2 - dy0;

        if (disDx1.abs() <= 20 && disDy1 <= 20) {
          if (object.type == ObjectType.Rectangle) {
            object.currentEditIndex = rectangleCount;
          } else if (object.type == ObjectType.Trend) {
            object.currentEditIndex = trendCount;
          }
          nearObject.object = object;
          nearObject.isSecondPoint = false;
          return nearObject;
        } else if (disDx2.abs() <= 20 && disDy2 <= 20) {
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
