import 'dart:async';

import 'package:example/core/consts/constants.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/consts/tool_tips_config.dart';
import 'package:example/features/symbols/views/bottom_sheets/quote_sort_bottom_sheet.dart';
import 'package:example/features/symbols/views/widgets/home_categories.dart';
import 'package:example/features/symbols/views/widgets/quotes_body_view.dart';
import 'package:example/features/trade/views/widgets/cupertino_custom_sliding_segmented_control.dart';
import 'package:example/core/shared/guide_tooltip_scaffold.dart';
import 'package:example/core/shared/guide_tooltip_widget.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';

enum QuotesWidgetLayoutType { advanced, table, simple }

@RoutePage()
class SymbolsScreen extends StatefulWidget {
  const SymbolsScreen({super.key});

  @override
  State<SymbolsScreen> createState() => _SymbolsScreenState();
}

class _SymbolsScreenState extends State<SymbolsScreen> {
  StreamController<QuotesWidgetLayoutType> layoutController =
      StreamController();

  late final quotesCubit = context.read<QuotesCubit>();

  @override
  void initState() {
    quotesCubit.setType('All');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    return GuideTooltipScaffold(
      preferenceKey: Constants.QUOTES_ONBOARDING_COMPLETED,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size(width, 145.0),
              child: MScroll(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GuideTooltipWidget(
                          config: QuotesTooltip.editSymbols.config,
                          child: MSvg(
                            name: Svgs.edit,
                            width: 21.0,
                            height: 21.0,
                            color: context.colorScheme.onSurface,
                          ).addAction(
                            onGesture: () {
                              context.navigateTo(const ModifySymbolsRoute());
                            },
                            padding: const MPadding.set(end: 16.0),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: GuideTooltipWidget(
                              config: QuotesTooltip.layoutToggle.config,
                              child: CupertinoCustomSlidingSegmentedControl(
                                fontSize: FoontSize.font16,
                                options: [
                                  context.tr.advanced,
                                  context.tr.simple,
                                  context.tr.table
                                ],
                                onChange: (value) {
                                  // index = value;
                                  QuotesWidgetLayoutType? type;
                                  switch (value) {
                                    case 0:
                                      type = QuotesWidgetLayoutType.advanced;
                                    case 1:
                                      type = QuotesWidgetLayoutType.simple;
                                    case 2:
                                      type = QuotesWidgetLayoutType.table;
                                  }
                                  layoutController.add(type!);
                                },
                              ),
                            ),
                          ),
                        ),
                        GuideTooltipWidget(
                          config: QuotesTooltip.addSymbol.config,
                          child: MSvg(
                            name: Svgs.add,
                            color: context.colorScheme.onSurface,
                            width: 21.0,
                            height: 21.0,
                          ).addAction(
                            onGesture: () {
                              context.navigateTo(const SearchSymbolsRoute());
                            },
                            padding: const MPadding.set(start: 16.0),
                          ),
                        ),
                        GuideTooltipWidget(
                          config: QuotesTooltip.sortSymbols.config,
                          child: MSvg(
                            name: Svgs.sort,
                            color: context.colorScheme.onSurface,
                            width: 21.0,
                            height: 21.0,
                          ).addAction(
                            onGesture: () {
                              showQuoteSortBottomSheet(
                                context: context,
                                symbolSortConfig: quotesCubit.currentSortConfig,
                                onSortChange: quotesCubit.sortSymbols,
                              );
                            },
                            padding: const MPadding.set(start: 16.0),
                          ),
                        )
                      ],
                    ).addPadding(horizontal: 21.0, vertical: 20),
                    const HomeCategories(),
                  ],
                ),
              )),
          body: QuotesBodyView(
            layoutController: layoutController,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    layoutController.close();
    // quotesCubit.dispose();
    super.dispose();
  }
}

/*Expanded(
child: MTextFiled(
  prefix: const MSvg(
    name: Svgs.search,
    height: 28.0,
    width: 28.0,
    color: MCoolors.highLight909090,
  ),
  enabled: false,
  hintText: 'Search by symbol...',
  hintColor: MCoolors.highLight909090,
  hintSize: FoontSize.font14,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0),
    borderSide: BorderSide.none,
  ),
  fillColor: MCoolors.highLight,
  textSize: FoontSize.font18,
  keyboardType: TextInputType.emailAddress,
  onChanged: (value) {},
  contentPadding: const MPadding.set(
    vertical: 12.0,
    horizontal: 16.0,
  ),
).addAction(
  onGesture: () {
    context.push(const SearchQuoteScreen());
  },
),
),*/
