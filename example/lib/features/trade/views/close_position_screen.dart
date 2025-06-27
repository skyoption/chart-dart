import 'package:example/core/builder/flow_builder.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/functions.dart';
import 'package:example/features/auth/logic/connect_cubit.dart';
import 'package:example/features/chart/views/widgets/symbol_options_widget.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';
import 'package:example/features/symbols/views/widgets/currencies_item_widget.dart';
import 'package:example/features/trade/logic/close_position_cubit.dart';
import 'package:example/features/trade/models/position_entity.dart';
import 'package:example/features/trade/views/open_position_screen.dart';
import 'package:example/features/trade/views/widgets/stop_loss_widget.dart';
import 'package:example/features/trade/views/widgets/take_profit_widget.dart';
import 'package:example/features/trade/views/widgets/trade_chart_item_widget.dart';
import 'package:example/features/trade/views/widgets/trade_price_item_widget.dart';
import 'package:example/features/trade_history/views/bottom_sheets/date_time_bottom_sheet.dart';
import 'package:example/injection/injectable.dart';

class ClosePositionScreen extends StatefulWidget {
  static const id = 'ClosePositionScreen';
  final PositionEntity position;

  const ClosePositionScreen({super.key, required this.position});

  @override
  State<ClosePositionScreen> createState() => _ClosePositionScreenState();
}

class _ClosePositionScreenState extends State<ClosePositionScreen> {
  late PositionType orderType =
      getPositionTypeByDirection(widget.position.direction);

  late ValueNotifier<double> volume =
      ValueNotifier(widget.position.volumeCurrent);

  double sl = 0;
  double tp = 0;
  final ValueNotifier<bool> enableSlAndTpFields = ValueNotifier(false);
  final formKey = GlobalKey<FormState>();

  void setSlAndTp({
    required double ask,
    required double bid,
  }) {
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
    final loginCubit = context.read<ConnectCubit>();
    final symbol = cubit.getSymbol(widget.position.groupSymbol);
    final height = context.height;
    final width = context.width;
    if (symbol == null) return const SizedBox();
    return BlocProvider(
      create: (context) => getIt<ClosePositionCubit>(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(width, height * 0.06),
          child: SafeArea(
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back,
                  color: context.colorScheme.scrim,
                  size: 30.0,
                ).addAction(
                  padding: const MPadding.set(end: 12.0),
                  onGesture: () {
                    context.pop();
                  },
                ),
                MText(
                  text: context.tr.closePosition,
                  color: context.colorScheme.scrim,
                  weight: FontWeight.w600,
                  size: FoontSize.font20,
                ),
              ],
            ).addPadding(top: 21.0, horizontal: 21.0),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const MPadding.set(horizontal: 21.0, bottom: 30.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CurrenciesItemWidget(item: symbol.symbol),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MText(
                        text: symbol.symbol.toUpperCase(),
                        color: context.colorScheme.scrim,
                        weight: FontWeight.w600,
                        size: FoontSize.font21,
                      ),
                      if (symbol.description.isNotEmpty)
                        MText(
                          text: symbol.description,
                          color: context.colorScheme.onSurface,
                          weight: FontWeight.w300,
                          size: FoontSize.font14,
                        ),
                    ],
                  ),
                ],
              ).addPadding(bottom: 21.0, top: 16.0),
              Column(
                children: [
                  TradePriceItemWidget(
                    symbol: symbol,
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
                  //       title: 'Volume (Lot)',
                  //       onChange: (value) {
                  //         double newVolume = double.tryParse(value) ?? 0;
                  //         if (newVolume < widget.position.volumeCurrent &&
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
                  //         if (volume.value > widget.position.volumeCurrent ||
                  //             volume.value < symbol.volumeMin ||
                  //             volume.value == 0) {
                  //           return 'Invalid';
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
                                  color: context.colorScheme.scrim,
                                  size: FoontSize.font19,
                                ).addPadding(top: 21, bottom: 14),
                                StopLossWidget(
                                  type: orderType,
                                  price: sl,
                                  onChange: (double value) {
                                    tp = value;
                                  },
                                ),
                                TakeProfitWidget(
                                  type: orderType,
                                  price: tp,
                                  onChange: (double value) {
                                    sl = value;
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                  MDividerItemWidget(
                    color: context.colorScheme.outline,
                    padding: const MPadding.set(vertical: 21.0),
                  ),
                  TradeChartItemWidget(
                    transition: ValueNotifier<ItemEntity>(
                      ItemEntity(
                        name: 'name',
                        value: TransactionOptions.market_order,
                      ),
                    ),
                  ),
                  MDividerItemWidget(
                    color: context.colorScheme.outline,
                    padding: const MPadding.set(vertical: 21.0),
                  ),
                  FlowBuilder<ClosePositionCubit>(
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
                            ).addPadding(top: 21),
                          ValueListenableBuilder(
                            valueListenable: loginCubit.socketState,
                            builder: (context, socketState, child) {
                              return ValueListenableBuilder(
                                valueListenable: widget.position.floatingChange,
                                builder: (context, value, child) {
                                  return MBouncingButton(
                                    bouncing: false,
                                    height: 50.0,
                                    borderRadius: 8.0,
                                    title: context.tr.closeWithProfit(
                                        value.signFixed(symbol.digits)),
                                    textSize: FoontSize.font16,
                                    color: socketState.isDisconnected
                                        ? AppColors.darkGrey
                                        : (value < 0
                                            ? context.colorScheme.error
                                            : context.colorScheme.primary),
                                    onTap: socketState.isDisconnected
                                        ? null
                                        : () {
                                            cubit.closePosition(
                                              profit: value
                                                  .signFixed(symbol.digits),
                                              symbol: symbol.symbol,
                                              ticketNumber: widget.position.id,
                                              volume: volume.value,
                                              sl: sl,
                                              tp: tp,
                                            );
                                          },
                                  ).addPadding(top: 12.0);
                                },
                              );
                            },
                          ),
                        ],
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
