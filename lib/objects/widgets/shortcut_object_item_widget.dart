import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/objects/widgets/svg.dart';
import 'package:candle_chart/widgets/paddings.dart';
import 'package:candle_chart/widgets/radius.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShortcutObjectItemWidget extends StatelessWidget {
  final String icon, title;
  final Function() onTap;
  const ShortcutObjectItemWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: context.scheme.surfaceContainerLow,
          borderRadius: MBorderRadius.set(all: 8.0),
        ),
        padding: MPadding.set(horizontal: 12.0, vertical: 10.0),
        child: Column(
          spacing: 6.0,
          children: [
            MSvg(
              name: icon,
              width: 30.0,
              height: 30.0,
              color: context.scheme.onSurface,
            ),
            Text(title, style: context.text.bodySmall),
          ],
        ),
      ),
    );
  }
}
