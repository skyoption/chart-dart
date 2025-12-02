import 'package:example/core/consts/exports.dart';
import 'package:example/core/widgets/top_bottom_sheet_widget.dart';
import 'package:example/features/chart/views/widgets/choose_symbol_item_widget.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';

class ChooseSymbolsBottomSheet extends StatefulWidget {
  final Function(String symbol) onChange;
  final Function()? onViewAll;
  const ChooseSymbolsBottomSheet({
    super.key,
    required this.onChange,
    required this.onViewAll,
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
    return SizedBox(
      height: 700.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TopBottomSheetWidget(),
          MText(
            text: context.tr.symbol,
            size: FoontSize.font21,
            color: context.colorScheme.onSurface,
            align: TextAlign.start,
            weight: FontWeight.w600,
          ).addPadding(horizontal: 21.0, bottom: 10.0),
          MTextFiled(
            controller: _searchController,
            hintText: context.tr.searchBySymbolName,
            textColor: context.colorScheme.onSurface,
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
          ).addPadding(bottom: 16.0, horizontal: 21.0),
          Expanded(
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
                      if (!item.symbol.toLowerCase().contains(
                            _searchController.text,
                          )) {
                        return SizedBox();
                      }
                      final currentSymbol = cubit.currentSymbol.value;
                      final isSelected = item.symbol == currentSymbol?.symbol;
                      return InkWell(
                        onTap: () async {
                          AutoRouterX(context).maybePop();
                          context.read<QuotesCubit>().setCurrentSymbol(
                                item,
                              );
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
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: context.colorScheme.primary),
              borderRadius: MBorderRadius.set(all: 8.0),
            ),
            padding: const MPadding.set(horizontal: 12.0, vertical: 12.0),
            margin: const MPadding.set(vertical: 16.0, horizontal: 21.0),
            child: Row(
              children: [
                Icon(
                  Icons.add,
                  color: context.colorScheme.primary,
                  size: 25.0,
                ).addPadding(end: 5.0),
                MText(
                  text: context.tr.addNewSymbol,
                  weight: FontWeight.w500,
                  size: FoontSize.font16,
                  color: context.colorScheme.primary,
                ),
              ],
            ),
          ).addAction(
              onGesture: () => context.pushRoute(const SearchSymbolsRoute())),
        ],
      ).addPadding(bottom: 30.0),
    );
  }
}

void showChooseSymbolsBottomSheet({
  required BuildContext context,
  required Function(String symbol) onChange,
  Function()? onViewAll,
}) {
  showMBottomSheet(
    context: context,
    noScrolling: true,
    removeTransparentBackground: true,
    backgorundColor: context.colorScheme.scrim,
    bottomSheet: ChooseSymbolsBottomSheet(
      onChange: onChange,
      onViewAll: onViewAll,
    ),
  );
}
