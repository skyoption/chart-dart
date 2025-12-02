import 'package:example/core/consts/exports.dart';
import 'package:example/features/trade/views/widgets/currency_ask_bid_widget.dart';
import 'package:example/features/trade/views/widgets/position_expiration_type_widget.dart';
import 'package:example/features/trade/views/widgets/stop_loss_widget.dart';
import 'package:example/features/trade/views/widgets/take_profit_widget.dart';
import 'package:example/features/trade/views/widgets/trade_textfiled_item_widget.dart';
import 'package:example/core/framework/functions.dart';
import 'package:example/core/shared/currencies_item_widget.dart';
import 'package:example/core/shared/my_scaffold_widget.dart';
import 'package:example/features/main/logic/connect_cubit.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';
import 'package:example/features/trade/logic/modify_order_cubit.dart';
import 'package:example/features/trade/logic/positions_cubit.dart';
import 'package:example/features/trade/models/order_entity.dart';

@RoutePage()
class EditOrderScreen extends StatefulWidget {
  final OrderEntity item;

  const EditOrderScreen({super.key, required this.item});

  @override
  State<EditOrderScreen> createState() => _EditOrderScreenState();
}

class _EditOrderScreenState extends State<EditOrderScreen> {
  late PositionType orderType = getPositionTypeByOrderType(
    widget.item.direction,
  );
  final price = ValueNotifier<double>(0);
  final volume = ValueNotifier<double>(0);
  final formKey = GlobalKey<FormState>();
  late double sl = widget.item.sl.toTwoDecimalNum;
  late double tp = widget.item.tp.toTwoDecimalNum;
  int expiration = 0;

  @override
  void dispose() {
    price.dispose();
    volume.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QuotesCubit>();
    final connectCubit = context.read<ConnectCubit>();
    final symbol = cubit.getSymbol(widget.item.symbol);
    if (symbol == null) return const SizedBox();
    volume.value = widget.item.volume;
    price.value = widget.item.openPrice;
    return MScaffoldWidget(
      title: context.tr.modify,
      appbarSize: 72.0,
      child: MScroll(
        padding: const MPadding.set(horizontal: 21.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: const MPadding.set(vertical: 12.0, horizontal: 20.0),
                margin: const MPadding.set(bottom: 21.0),
                decoration: BoxDecoration(
                  color: context.colorScheme.surfaceContainerLow,
                  borderRadius: MBorderRadius.set(all: 8.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CurrenciesItemWidget(item: symbol.symbol, size: 25.0),
                        MText(
                          text: symbol.symbol.toUpperCase(),
                          weight: FontWeight.w300,
                          size: FoontSize.font18,
                          color: context.colorScheme.onSurface,
                        ),
                      ],
                    ),
                    if (symbol.description.isNotEmpty)
                      MText(
                        text: symbol.description,
                        color: context.colorScheme.outline,
                        size: FoontSize.font14,
                      ).addPadding(start: 10.0),
                  ],
                ),
              ),
              Padding(
                padding: const MPadding.set(bottom: 21.0),
                child: CurrencyAskBidWidget(
                  item: symbol,
                  textSize: FoontSize.font16,
                  largeTextSize: FoontSize.font18,
                ),
              ),
              TradeTextFiledItemWidget(
                title: context.tr.price,
                init: widget.item.openPrice,
                step: 1,
                digits: symbol.digits,
                onChange: (value) {
                  price.value = double.tryParse(value) ?? 0.0;
                },
                validator: (messageError) {
                  if (price.value == 0) {
                    return context.tr.fieldInvalid(context.tr.price);
                  }
                  return null;
                },
              ).addPadding(bottom: 12.0),
              TradeTextFiledItemWidget(
                key: const ValueKey('volume-field'),
                digits: 2,
                init: getLimitVolume(symbol, widget.item.volume),
                max: getLimitVolume(symbol, symbol.volumeMax),
                min: getLimitVolume(symbol, symbol.volumeMin),
                title: context.tr.volume,
                onChange: (value) {
                  volume.value = double.tryParse(value) ?? 0;
                },
                suffix: FlowBuilder<CurrencyChanged>(
                  buildWhenState: (previous, current) {
                    return current.type == StateType.success;
                  },
                  builder: (context, state, cubit) {
                    return MText(
                      text: cubit.getCurrency.name,
                      size: FoontSize.font16,
                      color: context.colorScheme.onSurface,
                    ).addPadding(right: 20.0);
                  },
                ),
                validator: (messageError) {
                  final volumeMin = getLimitVolume(symbol, symbol.volumeMin);
                  final volumeMax = getLimitVolume(symbol, symbol.volumeMax);
                  if (volume.value < volumeMin || volume.value == 0) {
                    return errorMessage(context, volumeMin.toString());
                  }
                  if (volume.value > volumeMax) {
                    return errorMessage(
                      context,
                      volumeMax.toString(),
                      isMax: true,
                    );
                  }
                  return null;
                },
              ),
              ValueListenableBuilder<double>(
                valueListenable: price,
                builder: (context, price, child) {
                  return Column(
                    children: [
                      Row(
                        spacing: 12.0,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TakeProfitWidget(
                            symbol: symbol,
                            volume: currentVolume,
                            entryPrice: widget.item.openPrice,
                            init: widget.item.tp,
                            type: orderType,
                            digits: symbol.digits,
                            onChange: (value) {
                              tp = value;
                            },
                          ).addPadding(bottom: 16.0),
                          StopLossWidget(
                            symbol: symbol,
                            volume: currentVolume,
                            entryPrice: widget.item.openPrice,
                            init: widget.item.sl,
                            type: orderType,
                            digits: symbol.digits,
                            onChange: (value) {
                              sl = value;
                            },
                          ).addPadding(bottom: 16.0),
                        ],
                      ),
                    ],
                  );
                },
              ),
              PositionExpirationTypeWidget(
                onTap: (value) {
                  expiration = value;
                },
              ),
              FlowBuilder<ModifyOrderCubit>(
                onSuccess: (state, cubit) {
                  context.router.maybePop();
                },
                builder: (context, state, cubit) {
                  return Column(
                    children: [
                      if (cubit.error.isNotEmpty)
                        MText(
                          text: cubit.error,
                          color: Colors.red,
                          size: FoontSize.font16,
                        ).addPadding(top: 21),
                      ValueListenableBuilder(
                        valueListenable: connectCubit.socketState,
                        builder: (context, socketState, child) {
                          return ValueListenableBuilder(
                            valueListenable: connectCubit.hasTradePermission,
                            builder: (context, hasTradePermission, child) {
                              return MBouncingButton(
                                bouncing: false,
                                borderRadius: 8.0,
                                height: 50.0,
                                color: socketState.isDisconnected ||
                                        !hasTradePermission
                                    ? context.colorScheme.onSurfaceDisabled
                                    : context.colorScheme.primary,
                                title: context.tr.modify.toUpperCase(),
                                textSize: FoontSize.font16,
                                onTap: socketState.isDisconnected ||
                                        !hasTradePermission
                                    ? null
                                    : () {
                                        if (formKey.currentState!.validate()) {
                                          cubit.modifyOrder(
                                            requestSymbol: symbol,
                                            id: widget.item.id,
                                            price: _getUpdatedValue(
                                              price.value,
                                              widget.item.openPrice,
                                            ),
                                            volume: _getUpdatedValue(
                                              currentVolume,
                                              widget.item.volume,
                                            ),
                                            sl: _getUpdatedValue(
                                              sl,
                                              widget.item.sl.toTwoDecimalNum,
                                            ),
                                            tp: _getUpdatedValue(
                                              tp,
                                              widget.item.tp.toTwoDecimalNum,
                                            ),
                                            expiration: _getUpdatedValue(
                                              expiration,
                                              0,
                                            ),
                                          );
                                        }
                                      },
                              ).addPadding(top: 12.0);
                            },
                          );
                        },
                      ),
                    ],
                  );
                },
              ).addPadding(top: 50.0),
            ],
          ),
        ),
      ),
    );
  }

  double get currentVolume {
    final symbol = context.read<QuotesCubit>().currentSymbol.value!;
    final positionsCubit = context.read<PositionsCubit>();
    return convertPriceToLot(
      value: volume.value,
      symbol: symbol,
      price: price.value,
      accountLeverage: positionsCubit.account.value!.leverage,
    );
  }

  double getLimitVolume(SymbolEntity symbol, double volume, {int fixed = 0}) {
    final cubit = context.read<PositionsCubit>();
    final res = convertLotVolumeToPrice(
      data: volume,
      symbol: symbol,
      price: price.value,
      accountLeverage: cubit.account.value!.leverage,
    );
    return double.parse(res.toStringAsFixed(fixed));
  }
}

T? _getUpdatedValue<T>(T newValue, T oldValue) {
  return newValue != oldValue ? newValue : null;
}
