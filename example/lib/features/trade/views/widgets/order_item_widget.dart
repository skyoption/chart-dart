import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:example/app_router.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/mtoast.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';
import 'package:example/features/symbols/views/widgets/currencies_item_widget.dart';
import 'package:example/features/symbols/views/widgets/quote_details_item_widget.dart';
import 'package:example/features/trade/logic/delete_order_cubit.dart';
import 'package:example/features/trade/models/order_entity.dart';
import 'package:example/features/trade/views/modify_order_screen.dart';
import 'package:example/features/trade/views/open_position_screen.dart';
import 'package:example/injection/injectable.dart';

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

    final symbol = cubit.getSymbol(widget.item.symbol);
    final isSell = widget.item.direction == 'SELL';
    final price = isSell ? symbol?.askChange : symbol?.bidChange;
    return Slidable(
      key: key,
      controller: controller,
      startActionPane: ActionPane(
        extentRatio: 0.293,
        motion: const ScrollMotion(),
        dragDismissible: false,
        children: [
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
                    height: 24.0,
                    width: 24.0,
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
                deletePendingCubit.deleteOrder(ticket: widget.item.id);
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
              color: AppColors.primary,
              borderRadius: MBorderRadius.set(all: 8.0),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.add,
                  size: 25.0,
                  color: Colors.white,
                ).addAction(
                  padding: const MPadding.set(horizontal: 10.0),
                  onGesture: () {
                    if (symbol != null) {
                      if (symbol.isMarketClose) {
                        MToast.showError(
                            message: context.tr.marketCurrentlyClosed);
                      } else {
                        context.push(
                          OpenPositionScreen(
                            item: widget.item.symbol,
                          ),
                        );
                      }
                    }
                    controller.close();
                  },
                ),
                const Icon(
                  Icons.edit,
                  size: 25.0,
                  color: Colors.white,
                ).addAction(
                  padding: const MPadding.set(horizontal: 10.0),
                  onGesture: () {
                    if (symbol != null) {
                      if (symbol.isMarketClose) {
                        MToast.showError(
                            message: context.tr.marketCurrentlyClosed);
                      } else {
                        context.push(
                          ModifyOrderScreen(
                            item: widget.item,
                          ),
                        );
                      }
                    }
                    controller.close();
                  },
                ),
                const MSvg(
                  name: Svgs.candle,
                  color: Colors.white,
                  height: 23.0,
                  width: 23.0,
                ).addAction(
                  padding: const MPadding.set(horizontal: 10.0),
                  onGesture: () {
                    context.read<QuotesCubit>().currentSymbol.value = symbol;
                    mainKey.currentState?.navToChart();
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
        ),
        margin: const MPadding.set(horizontal: 18.0, bottom: 5.0),
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
          collapsedIconColor: context.colorScheme.scrim,
          iconColor: context.colorScheme.scrim,
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
                        color: context.colorScheme.scrim,
                      ).addPadding(end: 8);
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CurrenciesItemWidget(
                            size: 23.0,
                            value: symbol,
                          ),
                          MText(
                            text: widget.item.symbol.toUpperCase(),
                            weight: FontWeight.w600,
                            size: FoontSize.font16,
                            color: context.colorScheme.scrim,
                          ),
                          MText(
                            text:
                                '${widget.item.direction.replaceAll('_', ' ')} ${widget.item.volume}',
                            color: widget.item.direction.contains('SELL')
                                ? Colors.red
                                : Colors.green,
                            size: FoontSize.font13,
                            weight: FontWeight.w500,
                          ).addPadding(start: 8.0),
                        ],
                      ),
                      Row(
                        children: [
                          MText(
                            text: widget.item.openPrice.toString(),
                            size: FoontSize.font13,
                            color: context.colorScheme.onSurface,
                          ),
                          Padding(
                            padding: const MPadding.set(horizontal: 6.0),
                            child: Icon(
                              Icons.arrow_forward,
                              color: context.colorScheme.primaryFixed,
                              size: 18.0,
                            ),
                          ),
                          ValueListenableBuilder(
                            valueListenable: price!,
                            builder: (context, value, child) {
                              return MText(
                                text: value.toString(),
                                size: FoontSize.font13,
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
                            color: context.colorScheme.scrim,
                            height: 23,
                            width: 23,
                          ).addPadding(end: 3.0),
                          MText(
                            text: context.tr.wait,
                            color: context.colorScheme.scrim,
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
                size: FoontSize.font14,
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
                        value: widget.item.sl.toTwoDecimal,
                      ).addPadding(bottom: 6.0),
                      QuoteDetailsItemWidget(
                        hideDivider: true,
                        fontWeight: FontWeight.w200,
                        valueColor: context.colorScheme.onSurface,
                        titleColor: context.colorScheme.onSurface,
                        title: context.tr.takeProfitTitle,
                        value: widget.item.tp.toTwoDecimal,
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
  }
}
