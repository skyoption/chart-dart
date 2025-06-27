import 'dart:ui';

import 'package:example/core/builder/flow_builder.dart';
import 'package:example/core/consts/currency.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/mtoast.dart';
import 'package:example/features/auth/logic/connect_cubit.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';
import 'package:example/features/trade/logic/open_position_cubit.dart';
import 'package:example/features/trade/views/widgets/trade_textfiled_item_widget.dart';
import 'package:web_socket_client/web_socket_client.dart' as socket;

enum TransactionOptions {
  market_order,
  buy_limit,
  sell_limit,
  buy_stop,
  sell_stop,
}

extension TransactionOptionsExtension on TransactionOptions {
  String get name {
    switch (this) {
      case TransactionOptions.market_order:
        return 'Market';
      case TransactionOptions.buy_limit:
        return 'Buy Limit';
      case TransactionOptions.sell_limit:
        return 'Sell Limit';
      case TransactionOptions.buy_stop:
        return 'Buy Stop';
      case TransactionOptions.sell_stop:
        return 'Sell Stop';
    }
  }
}

class SymbolOptionsWidget extends StatefulWidget {
  final TransactionOptions type;

  const SymbolOptionsWidget({
    super.key,
    required this.type,
  });

  @override
  State<SymbolOptionsWidget> createState() => _SymbolOptionsWidgetState();
}

class _SymbolOptionsWidgetState extends State<SymbolOptionsWidget> {
  late final openPositionCubit = context.read<OpenPositionCubit>();
  late final connectCubit = context.read<ConnectCubit>();
  final formKey = GlobalKey<FormState>();
  ValueNotifier<double> volume = ValueNotifier<double>(0);

  @override
  Widget build(BuildContext context) {
    if (widget.type != TransactionOptions.market_order) {
      return MBouncingButton(
        onTap: () {},
        title: context.tr.sendOrderAtPrice('1.09277'),
        borderRadius: 12.0,
        height: 50.0,
        color: context.colorScheme.primary,
      );
    }
    return Form(
      key: formKey,
      child: ValueListenableBuilder(
        valueListenable: context.read<QuotesCubit>().currentSymbol,
        builder: (context, symbol, widget) {
          if (symbol == null) return const SizedBox();
          if (volume.value == 0) volume.value = symbol.volumeMin;
          if (context.isLandscape) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                changeCurrency().addPadding(bottom: 6.0),
                tradeTextFiled(symbol).addPadding(bottom: 12.0),
                FlowBuilder<OpenPositionCubit>(
                  builder: (context, state, cubit) {
                    return Column(
                      children: [
                        if (cubit.error.isNotEmpty)
                          MText(
                            text: cubit.error,
                            color: Colors.red,
                            size: FoontSize.font14,
                          ).addPadding(top: 12.0),
                        ValueListenableBuilder(
                          valueListenable: connectCubit.socketState,
                          builder: (context, connectionState, child) {
                            return SizedBox(
                              height: 120.0,
                              child: Stack(
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      bidChange(
                                        symbol,
                                        cubit,
                                        connectionState,
                                      ),
                                      askChange(
                                        symbol,
                                        cubit,
                                        connectionState,
                                      ),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: diffPrice(symbol),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            );
          }
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: tradeTextFiled(symbol),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    flex: 2,
                    child: changeCurrency(),
                  )
                ],
              ).addPadding(bottom: 5.0),
              FlowBuilder<OpenPositionCubit>(
                builder: (context, state, cubit) {
                  return Column(
                    children: [
                      if (cubit.error.isNotEmpty)
                        MText(
                          text: cubit.error,
                          color: Colors.red,
                          size: FoontSize.font14,
                        ).addPadding(top: 12.0),
                      ValueListenableBuilder(
                        valueListenable: connectCubit.socketState,
                        builder: (context, connectionState, child) {
                          return SizedBox(
                            height: 45.0,
                            child: Stack(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    bidChange(
                                      symbol,
                                      cubit,
                                      connectionState,
                                    ),
                                    askChange(
                                      symbol,
                                      cubit,
                                      connectionState,
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: diffPrice(symbol),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget bidChange(
    SymbolEntity symbol,
    OpenPositionCubit cubit,
    socket.ConnectionState? connectionState,
  ) =>
      ValueListenableBuilder(
        valueListenable: symbol.bidChange,
        builder: (context, value, child) {
          return MBouncingButton(
            bouncing: false,
            onTap: connectionState.isDisconnected
                ? null
                : () {
                    if (symbol.isMarketClose) {
                      MToast.showError(
                        message: context.tr.marketCurrentlyClosed,
                      );
                    } else {
                      if (formKey.currentState!.validate()) {
                        cubit.openPosition(
                          symbol: symbol.symbol,
                          direction: 'SELL',
                          volume: volume.value,
                          sl: 0,
                          tp: 0,
                        );
                      }
                    }
                  },
            title: context.tr.sellAtPrice('$value'),
            width: context.isLandscape
                ? context.width * 0.22
                : context.width * 0.42,
            borderRadius: 8.0,
            height: 50.0,
            color: connectionState.isDisconnected
                ? context.colorScheme.surfaceDisabled
                : context.colorScheme.error,
          );
        },
      );

  Widget askChange(
    SymbolEntity symbol,
    OpenPositionCubit cubit,
    socket.ConnectionState? connectionState,
  ) =>
      ValueListenableBuilder(
        valueListenable: symbol.askChange,
        builder: (context, value, child) {
          return MBouncingButton(
            bouncing: false,
            onTap: connectionState.isDisconnected
                ? null
                : () {
                    if (symbol.isMarketClose) {
                      MToast.showError(
                        message: context.tr.marketCurrentlyClosed,
                      );
                    } else {
                      if (formKey.currentState!.validate()) {
                        cubit.openPosition(
                          symbol: symbol.symbol,
                          direction: 'BUY',
                          volume: volume.value,
                          sl: 0,
                          tp: 0,
                        );
                      }
                    }
                  },
            title: context.tr.buyAtPrice('$value'),
            borderRadius: 8.0,
            width: context.isLandscape
                ? context.width * 0.22
                : context.width * 0.42,
            height: 50.0,
            color: connectionState.isDisconnected
                ? context.colorScheme.onSurfaceDisabled
                : context.colorScheme.success,
          );
        },
      );

  Widget diffPrice(SymbolEntity symbol) => ClipRect(
        child: BackdropFilter(
          blendMode: BlendMode.srcOver,
          filter: ImageFilter.blur(
            sigmaX: 2.0,
            sigmaY: 2.0,
          ),
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
              valueListenable: symbol.tick,
              builder: (context, tick, child) {
                return MText(
                  text: tick.round().toString(),
                  size: FoontSize.font12,
                  align: TextAlign.center,
                  color: context.colorScheme.scrim,
                );
              },
            ),
          ),
        ),
      );

  Widget changeCurrency() => Container(
        margin: const MPadding.set(bottom: 10.0),
        // decoration: BoxDecoration(
        //   border: Border.all(
        //     color: context.colorScheme.outline,
        //   ),
        //   borderRadius: MBorderRadius.set(all: 10.0),
        // ),
        child: MDropDown<Currencies>(
          setInitial: context.read<CurrencyChanged>().getCurrency,
          dropdownPadding: const MPadding.set(
            horizontal: 10.0,
            vertical: 3.5,
          ),
          options: Currencies.values,
          titleSize: FoontSize.font17,
          iconSize: 24,
          borderRadius: 10,
          iconColor: context.colorScheme.scrim,
          textColor: context.colorScheme.scrim,
          selectedItemColor: context.colorScheme.scrim,
          backgroundColor: context.colorScheme.surfaceContainer,
          textSize: FoontSize.font16,
          prefix: (item) {
            if (item == Currencies.LOT) {
              return SizedBox(width: 35.0);
            }
            return MSvg(
              name: item?.name,
              width: 24.0,
              height: 24.0,
            ).addPadding(end: 5.0);
          },
          itemTitle: (Currencies item) => item.name,
          onChanged: (value) {
            context.read<CurrencyChanged>().change(value);
          },
        ),
      );

  Widget tradeTextFiled(SymbolEntity symbol) => TradeTextFiledItemWidget(
        color: context.colorScheme.surfaceContainer,
        init: symbol.volumeMin,
        max: symbol.volumeMax,
        min: symbol.volumeMin,
        step: symbol.volumeStep,
        digits: 2,
        removeBorder: true,
        contentPadding: const MPadding.set(
          vertical: 16.0,
          horizontal: 12.0,
        ),
        onChange: (value) {
          volume.value = double.tryParse(value) ?? 0;
        },
        validator: (messageError) {
          if (volume.value < symbol.volumeMin ||
              volume.value > symbol.volumeMax ||
              volume.value == 0) {
            return context.tr.fieldInvalid(context.tr.volume);
          }
          return null;
        },
      );
}
