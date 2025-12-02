import 'package:example/core/consts/exports.dart';
import 'package:example/core/widgets/sheet_selection_item.dart';
import 'package:example/core/enums/symbol_sort.dart';

class QuoteSortBottomSheet extends StatefulWidget {
  final SymbolSortConfig symbolSortConfig;
  final ValueChanged<SymbolSortConfig> onSortSelection;

  const QuoteSortBottomSheet({
    super.key,
    required this.symbolSortConfig,
    required this.onSortSelection,
  });

  @override
  State<QuoteSortBottomSheet> createState() => _QuoteSortBottomSheetState();
}

class _QuoteSortBottomSheetState extends State<QuoteSortBottomSheet> {
  late SymbolSortConfig currentConfig;

  @override
  void initState() {
    currentConfig = widget.symbolSortConfig;
    super.initState();
  }

  void _handleSort(SymbolSortCriteria criteria) {
    setState(() {
      if (currentConfig.criteria == criteria && criteria.canToggle) {
        currentConfig = SymbolSortConfig(
          criteria: criteria,
          isAscending: !currentConfig.isAscending,
        );
      } else {
        currentConfig = SymbolSortConfig(
          criteria: criteria,
          isAscending: criteria.defaultAscending,
        );
      }
    });
    widget.onSortSelection(currentConfig);
    AutoRouterX(context).pop();
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
        SheetSelectionItem(
          name: SymbolSortCriteria.sortByName.displayName,
          onTap: () => _handleSort(SymbolSortCriteria.sortByName),
          isAscending: currentConfig.isAscending,
          isSelected: currentConfig.criteria == SymbolSortCriteria.sortByName,
        ),
        SheetSelectionItem(
          name: SymbolSortCriteria.activeTrades.displayName,
          onTap: () => _handleSort(SymbolSortCriteria.activeTrades),
          isSelected: currentConfig.criteria == SymbolSortCriteria.activeTrades,
          isAscending: false,
          hideIcon: true,
        ),
      ],
    ).addPadding(bottom: 30.0, horizontal: 21.0);
  }
}

void showQuoteSortBottomSheet({
  required BuildContext context,
  required SymbolSortConfig symbolSortConfig,
  required ValueChanged<SymbolSortConfig> onSortChange,
}) {
  showMBottomSheet(
    context: context,
    removeTransparentBackground: true,
    backgorundColor: context.colorScheme.scrim,
    bottomSheet: QuoteSortBottomSheet(
      symbolSortConfig: symbolSortConfig,
      onSortSelection: onSortChange,
    ),
  );
}
