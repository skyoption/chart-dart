// ignore_for_file: must_be_immutable

import 'package:example/core/consts/exports.dart';

class CurrencyPriceItemWidget extends StatelessWidget {
  final Color? color, backgroundColor;
  final String? title;
  final double value;
  final int digits;
  final double? textSize, largeTextSize;

  CurrencyPriceItemWidget({
    super.key,
    this.color,
    required this.value,
    required this.digits,
    this.title,
    this.textSize,
    this.largeTextSize,
    this.backgroundColor,
  }) {
    prices = value.toStringAsFixed(digits).split('.');
    final last = prices[1];
    prices[0] = '${prices[0]}.${last.substring(0, digits ~/ 2)}';
    prices[1] = last.substring((digits ~/ 2), digits);
  }

  List<String> prices = [];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        padding: const MPadding.set(vertical: 3.0, horizontal: 6.0),
        decoration: BoxDecoration(
          color: backgroundColor ?? Coolors.highlight2,
          border: Border.all(color: Colors.transparent),
          borderRadius: MBorderRadius.set(all: 6.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (title != null)
              MText(
                text: title,
                color: Coolors.white,
                weight: FontWeight.w400,
                size: textSize ?? FoontSize.font13,
              ).addPadding(end: 6.0),
            ...prices.asMap().entries.map((item) {
              return MText(
                text: item.value,
                color: color ?? Coolors.primaryColor,
                size: item.key == 1
                    ? largeTextSize ?? FoontSize.font14
                    : textSize ?? FoontSize.font12,
                weight: FontWeight.w600,
              );
            }),
          ],
        ).addPadding(bottom: 2.0),
      ),
    );
  }
}
