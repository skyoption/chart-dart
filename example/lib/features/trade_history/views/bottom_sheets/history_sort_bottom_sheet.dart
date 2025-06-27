import 'package:example/core/consts/exports.dart';
import 'package:example/core/enums/history_sort.dart';
import 'package:example/core/widgets/sheet_selection_item.dart';

class HistorySortBottomSheet extends StatefulWidget {
  final HistorySortConfig initialConfig;
  final ValueChanged<HistorySortConfig> onSortSelection;
  final List<HistorySortCriteria> hideOptions;
  const HistorySortBottomSheet({
    super.key,
    required this.initialConfig,
    required this.onSortSelection,
    required this.hideOptions,
  });

  @override
  State<HistorySortBottomSheet> createState() => _HistorySortBottomSheetState();
}

class _HistorySortBottomSheetState extends State<HistorySortBottomSheet> {
  late HistorySortConfig currentConfig;

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
                color: context.colorScheme.scrim,
                weight: FontWeight.w600,
                size: FoontSize.font20,
              ).addPadding(top: 12.0),
            ),
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: Icon(
                Icons.clear,
                size: 30.0,
                color: context.colorScheme.scrim,
              ).addAction(
                onGesture: () => context.pop(),
              ),
            )
          ],
        ),
        MDividerItemWidget(
          color: context.colorScheme.outline,
          padding: const MPadding.set(top: 30.0, bottom: 8.0),
        ),
        ...HistorySortCriteria.values.map((criterion) {
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
                  currentConfig = HistorySortConfig(
                    criteria: criterion,
                    isAscending: !currentConfig.isAscending,
                  );
                } else {
                  currentConfig = HistorySortConfig(
                    criteria: criterion,
                    isAscending: true,
                  );
                }
              });
              widget.onSortSelection(currentConfig);
              context.pop();
            },
          );
        }),
      ],
    ).addPadding(bottom: 30.0, horizontal: 21.0);
  }
}

void showHistorySortBottomSheet({
  required BuildContext context,
  required HistorySortConfig currentSort,
  required ValueChanged<HistorySortConfig> onSortSelection,
  List<HistorySortCriteria>? hideOptions,
}) {
  showMBottomSheet(
    context: context,
    removeTransparentBackground: true,
    backgorundColor: context.colorScheme.primaryContainer,
    bottomSheet: HistorySortBottomSheet(
      initialConfig: currentSort,
      onSortSelection: onSortSelection,
      hideOptions: hideOptions ?? [],
    ),
  );
}
