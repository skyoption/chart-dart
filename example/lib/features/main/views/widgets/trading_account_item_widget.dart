import 'package:example/core/consts/exports.dart';
import 'package:example/features/auth/models/connected_account_info_entity.dart';
import 'package:example/features/settings/views/bottom_sheets/switch_account_bottom_sheet.dart';
import 'package:example/features/settings/views/widgets/trade_value_item_widget.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:visibility_detector/visibility_detector.dart';

class TradingAccountItemWidget extends StatefulWidget {
  final Function onDelete, onSwitch;
  final Function(BuildContext)? onTap;
  final ConnectedAccountInfoEntity accountInfo;
  const TradingAccountItemWidget({
    super.key,
    required this.onDelete,
    required this.onSwitch,
    this.onTap,
    required this.accountInfo,
  });

  @override
  State<TradingAccountItemWidget> createState() =>
      _TradingAccountItemWidgetState();
}

class _TradingAccountItemWidgetState extends State<TradingAccountItemWidget>
    with SingleTickerProviderStateMixin {
  late final controller = SlidableController(this);
  bool isOpen = false;
  final key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: key,
      controller: controller,
      endActionPane: ActionPane(
        extentRatio: 0.2675,
        motion: const ScrollMotion(),
        dragDismissible: false,
        children: [
          VisibilityDetector(
            key: GlobalKey(),
            onVisibilityChanged: (info) {
              isOpen = !isOpen;
              setState(() {});
            },
            child: Container(
              height: double.infinity,
              padding: const MPadding.set(all: 16.0),
              decoration: BoxDecoration(
                color: context.colorScheme.error,
                borderRadius: MBorderRadius.set(end: 21.0),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.delete,
                    color: context.colorScheme.scrim,
                    size: 30.0,
                  ).addPadding(end: 6.0),
                  MText(
                    text: context.tr.delete,
                    color: context.colorScheme.scrim,
                    size: FoontSize.font16,
                    weight: FontWeight.w500,
                  )
                ],
              ),
            ).addAction(
              onGesture: () {
                controller.close();
              },
            ),
          )
        ],
      ),
      child: SizedBox(
        width: context.width,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: MBorderRadius.set(
                  end: isOpen ? 0.0 : 21.0,
                  start: 21.0,
                ),
                color: context.colorScheme.primaryContainer,
                border: Border.all(
                  color: context.colorScheme.outline,
                ),
              ),
              padding: const MPadding.set(horizontal: 21.0, vertical: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MText(
                        text: '${widget.accountInfo.id}',
                        size: FoontSize.font16,
                        weight: FontWeight.w600,
                        color: context.colorScheme.scrim,
                      ).addPadding(top: 5),
                      MText(
                        text: widget.accountInfo.group.toUpperCase(),
                        color: context.colorScheme.primary,
                        size: FoontSize.font16,
                        weight: FontWeight.w600,
                      ),
                    ],
                  ),
                  Divider(
                    color: context.colorScheme.outline,
                  ).addPadding(top: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TradeValueItemWidget(
                        title: context.tr.balance,
                        value: '${widget.accountInfo.balance}',
                        titleColor: context.colorScheme.scrim,
                        titleSize: FoontSize.font14,
                        valueColor: context.colorScheme.scrim,
                        valueWeight: FontWeight.w600,
                        titleWeight: FontWeight.w400,
                        valueSize: FoontSize.font14,
                      ).addPadding(end: 30.0),
                      TradeValueItemWidget(
                        title: context.tr.leverageTitle,
                        value: '1:${widget.accountInfo.leverage}',
                        titleColor: context.colorScheme.scrim,
                        titleSize: FoontSize.font14,
                        valueColor: context.colorScheme.scrim,
                        valueWeight: FontWeight.w600,
                        titleWeight: FontWeight.w400,
                        valueSize: FoontSize.font14,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // if (!isCurrent)
            //   Align(
            //     alignment: AlignmentDirectional.topEnd,
            //     child: const Icon(
            //       CupertinoIcons.delete,
            //       color: Coolors.red,
            //       size: 26.0,
            //     ).addAction(
            //       onGesture: onDelete,
            //       padding: const MPadding.set(all: 21.0),
            //     ),
            //   )
          ],
        ),
      ).addAction(
        onGesture: () {
          if (!widget.accountInfo.isDefault) {
            showSwitchAccountBottomSheet(
              context: context,
              onSwitch: widget.onSwitch,
              onDelete: widget.onDelete,
            );
          }
        },
      ),
    ).addPadding(horizontal: 21.0, bottom: 21.0);
  }
}
