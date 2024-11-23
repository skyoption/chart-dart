import 'dart:ui';

import 'package:candle_chart/entity/object_entity.dart';
import 'package:candle_chart/renderer/chart_details.dart';
import 'package:candle_chart/utils/kprint.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../base_chart_renderer.dart';

mixin DrawRectangleLines on ChartDetails {
  late final ChartPosition chartPosition;
  late final ChartStyle chartStyle;
  late Paint dot;
  late double scaleX;

  ObjectEntity? setRectangleOffset1(ObjectEntity item, Offset offset) {
    final rectangles = chartProperties.rectangles;
    final i = rectangles.indexWhere((e) => e.id == item.id);
    if (i != -1) {
      rectangles[i].currentEditIndex = item.currentEditIndex;
      rectangles[i].dx1 = getX(mStartIndex) + (offset.dx / scaleX);
      rectangles[i].value = getYPositionValue(offset.dy);
      return rectangles[i];
    }
    return null;
  }

  ObjectEntity? setRectangleOffset2(ObjectEntity item, Offset offset) {
    final rectangles = chartProperties.rectangles;
    final i = rectangles.indexWhere((e) => e.id == item.id);
    if (i != -1) {
      rectangles[i].currentEditIndex = item.currentEditIndex;
      rectangles[i].dx2 = getX(mStartIndex) + (offset.dx / scaleX);
      rectangles[i].value2 = getYPositionValue(offset.dy);
      return rectangles[i];
    }
    return null;
  }

  void drawRectangles(Canvas canvas, Size size, double lastX, double curX) {
    final rectangles = chartProperties.rectangles;
    if (rectangles.isEmpty) {
      return;
    }

    for (int i = 0; i < rectangles.length; i++) {
      double x1 = rectangles[i].dx1;
      double x2 = rectangles[i].dx2;
      double y1 = getMainY(rectangles[i].value);
      double y2 = getMainY(rectangles[i].value2);

      final pricePaint = Paint()
        ..color = colorFromHex(rectangles[i].color!)!
        ..strokeWidth = rectangles[i].height;

      if (rectangles[i].style == ObjectStyle.dash) {
      } else {
        if (rectangles[i].isFill) {
          canvas.drawRect(
            Rect.fromLTRB(x1, y1, x2, y2),
            pricePaint,
          );
        } else {
          canvas.drawPoints(
            PointMode.polygon,
            [
              Offset(x1, y1),
              Offset(x2, y1),
              Offset(x2, y2),
              Offset(x1, y2),
              Offset(x1, y1),
            ],
            pricePaint,
          );
        }
        if (rectangles[i].currentEditIndex == i) {
          canvas.drawCircle(
            Offset(x1, y1),
            2.5,
            dot,
          );
          canvas.drawCircle(
            Offset(x2, y2),
            2.5,
            dot,
          );
        }
      }
    }
  }
}

// void drawTrends(Canvas canvas, Size size) {
//   var index = calculateSelectedX(selectX);
//   Paint paintY = Paint()
//     ..color = chartColors.trendLineColor
//     ..strokeWidth = 1
//     ..isAntiAlias = true;
//   double x = getX(index);
//   trendLineX = x;
//
//   double y = selectY;
//
//   drawDashedLine(canvas, Offset(x, mTopPadding),
//       Offset(x, size.height - mBottomPadding), paintY);
//
//   Paint paintX = Paint()
//     ..color = chartColors.trendLineColor
//     ..strokeWidth = 1
//     ..isAntiAlias = true;
//
//   drawDashedLine(canvas, Offset(-mTranslateX, y),
//       Offset(-mTranslateX + mWidth / scaleX, y), paintX);
//
//   Paint paint = Paint()
//     ..color = chartColors.trendLineColor
//     ..strokeWidth = 1.0
//     ..style = PaintingStyle.stroke
//     ..strokeCap = StrokeCap.round;
//
//   if (scaleX >= 1) {
//     canvas.drawOval(
//       Rect.fromCenter(
//           center: Offset(x, y), height: 15.0 * scaleX, width: 15.0),
//       paint,
//     );
//   } else {
//     canvas.drawOval(
//       Rect.fromCenter(
//           center: Offset(x, y), height: 10.0, width: 10.0 / scaleX),
//       paint,
//     );
//   }
//   // if (lines.isNotEmpty) {
//   //   lines.forEach((element) {
//   //     var y1 = -((element.p1.dy - 35) / element.scale) + element.maxHeight;
//   //     var y2 = -((element.p2.dy - 35) / element.scale) + element.maxHeight;
//   //     var a = (trendLineMax! - y1) * rectanglescale! + trendLineContentRec!;
//   //     var b = (trendLineMax! - y2) * rectanglescale! + trendLineContentRec!;
//   //     var p1 = Offset(element.p1.dx, a);
//   //     var p2 = Offset(element.p2.dx, b);
//   //     canvas.drawLine(
//   //         p1,
//   //         element.p2 == Offset(-1, -1) ? Offset(x, y) : p2,
//   //         Paint()
//   //           ..color = Colors.yellow
//   //           ..strokeWidth = 2);
//   //   });
//   // }
// }
//
// void drawDashedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
//   const double dashWidth = 3;
//   const double dashSpace = 2;
//   double distance = (end - start).distance;
//   double dashCount = (distance / (dashWidth + dashSpace)).floorToDouble();
//
//   for (int i = 0; i < dashCount; ++i) {
//     double startX = start.dx + (end.dx - start.dx) * (i / dashCount);
//     double startY = start.dy + (end.dy - start.dy) * (i / dashCount);
//     double endX = start.dx + (end.dx - start.dx) * ((i + 0.5) / dashCount);
//     double endY = start.dy + (end.dy - start.dy) * ((i + 0.5) / dashCount);
//     canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
//   }
// }
