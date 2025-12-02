import 'package:example/core/consts/exports.dart';
import 'package:example/features/symbols/views/widgets/currencies_item_widget.dart';
import 'package:example/core/shared/row_value_item_widget.dart';
import 'package:example/features/trade_history/models/history_action_entity.dart';

class HistoryActionItemWidget extends StatefulWidget {
  final HistoryActionEntity item;

  const HistoryActionItemWidget({super.key, required this.item});

  @override
  State<HistoryActionItemWidget> createState() =>
      _HistoryActionItemWidgetState();
}

class _HistoryActionItemWidgetState extends State<HistoryActionItemWidget> {
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
        color: context.colorScheme.surfaceContainerLow,
      ),
      margin: const MPadding.set(horizontal: 12.0, bottom: 4.0),
      child: MediaQuery.removePadding(
        context: context,
        removeLeft: true,
        removeRight: true,
        child: ExpansionTile(
          showTrailingIcon: false,
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CurrenciesItemWidget(item: widget.item.symbol),
                          MText(
                            text: widget.item.symbol.toUpperCase(),
                            weight: FontWeight.w600,
                            size: FoontSize.font16,
                            color: context.colorScheme.onSurface,
                          ).addPadding(end: 12.0),
                          MText(
                            text:
                                '${widget.item.direction} ${widget.item.type} ${widget.item.volume}',
                            color: widget.item.direction == 'SELL'
                                ? Colors.red
                                : Colors.green,
                            size: FoontSize.font13,
                            weight: FontWeight.w400,
                          ),
                        ],
                      ).addPadding(bottom: 4.0),
                      MText(
                        text: context.tr.at(widget.item.price),
                        size: FoontSize.font13,
                        weight: FontWeight.w400,
                        color: context.colorScheme.onSurface,
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (widget.item.type == 'CLOSE' && widget.item.profit != 0)
                    MText(
                      text: double.parse(
                        widget.item.profit.currency6,
                      ).signingFixed,
                      color: widget.item.profit.getColor(),
                      size: FoontSize.font13,
                      weight: FontWeight.w400,
                    ).addPadding(bottom: 3.0)
                  else
                    const SizedBox(height: 30.0),
                  MText(
                    text: widget.item.createdAt.toLastTime,
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
              padding: const MPadding.set(bottom: 12.0, horizontal: 12.0),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          RowValueItemWidget(
                            title: context.tr.actionId,
                            subTitle: widget.item.id.toString(),
                            subTitleWeight: FontWeight.w300,
                            titleWeight: FontWeight.w300,
                            titleFontSize: FoontSize.font13,
                            subTitleFontSize: FoontSize.font13,
                            subTitleColor: context.colorScheme.onSurface,
                            titleColor: context.colorScheme.onSurfaceVariant,
                          ),
                          RowValueItemWidget(
                            title: context.tr.positionId,
                            subTitle: widget.item.tradeId.toString(),
                            subTitleWeight: FontWeight.w300,
                            titleWeight: FontWeight.w300,
                            titleFontSize: FoontSize.font13,
                            subTitleFontSize: FoontSize.font13,
                            subTitleColor: context.colorScheme.onSurface,
                            titleColor: context.colorScheme.onSurfaceVariant,
                          ),
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
                      flex: 5,
                      child: Column(
                        children: [
                          RowValueItemWidget(
                            title: context.tr.commission,
                            subTitle: widget.item.commission.currency2,
                            subTitleWeight: FontWeight.w300,
                            titleWeight: FontWeight.w300,
                            titleFontSize: FoontSize.font13,
                            subTitleFontSize: FoontSize.font13,
                            subTitleColor: context.colorScheme.onSurface,
                            titleColor: context.colorScheme.onSurfaceVariant,
                          ).addPadding(bottom: 4.0),
                          if (widget.item.isPositionClosed)
                            RowValueItemWidget(
                              title: context.tr.profit,
                              subTitle: double.parse(
                                widget.item.profit.currency6,
                              ).signingFixed,
                              subTitleWeight: FontWeight.w300,
                              titleWeight: FontWeight.w300,
                              titleFontSize: FoontSize.font13,
                              subTitleFontSize: FoontSize.font13,
                              subTitleColor: widget.item.profit.getColor(),
                              titleColor: context.colorScheme.onSurfaceVariant,
                            ),
                          if (!widget.item.isPositionClosed)
                            RowValueItemWidget(
                              title: context.tr.price,
                              subTitle: widget.item.price,
                              subTitleWeight: FontWeight.w300,
                              titleWeight: FontWeight.w300,
                              titleFontSize: FoontSize.font13,
                              subTitleFontSize: FoontSize.font13,
                              titleColor: context.colorScheme.onSurfaceVariant,
                            ),
                        ],
                      ),
                    ),
                  ],
                ).addPadding(horizontal: 12.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
