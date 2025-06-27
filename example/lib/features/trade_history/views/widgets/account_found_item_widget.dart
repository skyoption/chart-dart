import 'package:example/core/consts/exports.dart';
import 'package:example/features/trade_history/models/history.dart';

class AccountFoundItemWidget extends StatefulWidget {
  final History item;

  const AccountFoundItemWidget({
    super.key,
    required this.item,
  });

  @override
  State<AccountFoundItemWidget> createState() => _AccountFoundItemWidgetState();
}

class _AccountFoundItemWidgetState extends State<AccountFoundItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: context.colorScheme.outline,
        ),
        borderRadius: MBorderRadius.set(all: 8.0),
      ),
      margin: const MPadding.set(top: 6.0, horizontal: 21.0),
      padding: const MPadding.set(vertical: 6.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MText(
                  text: widget.item.type,
                  color: context.colorScheme.scrim,
                  weight: FontWeight.w600,
                  size: FoontSize.font16,
                ).addPadding(end: 12.0, bottom: 4.0),
                MText(
                  text: widget.item.comment,
                  size: FoontSize.font16,
                  color: context.colorScheme.onSurface,
                ),
              ],
            ).addPadding(start: 12.0),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              MText(
                text: widget.item.amount.signingFixed,
                color: widget.item.amount.getColor(),
                size: FoontSize.font18,
                weight: FontWeight.w400,
              ).addPadding(bottom: 4.0),
              MText(
                text: widget.item.date.toLastTime,
                color: context.colorScheme.onSurface,
                size: FoontSize.font16,
              ),
            ],
          ).addPadding(end: 12.0, top: 4.0)
        ],
      ),
    );
  }
}
