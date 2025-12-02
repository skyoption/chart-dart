import 'package:example/core/consts/exports.dart';
import 'package:example/features/symbols/views/widgets/currencies_item_widget.dart';
import 'package:example/features/symbols/views/widgets/quote_details_item_widget.dart';
import 'package:example/features/trade_history/models/history_position_entity.dart';

class HistoryPositionItemWidget extends StatefulWidget {
  final HistoryPositionEntity item;

  const HistoryPositionItemWidget({
    super.key,
    required this.item,
  });

  @override
  State<HistoryPositionItemWidget> createState() =>
      _HistoryPositionItemWidgetState();
}

class _HistoryPositionItemWidgetState extends State<HistoryPositionItemWidget> {
  late final ValueNotifier<bool> isExpanded;

  @override
  void initState() {
    isExpanded = ValueNotifier(false);
    super.initState();
  }

  @override
  void dispose() {
    isExpanded.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: MBorderRadius.set(all: 8.0),
        border: Border.all(color: context.colorScheme.outline),
      ),
      margin: const MPadding.set(horizontal: 12.0, bottom: 4.0),
      child: ExpansionTile(
        showTrailingIcon: false,
        tilePadding: const MPadding.set(horizontal: 6.0),
        shape: const RoundedRectangleBorder(side: BorderSide.none),
        expansionAnimationStyle: AnimationStyle(
          duration: Durations.long1,
          curve: Curves.easeIn,
          reverseCurve: Curves.easeOut,
          reverseDuration: Durations.long1,
        ),
        collapsedIconColor: context.colorScheme.onSurface,
        iconColor: context.colorScheme.onSurface,
        onExpansionChanged: (value) {
          isExpanded.value = value;
        },
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ValueListenableBuilder(
                  valueListenable: isExpanded,
                  builder: (context, expanded, child) {
                    return Icon(
                      expanded
                          ? Icons.keyboard_arrow_up_outlined
                          : Icons.keyboard_arrow_down_outlined,
                      color: context.colorScheme.onSurface,
                    );
                  },
                ).addPadding(end: 3.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CurrenciesItemWidget(
                          item: widget.item.symbol,
                        ),
                        MText(
                          text: widget.item.symbol.toUpperCase(),
                          weight: FontWeight.w600,
                          size: FoontSize.font16,
                          color: context.colorScheme.onSurface,
                        ).addPadding(end: 12.0),
                        MText(
                          text:
                              '${widget.item.direction} ${widget.item.volumeCurrent != widget.item.volumeInit ? "${widget.item.volumeCurrent}/${widget.item.volumeInit}" : widget.item.volumeCurrent.toTwoDecimal}',
                          color: widget.item.direction == 'SELL'
                              ? Colors.red
                              : Colors.green,
                          size: FoontSize.font13,
                          weight: FontWeight.w400,
                        )
                      ],
                    ).addPadding(bottom: 4.0),
                    Row(
                      children: [
                        MText(
                          text: widget.item.openPrice.toString(),
                          size: FoontSize.font13,
                          weight: FontWeight.w400,
                          color: context.colorScheme.onSurface,
                        ),
                        Padding(
                          padding: const MPadding.set(horizontal: 4.0),
                          child: Icon(
                            Icons.arrow_forward,
                            color: context.colorScheme.onSurface,
                            size: 18.0,
                          ),
                        ),
                        MText(
                          text: widget.item.closePrice.toString(),
                          size: FoontSize.font13,
                          weight: FontWeight.w400,
                          color: context.colorScheme.onSurface,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MText(
                  text: widget.item.amount.signingFixed,
                  color: widget.item.amount.getColor(),
                  size: FoontSize.font13,
                  weight: FontWeight.w400,
                ).addPadding(bottom: 3.0),
                MText(
                  text: widget.item.date.toLastTime,
                  color: context.colorScheme.onSurface,
                  size: FoontSize.font13,
                ),
              ],
            ).addPadding(end: 12.0, top: 4.0),
          ],
        ),
        children: [
          MDividerItemWidget(
            color: context.colorScheme.outline,
            padding: const MPadding.set(bottom: 12.0),
          ),
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
                      title: context.tr.openPrice,
                      value: widget.item.openPrice.toString(),
                    ).addPadding(bottom: 4.0),
                    QuoteDetailsItemWidget(
                      hideDivider: true,
                      fontWeight: FontWeight.w200,
                      valueColor: context.colorScheme.onSurface,
                      titleColor: context.colorScheme.onSurface,
                      title: context.tr.closePrice,
                      value: widget.item.closePrice.toString(),
                    ).addPadding(bottom: 4.0),
                    QuoteDetailsItemWidget(
                      hideDivider: true,
                      fontWeight: FontWeight.w200,
                      valueColor: context.colorScheme.onSurface,
                      titleColor: context.colorScheme.onSurface,
                      title: context.tr.orderId,
                      value: widget.item.id.toString(),
                    ).addPadding(bottom: 4.0),
                  ],
                ),
              ),
              SizedBox(
                height: context.height * 0.07,
                width: 30.0,
                child: VerticalDivider(
                  color: context.colorScheme.outline,
                ),
              ),
              Expanded(
                flex: 6,
                child: Column(
                  children: [
                    QuoteDetailsItemWidget(
                      hideDivider: true,
                      fontWeight: FontWeight.w200,
                      valueColor: context.colorScheme.onSurface,
                      titleColor: context.colorScheme.onSurface,
                      title: context.tr.openTime,
                      value: widget.item.openTime.toLastTime,
                    ).addPadding(bottom: 4.0),
                    QuoteDetailsItemWidget(
                      hideDivider: true,
                      fontWeight: FontWeight.w200,
                      valueColor: context.colorScheme.onSurface,
                      titleColor: context.colorScheme.onSurface,
                      title: context.tr.commissionTitle,
                      value: widget.item.commission.toString(),
                    ).addPadding(bottom: 4.0),
                    QuoteDetailsItemWidget(
                      hideDivider: true,
                      fontWeight: FontWeight.w200,
                      valueColor: context.colorScheme.onSurface,
                      titleColor: context.colorScheme.onSurface,
                      title: context.tr.swap,
                      value: widget.item.swap.signingFixed,
                    ).addPadding(bottom: 4.0),
                  ],
                ),
              ),
            ],
          ).addPadding(horizontal: 12.0),
        ],
      ),
    );
  }
}
