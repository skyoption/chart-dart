// ignore_for_file: must_be_immutable

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
    prices = value.toStringAsFixed(digits).split('.');
    final last = prices[1];
    prices[0] = '${prices[0]}.${last.substring(0, digits ~/ 2)}';
    if (digits > 2) prices.add(last[digits ~/ 2]);
    prices[1] = last.substring(digits ~/ 2, digits >= 5 ? 4 : digits);
  }

  List<String> prices = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const MPadding.set(bottom: 3.0),
      padding: const MPadding.set(vertical: 3.0, horizontal: 8.0),
      decoration: title != null
          ? BoxDecoration(
              color: color != null
                  ? color!.withAlpha(40)
                  : context.colorScheme.surfaceVariant,
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
