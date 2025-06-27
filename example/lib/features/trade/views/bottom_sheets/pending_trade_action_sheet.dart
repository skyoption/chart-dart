import 'package:example/core/consts/exports.dart';
import 'package:example/features/symbols/views/widgets/bottom_sheet_item_widget.dart';
import 'package:example/features/trade/logic/close_all_pending_cubit.dart';
import 'package:example/injection/injectable.dart';

class PendingTradeActionsSheet extends StatefulWidget {
  const PendingTradeActionsSheet({
    super.key,
  });

  @override
  State<PendingTradeActionsSheet> createState() =>
      _PendingTradeActionsSheetState();
}

class _PendingTradeActionsSheetState extends State<PendingTradeActionsSheet> {
  final cubit = getIt<CloseAllPendingCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: Column(
        children: [
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: Icon(
              Icons.clear,
              size: 30.0,
              color: context.colorScheme.scrim,
            ).addAction(
              onGesture: () => context.pop(),
            ),
          ).addPadding(bottom: 21.0),
          BottomSheetItemWidget(
            title: context.tr.deleteAllOrders,
            onTap: () {
              cubit.deleteAllOrders();
            },
          ),
          BottomSheetItemWidget(
            title: context.tr.deleteAllBuyLimitOrders,
            onTap: () {
              cubit.deleteAllBuyLimitOrders();
            },
          ),
          BottomSheetItemWidget(
            title: context.tr.deleteAllSellLimitOrders,
            onTap: () {
              cubit.deleteAllSellLimitOrders();
            },
          ),
          BottomSheetItemWidget(
            title: context.tr.deleteAllBuyStopOrders,
            onTap: () {
              cubit.deleteAllBuyStopOrders();
            },
          ),
          BottomSheetItemWidget(
            title: context.tr.deleteAllSellStopOrders,
            onTap: () {
              cubit.deleteAllSellStopOrders();
            },
          ),
        ],
      ).addPadding(bottom: 30.0, horizontal: 21.0),
    );
  }
}

void showPendingTradeActionsBottomSheet({
  required BuildContext context,
}) {
  showMBottomSheet(
    context: context,
    removeTransparentBackground: true,
    backgorundColor: context.colorScheme.primaryContainer,
    bottomSheet: const PendingTradeActionsSheet(),
  );
}
