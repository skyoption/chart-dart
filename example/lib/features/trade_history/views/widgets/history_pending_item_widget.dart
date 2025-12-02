import 'package:example/core/consts/exports.dart';
import 'package:example/features/symbols/views/widgets/currencies_item_widget.dart';
import 'package:example/features/symbols/views/widgets/quote_details_item_widget.dart';
import 'package:example/core/framework/functions.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';
import 'package:example/features/trade_history/models/history_pending_entity.dart';

class HistoryPendingItemWidget extends StatefulWidget {
  final HistoryPendingEntity item;

  const HistoryPendingItemWidget({
    super.key,
    required this.item,
  });

  @override
  State<HistoryPendingItemWidget> createState() =>
      _HistoryPendingItemWidgetState();
}

class _HistoryPendingItemWidgetState extends State<HistoryPendingItemWidget> {
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
    final cubit = context.read<QuotesCubit>();
    final symbol = cubit.getSymbol(widget.item.symbol);
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
                ).addPadding(end: 8.0),
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
                        ),
                        MText(
                          text: widget.item.direction.replaceAll('_', ' '),
                          color: context.colorScheme.success,
                          size: FoontSize.font14,
                          weight: FontWeight.w400,
                        ).addPadding(
                          start: 10.0,
                        ),
                      ],
                    ).addPadding(bottom: 4.0),
                    MText(
                      text: context.tr.volumeAt(widget.item.volume.toString(),
                          widget.item.openPrice.toString()),
                      size: FoontSize.font13,
                      color: context.colorScheme.onSurface,
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MText(
                  text: widget.item.type > 1
                      ? context.tr.filled
                      : context.tr.canceled,
                  color: context.colorScheme.onSurface,
                  size: FoontSize.font14,
                  weight: FontWeight.w400,
                ).addPadding(bottom: 3.0),
                MText(
                  text: widget.item.closedAt.toLastTime,
                  color: Coolors.grey,
                  size: FoontSize.font14,
                )
              ],
            )
          ],
        ).addPadding(horizontal: 12.0),
        children: [
          MDividerItemWidget(
            color: context.colorScheme.outline,
            padding: const MPadding.set(bottom: 12.0),
          ),
          Column(
            children: [
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
                            symbol?.digits ?? 2,
                            maxDecimalPlaces: symbol?.digits ?? 2,
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
                            symbol?.digits ?? 2,
                            maxDecimalPlaces: symbol?.digits ?? 2,
                          ).toString(),
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
                    flex: 6,
                    child: Column(
                      children: [
                        QuoteDetailsItemWidget(
                          hideDivider: true,
                          fontWeight: FontWeight.w200,
                          valueColor: context.colorScheme.onSurface,
                          titleColor: context.colorScheme.onSurface,
                          title: context.tr.openTime,
                          value: widget.item.createdAt,
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
        ],
      ),
    );
  }
}
