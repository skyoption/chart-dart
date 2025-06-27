import 'package:example/core/consts/exports.dart';
import 'package:example/features/symbols/views/widgets/currencies_item_widget.dart';
import 'package:example/features/trade_history/models/history_action_entity.dart';

class HistoryActionItemWidget extends StatefulWidget {
  final HistoryActionEntity item;

  const HistoryActionItemWidget({
    super.key,
    required this.item,
  });

  @override
  State<HistoryActionItemWidget> createState() =>
      _HistoryActionItemWidgetState();
}

class _HistoryActionItemWidgetState extends State<HistoryActionItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const MPadding.set(horizontal: 21.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: MBorderRadius.set(all: 8.0),
        border: Border.all(color: context.colorScheme.outline),
      ),
      margin: const MPadding.set(horizontal: 21.0, bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CurrenciesItemWidget(
                    item: widget.item.symbol,
                  ),
                  MText(
                    text: widget.item.symbol.toUpperCase(),
                    weight: FontWeight.w600,
                    size: FoontSize.font16,
                    color: context.colorScheme.scrim,
                  ),
                  MText(
                    text:
                        '${widget.item.direction} ${widget.item.type} ${widget.item.volume}',
                    size: FoontSize.font13,
                    weight: FontWeight.w500,
                    color: widget.item.direction == 'SELL'
                        ? Colors.red
                        : Colors.green,
                  ).addPadding(start: 10.0),
                ],
              ).addPadding(bottom: 4.0),
              MText(
                text: context.tr.at(widget.item.price.toString()),
                size: FoontSize.font14,
                color: context.colorScheme.onSurface,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (widget.item.profit != 0)
                MText(
                  text: widget.item.profit.signingFixed,
                  color: widget.item.profit.getColor(),
                  size: FoontSize.font16,
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
          ).addPadding(top: 4.0),
        ],
      ),
    );
  }
}
