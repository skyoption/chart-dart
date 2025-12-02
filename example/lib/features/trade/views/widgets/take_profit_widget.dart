import 'package:example/core/consts/exports.dart';
import 'package:example/features/trade/views/widgets/trade_textfiled_item_widget.dart';
import 'package:example/core/consts/pick_option.dart';
import 'package:example/core/framework/functions.dart';
import 'package:example/core/shared/custom_drop_down.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';

class TakeProfitWidget extends StatefulWidget {
  final PositionType? type;
  final double? init;
  final int digits;
  final bool enable;
  final SymbolEntity symbol;
  final ValueChanged<double>? onChange;
  final double volume;
  final double? entryPrice;

  const TakeProfitWidget({
    super.key,
    required this.type,
    this.enable = true,
    this.onChange,
    this.init,
    this.digits = 2,
    required this.symbol,
    required this.volume,
    this.entryPrice,
  });

  @override
  State<TakeProfitWidget> createState() => _TakeProfitWidgetState();
}

class _TakeProfitWidgetState extends State<TakeProfitWidget> {
  double price = 0;
  @override
  void initState() {
    if (widget.init != null) {
      price = widget.init!;
      if (widget.onChange != null && widget.init != null) {
        widget.onChange!(getTotalPrice(takeProfitOptions.value, widget.init!));
      }
    }

    super.initState();
  }

  final totalPrice = ValueNotifier<double>(0);

  late final List<PickOption<PriceOptions>> pickOptions = [
    PickOption(PriceOptions.Price, context.tr.price),
    PickOption(PriceOptions.Money, context.tr.money),
    PickOption(PriceOptions.Pips, context.tr.pips),
  ];

  final takeProfitOptions = ValueNotifier<PriceOptions>(PriceOptions.Price);

  @override
  Widget build(BuildContext context) {
    if (widget.entryPrice != null) {
      return child(widget.entryPrice!);
    }
    return ValueListenableBuilder(
      valueListenable: widget.type == PositionType.ask
          ? widget.symbol.askChange
          : widget.symbol.bidChange,
      builder: (context, entryPrice, _) {
        totalPrice.value = getTotalPrice(takeProfitOptions.value, entryPrice);
        if (widget.onChange != null) widget.onChange!(totalPrice.value);
        return child(entryPrice);
      },
    );
  }

  Widget child(double entryPrice) {
    return Column(
      children: [
        Row(
          spacing: 12.0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: ValueListenableBuilder(
                valueListenable: takeProfitOptions,
                builder: (context, priceOption, child) {
                  return TradeTextFiledItemWidget(
                    digits: widget.digits,
                    title: context.tr.takeProfit,
                    init: widget.init,
                    onChange: (value) {
                      price = double.tryParse(value) ?? 0.0;
                      totalPrice.value = getTotalPrice(priceOption, entryPrice);
                      if (widget.onChange != null) {
                        widget.onChange!(totalPrice.value);
                      }
                    },
                    enable: widget.enable,
                    validator: (messageError) {
                      if (widget.type == null) return null;
                      if (price == 0 &&
                          takeProfitOptions.value != PriceOptions.Price) {
                        return context.tr.fieldInvalid(context.tr.takeProfit);
                      } else if (price == 0) {
                        return null;
                      }
                      final totalPrice = getTotalPrice(priceOption, entryPrice);
                      if (widget.type == PositionType.ask) {
                        return entryPrice > totalPrice
                            ? context.tr.fieldInvalid(context.tr.takeProfit)
                            : null;
                      } else if (widget.type == PositionType.bid) {
                        return totalPrice < entryPrice
                            ? null
                            : context.tr.fieldInvalid(context.tr.takeProfit);
                      }
                      return null;
                    },
                  );
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: CDropDown<PriceOptions>(
                height: 50.0,
                initialValue: pickOptions[0].value,
                fillColor: context.colorScheme.surfaceContainerLow,
                dropdownPadding: MPadding.set(horizontal: 21.0),
                options: pickOptions,
                bottomPadding: 8.0,
                onSelection: (value) {
                  if (value != null) {
                    takeProfitOptions.value = value.value;
                  }
                },
              ).addPadding(top: 27.0),
            ),
          ],
        ),
        ValueListenableBuilder(
          valueListenable: totalPrice,
          builder: (context, totalPrice, child) {
            return ValueListenableBuilder(
              valueListenable: takeProfitOptions,
              builder: (context, priceOption, child) {
                if (totalPrice == 0) return SizedBox();
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MText(
                      text:
                          "${context.tr.value}: ${totalPrice.toStringAsFixed(widget.digits)} ${context.tr.usd}",
                      size: FoontSize.font10,
                      weight: FontWeight.w400,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                    MText(
                      text:
                          "${context.tr.money}: ${getMoney(priceOption, entryPrice).toStringAsFixed(2)}",
                      size: FoontSize.font10,
                      weight: FontWeight.w400,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                    MText(
                      text:
                          "${context.tr.pips}: ${getPips(priceOption, entryPrice).toStringAsFixed(2)}",
                      size: FoontSize.font10,
                      weight: FontWeight.w400,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }

  //1.34120

  double getMoney(priceOption, entryPrice) {
    final result = priceOption == PriceOptions.Money
        ? price
        : priceOption == PriceOptions.Pips
            ? pipsToMoney(
                pips: price,
                lotSize: widget.volume,
                contractSize: widget.symbol.contractSize,
                decimalPlaces: widget.symbol.digits,
                profitRatio: widget.symbol.profitRatio,
                tickSize: widget.symbol.tickSize,
              )
            : priceToMoney(
                entryPrice: entryPrice,
                targetPrice: price,
                decimalPlaces: widget.symbol.digits,
                contractSize: widget.symbol.contractSize,
                volume: widget.volume,
                profitRatio: widget.symbol.profitRatio,
              );
    return result.abs();
  }

  double getPips(priceOption, entryPrice) {
    final result = priceOption == PriceOptions.Price
        ? priceToPips(
            entryPrice: entryPrice,
            targetPrice: price,
            isBuyTarget: widget.type == PositionType.ask,
            pipSize: widget.symbol.tickSize * 10,
            decimalPlaces: widget.symbol.digits,
          )
        : priceOption == PriceOptions.Pips
            ? price
            : moneyToPips(
                money: price,
                isBuyTarget: widget.type == PositionType.ask,
                decimalPlaces: widget.symbol.digits,
                lotSize: widget.volume,
                contractSize: widget.symbol.contractSize,
                profitRatio: widget.symbol.profitRatio,
                tickSize: widget.symbol.tickSize,
              );
    return result.abs();
  }

  double getTotalPrice(PriceOptions priceOptions, entryPrice) {
    final result = priceOptions == PriceOptions.Price
        ? price
        : priceOptions == PriceOptions.Pips
            ? pipsToPrice(
                entryPrice: entryPrice,
                pips: price,
                isBuyTarget: widget.type == PositionType.ask,
                pipSize: widget.symbol.tickSize * 10,
                decimalPlaces: widget.symbol.digits,
              )
            : moneyToPrice(
                volume: widget.volume,
                contractSize: widget.symbol.contractSize,
                entryPrice: entryPrice,
                money: price,
                isBuyTarget: widget.type == PositionType.ask,
                decimalPlaces: widget.symbol.digits,
                profitRatio: widget.symbol.profitRatio,
              );
    return result.abs();
  }

  @override
  void dispose() {
    totalPrice.dispose();
    takeProfitOptions.dispose();
    super.dispose();
  }
}
