import 'package:example/core/builder/flow_builder.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';
import 'package:example/features/symbols/views/widgets/edit_quote_item_widget.dart';
import 'package:example/features/trade/logic/positions_cubit.dart';

class EditQuoteScreen extends StatelessWidget {
  static const id = 'EditQuoteScreen';

  const EditQuoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final inPositionSymbols = context.read<PositionsCubit>().symbols;
    final height = context.height;
    final width = context.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(width, height * 0.08),
        child: SafeArea(
          child: Row(
            children: [
              Icon(
                Icons.arrow_back,
                color: context.colorScheme.scrim,
                size: 30.0,
              ).addAction(
                padding: const MPadding.set(end: 12.0),
                onGesture: () {
                  context.pop();
                },
              ),
              MText(
                text: context.tr.editSymbols,
                color: context.colorScheme.scrim,
                weight: FontWeight.w600,
                size: FoontSize.font18,
              ),
            ],
          ).addPadding(bottom: 12.0, top: 21.0, horizontal: 21.0),
        ),
      ),
      body: FlowBuilder<QuotesCubit>(
        builder: (context, state, cubit) {
          return ReorderableListView(
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              bottom: 30.0,
            ),
            onReorder: cubit.reorderSymbols,
            children: cubit.symbols.asMap().entries.map((entry) {
              final index = entry.key;
              final quote = entry.value;
              return SizedBox(
                width: context.mWidth,
                key: Key(quote.symbol),
                child: EditQuoteWidget(
                  index: index,
                  item: quote,
                  inPositionsSymbols: inPositionSymbols,
                  onDelete: cubit.removeSymbol,
                ).addPadding(vertical: 6.0, horizontal: 6.0),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
