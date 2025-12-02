import 'package:example/core/consts/exports.dart';
import 'package:example/features/symbols/views/widgets/bottom_sheet_item_widget.dart';
import 'package:example/injection/injectable.dart';
import 'package:example/features/trade/logic/close_all_positions_cubit.dart';

class ActiveTradeActionsSheet extends StatefulWidget {
  const ActiveTradeActionsSheet({
    super.key,
  });

  @override
  State<ActiveTradeActionsSheet> createState() =>
      _ActiveTradeActionsSheetState();
}

class _ActiveTradeActionsSheetState extends State<ActiveTradeActionsSheet> {
  final cubit = getIt<CloseAllPositionsCubit>();

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
              color: context.colorScheme.onSurface,
            ).addAction(
              onGesture: () => AutoRouterX(context).maybePop(),
            ),
          ).addPadding(bottom: 21.0),
          BottomSheetItemWidget(
            title: context.tr.closeAllPositions,
            onTap: () {
              cubit.closeAllPositions();
            },
          ),
          BottomSheetItemWidget(
            title: context.tr.closeProfitablePositions,
            onTap: () {
              cubit.closeProfitablePositions();
            },
          ),
          BottomSheetItemWidget(
            title: context.tr.closeLosingPositions,
            onTap: () {
              cubit.closeLosingPositions();
            },
          ),
        ],
      ).addPadding(bottom: 30.0, horizontal: 21.0),
    );
  }
}

void showActiveTradeActionsBottomSheet({
  required BuildContext context,
}) {
  showMBottomSheet(
    context: context,
    removeTransparentBackground: true,
    backgorundColor: context.colorScheme.scrim,
    bottomSheet: const ActiveTradeActionsSheet(),
  );
}
