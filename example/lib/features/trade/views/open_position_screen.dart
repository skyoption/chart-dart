import 'package:candle_chart/k_chart_widget.dart';
import 'package:example/core/builder/flow_builder.dart' show FlowBuilder;
import 'package:example/core/consts/exports.dart';
import 'package:example/features/auth/logic/connect_cubit.dart';
import 'package:example/features/chart/logic/chart_cubit.dart';
import 'package:example/features/chart/views/widgets/symbol_options_widget.dart';
import 'package:example/features/chart/views/widgets/symbols_widget.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';
import 'package:example/features/trade/logic/open_order_cubit.dart';
import 'package:example/features/trade/logic/open_position_cubit.dart';
import 'package:example/features/trade/views/widgets/open_position_info_widget.dart';
import 'package:example/features/trade/views/widgets/position_expiration_type_widget.dart';
import 'package:example/features/trade/views/widgets/stop_loss_widget.dart';
import 'package:example/features/trade/views/widgets/take_profit_widget.dart';
import 'package:example/features/trade/views/widgets/trade_chart_item_widget.dart';
import 'package:example/features/trade/views/widgets/trade_dropdown_item_widget.dart';
import 'package:example/features/trade/views/widgets/trade_price_item_widget.dart';
import 'package:example/features/trade/views/widgets/trade_textfiled_item_widget.dart';
import 'package:example/features/trade_history/views/bottom_sheets/date_time_bottom_sheet.dart';
import 'package:example/injection/injectable.dart';

enum PositionType { bid, ask, none }

class OpenPositionScreen extends StatefulWidget {
  static const id = 'OpenPositionScreen';
  final String? item;

  const OpenPositionScreen({super.key, this.item});

  @override
  State<OpenPositionScreen> createState() => _OpenPositionScreenState();
}

class _OpenPositionScreenState extends State<OpenPositionScreen> {
  late final transitionTypes = [
    ItemEntity(
      name: context.tr.marketExecution,
      value: TransactionOptions.market_order,
    ),
    ItemEntity(
      name: context.tr.buyLimit,
      value: TransactionOptions.buy_limit,
    ),
    ItemEntity(
      name: context.tr.sellLimit,
      value: TransactionOptions.sell_limit,
    ),
    ItemEntity(
      name: context.tr.buyStop,
      value: TransactionOptions.buy_stop,
    ),
    ItemEntity(
      name: context.tr.sellStop,
      value: TransactionOptions.sell_stop,
    ),
  ];

  final formKey = GlobalKey<FormState>();
  final price = ValueNotifier<double>(0);
  late final transition = ValueNotifier<ItemEntity>(transitionTypes[0]);
  ValueNotifier<double> volume = ValueNotifier<double>(0);
  ValueNotifier<PositionType> orderType = ValueNotifier(PositionType.none);
  late final loginCubit = context.read<ConnectCubit>();

  double sl = 0, tp = 0;
  int expiration = 0;
  final openPositionCubit = getIt<OpenPositionCubit>();
  final openOrderCubit = getIt<OpenOrderCubit>();

  @override
  void initState() {
    final cubit = context.read<QuotesCubit>();
    if (widget.item != null) {
      cubit.currentSymbol.value = cubit.getSymbol(widget.item!);
    }
    super.initState();
  }

  void _updateChart(symbol) {
    final chartCubit = context.read<ChartCubit>();
    chartCubit.getCandles(
      timeFrame: CandleTimeFormat.M1,
      symbol: symbol,
      offset: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = context.height;
    final width = context.width;
    final cubit = context.read<QuotesCubit>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(width, height * 0.056),
        child: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Icon(
                  Icons.arrow_back,
                  color: context.colorScheme.scrim,
                  size: 30.0,
                ).addAction(
                  padding: const MPadding.set(end: 12.0),
                  onGesture: () {
                    context.pop();
                  },
                ),
              ),
              Align(
                alignment: AlignmentDirectional.center,
                child: SymbolsWidget(
                  onChanged: (String symbol) {
                    _updateChart(symbol);
                  },
                ),
              ),
            ],
          ).addPadding(horizontal: 21.0),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => openPositionCubit),
          BlocProvider(create: (context) => openOrderCubit),
        ],
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            padding: const MPadding.set(bottom: 30.0),
            physics: const BouncingScrollPhysics(),
            child: ValueListenableBuilder(
              valueListenable: cubit.currentSymbol,
              builder: (context, symbol, widget) {
                if (symbol == null) return const SizedBox();
                if (volume.value == 0) volume.value = symbol.volumeMin;
                return ValueListenableBuilder<ItemEntity>(
                  valueListenable: transition,
                  builder: (context, transitionType, child) {
                    return Column(
                      children: [
                        if (transitionType.value ==
                            TransactionOptions.market_order)
                          Padding(
                            padding: const MPadding.set(end: 5.0),
                            child: TradeChartItemWidget(
                              transition: transition,
                            ),
                          ),
                        if (transitionType.value !=
                            TransactionOptions.market_order)
                          Padding(
                            padding: const MPadding.set(
                              horizontal: 21.0,
                              vertical: 21.0,
                            ),
                            child: TradePriceItemWidget(
                              symbol: symbol,
                            ),
                          ),
                        MDividerItemWidget(
                          color: context.colorScheme.outline,
                          padding: const MPadding.set(
                            bottom: 21.0,
                            horizontal: 21.0,
                          ),
                        ),
                        Column(
                          children: [
                            TradeDropdownItemWidget<ItemEntity>(
                              title: context.tr.tradeType,
                              initial: transitionTypes[0],
                              options: transitionTypes,
                              onTap: (item) {
                                transition.value = item;
                                if (item.value == TransactionOptions.buy_stop ||
                                    item.value ==
                                        TransactionOptions.sell_limit) {
                                  orderType.value = PositionType.ask;
                                } else if (item.value ==
                                        TransactionOptions.buy_limit ||
                                    item.value ==
                                        TransactionOptions.sell_stop) {
                                  orderType.value = PositionType.bid;
                                }
                              },
                              onName: (item) => item.name,
                            ),
                            if (transitionType.value !=
                                TransactionOptions.market_order)
                              TradeTextFiledItemWidget(
                                key: const ValueKey('price-field'),
                                title: context.tr.price,
                                step: 1,
                                init: 1000,
                                onChange: (value) {
                                  price.value = double.tryParse(value) ?? 0.0;
                                },
                                validator: (messageError) {
                                  if (price.value < 0) {
                                    return context.tr.invalid;
                                  }
                                  return null;
                                },
                              ),
                            TradeTextFiledItemWidget(
                              key: const ValueKey('volume-field'),
                              init: symbol.volumeMin,
                              max: symbol.volumeMax,
                              min: symbol.volumeMin,
                              step: symbol.volumeStep,
                              digits: symbol.digits,
                              title: context.tr.volume,
                              onChange: (value) {
                                volume.value = double.tryParse(value) ?? 0;
                              },
                              validator: (messageError) {
                                if (volume.value < symbol.volumeMin ||
                                    volume.value > symbol.volumeMax ||
                                    volume.value == 0) {
                                  return context.tr.invalid;
                                }
                                return null;
                              },
                            ),
                            ValueListenableBuilder<PositionType>(
                                valueListenable: orderType,
                                builder: (context, value, child) {
                                  final currentPrice = transitionType.value ==
                                          TransactionOptions.market_order
                                      ? value == PositionType.ask
                                          ? symbol.askChange.value
                                          : symbol.bidChange.value
                                      : price.value;
                                  return Column(
                                    children: [
                                      StopLossWidget(
                                        type: value,
                                        price: currentPrice,
                                        onChange: (value) {
                                          sl = value;
                                        },
                                      ),
                                      TakeProfitWidget(
                                        type: value,
                                        price: currentPrice,
                                        onChange: (value) {
                                          tp = value;
                                        },
                                      ),
                                    ],
                                  );
                                }),
                            if (transitionType.value !=
                                TransactionOptions.market_order)
                              PositionExpirationTypeWidget(
                                transactionOption: transitionType.value,
                                onTap: (value) {
                                  expiration = value;
                                },
                              )
                          ],
                        ).addPadding(horizontal: 21.0),
                        MDividerItemWidget(
                          color: context.colorScheme.outline,
                          padding: const MPadding.set(
                            vertical: 12.0,
                            horizontal: 21.0,
                          ),
                        ),
                        OpenPositionInfoWidget(
                          volume: volume,
                          symbol: symbol,
                          price: transitionType.value ==
                                  TransactionOptions.market_order
                              ? orderType.value == PositionType.ask
                                  ? symbol.askChange
                                  : symbol.bidChange
                              : price,
                        ),
                        if (transitionType.value ==
                            TransactionOptions.market_order)
                          positionButtons(symbol)
                        else
                          FlowBuilder<OpenOrderCubit>(
                            onSuccess: (state, cubit) {
                              context.pop();
                            },
                            builder: (context, state, cubit) {
                              return ValueListenableBuilder(
                                valueListenable: price,
                                builder: (context, value, child) {
                                  return Column(
                                    children: [
                                      if (cubit.error.isNotEmpty)
                                        MText(
                                          text: cubit.error,
                                          color: AppColors.red,
                                          size: FoontSize.font14,
                                        ).addPadding(top: 12.0),
                                      MBouncingButton(
                                        height: 50.0,
                                        borderRadius: 8.0,
                                        title: context.tr
                                            .sendOrderAtPrice(value.toString()),
                                        textSize: FoontSize.font18,
                                        color: AppColors.primary,
                                        onTap: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            cubit.openOrder(
                                              symbol: symbol.symbol,
                                              direction: transitionType
                                                  .value.name
                                                  .toUpperCase()
                                                  .replaceAll(' ', '_'),
                                              price: price.value,
                                              expirationDate: expiration,
                                              volume: volume.value,
                                              sl: sl,
                                              tp: tp,
                                            );
                                          }
                                        },
                                      ).addPadding(top: 12.0, horizontal: 21.0),
                                    ],
                                  );
                                },
                              );
                            },
                          )
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget positionButtons(SymbolEntity symbol) {
    return FlowBuilder<OpenPositionCubit>(
      onSuccess: (state, cubit) {
        context.pop();
      },
      builder: (context, state, cubit) {
        return Column(
          children: [
            if (cubit.error.isNotEmpty)
              MText(
                text: cubit.error,
                color: AppColors.red,
                size: FoontSize.font14,
              ).addPadding(top: 12.0),
            ValueListenableBuilder(
              valueListenable: loginCubit.socketState,
              builder: (context, socketState, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: symbol.bidChange,
                      builder: (context, value, child) {
                        return MBouncingButton(
                          height: 50.0,
                          borderRadius: 8.0,
                          width: context.width * 0.42,
                          title: context.tr.sellAtPrice(value.toString()),
                          textSize: FoontSize.font18,
                          color: socketState.connectionColor(
                            Coolors.red,
                            context.colorScheme.error,
                          ),
                          onTap: socketState.isDisconnected
                              ? null
                              : () {
                                  orderType.value = PositionType.bid;
                                  if (formKey.currentState!.validate()) {
                                    cubit.openPosition(
                                      symbol: symbol.symbol,
                                      direction: 'SELL',
                                      volume: volume.value,
                                      sl: sl,
                                      tp: tp,
                                    );
                                  }
                                },
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: symbol.askChange,
                      builder: (context, value, child) {
                        return MBouncingButton(
                          height: 50.0,
                          borderRadius: 8.0,
                          width: context.width * 0.42,
                          title: context.tr.buyAtPrice(value.toString()),
                          textSize: FoontSize.font18,
                          color: socketState.connectionColor(
                            Coolors.green,
                            context.colorScheme.error,
                          ),
                          onTap: socketState.isDisconnected
                              ? null
                              : () {
                                  orderType.value = PositionType.ask;
                                  if (formKey.currentState!.validate()) {
                                    cubit.openPosition(
                                      symbol: symbol.symbol,
                                      direction: 'BUY',
                                      volume: volume.value,
                                      sl: sl,
                                      tp: tp,
                                    );
                                  }
                                },
                        );
                      },
                    ),
                  ],
                ).addPadding(top: 12.0);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
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
