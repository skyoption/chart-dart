import 'package:example/core/consts/exports.dart';
import 'package:example/features/trade/views/widgets/currency_price_item_widget.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';

class CurrencyAskBidWidget extends StatelessWidget {
  final bool noTitle;
  final SymbolEntity item;
  final double? textSize, largeTextSize;
  final bool isVertical;

  const CurrencyAskBidWidget({
    super.key,
    required this.item,
    this.noTitle = false,
    this.isVertical = false,
    this.textSize,
    this.largeTextSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (!isVertical)
          ValueListenableBuilder(
            valueListenable: item.askChange,
            builder: (context, value, child) {
              return CurrencyPriceItemWidget(
                color: Colors.white,
                backgroundColor: item.askColor.value,
                textSize: textSize,
                largeTextSize: largeTextSize,
                digits: item.digits,
                value: double.parse(value.toStringAsFixed(item.digits)),
              ).addPadding(end: noTitle ? 0.0 : 12.0);
            },
          ),
        MSvg(
          name: Svgs.size,
          color: context.colorScheme.onSurface,
          width: 16.0,
          height: 16.0,
        ).addPadding(horizontal: 4.0),
        ValueListenableBuilder(
          valueListenable: item.spread,
          builder: (context, value, child) {
            return MText(
              text: value.toStringAsFixed(0),
              weight: FontWeight.w300,
              size: textSize ?? FoontSize.font14,
              color: context.colorScheme.onSurface,
            );
          },
        ).addPadding(end: 12.0),
        Column(
          children: [
            if (isVertical)
              ValueListenableBuilder(
                valueListenable: item.askChange,
                builder: (context, value, child) {
                  return CurrencyPriceItemWidget(
                    color: Colors.white,
                    backgroundColor: item.askColor.value,
                    textSize: textSize,
                    largeTextSize: largeTextSize,
                    digits: item.digits,
                    value: double.parse(value.toStringAsFixed(item.digits)),
                  ).addPadding(end: noTitle ? 0.0 : 12.0);
                },
              ),
            ValueListenableBuilder(
              valueListenable: item.bidChange,
              builder: (context, value, child) {
                return CurrencyPriceItemWidget(
                  backgroundColor: item.bidColor.value,
                  color: Colors.white,
                  textSize: textSize,
                  largeTextSize: largeTextSize,
                  digits: item.digits,
                  value: double.parse(value.toStringAsFixed(item.digits)),
                ).addPadding(end: noTitle ? 0.0 : 12.0);
              },
            ),
          ],
        ),
      ],
    );
  }
}
