import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/widgets/paddings.dart';
import 'package:candle_chart/widgets/radius.dart';
import 'package:flutter/material.dart';

class TopBottomSheetWidget extends StatelessWidget {
  const TopBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200.0,
        height: 6.0,
        decoration: BoxDecoration(
          color: context.scheme.onSurface,
          borderRadius: MBorderRadius.set(all: 12.0),
        ),
      ),
    ).addPadding(bottom: 21.0);
  }
}
