import 'package:example/core/consts/exports.dart';
import 'package:example/features/chart/views/bottom_sheets/choose_symbol_bottom_sheet.dart';
import 'package:example/features/symbols/views/widgets/currencies_item_widget.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';

class ChooseSymbolWidget extends StatefulWidget {
  const ChooseSymbolWidget({
    super.key,
    required this.onChanged,
    this.onViewAll,
  });

  final Function(String symbol) onChanged;
  final Function()? onViewAll;

  @override
  State<ChooseSymbolWidget> createState() => _ChooseSymbolWidgetState();
}

class _ChooseSymbolWidgetState extends State<ChooseSymbolWidget> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QuotesCubit>();
    return ValueListenableBuilder<SymbolEntity?>(
      valueListenable: cubit.currentSymbol,
      builder: (context, symbol, child) {
        return Container(
          height: 48.0,
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerLow,
            borderRadius: MBorderRadius.set(all: 10.0),
          ),
          padding: const MPadding.set(horizontal: 15.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (symbol != null)
                CurrenciesItemWidget(value: symbol, size: 18.0, endPadding: 5),
              MText(
                text: symbol == null ? context.tr.chooseSymbol : symbol.symbol,
                color: symbol == null
                    ? context.colorScheme.onSurfaceVariant
                    : context.colorScheme.onSurface,
                size: symbol == null ? FoontSize.font13 : FoontSize.font18,
              ).addPadding(end: 2),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 26.0,
                color: context.colorScheme.onSurface,
              ),
            ],
          ),
        );
      },
    ).addAction(
      onGesture: () {
        showChooseSymbolsBottomSheet(
          context: context,
          onChange: widget.onChanged,
          onViewAll: widget.onViewAll,
        );
      },
    );
  }
}
