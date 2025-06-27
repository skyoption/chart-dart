import 'package:example/core/consts/exports.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';
import 'package:example/features/symbols/views/bottom_sheets/quote_bottom_sheet.dart';
import 'package:example/features/symbols/views/widgets/quote_price_item_widget.dart';
import 'package:example/features/symbols/views/widgets/quote_slogo_item_widget.dart';

import 'currencies_item_widget.dart';

class QuotesSimpleWidget extends StatelessWidget {
  final SymbolEntity item;

  const QuotesSimpleWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.primaryContainer,
        border: Border.all(
          color: context.colorScheme.outline,
        ),
        borderRadius: MBorderRadius.set(all: 8.0),
      ),
      margin: const MPadding.set(top: 6.0),
      padding: const MPadding.set(vertical: 6.0),
      child: Row(
        children: [
          Row(
            children: [
              QuoteSlogoItemWidget(
                height: 60.0,
                item: item,
              ),
              Align(
                alignment: AlignmentDirectional.topCenter,
                child: ValueListenableBuilder(
                  valueListenable: item.isFavChange,
                  builder: (context, value, child) {
                    return MSvg(
                      name: Svgs.fav,
                      color: value
                          ? AppColors.orange
                          : context.colorScheme.onSurface,
                      height: 21.0,
                      width: 21.0,
                    ).addAction(
                      onGesture: () {
                        context.read<QuotesCubit>().setFav(item, !value);
                      },
                      padding: const MPadding.set(end: 3.0, start: 6.0),
                    );
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CurrenciesItemWidget(item: item.symbol),
                    MText(
                      text: item.symbol.toUpperCase(),
                      color: context.colorScheme.scrim,
                      weight: FontWeight.w600,
                      size: FoontSize.font16,
                    ),
                  ],
                ),
              ],
            ).addPadding(start: 2.0),
          ),
          Row(
            children: [
              ValueListenableBuilder(
                valueListenable: item.askChange,
                builder: (context, value, child) {
                  return QuotePriceItemWidget(
                    digits: item.digits,
                    value: value,
                    color: item.askColor.value,
                  );
                },
              ),
              Row(
                children: [
                  MSvg(
                    name: Svgs.selected,
                    color: context.colorScheme.onSurface,
                    width: 18.0,
                    height: 18.0,
                  ).addPadding(end: 2.0),
                  ValueListenableBuilder(
                    valueListenable: item.tick,
                    builder: (context, value, child) {
                      return MText(
                        text: value.toStringAsFixed(0),
                        color: context.colorScheme.onSurface,
                        size: FoontSize.font13,
                        weight: FontWeight.w400,
                      );
                    },
                  ),
                ],
              ).addPadding(end: 2.0),
              ValueListenableBuilder(
                valueListenable: item.bidChange,
                builder: (context, value, child) {
                  return QuotePriceItemWidget(
                    digits: item.digits,
                    value: value,
                    color: item.bidColor.value,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ).addAction(
      onGesture: () {
        showQuoteBottomSheet(
          context: context,
          symbol: item,
        );
      },
    );
  }
}
