import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/features/main/views/main_screen.dart';
import 'package:example/features/symbols/views/widgets/currencies_item_widget.dart';
import 'package:example/features/symbols/views/widgets/quote_details_item_widget.dart';
import 'package:example/core/framework/functions.dart';
import 'package:example/core/framework/mtoast.dart';
import 'package:example/features/main/models/connected_account_info_entity.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';
import 'package:example/features/trade/logic/positions_cubit.dart';
import 'package:example/features/trade/models/position_entity.dart';

class PositionItemWidget extends StatefulWidget {
  final PositionEntity item;

  const PositionItemWidget({
    super.key,
    required this.item,
  });

  @override
  State<PositionItemWidget> createState() => _PositionItemWidgetState();
}

class _PositionItemWidgetState extends State<PositionItemWidget>
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
    final symbol = cubit.getSymbol(widget.item.groupSymbol);
    final isSell = widget.item.direction == 'SELL';
    final positionsCubit = context.read<PositionsCubit>();

    if (symbol == null) return SizedBox();
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
                Container(
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
                    controller.close();
                    if (symbol.isMarketClose) {
                      MToast.showError(
                          message: context.tr.marketCurrentlyClosed);
                    } else {
                      context.navigateTo(
                          ClosePositionRoute(position: widget.item));
                    }
                  },
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
                                item: symbol.symbol,
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
                              EditPositionRoute(position: widget.item),
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
                          isFullscreen: isFullScreen,
                          currentSymbol: symbol,
                        ));
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
              tilePadding: const MPadding.set(horizontal: 16),
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
                  ValueListenableBuilder(
                    valueListenable: expandedNotifier,
                    builder: (context, expanded, child) {
                      return Icon(
                        expanded
                            ? Icons.keyboard_arrow_up_outlined
                            : Icons.keyboard_arrow_down_outlined,
                        color: context.colorScheme.onSurface,
                      ).addPadding(end: 7);
                    },
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CurrenciesItemWidget(
                              size: 17.0,
                              value: symbol,
                            ),
                            MText(
                              text: widget.item.groupSymbol,
                              weight: FontWeight.w600,
                              size: FoontSize.font14,
                              color: context.colorScheme.onSurface,
                            ),
                            MText(
                              size: FoontSize.font12,
                              weight: FontWeight.w500,
                              text:
                                  '${widget.item.direction} ${widget.item.volumeCurrent != widget.item.volumeInit ? "${widget.item.volumeCurrent}/${widget.item.volumeInit}" : widget.item.volumeCurrent.toTwoDecimal}',
                              color: widget.item.direction == 'SELL'
                                  ? Colors.red
                                  : Colors.green,
                            ).addPadding(start: 10.0),
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
                              padding: const MPadding.set(horizontal: 8.0),
                              child: Icon(
                                Icons.arrow_forward,
                                color: context.colorScheme.primaryFixed,
                                size: 15.0,
                              ),
                            ),
                            ValueListenableBuilder(
                              valueListenable:
                                  isSell ? symbol.askChange : symbol.bidChange,
                              builder: (context, value, child) {
                                return MText(
                                  text: value.toStringAsFixed(
                                    symbol.digits,
                                  ),
                                  size: FoontSize.font12,
                                  color: context.colorScheme.onSurface,
                                );
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ValueListenableBuilder(
                            valueListenable: widget.item.floatingChange,
                            builder: (context, value, child) {
                              return MText(
                                text: value.toTwoDecimal,
                                color: value.getColor(),
                                size: FoontSize.font12,
                                weight: FontWeight.w500,
                              ).addPadding(bottom: 3.0);
                            },
                          ).addPadding(bottom: 4.0),
                          MText(
                            text: widget.item.openTime.toTimeAndDate,
                            size: FoontSize.font12,
                            weight: FontWeight.w400,
                            color: context.colorScheme.onSurface,
                          ),
                        ],
                      ).addPadding(end: 14.0),
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
                    SizedBox(
                      height: context.height * 0.07,
                      width: 35.0,
                      child: VerticalDivider(
                        color: context.colorScheme.outline,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          QuoteDetailsItemWidget(
                            hideDivider: true,
                            fontWeight: FontWeight.w200,
                            valueColor: context.colorScheme.onSurface,
                            titleColor: context.colorScheme.onSurface,
                            title: context.tr.marginTitle,
                            value: widget.item.margin.toString(),
                          ).addPadding(bottom: 6.0),
                          QuoteDetailsItemWidget(
                            hideDivider: true,
                            fontWeight: FontWeight.w200,
                            valueColor: context.colorScheme.onSurface,
                            titleColor: context.colorScheme.onSurface,
                            title: context.tr.swap,
                            value: widget.item.swap.toString(),
                          ).addPadding(bottom: 6.0),
                          QuoteDetailsItemWidget(
                            hideDivider: true,
                            fontWeight: FontWeight.w200,
                            valueColor: context.colorScheme.onSurface,
                            titleColor: context.colorScheme.onSurface,
                            title: context.tr.commissionTitle,
                            value: widget.item.commission.toString(),
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
