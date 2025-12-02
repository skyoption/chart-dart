import 'package:example/core/consts/exports.dart';
import 'package:example/core/widgets/sheet_selection_item.dart';
import 'package:example/core/enums/position_sort.dart';

class TradeBottomSheet extends StatefulWidget {
  final PositionSortConfig initialConfig;
  final ValueChanged<PositionSortConfig> onSortSelection;
  final List<PositionSortCriteria> hideOptions;

  const TradeBottomSheet({
    super.key,
    required this.initialConfig,
    required this.onSortSelection,
    required this.hideOptions,
  });

  @override
  State<TradeBottomSheet> createState() => _TradeBottomSheetState();
}

class _TradeBottomSheetState extends State<TradeBottomSheet> {
  late PositionSortConfig currentConfig;

  @override
  void initState() {
    super.initState();
    currentConfig = widget.initialConfig;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: MText(
                text: context.tr.sortBy,
                color: context.colorScheme.onSurface,
                weight: FontWeight.w600,
                size: FoontSize.font20,
              ),
            ),
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: Icon(
                Icons.clear,
                size: 30.0,
                color: context.colorScheme.onSurface,
              ).addAction(
                onGesture: () => AutoRouterX(context).pop(),
              ),
            )
          ],
        ).addPadding(bottom: 40.0),
        ...PositionSortCriteria.values.map((criterion) {
          if (widget.hideOptions.contains(criterion)) {
            return const SizedBox.shrink();
          }
          bool isSelected = currentConfig.criteria == criterion;
          return SheetSelectionItem(
            isSelected: isSelected,
            name: criterion.displayName,
            isAscending: currentConfig.isAscending,
            onTap: () {
              setState(() {
                if (isSelected) {
                  currentConfig = PositionSortConfig(
                    criteria: criterion,
                    isAscending: !currentConfig.isAscending,
                  );
                } else {
                  currentConfig = PositionSortConfig(
                    criteria: criterion,
                    isAscending: true,
                  );
                }
              });
              widget.onSortSelection(currentConfig);
              AutoRouterX(context).pop();
            },
          );
        }),
      ],
    ).addPadding(bottom: 30.0, horizontal: 21.0);
  }
}

void showTradeBottomSheet({
  required BuildContext context,
  required PositionSortConfig currentSort,
  required ValueChanged<PositionSortConfig> onSortSelection,
  List<PositionSortCriteria>? hideOptions,
}) {
  showMBottomSheet(
    context: context,
    removeTransparentBackground: true,
    backgorundColor: context.colorScheme.scrim,
    bottomSheet: TradeBottomSheet(
      initialConfig: currentSort,
      onSortSelection: onSortSelection,
      hideOptions: hideOptions ?? [],
    ),
  );
}
