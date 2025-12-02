import 'package:example/core/consts/exports.dart';
import 'package:example/features/symbols/views/widgets/currencies_item_widget.dart';
import 'package:example/core/framework/functions.dart';
import 'package:example/core/shared/my_scaffold_widget.dart';
import 'package:example/core/shared/row_value_item_widget.dart';
import 'package:example/features/main/logic/connect_cubit.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';
import 'package:example/features/trade/logic/positions_cubit.dart';

@RoutePage()
class SymbolDetailsScreen extends StatefulWidget {
  final SymbolEntity item;

  const SymbolDetailsScreen({
    super.key,
    required this.item,
  });

  @override
  State<SymbolDetailsScreen> createState() => _SymbolDetailsScreenState();
}

class _SymbolDetailsScreenState extends State<SymbolDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final positionsCubit = context.read<PositionsCubit>();
    return MScaffoldWidget(
      title: context.tr.details,
      appbarSize: 75.0,
      child: MScroll(
        padding: const MPadding.set(horizontal: 21.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainer,
                borderRadius: MBorderRadius.set(all: 12.0),
              ),
              padding: const MPadding.set(vertical: 16.0, horizontal: 21.0),
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    children: [
                      CurrenciesItemWidget(size: 40.0, value: widget.item),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MText(
                            text: widget.item.symbol,
                            weight: FontWeight.w600,
                            size: FoontSize.font18,
                            color: context.colorScheme.onSurface,
                          ).addPadding(bottom: 3.0),
                          if (widget.item.description.isNotEmpty)
                            MText(
                              text: widget.item.description,
                              weight: FontWeight.w300,
                              size: FoontSize.font14,
                              color: context.colorScheme.onSurface,
                            ),
                        ],
                      ),
                    ],
                  ).addPadding(bottom: 21.0),
                  RowValueItemWidget(
                    title: context.tr.sector,
                    subTitle: widget.item.sector,
                    subTitleWeight: FontWeight.w400,
                    titleWeight: FontWeight.w300,
                    subTitleColor: context.colorScheme.onSurface,
                    titleColor: context.colorScheme.onSurface,
                  ).addPadding(bottom: 4.0),
                  RowValueItemWidget(
                    title: context.tr.digits,
                    subTitle: widget.item.digits,
                    subTitleWeight: FontWeight.w400,
                    titleWeight: FontWeight.w300,
                    subTitleColor: context.colorScheme.onSurface,
                    titleColor: context.colorScheme.onSurface,
                  ).addPadding(bottom: 4.0),
                  ValueListenableBuilder(
                    valueListenable: positionsCubit.account,
                    builder: (context, tradingAccount, child) {
                      final accountLeverage = tradingAccount?.leverage ?? 0;
                      return RowValueItemWidget(
                        title: context.tr.leverage,
                        subTitle:
                            "1:${getLeverage(widget.item.leverage, accountLeverage)}",
                        subTitleWeight: FontWeight.w400,
                        titleWeight: FontWeight.w300,
                        subTitleColor: context.colorScheme.onSurface,
                        titleColor: context.colorScheme.onSurface,
                      ).addPadding(bottom: 4.0);
                    },
                  ),
                  ValueListenableBuilder(
                    valueListenable: widget.item.askChange,
                    builder: (context, value, child) {
                      return RowValueItemWidget(
                        title: context.tr.ask,
                        subTitle: value.toString(),
                        subTitleWeight: FontWeight.w400,
                        titleWeight: FontWeight.w300,
                        subTitleColor: widget.item.askColor.value,
                        titleColor: context.colorScheme.onSurface,
                      ).addPadding(bottom: 4.0);
                    },
                  ),
                  ValueListenableBuilder(
                    valueListenable: widget.item.bidChange,
                    builder: (context, value, child) {
                      return RowValueItemWidget(
                        title: context.tr.bid,
                        subTitle: value.toString(),
                        subTitleWeight: FontWeight.w400,
                        titleWeight: FontWeight.w300,
                        subTitleColor: widget.item.bidColor.value,
                        titleColor: context.colorScheme.onSurface,
                      ).addPadding(bottom: 4.0);
                    },
                  ),
                  RowValueItemWidget(
                    title: context.tr.contractSize,
                    containerSize: 30.0,
                    subTitle: widget.item.contractSize,
                    subTitleWeight: FontWeight.w400,
                    titleWeight: FontWeight.w300,
                    subTitleColor: context.colorScheme.onSurface,
                    titleColor: context.colorScheme.onSurface,
                  ).addPadding(bottom: 4.0),
                  RowValueItemWidget(
                    title: context.tr.spread,
                    containerSize: widget.item.spread.value,
                    subTitle: context.tr.floating,
                    subTitleWeight: FontWeight.w400,
                    titleWeight: FontWeight.w300,
                    subTitleColor: context.colorScheme.onSurface,
                    titleColor: context.colorScheme.onSurface,
                  ).addPadding(bottom: 4.0),
                  RowValueItemWidget(
                    title: context.tr.stopsLevel,
                    containerSize: 30.0,
                    subTitle: widget.item.stopLevel.toString(),
                    subTitleWeight: FontWeight.w400,
                    titleWeight: FontWeight.w300,
                    subTitleColor: context.colorScheme.onSurface,
                    titleColor: context.colorScheme.onSurface,
                  ).addPadding(bottom: 4.0),
                  RowValueItemWidget(
                    title: context.tr.marginCurrency,
                    containerSize: 30.0,
                    subTitle: widget.item.marginCurrency,
                    subTitleWeight: FontWeight.w400,
                    titleWeight: FontWeight.w300,
                    subTitleColor: context.colorScheme.onSurface,
                    titleColor: context.colorScheme.onSurface,
                  ).addPadding(bottom: 4.0),
                  RowValueItemWidget(
                    title: context.tr.profitCurrency,
                    containerSize: 30.0,
                    subTitle: widget.item.profitCurrency,
                    subTitleWeight: FontWeight.w400,
                    titleWeight: FontWeight.w300,
                    subTitleColor: context.colorScheme.onSurface,
                    titleColor: context.colorScheme.onSurface,
                  ).addPadding(bottom: 4.0),
                  RowValueItemWidget(
                    title: context.tr.minimalVolume,
                    containerSize: 30.0,
                    subTitle: widget.item.volumeMin,
                    subTitleWeight: FontWeight.w400,
                    titleWeight: FontWeight.w300,
                    subTitleColor: context.colorScheme.onSurface,
                    titleColor: context.colorScheme.onSurface,
                  ).addPadding(bottom: 4.0),
                  RowValueItemWidget(
                    title: context.tr.maximalVolume,
                    containerSize: 30.0,
                    subTitle: widget.item.volumeMax,
                    subTitleWeight: FontWeight.w400,
                    titleWeight: FontWeight.w300,
                    subTitleColor: context.colorScheme.onSurface,
                    titleColor: context.colorScheme.onSurface,
                  ).addPadding(bottom: 4.0),
                  RowValueItemWidget(
                    title: context.tr.volumeStep,
                    containerSize: 30.0,
                    subTitle: widget.item.volumeStep,
                    subTitleWeight: FontWeight.w400,
                    titleWeight: FontWeight.w300,
                    subTitleColor: context.colorScheme.onSurface,
                    titleColor: context.colorScheme.onSurface,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
