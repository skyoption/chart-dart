import 'package:candle_chart/indicators/widgets/slug_widget.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/widgets/paddings.dart';
import 'package:flutter/material.dart';

class SelectItemWidget extends StatelessWidget {
  final bool isSelected;
  final String item;

  const SelectItemWidget({
    super.key,
    required this.isSelected,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isSelected ? context.scheme.inversePrimary : context.scheme.scrim,
      padding: const MPadding.set(horizontal: 12.0, vertical: 10.0),
      margin: const MPadding.set(bottom: 5.0),
      child: Row(
        spacing: 12.0,
        children: [
          SlugWidget(),
          Text(
            item,
            style: context.text.bodyMedium,
          ),
        ],
      ),
    );
  }
}
