import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/functions.dart';
import 'package:example/core/shared/slug_value_item_widget.dart';
import 'package:example/core/shared/top_bottom_sheet_widget.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';
import 'package:example/features/trade/logic/positions_cubit.dart';

class SymbolDetailsBottomSheet extends StatelessWidget {
  final SymbolEntity symbol;
  final ValueNotifier<double> volume;
  final ValueNotifier<double> price;

  const SymbolDetailsBottomSheet({
    super.key,
    required this.symbol,
    required this.volume,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PositionsCubit>();
    final leverage = getLeverage(
      symbol.leverage,
      cubit.account.value!.leverage,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TopBottomSheetWidget(),
        MText(
          text: context.tr.orderInformation,
          color: context.colorScheme.onSurface,
          size: FoontSize.font18,
          weight: FontWeight.w500,
        ).addPadding(bottom: 21.0),
        SlugValueItemWidget(
          title: context.tr.leverage,
          value: '1:$leverage',
          valueWeight: FontWeight.w400,
        ).addPadding(bottom: 12.0),
        ValueListenableBuilder(
          valueListenable: volume,
          builder: (context, volume, child) {
            return Column(
              children: [
                SlugValueItemWidget(
                  title: '${context.tr.pointValue} (${symbol.tickSize})',
                  value: getPointValue(
                    volume: convertPriceToLot(
                      value: volume,
                      price: price.value,
                      accountLeverage: cubit.account.value!.leverage,
                      symbol: symbol,
                    ),
                    symbol: symbol,
                  ).toStringAsFixed(4),
                  valueWeight: FontWeight.w400,
                ).addPadding(bottom: 12.0),
                ValueListenableBuilder(
                  valueListenable: price,
                  builder: (context, price, child) {
                    return SlugValueItemWidget(
                      title:
                          "${context.tr.tradeMargin} (${convertPriceToLot(value: volume, price: price, accountLeverage: cubit.account.value!.leverage, symbol: symbol).toTwoDecimal} ${context.tr.lot})",
                      value: getTradeMargin(
                        volume: volume,
                        price: price,
                        accountLeverage: cubit.account.value!.leverage,
                        symbol: symbol,
                      ).toStringAsFixed(2),
                      valueWeight: FontWeight.w400,
                    ).addPadding(bottom: 12.0);
                  },
                ),
              ],
            );
          },
        ),
        SlugValueItemWidget(
          title: context.tr.availableMargin,
          value: cubit.account.value!.marginFree.currency2,
          valueWeight: FontWeight.w400,
        ).addPadding(bottom: 12.0),
      ],
    ).addPadding(vertical: 21.0, horizontal: 12.0);
  }
}

void showSymbolDetailsBottomSheet({
  required BuildContext context,
  required SymbolEntity symbol,
  required ValueNotifier<double> volume,
  required ValueNotifier<double> price,
  String selectedSymbol = "All",
}) {
  showMBottomSheet(
    context: context,
    removeTransparentBackground: true,
    backgorundColor: context.colorScheme.scrim,
    bottomSheet: SymbolDetailsBottomSheet(
      symbol: symbol,
      price: price,
      volume: volume,
    ),
  );
}
