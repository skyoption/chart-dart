import 'dart:ui';

import 'package:example/core/consts/exports.dart';
import 'package:example/features/trade/views/widgets/trade_textfiled_item_widget.dart';
import 'package:example/core/framework/functions.dart';
import 'package:example/core/framework/mtoast.dart';
import 'package:example/core/shared/change_currencies_drop_down_widget.dart';
import 'package:example/features/main/logic/connect_cubit.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';
import 'package:example/features/trade/logic/open_position_cubit.dart';
import 'package:example/features/trade/logic/positions_cubit.dart';
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

  const SymbolOptionsWidget({super.key, required this.type});

  @override
  State<SymbolOptionsWidget> createState() => _SymbolOptionsWidgetState();
}

class _SymbolOptionsWidgetState extends State<SymbolOptionsWidget> {
  late final openPositionCubit = context.read<OpenPositionCubit>();
  late final connectCubit = context.read<ConnectCubit>();
  final formKey = GlobalKey<FormState>();
  final volume = ValueNotifier<double>(0);
  final price = ValueNotifier<double>(0);

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
          price.value = symbol.bidChange.value;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(Duration(milliseconds: 150), () {
              formKey.currentState?.validate();
            });
          });
          if (context.isLandscape) {
            return Row(
              spacing: 16.0,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(flex: 2),
                Expanded(
                  flex: 6,
                  child: FlowBuilder<OpenPositionCubit>(
                    builder: (context, state, cubit) {
                      return ValueListenableBuilder(
                        valueListenable: connectCubit.socketState,
                        builder: (context, connectionState, child) {
                          return ValueListenableBuilder(
                            valueListenable: connectCubit.hasTradePermission,
                            builder: (context, hasTradePermission, child) {
                              return SizedBox(
                                height: 50.0,
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
                                          height: 45.0,
                                          hasTradePermission:
                                              hasTradePermission,
                                        ),
                                        askChange(
                                          symbol,
                                          cubit,
                                          connectionState,
                                          height: 45.0,
                                          hasTradePermission:
                                              hasTradePermission,
                                        ),
                                      ],
                                    ),
                                    Positioned.fill(
                                      bottom: 8.0,
                                      child: Center(child: diffPrice(symbol)),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                Expanded(flex: 4, child: tradeTextFiled(symbol)),
                Expanded(flex: 2, child: changeCurrency()),
              ],
            );
          }
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 5, child: tradeTextFiled(symbol)),
                  const SizedBox(width: 16.0),
                  Expanded(flex: 2, child: changeCurrency()),
                ],
              ).addPadding(bottom: 5.0),
              FlowBuilder<OpenPositionCubit>(
                builder: (context, state, cubit) {
                  return Column(
                    children: [
                      ValueListenableBuilder(
                        valueListenable: connectCubit.socketState,
                        builder: (context, connectionState, child) {
                          return ValueListenableBuilder(
                            valueListenable: connectCubit.hasTradePermission,
                            builder: (context, hasTradePermission, child) {
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
                                          hasTradePermission:
                                              hasTradePermission,
                                        ),
                                        askChange(
                                          symbol,
                                          cubit,
                                          connectionState,
                                          hasTradePermission:
                                              hasTradePermission,
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

  double getLimitVolume(
    SymbolEntity symbol,
    double volume,
    double currentPrice,
    int accountLeverage,
  ) {
    return convertLotVolumeToPrice(
      data: volume,
      symbol: symbol,
      price: currentPrice,
      accountLeverage: accountLeverage,
    );
  }

  Widget bidChange(
    SymbolEntity symbol,
    OpenPositionCubit cubit,
    socket.ConnectionState? connectionState, {
    required bool hasTradePermission,
    double height = 50.0,
  }) =>
      ValueListenableBuilder(
        valueListenable: symbol.bidChange,
        builder: (context, value, child) {
          return MBouncingButton(
            bouncing: false,
            onTap: connectionState.isDisconnected || !hasTradePermission
                ? null
                : () {
                    if (symbol.isMarketClose) {
                      MToast.showError(
                          message: context.tr.marketCurrentlyClosed);
                    } else {
                      price.value = value;
                      if (formKey.currentState!.validate()) {
                        final positionsCubit = context.read<PositionsCubit>();
                        cubit.openPosition(
                          symbol: symbol.symbol,
                          direction: 'SELL',
                          volume: convertPriceToLot(
                            value: volume.value,
                            symbol: symbol,
                            price: value,
                            accountLeverage:
                                positionsCubit.account.value!.leverage,
                          ),
                          price: value,
                          sl: 0,
                          tp: 0,
                        );
                      }
                    }
                  },
            title: context.tr.sellAtPrice(value.toStringAsFixed(symbol.digits)),
            width: context.isLandscape
                ? context.width * 0.16
                : context.width * 0.42,
            borderRadius: 8.0,
            height: height,
            textSize: context.isLandscape ? FoontSize.font14 : FoontSize.font16,
            color: connectionState.isDisconnected || !hasTradePermission
                ? context.colorScheme.surfaceDisabled
                : context.colorScheme.error,
          );
        },
      );

  Widget askChange(
    SymbolEntity symbol,
    OpenPositionCubit cubit,
    socket.ConnectionState? connectionState, {
    required bool hasTradePermission,
    double height = 50.0,
  }) =>
      ValueListenableBuilder(
        valueListenable: symbol.askChange,
        builder: (context, value, child) {
          return MBouncingButton(
            bouncing: false,
            onTap: connectionState.isDisconnected || !hasTradePermission
                ? null
                : () {
                    if (symbol.isMarketClose) {
                      MToast.showError(
                          message: context.tr.marketCurrentlyClosed);
                    } else {
                      price.value = value;
                      if (formKey.currentState!.validate()) {
                        final positionsCubit = context.read<PositionsCubit>();
                        cubit.openPosition(
                          symbol: symbol.symbol,
                          direction: 'BUY',
                          volume: convertPriceToLot(
                            value: volume.value,
                            symbol: symbol,
                            price: value,
                            accountLeverage:
                                positionsCubit.account.value!.leverage,
                          ),
                          price: value,
                          sl: 0,
                          tp: 0,
                        );
                      }
                    }
                  },
            textSize: context.isLandscape ? FoontSize.font14 : FoontSize.font16,
            title: context.tr.buyAtPrice(value.toStringAsFixed(symbol.digits)),
            borderRadius: 8.0,
            width: context.isLandscape
                ? context.width * 0.16
                : context.width * 0.42,
            height: height,
            color: connectionState.isDisconnected || !hasTradePermission
                ? context.colorScheme.onSurfaceDisabled
                : context.colorScheme.success,
          );
        },
      );

  Widget diffPrice(SymbolEntity symbol) => ClipRect(
        child: BackdropFilter(
          blendMode: BlendMode.srcOver,
          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
          child: Container(
            padding: const MPadding.set(vertical: 3.0, horizontal: 12.0),
            constraints: BoxConstraints(minWidth: 70),
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
      );

  Widget changeCurrency({double? width}) =>
      ChangeCurrenciesDropDownWidget(width: width);

  Widget tradeTextFiled(SymbolEntity symbol) {
    final positionsCubit = context.read<PositionsCubit>();
    return ValueListenableBuilder<double>(
      valueListenable: price,
      builder: (context, priceValue, child) {
        return FlowBuilder<CurrencyChanged>(
          listener: (context, state, cubit) {
            if (state.type == StateType.success) {
              Future.delayed(Duration(milliseconds: 100), () {
                formKey.currentState!.validate();
              });
            }
          },
          buildWhenState: (previous, current) {
            return current.type == StateType.success;
          },
          builder: (context, state, cubit) {
            return ValueListenableBuilder(
              valueListenable: positionsCubit.account,
              builder: (context, account, child) {
                final accountLeverage = account?.leverage ?? 1;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TradeTextFiledItemWidget(
                      suffix: MText(
                        text: cubit.getCurrency.name,
                        size: context.isLandscape
                            ? FoontSize.font13
                            : FoontSize.font15,
                        color: context.colorScheme.onSurface,
                      ).addPadding(right: 20.0),
                      init: getLimitVolume(
                        symbol,
                        symbol.volumeMin,
                        priceValue,
                        accountLeverage,
                      ),
                      color: context.colorScheme.surfaceContainerLow,
                      max: getLimitVolume(
                        symbol,
                        symbol.volumeMax,
                        priceValue,
                        accountLeverage,
                      ),
                      min: getLimitVolume(
                        symbol,
                        symbol.volumeMin,
                        priceValue,
                        accountLeverage,
                      ),
                      step: symbol.volumeStep,
                      digits: 2,
                      contentPadding: MPadding.set(
                        vertical: context.isLandscape ? 0.0 : 14.0,
                        horizontal: 12.0,
                      ),
                      onChange: (value) {
                        volume.value = double.tryParse(value) ?? 0;
                      },
                      validator: (messageError) {
                        final volumeMin = getLimitVolume(
                          symbol,
                          symbol.volumeMin,
                          priceValue,
                          accountLeverage,
                        );
                        final volumeMax = getLimitVolume(
                          symbol,
                          symbol.volumeMax,
                          priceValue,
                          accountLeverage,
                        );
                        if (volume.value < volumeMin || volume.value == 0) {
                          return errorMessage(context, volumeMin.toString());
                        } else if (volume.value > volumeMax) {
                          return errorMessage(
                            context,
                            volumeMax.toString(),
                            isMax: true,
                          );
                        }
                        return null;
                      },
                    ),
                    if (cubit.getCurrency == Currencies.LOT)
                      ValueListenableBuilder(
                        valueListenable: volume,
                        builder: (context, value, child) {
                          final requiredMargin = getTradeMargin(
                            volume: value,
                            symbol: symbol,
                            price: priceValue,
                            accountLeverage: accountLeverage,
                          );
                          return MText(
                            text:
                                "${context.tr.requiredMargin}: $requiredMargin ${context.tr.usd}",
                            size: FoontSize.font12,
                            color: context.colorScheme.onSurface,
                          );
                        },
                      ).addPadding(bottom: 8.0)
                    else
                      SizedBox(height: 8.0),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
