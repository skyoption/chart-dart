import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/features/main/views/main_screen.dart';
import 'package:example/features/symbols/views/widgets/currencies_item_widget.dart';
import 'package:example/features/symbols/views/widgets/quote_details_item_widget.dart';
import 'package:example/injection/injectable.dart';
import 'package:example/core/framework/functions.dart';
import 'package:example/core/framework/mtoast.dart';
import 'package:example/features/main/models/connected_account_info_entity.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';
import 'package:example/features/trade/logic/delete_order_cubit.dart';
import 'package:example/features/trade/logic/positions_cubit.dart';
import 'package:example/features/trade/models/order_entity.dart';

class OrderItemWidget extends StatefulWidget {
  final OrderEntity item;

  const OrderItemWidget({
    super.key,
    required this.item,
  });

  @override
  State<OrderItemWidget> createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget>
    with SingleTickerProviderStateMixin {
  ValueNotifier<bool> expandedNotifier = ValueNotifier(false);
  late final controller = SlidableController(this);
  final key = GlobalKey();

  @override
  void dispose() {
    expandedNotifier.dispose();
    key.currentState?.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QuotesCubit>();
    final deletePendingCubit = getIt<DeleteOrderCubit>();
    final positionsCubit = context.read<PositionsCubit>();
    final symbol = cubit.getSymbol(widget.item.symbol);
    final isSell = widget.item.direction == 'SELL';
    final price = isSell ? symbol?.askChange : symbol?.bidChange;
    if (symbol == null) return const SizedBox.shrink();
    return ValueListenableBuilder<ConnectedAccountInfoEntity?>(
      valueListenable: positionsCubit.account,
      builder: (context, account, child) {
        final isMainAccount = account?.isMainAccount ?? true;
        return Slidable(
          key: key,
          controller: controller,
          startActionPane: ActionPane(
            extentRatio: 0.293,
            motion: const ScrollMotion(),
            dragDismissible: false,
            children: [
              if (isMainAccount)
                BlocProvider(
                  create: (context) => deletePendingCubit,
                  child: Container(
                    width: 140.0,
                    margin: MPadding.set(bottom: 6.0),
                    padding: const MPadding.set(all: 17.0),
                    decoration: BoxDecoration(
                      color: context.colorScheme.primary,
                      borderRadius: MBorderRadius.set(all: 8.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const MAssetImage(
                          name: Pngs.check,
                          height: 20.0,
                          width: 20.0,
                          color: Coolors.white,
                        ).addPadding(end: 6.0),
                        MText(
                          text: context.tr.close,
                          color: Coolors.white,
                          size: FoontSize.font18,
                          weight: FontWeight.w500,
                        )
                      ],
                    ),
                  ).addAction(
                    onGesture: () {
                      deletePendingCubit.deleteOrder(order: widget.item);
                      controller.close();
                    },
                  ),
                ),
            ],
          ),
          endActionPane: ActionPane(
            extentRatio: 0.335,
            motion: const ScrollMotion(),
            dragDismissible: false,
            children: [
              Container(
                margin: MPadding.set(bottom: 6.0),
                padding: const MPadding.set(all: 16.0),
                decoration: BoxDecoration(
                  color: context.colorScheme.primary,
                  borderRadius: MBorderRadius.set(all: 8.0),
                ),
                child: Row(
                  children: [
                    if (isMainAccount)
                      const Icon(
                        Icons.add,
                        size: 20.0,
                        color: Colors.white,
                      ).addAction(
                        padding: const MPadding.set(horizontal: 10.0),
                        onGesture: () {
                          if (symbol.isMarketClose) {
                            MToast.showError(
                                message: context.tr.marketCurrentlyClosed);
                          } else {
                            context.navigateTo(
                              NewPositionRoute(
                                item: widget.item.symbol,
                              ),
                            );
                          }
                          controller.close();
                        },
                      ),
                    if (isMainAccount)
                      const Icon(
                        Icons.edit,
                        size: 20.0,
                        color: Colors.white,
                      ).addAction(
                        padding: const MPadding.set(horizontal: 10.0),
                        onGesture: () {
                          if (symbol.isMarketClose) {
                            MToast.showError(
                                message: context.tr.marketCurrentlyClosed);
                          } else {
                            context.navigateTo(
                              EditOrderRoute(
                                item: widget.item,
                              ),
                            );
                          }
                          controller.close();
                        },
                      ),
                    const MSvg(
                      name: Svgs.candle,
                      color: Colors.white,
                      height: 21.0,
                      width: 21.0,
                    ).addAction(
                      padding: const MPadding.set(horizontal: 10.0),
                      onGesture: () {
                        context.read<QuotesCubit>().currentSymbol.value =
                            symbol;
                        context.navigateTo(ChartRoute(
                            isFullscreen: isFullScreen, currentSymbol: symbol));
                        controller.close();
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: MBorderRadius.set(all: 8.0),
              border: Border.all(color: context.colorScheme.outline),
              color: Colors.transparent,
            ),
            margin: const MPadding.set(horizontal: 12.0, bottom: 4.0),
            child: ExpansionTile(
              showTrailingIcon: false,
              shape: const RoundedRectangleBorder(
                side: BorderSide.none,
              ),
              tilePadding: const MPadding.set(horizontal: 9.0),
              expansionAnimationStyle: AnimationStyle(
                duration: Durations.long1,
                curve: Curves.easeIn,
                reverseCurve: Curves.easeOut,
                reverseDuration: Durations.long1,
              ),
              collapsedIconColor: context.colorScheme.onSurface,
              iconColor: context.colorScheme.onSurface,
              onExpansionChanged: (value) {
                expandedNotifier.value = value;
              },
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ValueListenableBuilder(
                        valueListenable: expandedNotifier,
                        builder: (context, expanded, child) {
                          return Icon(
                            expanded
                                ? Icons.keyboard_arrow_up_outlined
                                : Icons.keyboard_arrow_down_outlined,
                            color: context.colorScheme.onSurface,
                          ).addPadding(end: 8);
                        },
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CurrenciesItemWidget(
                                size: 17.0,
                                value: symbol,
                              ),
                              MText(
                                text: widget.item.symbol.toUpperCase(),
                                weight: FontWeight.w600,
                                size: FoontSize.font14,
                                color: context.colorScheme.onSurface,
                              ),
                              MText(
                                text:
                                    '${widget.item.direction.replaceAll('_', ' ')} ${widget.item.volume}',
                                color: widget.item.direction.contains('SELL')
                                    ? Colors.red
                                    : Colors.green,
                                size: FoontSize.font12,
                                weight: FontWeight.w500,
                              ).addPadding(start: 8.0),
                            ],
                          ).addPadding(bottom: 5.0),
                          Row(
                            children: [
                              MText(
                                text: widget.item.openPrice.toStringAsFixed(
                                  symbol.digits,
                                ),
                                size: FoontSize.font12,
                                color: context.colorScheme.onSurface,
                              ),
                              Padding(
                                padding: const MPadding.set(horizontal: 6.0),
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: context.colorScheme.primaryFixed,
                                  size: 15.0,
                                ),
                              ),
                              ValueListenableBuilder(
                                valueListenable: price!,
                                builder: (context, value, child) {
                                  return MText(
                                    text: value.toStringAsFixed(
                                      symbol.digits,
                                    ),
                                    size: FoontSize.font12,
                                    color: context.colorScheme.onSurface,
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              MSvg(
                                name: Svgs.waitingIcon,
                                color: context.colorScheme.onSurface,
                                height: 20,
                                width: 20,
                              ).addPadding(end: 3.0),
                              MText(
                                text: context.tr.wait,
                                color: context.colorScheme.onSurface,
                                size: FoontSize.font18,
                                weight: FontWeight.w400,
                              )
                            ],
                          ).addPadding(bottom: 6.0),
                          MText(
                            text: widget.item.createdAt.toLastTime,
                            color: context.colorScheme.onSurface,
                            size: FoontSize.font12,
                          ),
                        ],
                      ).addPadding(end: 25.0),
                    ],
                  ),
                ],
              ),
              children: [
                MDividerItemWidget(
                  color: context.colorScheme.outline,
                  padding: const MPadding.set(bottom: 12.0),
                ),
                if (widget.item.comment.isNotEmpty)
                  MText(
                    text: widget.item.comment,
                    size: FoontSize.font13,
                    color: context.colorScheme.onSurface,
                  ).addPadding(horizontal: 12.0, bottom: 6.0),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          QuoteDetailsItemWidget(
                            hideDivider: true,
                            fontWeight: FontWeight.w200,
                            valueColor: context.colorScheme.onSurface,
                            titleColor: context.colorScheme.onSurface,
                            title: context.tr.stopLossTitle,
                            value: truncateToDecimalPlaces(
                              widget.item.sl,
                              symbol.digits,
                              maxDecimalPlaces: symbol.digits,
                            ).toString(),
                          ).addPadding(bottom: 6.0),
                          QuoteDetailsItemWidget(
                            hideDivider: true,
                            fontWeight: FontWeight.w200,
                            valueColor: context.colorScheme.onSurface,
                            titleColor: context.colorScheme.onSurface,
                            title: context.tr.takeProfitTitle,
                            value: truncateToDecimalPlaces(
                              widget.item.tp,
                              symbol.digits,
                              maxDecimalPlaces: symbol.digits,
                            ).toString(),
                          ).addPadding(bottom: 6.0),
                          QuoteDetailsItemWidget(
                            hideDivider: true,
                            fontWeight: FontWeight.w200,
                            valueColor: context.colorScheme.onSurface,
                            titleColor: context.colorScheme.onSurface,
                            title: context.tr.orderId,
                            value: widget.item.id.toString(),
                          ).addPadding(bottom: 6.0),
                        ],
                      ),
                    ),
                  ],
                ).addPadding(horizontal: 12.0),
              ],
            ),
          ),
        );
      },
    );
  }
}
