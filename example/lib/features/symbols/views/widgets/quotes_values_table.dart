import 'package:example/core/consts/exports.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';
import 'package:example/features/symbols/views/widgets/quote_slogo_item_widget.dart';

import '../bottom_sheets/quote_bottom_sheet.dart';

class QuotesValuesTable extends StatelessWidget {
  final List<SymbolEntity> items;

  const QuotesValuesTable({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: MBorderRadius.set(all: 10),
        border: Border.all(
          color: Coolors.grey.withValues(alpha: 0.3),
        ),
      ),
      child: ClipRRect(
        borderRadius: MBorderRadius.set(all: 8.0),
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          border: TableBorder(
              verticalInside: BorderSide(
            color: Coolors.grey.withValues(alpha: 0.3),
          )),
          columnWidths: const {
            0: FlexColumnWidth(4),
            1: FlexColumnWidth(4),
            2: FlexColumnWidth(4),
            3: FlexColumnWidth(2.5),
            4: FlexColumnWidth(2.5),
            5: FlexColumnWidth(3),
          },
          children: items.map((item) {
            return TableRow(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Coolors.grey.withValues(alpha: 0.15),
                ),
              ),
              children: [
                TableRowInkWell(
                  onTap: () {
                    showQuoteBottomSheet(
                      context: context,
                      symbol: item,
                    );
                  },
                  child: Row(
                    children: [
                      QuoteSlogoItemWidget(
                        height: 40.0,
                        item: item,
                      ),
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: ValueListenableBuilder(
                          valueListenable: item.isFavChange,
                          builder: (context, value, child) {
                            return MSvg(
                              name: Svgs.fav,
                              color: value
                                  ? AppColors.orange
                                  : context.colorScheme.onSurface,
                              height: 21.0,
                              width: 21.0,
                            ).addAction(
                              onGesture: () {
                                context
                                    .read<QuotesCubit>()
                                    .setFav(item, !value);
                              },
                              padding: const MPadding.set(end: 3.0, start: 6.0),
                            );
                          },
                        ),
                      ),
                      Row(
                        children: [
                          // const TableCurrenciesItemWidget(
                          //   images: [
                          //     image,
                          //     image,
                          //   ],
                          // ),
                          MText(
                            text: item.symbol,
                            color: context.colorScheme.scrim,
                            weight: FontWeight.w400,
                            size: FoontSize.font12,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                TableCell(
                  child: ValueListenableBuilder(
                    valueListenable: item.askChange,
                    builder: (context, value, child) {
                      return MText(
                        text: value.toStringAsFixed(item.digits),
                        color: item.askColor.value,
                        weight: FontWeight.w400,
                        size: FoontSize.font13,
                        align: TextAlign.center,
                      );
                    },
                  ).addPadding(vertical: 18),
                ),
                TableCell(
                  child: ValueListenableBuilder(
                    valueListenable: item.bidChange,
                    builder: (context, value, child) {
                      return MText(
                        text: value.toStringAsFixed(item.digits),
                        color: item.bidColor.value,
                        weight: FontWeight.w400,
                        size: FoontSize.font13,
                        align: TextAlign.center,
                      );
                    },
                  ).addPadding(vertical: 18),
                ),
                TableCell(
                  child: MText(
                    text: context.tr.noValue,
                    color: context.colorScheme.scrim,
                    weight: FontWeight.w400,
                    size: FoontSize.font13,
                    align: TextAlign.center,
                  ).addPadding(vertical: 18),
                ),
                TableCell(
                  child: Column(
                    children: [
                      MText(
                        text: '+320',
                        color: AppColors.green,
                        weight: FontWeight.w400,
                        size: FoontSize.font13,
                        align: TextAlign.center,
                      ).addPadding(vertical: 5),
                      MText(
                        text: '+0.1%',
                        color: AppColors.green,
                        weight: FontWeight.w400,
                        size: FoontSize.font13,
                        align: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                TableCell(
                  child: ValueListenableBuilder(
                    valueListenable: item.dateTime,
                    builder: (context, value, child) {
                      return MText(
                        text: value.toLastTimeOnly,
                        color: context.colorScheme.scrim,
                        weight: FontWeight.w400,
                        size: FoontSize.font13,
                        align: TextAlign.center,
                      );
                    },
                  ).addPadding(vertical: 18),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
