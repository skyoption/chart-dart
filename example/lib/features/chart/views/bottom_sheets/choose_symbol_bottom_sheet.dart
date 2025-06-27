import 'package:example/core/builder/flow_builder.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/widgets/top_bottom_sheet_widget.dart';
import 'package:example/features/chart/views/widgets/choose_symbol_item_widget.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';
import 'package:example/features/symbols/views/quotes_screen.dart';

class ChooseSymbolsBottomSheet extends StatefulWidget {
  final Function(String symbol) onChange;
  const ChooseSymbolsBottomSheet({
    super.key,
    required this.onChange,
  });

  @override
  State<ChooseSymbolsBottomSheet> createState() =>
      _ChooseSymbolsBottomSheetState();
}

class _ChooseSymbolsBottomSheetState extends State<ChooseSymbolsBottomSheet> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TopBottomSheetWidget(),
        MText(
          text: context.tr.symbol,
          size: FoontSize.font21,
          color: context.colorScheme.scrim,
          align: TextAlign.start,
          weight: FontWeight.w600,
        ).addPadding(horizontal: 21.0, bottom: 10.0),
        Row(
          spacing: 16.0,
          children: [
            Expanded(
              child: MTextFiled(
                controller: _searchController,
                hintText: context.tr.searchBySymbolName,
                textColor: context.colorScheme.scrim,
                titleColor: context.colorScheme.onSurface,
                hintColor: context.colorScheme.onSurfaceDisabled,
                // controller: cubit.number,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                activeBorderColor: Colors.transparent,
                onChanged: (value) => setState(() {}),
                fillColor: context.colorScheme.surfaceContainerLow,
                contentPadding: const MPadding.set(all: 12.0),
                textSize: FoontSize.font15,
                hintSize: FoontSize.font15,
                keyboardType: TextInputType.text,
                prefix: MSvg(
                  name: Svgs.search,
                  color: context.colorScheme.onSurface,
                  width: 21.0,
                  height: 21.0,
                ).addPadding(horizontal: 6.0),
              ),
            ),
            MBouncingButton(
              onTap: () {
                context.push(const QuotesScreen());
              },
              title: context.tr.viewAll,
              borderRadius: 8.0,
              height: 50.0,
              width: 150.0,
              color: context.colorScheme.primary,
            )
          ],
        ).addPadding(bottom: 16.0, horizontal: 21.0),
        Flexible(
          child: SingleChildScrollView(
            child: FlowBuilder<QuotesCubit>(
              buildWhenState: (previous, current) {
                return previous.data is List<SymbolEntity> &&
                    current.data is List<SymbolEntity> &&
                    previous.data != current.data;
              },
              builder: (context, state, cubit) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: cubit.noFilterSymbols.map((item) {
                    if (!item.symbol
                        .toLowerCase()
                        .contains(_searchController.text)) {
                      return SizedBox();
                    }
                    final currentSymbol = cubit.currentSymbol.value;
                    final isSelected = item.symbol == currentSymbol?.symbol;
                    return InkWell(
                      onTap: () async {
                        context.pop();
                        context.read<QuotesCubit>().setCurrentSymbol(item);
                        widget.onChange(item.symbol);
                      },
                      child: ChooseSymbolItemWidget(
                        isSelected: isSelected,
                        item: item,
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ),
      ],
    ).addPadding(bottom: 30.0);
  }
}

void showChooseSymbolsBottomSheet({
  required BuildContext context,
  required Function(String symbol) onChange,
}) {
  showMBottomSheet(
    context: context,
    removeTransparentBackground: true,
    noScrolling: true,
    backgorundColor: context.colorScheme.primaryContainer,
    bottomSheet: ChooseSymbolsBottomSheet(
      onChange: onChange,
    ),
  );
}
