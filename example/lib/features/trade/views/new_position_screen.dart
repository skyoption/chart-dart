// ignore_for_file: constant_identifier_names

import 'dart:ui';

import 'package:candle_chart/k_chart_widget.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/features/chart/views/widgets/chart_shortcut_widget.dart';
import 'package:example/features/chart/views/widgets/choose_symbol_widget.dart';
import 'package:example/features/chart/views/widgets/selectable_item_widget.dart';
import 'package:example/features/chart/views/widgets/symbol_options_widget.dart';
import 'package:example/features/trade/views/widgets/currency_ask_bid_widget.dart';
import 'package:example/features/trade/views/widgets/position_expiration_type_widget.dart';
import 'package:example/features/trade/views/widgets/stop_loss_widget.dart';
import 'package:example/features/trade/views/widgets/symbol_details_widget.dart';
import 'package:example/features/trade/views/widgets/take_profit_widget.dart';
import 'package:example/features/trade/views/widgets/trade_chart_item_widget.dart';
import 'package:example/features/trade/views/widgets/trade_textfiled_item_widget.dart';
import 'package:example/core/framework/functions.dart';
import 'package:example/core/shared/bottom_sheets/date_time_bottom_sheet.dart';
import 'package:example/core/shared/change_currencies_drop_down_widget.dart';
import 'package:example/core/shared/my_scaffold_widget.dart';
import 'package:example/core/shared/top_icon_button_widget.dart';
import 'package:example/features/chart/logic/chart_cubit.dart';
import 'package:example/features/main/logic/connect_cubit.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';
import 'package:example/features/trade/logic/open_order_cubit.dart';
import 'package:example/features/trade/logic/open_position_cubit.dart';
import 'package:example/features/trade/logic/positions_cubit.dart';

enum ExpirationOptions { GTC, Today, Specified }

@RoutePage()
class NewPositionScreen extends StatefulWidget {
  final String? item;

  const NewPositionScreen({super.key, this.item});

  @override
  State<NewPositionScreen> createState() => _NewPositionScreenState();
}

class _NewPositionScreenState extends State<NewPositionScreen> {
  int expiration = 0;
  double sl = 0, tp = 0;
  final formKey = GlobalKey<FormState>();
  final price = ValueNotifier<double>(1000);
  final volume = ValueNotifier<double>(0);
  final key = GlobalKey<TradeChartItemWidgetState>();
  final orderType = ValueNotifier<PositionType?>(null);
  late final openPositionCubit = context.read<OpenPositionCubit>();
  late final openOrderCubit = context.read<OpenOrderCubit>();
  late final connectCubit = context.read<ConnectCubit>();
  late final positionsCubit = context.read<PositionsCubit>();

  late final transition = ValueNotifier<ItemEntity>(transitionTypes[0]);
  late final transitionTypes = [
    ItemEntity(
      name: context.tr.marketExecution,
      value: TransactionOptions.market_order,
    ),
    ItemEntity(name: context.tr.buyLimit, value: TransactionOptions.buy_limit),
    ItemEntity(
      name: context.tr.sellLimit,
      value: TransactionOptions.sell_limit,
    ),
    ItemEntity(name: context.tr.buyStop, value: TransactionOptions.buy_stop),
    ItemEntity(name: context.tr.sellStop, value: TransactionOptions.sell_stop),
  ];

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QuotesCubit>();
    return MScaffoldWidget(
      title: context.tr.openNewPosition,
      appbarSize: 50.0,
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          padding: MPadding.set(top: 12.0),
          child: Column(
            children: [
              ValueListenableBuilder(
                valueListenable: cubit.currentSymbol,
                builder: (context, symbol, widget) {
                  if (symbol == null) return const SizedBox();

                  // Recalculate volume when symbol changes to ensure proper margin calculations
                  if (volume.value == 0) {
                    volume.value = getLimitVolume(symbol, symbol.volumeMin);
                  } else {
                    // Convert current volume to lot size and then back to price for the new symbol
                    final currentLotVolume = convertPriceToLot(
                      value: volume.value,
                      symbol: symbol,
                      price: transition.value.value ==
                              TransactionOptions.market_order
                          ? orderType.value == PositionType.ask
                              ? symbol.askChange.value
                              : symbol.bidChange.value
                          : price.value,
                      accountLeverage: positionsCubit.account.value!.leverage,
                    );

                    // Use getLimitVolume to convert lot volume to price for the new symbol
                    volume.value = getLimitVolume(symbol, currentLotVolume);
                  }

                  key.currentState?.clear();
                  return Column(
                    children: [
                      ChooseSymbolWidget(
                        onChanged: (symbol) {
                          _updateChart(symbol);
                        },
                      ),
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: CurrencyAskBidWidget(
                              item: symbol,
                              textSize: FoontSize.font13,
                              largeTextSize: FoontSize.font16,
                            ).addPadding(top: 6.0),
                          ),
                          Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: ValueListenableBuilder<ItemEntity>(
                              valueListenable: transition,
                              builder: (context, transitionType, child) {
                                if (transitionType.value !=
                                    TransactionOptions.market_order) {
                                  return SizedBox();
                                }
                                return ValueListenableBuilder<GraphStyle>(
                                  valueListenable: style,
                                  builder: (context, value, child) {
                                    final isCandle =
                                        value == GraphStyle.candles;
                                    return TopIconButtonWidget(
                                      iconTransparent: true,
                                      iconSize: 21.0,
                                      icon: isCandle
                                          ? Svgs.activeCandle
                                          : Svgs.activeArea,
                                      onTap: () {
                                        if (isCandle) {
                                          style.value = GraphStyle.area;
                                        } else {
                                          style.value = GraphStyle.candles;
                                        }
                                      },
                                      height: 40.0,
                                      width: 48.0,
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ).addPadding(top: 12.0, horizontal: 21.0),
                      ValueListenableBuilder<ItemEntity>(
                        valueListenable: transition,
                        builder: (context, transitionType, child) {
                          return Column(
                            children: [
                              ValueListenableBuilder<ItemEntity>(
                                valueListenable: transition,
                                builder: (context, transitionType, child) {
                                  if (transitionType.value !=
                                      TransactionOptions.market_order) {
                                    return SizedBox(height: 21.0);
                                  }
                                  return chart();
                                },
                              ),
                              // optionsBar(),
                              priceField(transitionType, symbol).addPadding(
                                horizontal: context.isLandscape ? 150.0 : 0,
                              ),
                              ValueListenableBuilder(
                                valueListenable: volume,
                                builder: (context, volumeValue, child) {
                                  return volumeField(
                                    symbol: symbol,
                                    volumeValue: volumeValue,
                                    accountLeverage:
                                        positionsCubit.account.value!.leverage,
                                  ).addPadding(
                                    horizontal: context.isLandscape ? 150.0 : 0,
                                  );
                                },
                              ),
                              ValueListenableBuilder(
                                valueListenable: volume,
                                builder: (context, value, child) {
                                  return takeProfitAndStopLoss(
                                    transitionType,
                                    symbol,
                                  ).addPadding(
                                    horizontal: context.isLandscape ? 150.0 : 0,
                                  );
                                },
                              ),
                              positionExpiration(transitionType).addPadding(
                                horizontal: context.isLandscape ? 150.0 : 0,
                              ),
                              Row(
                                children: [
                                  MText(
                                    text: context.tr.orderInformation,
                                    size: FoontSize.font17,
                                    weight: FontWeight.w500,
                                    color: context.colorScheme.onSurface,
                                  ).addPadding(end: 8.0),
                                  const MSvg(
                                    name: Svgs.info,
                                    width: 20,
                                    height: 20,
                                  ).addAction(
                                    onTap: () => showSymbolDetailsBottomSheet(
                                      context: context,
                                      volume: volume,
                                      symbol: symbol,
                                      price: transitionType.value ==
                                              TransactionOptions.market_order
                                          ? orderType.value == PositionType.ask
                                              ? symbol.askChange
                                              : symbol.bidChange
                                          : price,
                                    ),
                                  ),
                                ],
                              ).addPadding(
                                horizontal: context.isLandscape ? 130 : 21.0,
                                top: 12.0,
                              ),
                              if (transitionType.value ==
                                  TransactionOptions.market_order)
                                positionButtons(symbol)
                              else
                                orderButton(symbol, transitionType),
                            ],
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  final style = ValueNotifier<GraphStyle>(GraphStyle.area);

  Widget chart() {
    return ChartShortcutWidget(
      graphStyle: style,
      initialSymbol: widget.item,
    ).addPadding(bottom: 21.0);
  }

  void _updateChart(symbol) {
    final chartCubit = context.read<ChartCubit>();
    chartCubit.getCandles(symbol: symbol, offset: 0);

    // Recalculate volume when symbol changes to update margin calculations
    final newSymbol = context.read<QuotesCubit>().currentSymbol.value;
    if (newSymbol != null && volume.value > 0) {
      // Convert current volume to lot size and then back to price for the new symbol
      final currentLotVolume = convertPriceToLot(
        value: volume.value,
        symbol: newSymbol,
        price: transition.value.value == TransactionOptions.market_order
            ? orderType.value == PositionType.ask
                ? newSymbol.askChange.value
                : newSymbol.bidChange.value
            : price.value,
        accountLeverage: positionsCubit.account.value!.leverage,
      );

      // Use getLimitVolume to convert lot volume to price for the new symbol
      volume.value = getLimitVolume(newSymbol, currentLotVolume);
    }
  }

  Widget positionButtons(SymbolEntity symbol) {
    return FlowBuilder<OpenPositionCubit>(
      onSuccess: (state, cubit) {
        AutoRouterX(context).maybePop();
      },
      builder: (context, state, cubit) {
        return Column(
          children: [
            ValueListenableBuilder(
              valueListenable: connectCubit.socketState,
              builder: (context, socketState, child) {
                return Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ValueListenableBuilder(
                          valueListenable: symbol.bidChange,
                          builder: (context, value, child) {
                            return ValueListenableBuilder(
                              valueListenable: connectCubit.hasTradePermission,
                              builder: (context, hasTradePermission, child) {
                                return MBouncingButton(
                                  bouncing: false,
                                  height: 50.0,
                                  width: context.isLandscape
                                      ? context.width * 0.32
                                      : context.width * 0.42,
                                  borderRadius: 8.0,
                                  title:
                                      '${context.tr.sell.toUpperCase()} @ $value',
                                  textSize: FoontSize.font16,
                                  color: socketState.isDisconnected ||
                                          !hasTradePermission ||
                                          symbol.isMarketClose
                                      ? context.colorScheme.onSurfaceDisabled
                                      : context.colorScheme.error,
                                  onTap: socketState.isDisconnected ||
                                          !hasTradePermission ||
                                          symbol.isMarketClose
                                      ? null
                                      : () {
                                          orderType.value = PositionType.bid;
                                          Future.delayed(
                                            Duration(milliseconds: 200),
                                            () {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                cubit.openPosition(
                                                  symbol: symbol.symbol,
                                                  direction: 'SELL',
                                                  volume: currentVolume,
                                                  sl: sl,
                                                  tp: tp,
                                                  price: getPrice(symbol),
                                                );
                                              }
                                            },
                                          );
                                        },
                                );
                              },
                            );
                          },
                        ),
                        ValueListenableBuilder(
                          valueListenable: symbol.askChange,
                          builder: (context, value, child) {
                            return ValueListenableBuilder(
                              valueListenable: connectCubit.hasTradePermission,
                              builder: (context, hasTradePermission, child) {
                                return MBouncingButton(
                                  bouncing: false,
                                  height: 50.0,
                                  width: context.isLandscape
                                      ? context.width * 0.32
                                      : context.width * 0.42,
                                  borderRadius: 8.0,
                                  title:
                                      '${context.tr.buy.toUpperCase()} @ $value',
                                  textSize: FoontSize.font16,
                                  color: socketState.isDisconnected ||
                                          !hasTradePermission ||
                                          symbol.isMarketClose
                                      ? context.colorScheme.onSurfaceDisabled
                                      : context.colorScheme.success,
                                  onTap: socketState.isDisconnected ||
                                          !hasTradePermission ||
                                          symbol.isMarketClose
                                      ? null
                                      : () {
                                          orderType.value = PositionType.ask;
                                          Future.delayed(
                                            Duration(milliseconds: 200),
                                            () {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                cubit.openPosition(
                                                  symbol: symbol.symbol,
                                                  direction: 'BUY',
                                                  volume: currentVolume,
                                                  sl: sl,
                                                  tp: tp,
                                                  price: getPrice(symbol),
                                                );
                                              }
                                            },
                                          );
                                        },
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ).addPadding(horizontal: 21.0),
                    Align(
                      alignment: Alignment.center,
                      child: ClipRect(
                        child: BackdropFilter(
                          blendMode: BlendMode.srcOver,
                          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                          child: Container(
                            padding: const MPadding.set(
                              vertical: 3.0,
                              horizontal: 12.0,
                            ),
                            constraints: BoxConstraints(minWidth: 60),
                            decoration: BoxDecoration(
                              color: context.colorScheme.surfaceContainerLow,
                              borderRadius: MBorderRadius.set(all: 25.0),
                            ),
                            child: ValueListenableBuilder(
                              valueListenable: symbol.spread,
                              builder: (context, tick, child) {
                                return MText(
                                  text: tick.round().toString(),
                                  size: FoontSize.font12,
                                  align: TextAlign.center,
                                  color: context.colorScheme.onSurface,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ).addPadding(top: 14.0),
                  ],
                ).addPadding(top: 12.0, bottom: 50.0);
              },
            ),
          ],
        ).addPadding(horizontal: context.isLandscape ? 150.0 : 0);
      },
    );
  }

  double getPrice(SymbolEntity symbol) {
    return transition.value.value == TransactionOptions.market_order
        ? orderType.value == PositionType.ask
            ? symbol.askChange.value
            : symbol.bidChange.value
        : price.value;
  }

  double get currentVolume {
    final symbol = context.read<QuotesCubit>().currentSymbol.value!;
    final positionsCubit = context.read<PositionsCubit>();
    final currentPrice =
        transition.value.value == TransactionOptions.market_order
            ? orderType.value == PositionType.ask
                ? symbol.askChange
                : symbol.bidChange
            : price;
    return convertPriceToLot(
      value: volume.value,
      symbol: symbol,
      price: currentPrice.value,
      accountLeverage: positionsCubit.account.value!.leverage,
    );
  }

  Widget orderButton(SymbolEntity symbol, ItemEntity transitionType) {
    return FlowBuilder<OpenOrderCubit>(
      onSuccess: (state, cubit) {
        AutoRouterX(context).maybePop();
      },
      builder: (context, state, cubit) {
        return ValueListenableBuilder(
          valueListenable: price,
          builder: (context, value, child) {
            return Column(
              children: [
                ValueListenableBuilder(
                  valueListenable: connectCubit.socketState,
                  builder: (context, socketState, child) {
                    return MBouncingButton(
                      bouncing: false,
                      height: 50.0,
                      borderRadius: 8.0,
                      width: double.infinity,
                      title:
                          '${context.tr.orderSend} ${value != 0 ? ' @$value' : ''}',
                      textSize: FoontSize.font16,
                      color: socketState.connectionColor(
                        context.colorScheme.primary,
                        context.colorScheme.error,
                      ),
                      onTap: socketState.isDisconnected
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                cubit.openOrder(
                                  symbol: symbol.symbol,
                                  direction: transitionType.name
                                      .toString()
                                      .toUpperCase()
                                      .replaceAll(' ', '_'),
                                  price: price.value,
                                  expirationDate: expiration,
                                  volume: currentVolume,
                                  sl: sl,
                                  tp: tp,
                                );
                              }
                            },
                    ).addPadding(
                      top: 12.0,
                      horizontal: context.isLandscape ? 150 : 21.0,
                      bottom: 50.0,
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget takeProfitAndStopLoss(transitionType, symbol) {
    return ValueListenableBuilder<double>(
      valueListenable: price,
      builder: (context, price, child) {
        return ValueListenableBuilder<PositionType?>(
          valueListenable: orderType,
          builder: (context, value, child) {
            return Column(
              children: [
                TakeProfitWidget(
                  volume: currentVolume,
                  symbol: symbol,
                  type: value,
                  digits: symbol.digits,
                  onChange: (value) {
                    tp = value;
                  },
                ).addPadding(bottom: 16.0),
                StopLossWidget(
                  symbol: symbol,
                  type: value,
                  volume: currentVolume,
                  digits: symbol.digits,
                  onChange: (value) {
                    sl = value;
                  },
                ),
              ],
            );
          },
        ).addPadding(horizontal: 21.0, bottom: 16.0);
      },
    );
  }

  double getLimitMargin(SymbolEntity symbol) {
    final cubit = context.read<PositionsCubit>();
    final currentPrice =
        transition.value.value == TransactionOptions.market_order
            ? orderType.value == PositionType.ask
                ? symbol.askChange
                : symbol.bidChange
            : price;
    final res = getTradeMargin(
      volume: currentVolume,
      symbol: symbol,
      price: currentPrice.value,
      accountLeverage: cubit.account.value!.leverage,
    );
    return truncateToDecimalPlaces(res, 3);
  }

  double getLimitVolume(SymbolEntity symbol, double volume, {int fixed = 2}) {
    final cubit = context.read<PositionsCubit>();
    final currentPrice =
        transition.value.value == TransactionOptions.market_order
            ? orderType.value == PositionType.ask
                ? symbol.askChange
                : symbol.bidChange
            : price;
    final res = convertLotVolumeToPrice(
      data: volume,
      symbol: symbol,
      price: currentPrice.value,
      accountLeverage: cubit.account.value!.leverage,
    );
    return double.parse(res.toStringAsFixed(fixed));
  }

  Widget volumeField({
    required SymbolEntity symbol,
    required double volumeValue,
    required int accountLeverage,
  }) {
    return FlowBuilder<CurrencyChanged>(
      buildWhenState: (previous, current) {
        return current.type == StateType.success;
      },
      builder: (context, state, cubit) {
        final currency = cubit.getCurrency;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MText(
              text: context.tr.volume,
              size: FoontSize.font14,
              weight: FontWeight.w400,
              color: context.colorScheme.onSurface,
            ).addPadding(bottom: 10.0),
            Row(
              spacing: 12.0,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: TradeTextFiledItemWidget(
                    digits: 2,
                    init: getLimitVolume(symbol, symbol.volumeMin),
                    max: getLimitVolume(symbol, symbol.volumeMax),
                    min: getLimitVolume(symbol, symbol.volumeMin),
                    // title: context.tr.volume,
                    onChange: (value) {
                      volume.value = truncateToDecimalPlaces(
                        double.tryParse(value) ?? 0,
                        2,
                      );
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
                      final volumeMin = getLimitVolume(
                        symbol,
                        symbol.volumeMin,
                      );
                      final volumeMax = getLimitVolume(
                        symbol,
                        symbol.volumeMax,
                      );
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
                ),
                Expanded(flex: 2, child: ChangeCurrenciesDropDownWidget()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ValueListenableBuilder(
                  valueListenable: volume,
                  builder: (context, value, child) {
                    return MText(
                      text:
                          "${context.tr.commission}: ${truncateToDecimalPlaces((symbol.commissionIn + symbol.commissionOut) * currentVolume, 2)} ${context.tr.usd}",
                      size: FoontSize.font10,
                      weight: FontWeight.w400,
                      color: context.colorScheme.onSurfaceVariant,
                    );
                  },
                ),
                ValueListenableBuilder(
                  valueListenable: price,
                  builder: (context, priceValue, child) {
                    return ValueListenableBuilder(
                      valueListenable: volume,
                      builder: (context, value, child) {
                        return MText(
                          text:
                              "${currency != Currencies.LOT ? '${context.tr.lot} ' : context.tr.margin}: ${getLimitMargin(symbol).toCurrencyAsFixed(3)}",
                          size: FoontSize.font10,
                          weight: FontWeight.w400,
                          color: context.colorScheme.onSurfaceVariant,
                        );
                      },
                    );
                  },
                ),
                ValueListenableBuilder(
                  valueListenable: positionsCubit.account,
                  builder: (context, value, child) {
                    return MText(
                      text:
                          "${context.tr.leverage}: 1:${positionsCubit.account.value!.leverage}",
                      size: FoontSize.font10,
                      weight: FontWeight.w400,
                      color: context.colorScheme.onSurfaceVariant,
                    );
                  },
                ),
              ],
            ),
          ],
        );
      },
    ).addPadding(horizontal: 21.0, bottom: 16.0);
  }

  Widget priceField(transitionType, SymbolEntity symbol) {
    if (transitionType.value != TransactionOptions.market_order) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            flex: 4,
            child: TradeTextFiledItemWidget(
              title: context.tr.price,
              step: 1,
              init: symbol.bid,
              digits: symbol.digits,
              onChange: (value) {
                price.value = double.tryParse(value) ?? 0.0;
              },
              validator: (messageError) {
                if (price.value < 0) {
                  return context.tr.fieldInvalid(context.tr.price);
                }
                return null;
              },
            ),
          ),
        ],
      ).addPadding(bottom: 16.0, horizontal: 21.0);
    }
    return SizedBox();
  }

  Widget optionsBar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 21.0,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(transitionTypes.length, (index) {
          final item = transitionTypes[index];
          return SelectableItemWidget(
            item: item,
            isSelected: transition.value == item,
            onTap: () {
              transition.value = item;
              if (item.value == TransactionOptions.buy_stop ||
                  item.value == TransactionOptions.sell_limit) {
                orderType.value = PositionType.ask;
              } else if (item.value == TransactionOptions.buy_limit ||
                  item.value == TransactionOptions.sell_stop) {
                orderType.value = PositionType.bid;
              }
            },
          );
        }),
      ),
    ).addPadding(bottom: 21.0, horizontal: 16.0);
  }

  Widget positionExpiration(ItemEntity transitionType) {
    if (transitionType.value != TransactionOptions.market_order) {
      return PositionExpirationTypeWidget(
        transactionOption: transitionType.value,
        onTap: (value) {
          expiration = value;
        },
      ).addPadding(horizontal: 21.0);
    }
    return SizedBox();
  }

  @override
  void dispose() {
    style.dispose();
    openPositionCubit.close();
    openOrderCubit.close();
    price.dispose();
    orderType.dispose();
    transition.dispose();
    formKey.currentState?.dispose();
    volume.dispose();
    super.dispose();
  }
}
