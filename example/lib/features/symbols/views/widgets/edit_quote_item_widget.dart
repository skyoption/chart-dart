import 'package:example/core/consts/exports.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';
import 'package:example/features/symbols/views/widgets/currencies_item_widget.dart';

class EditQuoteWidget extends StatelessWidget {
  final Function(SymbolEntity deletedSymbol) onDelete;
  final SymbolEntity item;
  final int index;
  final List<String> inPositionsSymbols;
  const EditQuoteWidget({
    super.key,
    required this.onDelete,
    required this.item,
    required this.index,
    required this.inPositionsSymbols,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: Coolors.grey.withValues(alpha: 0.3),
        ),
        borderRadius: MBorderRadius.set(all: 8.0),
      ),
      padding: const MPadding.set(vertical: 12.0, horizontal: 14.0),
      child: Row(
        children: [
          if (!inPositionsSymbols.contains(item.symbol))
            const MSvg(
              name: Svgs.delete,
              height: 21.0,
              width: 21.0,
            ).addAction(onGesture: () => onDelete(item)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CurrenciesItemWidget(
                      size: 26.0,
                      item: item.symbol,
                    ),
                    MText(
                      text: item.symbol,
                      color: context.colorScheme.scrim,
                      weight: FontWeight.w600,
                      size: FoontSize.font16,
                    ),
                  ],
                ),
                if (item.description.isNotEmpty)
                  MText(
                    text: item.description,
                    color: context.colorScheme.scrim,
                    weight: FontWeight.w400,
                    size: FoontSize.font14,
                  ).addPadding(vertical: 5.0),
              ],
            ).addPadding(horizontal: 12.0),
          ),
          ReorderableDragStartListener(
            index: index,
            child: MSvg(
              name: Svgs.drag,
              height: 18.0,
              width: 18.0,
              color: context.colorScheme.surfaceBright,
            ),
          )
        ],
      ),
    );
  }
}
