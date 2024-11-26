import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/entity/object_entity.dart';
import 'package:candle_chart/renderer/chart_details.dart';
import 'package:candle_chart/utils/kprint.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../base_chart_renderer.dart';

mixin DrawVerticalLines on ChartDetails {
  late final ChartPosition chartPosition;
  late final ChartStyle chartStyle;
  late Paint dot;
  late double scaleX;
  double? fDisplayHeight;

  ObjectEntity? setVerticalLineOffset(
    ObjectEntity item,
    Offset offset,
    List<KLineEntity> data,
  ) {
    final verticalLines = chartProperties.verticalLines;
    final i = verticalLines.indexWhere((e) => e.id == item.id);
    if (i != -1) {
      verticalLines[i].currentEditIndex = item.currentEditIndex;
      verticalLines[i].dx1 = getX(mStartIndex) + (offset.dx / scaleX);
      // final index = calculateSelectedX(verticalLines[i].dx1);
      // kPrint(mStartIndex);
      // kPrint(index);
      // final datetime = DateTime.fromMillisecondsSinceEpoch(data.first.time!)
      //     .add(Duration(hours: index * 4));
      // verticalLines[i].datetime = datetime.millisecondsSinceEpoch;
      // kPrint(datetime.toIso8601String());
      // final r = data.indexWhere((e) => e.time == verticalLines[i].datetime);
      // verticalLines[i].dx1 = getX(r);
      return verticalLines[i];
    }
    return null;
  }

  void drawVerticalLines(Canvas canvas, Size size, bool isBackground) {
    final verticalLines = chartProperties.verticalLines;
    if (verticalLines.isEmpty) {
      return;
    }
    for (int i = 0; i < verticalLines.length; i++) {
      double x = verticalLines[i].dx1;

      final pricePaint = Paint()
        ..color = colorFromHex(verticalLines[i].color!)!
        ..strokeWidth = verticalLines[i].height;

      if (verticalLines[i].style == ObjectStyle.dash) {
        double startY = this.chartStyle.topPadding;
        final max = fDisplayHeight!;
        double space =
            this.chartStyle.priceLineSpan + this.chartStyle.priceLineLength;
        while (startY < max) {
          canvas.drawLine(
            Offset(x, startY),
            Offset(x, startY + this.chartStyle.priceLineLength),
            pricePaint,
          );
          startY += space;
        }
      } else {
        canvas.drawLine(
          Offset(x, this.chartStyle.topPadding),
          Offset(x, fDisplayHeight!),
          pricePaint,
        );

      } if (verticalLines[i].currentEditIndex == i) {
        canvas.drawCircle(
          Offset(x, this.chartStyle.topPadding),
          2.5,
          dot,
        );
        canvas.drawCircle(
          Offset(x, fDisplayHeight!),
          2.5,
          dot,
        );
      }
    }
  }
}
