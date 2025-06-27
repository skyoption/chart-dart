import 'package:example/core/consts/exports.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';
import 'package:example/features/symbols/views/widgets/currencies_item_widget.dart';
import 'package:example/features/symbols/views/widgets/quote_details_item_widget.dart';

class QuoteDetailsScreen extends StatefulWidget {
  final SymbolEntity symbol;
  static const id = 'QuoteDetailsScreen';

  const QuoteDetailsScreen({
    super.key,
    required this.symbol,
  });

  @override
  State<QuoteDetailsScreen> createState() => _QuoteDetailsScreenState();
}

class _QuoteDetailsScreenState extends State<QuoteDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final height = context.height;
    final width = context.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(width, height * 0.13),
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
                    text: context.tr.details,
                    color: context.colorScheme.scrim,
                    weight: FontWeight.w600,
                    size: FoontSize.font18,
                  ),
                ],
              ).addPadding(bottom: 12.0, top: 21.0),
              Row(
                children: [
                  CurrenciesItemWidget(
                    value: widget.symbol,
                    size: 36.0,
                  ).addPadding(end: 4.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MText(
                        text: widget.symbol.symbol,
                        color: AppColors.secondColor,
                        weight: FontWeight.w600,
                        size: FoontSize.font16,
                      ).addPadding(bottom: 3.0),
                      if (widget.symbol.description.isNotEmpty)
                        MText(
                          text: widget.symbol.description,
                          color: AppColors.highLight909090,
                          size: FoontSize.font14,
                        ).addPadding(end: 8.0),
                    ],
                  ),
                ],
              ),
            ],
          ).addPadding(horizontal: 21.0),
        ),
      ),
      body: MScroll(
        padding: const MPadding.set(horizontal: 21.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QuoteDetailsItemWidget(
              title: context.tr.sector,
              value: widget.symbol.sector,
            ),
            QuoteDetailsItemWidget(
              title: context.tr.industry,
              value: 'Undefined',
            ),
            QuoteDetailsItemWidget(
              title: context.tr.digits,
              value: widget.symbol.digits.toString(),
            ),
            QuoteDetailsItemWidget(
              title: context.tr.contractSize,
              value: widget.symbol.contractSize.toString(),
            ),
            QuoteDetailsItemWidget(
              title: context.tr.spread,
              value: 'Floating',
            ),
            QuoteDetailsItemWidget(
              title: context.tr.stopsLevel,
              value: widget.symbol.stopLevel.toString(),
            ),
            QuoteDetailsItemWidget(
              title: context.tr.marginCurrency,
              value: widget.symbol.marginCurrency.toString(),
            ),
            QuoteDetailsItemWidget(
              title: context.tr.profitCurrency,
              value: widget.symbol.profitCurrency,
            ),
            QuoteDetailsItemWidget(
              title: context.tr.calculation,
              value: 'Forex',
            ),
            QuoteDetailsItemWidget(
              title: context.tr.chartMode,
              value: 'by bid price',
            ),
            QuoteDetailsItemWidget(
              title: context.tr.trade,
              value: 'Full access',
            ),
            QuoteDetailsItemWidget(
              title: context.tr.execution,
              value: 'Market Execution ',
            ),
            QuoteDetailsItemWidget(
              title: context.tr.gtcMode,
              value: 'Good till canceled',
            ),
            QuoteDetailsItemWidget(
              title: context.tr.filling,
              value: 'Fill or kill, Immediate or cancel ',
            ),
            QuoteDetailsItemWidget(
              title: context.tr.expiration,
              value: 'All',
            ),
            QuoteDetailsItemWidget(
              title: context.tr.minimalVolume,
              value: widget.symbol.volumeMin.toString(),
            ),
            QuoteDetailsItemWidget(
              title: context.tr.maximalVolume,
              value: widget.symbol.volumeMax.toString(),
            ),
            QuoteDetailsItemWidget(
              title: context.tr.volumeStep,
              value: widget.symbol.volumeStep.toString(),
            ),
            const MDividerItemWidget(padding: MPadding.set(vertical: 12.0)),
          ],
        ),
      ),
    );
  }
}
