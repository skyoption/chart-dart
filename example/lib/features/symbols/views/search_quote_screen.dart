import 'package:example/core/builder/flow_builder.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/widgets/custom_fade_animation.com.dart';
import 'package:example/core/widgets/empty_widget.dart';
import 'package:example/features/symbols/logic/search_cubit.dart';
import 'package:example/features/symbols/views/widgets/quote_category_item_widget.dart';
import 'package:example/features/symbols/views/widgets/search_item_widget.dart';
import 'package:example/features/trade/logic/positions_cubit.dart';
import 'package:example/injection/injectable.dart';

class SearchQuoteScreen extends StatefulWidget {
  static const id = 'SearchQuoteScreen';

  const SearchQuoteScreen({
    super.key,
  });

  @override
  State<SearchQuoteScreen> createState() => _SearchQuoteScreenState();
}

class _SearchQuoteScreenState extends State<SearchQuoteScreen> {
  final cubit = getIt<SearchCubit>();

  @override
  void initState() {
    cubit.getAllSymbols();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final symbols = context.read<PositionsCubit>().symbols;
    final height = context.height;
    final width = context.width;
    return BlocProvider(
      create: (context) => cubit,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(width, height * 0.12),
          child: SafeArea(
            child: Column(
              children: [
                Row(
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
                      text: context.tr.search,
                      color: context.colorScheme.scrim,
                      weight: FontWeight.w600,
                      size: FoontSize.font18,
                    ),
                  ],
                ).addPadding(bottom: 12.0, top: 21.0),
                MTextFiled(
                  prefix: MSvg(
                    name: Svgs.search,
                    height: 28.0,
                    width: 28.0,
                    color: context.colorScheme.onSurface,
                  ),
                  hintText: context.tr.findSymbol,
                  hintColor: context.colorScheme.onSurface,
                  hintSize: FoontSize.font14,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: context.colorScheme.primaryContainer,
                  textSize: FoontSize.font18,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: cubit.searchForSymbol,
                  contentPadding: const MPadding.set(
                    vertical: 12.0,
                    horizontal: 16.0,
                  ),
                ),
              ],
            ).addPadding(horizontal: 21.0),
          ),
        ),
        body: MScroll(
          padding: const MPadding.set(horizontal: 21.0, bottom: 30.0),
          child: FlowBuilder<SearchCubit>(
            builder: (context, state, cubit) {
              if (cubit.symbolSearch == SymbolSearch.emptyResults) {
                return Center(
                  child: EmptyWidget(
                    text: context.tr.noSymbolsWasFound,
                    svgIconPath: Svgs.search,
                  ),
                );
              }
              if (cubit.symbolSearch == SymbolSearch.hasResults) {
                return CustomFadeAnimation(
                  child: MScroll(
                    child: Column(
                      children: cubit.searchSymbols.map(
                        (item) {
                          return SearchItemWidget(
                            item: item,
                            inPositionSymbols: symbols,
                          );
                        },
                      ).toList(),
                    ),
                  ),
                );
              }
              return CustomFadeAnimation(
                child: Column(
                  children: cubit.categories.entries.map(
                    (item) {
                      return QuoteCategoryItemWidget(
                        title: item.key,
                        symbols: item.value,
                        inPositionSymbols: symbols,
                      );
                    },
                  ).toList(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }
}
