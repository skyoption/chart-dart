import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/widgets/paddings.dart';
import 'package:candle_chart/widgets/radius.dart';
import 'package:flutter/material.dart';

class SlugWidget extends StatelessWidget {
  final Color? color;
  final double height;
  const SlugWidget({super.key, this.color, this.height = 32.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: 2.0,
      decoration: BoxDecoration(
        color: color ?? context.scheme.secondary,
        borderRadius: MBorderRadius.set(all: 12.0),
      ),
      margin: MPadding.set(horizontal: 8.0),
    );
  }
}
