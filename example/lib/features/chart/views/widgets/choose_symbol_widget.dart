import 'package:example/core/consts/exports.dart';
import 'package:example/features/chart/views/bottom_sheets/choose_symbol_bottom_sheet.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';
import 'package:example/features/symbols/views/widgets/currencies_item_widget.dart';

class ChooseSymbolWidget extends StatefulWidget {
  const ChooseSymbolWidget({super.key, required this.onChanged});

  final Function(String symbol) onChanged;

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
          padding: const MPadding.set(horizontal: 16.0),
          child: Row(
            spacing: 50.0,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (symbol != null)
                    CurrenciesItemWidget(
                      value: symbol,
                      size: 21.0,
                    ),
                  MText(
                    text: symbol == null
                        ? context.tr.chooseSymbol
                        : symbol.symbol,
                    color: symbol == null
                        ? context.colorScheme.onSurfaceVariant
                        : context.colorScheme.scrim,
                    size: symbol == null ? FoontSize.font16 : FoontSize.font18,
                  )
                ],
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 26.0,
                color: context.colorScheme.scrim,
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
        );
      },
    );
  }
}
