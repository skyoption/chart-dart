import 'package:example/core/consts/exports.dart';
import 'package:example/features/trade/views/widgets/currency_ask_bid_widget.dart';
import 'package:example/features/trade/views/widgets/position_details_widget.dart';
import 'package:example/features/trade/views/widgets/stop_loss_widget.dart';
import 'package:example/features/trade/views/widgets/take_profit_widget.dart';
import 'package:example/core/framework/functions.dart';
import 'package:example/core/shared/currencies_item_widget.dart';
import 'package:example/core/shared/my_scaffold_widget.dart';
import 'package:example/features/main/logic/connect_cubit.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';
import 'package:example/features/trade/logic/close_position_cubit.dart';
import 'package:example/features/trade/logic/positions_cubit.dart';
import 'package:example/features/trade/models/position_entity.dart';

@RoutePage()
class ClosePositionScreen extends StatefulWidget {
  static const id = 'ClosePositionScreen';
  final PositionEntity position;

  const ClosePositionScreen({super.key, required this.position});

  @override
  State<ClosePositionScreen> createState() => _ClosePositionScreenState();
}

class _ClosePositionScreenState extends State<ClosePositionScreen> {
  late PositionType orderType = getPositionTypeByDirection(
    widget.position.direction,
  );

  late ValueNotifier<double> volume = ValueNotifier(
    widget.position.volumeCurrent,
  );

  double sl = 0;
  double tp = 0;
  final ValueNotifier<bool> enableSlAndTpFields = ValueNotifier(false);
  final formKey = GlobalKey<FormState>();

  void setSlAndTp({required double ask, required double bid}) {
    if (orderType == PositionType.bid) {
      sl = ask;
      tp = ask;
    } else {
      sl = bid;
      tp = bid;
    }
  }

  @override
  void dispose() {
    volume.dispose();
    enableSlAndTpFields.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QuotesCubit>();
    final connectCubit = context.read<ConnectCubit>();
    final symbol = cubit.getSymbol(widget.position.groupSymbol);

    if (symbol == null) return const SizedBox();
    return FlowBuilder<PositionsCubit>(
      builder: (context, state, positionCubit) {
        PositionEntity position =
            positionCubit.getPosition(widget.position.id) ?? widget.position;
        return MScaffoldWidget(
          title: context.tr.closePosition,
          appbarSize: 72.0,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const MPadding.set(horizontal: 21.0, bottom: 30.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const MPadding.set(
                      vertical: 12.0,
                      horizontal: 20.0,
                    ),
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
                            CurrenciesItemWidget(
                              item: symbol.symbol,
                              size: 25.0,
                            ),
                            MText(
                              text: symbol.symbol.toUpperCase(),
                              weight: FontWeight.w300,
                              size: FoontSize.font18,
                              color: context.colorScheme.onSurface,
                            ),
                          ],
                        ),
                        MText(
                          text:
                              "${position.direction} ${position.volumeCurrent} ${context.tr.at(position.openPrice)}",
                          color: position.direction == 'SELL'
                              ? Colors.red
                              : Colors.green,
                          size: FoontSize.font16,
                          weight: FontWeight.w400,
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
                  // ValueListenableBuilder(
                  //   valueListenable: volume,
                  //   builder: (context, volumeValue, child) {
                  //     return TradeTextFiledItemWidget(
                  //       init: volumeValue,
                  //       max: volumeValue,
                  //       min: symbol.volumeMin,
                  //       step: symbol.volumeStep,
                  //       digits: symbol.digits,
                  //       title: context.tr.volumeLot,
                  //       onChange: (value) {
                  //         double newVolume = double.tryParse(value) ?? 0;
                  //         if (newVolume < position.volumeCurrent &&
                  //             newVolume != 0) {
                  //           enableSlAndTpFields.value = true;
                  //           setSlAndTp(
                  //             bid: symbol.bidChange.value,
                  //             ask: symbol.askChange.value,
                  //           );
                  //         } else {
                  //           enableSlAndTpFields.value = false;
                  //           sl = 0;
                  //           tp = 0;
                  //         }
                  //         volume.value = newVolume;
                  //       },
                  //       validator: (messageError) {
                  //         if (volume.value > position.volumeCurrent ||
                  //             volume.value < symbol.volumeMin ||
                  //             volume.value == 0) {
                  //           return context.tr.fieldInvalid(context.tr.volumeLot);
                  //         }
                  //         return null;
                  //       },
                  //     ).addPadding(top: 30.0);
                  //   },
                  // ),
                  ValueListenableBuilder(
                    valueListenable: enableSlAndTpFields,
                    builder: (context, isEnabled, child) {
                      return AnimatedSize(
                        duration: const Duration(milliseconds: 500),
                        child: Visibility(
                          visible: isEnabled,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            key: ValueKey(isEnabled),
                            children: [
                              MText(
                                text: context.tr.modifyTradeLevels,
                                color: context.colorScheme.onSurface,
                                size: FoontSize.font19,
                              ).addPadding(top: 21, bottom: 14),
                              TakeProfitWidget(
                                symbol: symbol,
                                volume: widget.position.volumeCurrent,
                                entryPrice: widget.position.openPrice,
                                type: orderType,
                                digits: symbol.digits,
                                onChange: (double value) {
                                  tp = value;
                                },
                              ).addPadding(bottom: 16.0),
                              StopLossWidget(
                                symbol: symbol,
                                volume: widget.position.volumeCurrent,
                                entryPrice: widget.position.openPrice,
                                type: orderType,
                                digits: symbol.digits,
                                onChange: (double value) {
                                  sl = value;
                                },
                              ).addPadding(bottom: 16.0),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  PositionDetailsWidget(symbol: symbol, position: position),
                  FlowBuilder<ClosePositionCubit>(
                    onSuccess: (state, cubit) {
                      context.navigateTo(const TradeRoute());
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
                                valueListenable: position.floatingChange,
                                builder: (context, value, child) {
                                  return ValueListenableBuilder(
                                    valueListenable:
                                        connectCubit.hasTradePermission,
                                    builder: (
                                      context,
                                      hasTradePermission,
                                      child,
                                    ) {
                                      return MBouncingButton(
                                        bouncing: false,
                                        height: 50.0,
                                        borderRadius: 8.0,
                                        title:
                                            '${context.tr.close} ${value.isNegative ? '' : '+'}${value.currencyName2}',
                                        textSize: FoontSize.font16,
                                        color: socketState.isDisconnected ||
                                                !hasTradePermission
                                            ? context
                                                .colorScheme.onSurfaceDisabled
                                            : (value < 0
                                                ? context.colorScheme.error
                                                : context.colorScheme.success),
                                        onTap: socketState.isDisconnected ||
                                                !hasTradePermission
                                            ? null
                                            : () {
                                                cubit.closePosition(
                                                  profit: value.signFixed(
                                                    symbol.digits,
                                                  ),
                                                  symbol: symbol.symbol,
                                                  ticketNumber: position.id,
                                                  volume: volume.value,
                                                  sl: sl,
                                                  tp: tp,
                                                );
                                                context.router.pop();
                                              },
                                      ).addPadding(top: 50.0);
                                    },
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
              ),
            ),
          ),
        );
      },
    );
  }
}
