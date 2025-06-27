import 'package:example/core/consts/exports.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';
import 'package:example/features/symbols/views/widgets/quote_price_item_widget.dart';

class TradePriceItemWidget extends StatefulWidget {
  final SymbolEntity symbol;
  const TradePriceItemWidget({super.key, required this.symbol});

  @override
  State<TradePriceItemWidget> createState() => _TradePriceItemWidgetState();
}

class _TradePriceItemWidgetState extends State<TradePriceItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ValueListenableBuilder(
          valueListenable: widget.symbol.askChange,
          builder: (context, value, child) {
            return QuotePriceItemWidget(
              digits: widget.symbol.digits,
              value: value,
              title: context.tr.askPrice,
              color: widget.symbol.askColor.value,
            );
          },
        ),
        Row(
          children: [
            MSvg(
              name: Svgs.selected,
              color: context.colorScheme.primary,
              height: 22.0,
            ).addPadding(horizontal: 2.0),
            ValueListenableBuilder(
              valueListenable: widget.symbol.tick,
              builder: (context, value, child) {
                return MText(
                  text: value.toStringAsFixed(0),
                  color: context.colorScheme.primary,
                  size: FoontSize.font14,
                  weight: FontWeight.w400,
                );
              },
            )
          ],
        ).addPadding(horizontal: 12.0),
        ValueListenableBuilder(
          valueListenable: widget.symbol.bidChange,
          builder: (context, value, child) {
            return QuotePriceItemWidget(
              digits: widget.symbol.digits,
              value: value,
              title: context.tr.bidPrice,
              color: widget.symbol.bidColor.value,
            );
          },
        ),
      ],
    );
  }
}

class ChartValue {
  ChartValue(this.x, this.y);

  final String x;
  final double y;
}
