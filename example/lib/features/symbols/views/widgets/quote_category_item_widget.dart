import 'package:example/core/consts/exports.dart';
import 'package:example/features/symbols/models/schema/symbol_model.dart';
import 'package:example/features/symbols/views/widgets/add_quote_item_widget.dart';

class QuoteCategoryItemWidget extends StatefulWidget {
  final String title;
  final List<SymbolModel> symbols;
  final List<String> inPositionSymbols;

  const QuoteCategoryItemWidget({
    super.key,
    required this.title,
    required this.symbols,
    required this.inPositionSymbols,
  });

  @override
  State<QuoteCategoryItemWidget> createState() =>
      _QuoteCategoryItemWidgetState();
}

class _QuoteCategoryItemWidgetState extends State<QuoteCategoryItemWidget> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            MSvg(
              name: Svgs.folder,
              height: 26.0,
              width: 26.0,
              color: context.colorScheme.scrim,
            ).addPadding(end: 14.0),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MText(
                    text: widget.title,
                    size: FoontSize.font16,
                    weight: FontWeight.w600,
                    color: context.colorScheme.scrim,
                  ),
                  Icon(
                    show
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: context.colorScheme.scrim,
                    size: 31.0,
                  ).addAction(
                    onGesture: () {
                      show = !show;
                      setState(() {});
                    },
                  )
                ],
              ),
            ),
          ],
        ),
        MDividerItemWidget(
          color: context.colorScheme.outline,
          padding: const MPadding.set(vertical: 12.0),
        ),
        if (show)
          Column(
            children: widget.symbols.map((item) {
              return AddQuoteWidget(
                item: item,
                inPositionSymbols: widget.inPositionSymbols,
              );
            }).toList(),
          ).addPadding(bottom: 21.0)
      ],
    );
  }
}
