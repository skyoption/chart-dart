// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:example/core/consts/exports.dart';

class QuotePriceItemWidget extends StatelessWidget {
  final Color? color;
  final String? title;
  final double value;
  final int digits;
  QuotePriceItemWidget({
    super.key,
    this.color,
    required this.value,
    this.title,
    required this.digits,
  }) {
    String formattedValue = value.toStringAsFixed(digits);
    prices = formattedValue.split('.');
    final last = prices[1];
    if (last.length >= 2) {
      prices[0] = '${prices[0]}.${last.substring(0, 2)}';

      if (last.length > 2) {
        prices[1] = last.substring(2, min(4, last.length));

        if (last.length > 4) {
          prices.add(last.substring(4));
        }
      } else {
        prices[1] = '';
      }
    } else {
      prices[0] = '${prices[0]}.$last';
      prices[1] = '';
    }
  }

  List<String> prices = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const MPadding.set(bottom: 3.0),
      padding: const MPadding.set(vertical: 3.0, horizontal: 8.0),
      decoration: title != null
          ? BoxDecoration(
              color: color != null ? color!.withAlpha(40) : AppColors.highLight,
              borderRadius: MBorderRadius.set(all: 6.0),
            )
          : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (title != null)
            MText(
              text: title,
              color: color ?? context.colorScheme.onSurface,
              weight: FontWeight.w400,
              size: FoontSize.font13,
            ).addPadding(end: 6.0),
          ...prices.asMap().entries.map((item) {
            return MText(
              text: item.value,
              color: color ?? context.colorScheme.onSurface,
              size: item.key == 1 ? FoontSize.font16 : FoontSize.font13,
              weight: FontWeight.w600,
            );
          })
        ],
      ).addPadding(bottom: 2.0),
    );
  }
}
