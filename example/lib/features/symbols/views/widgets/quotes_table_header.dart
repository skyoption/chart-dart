import '../../../../../core/consts/exports.dart';

class QuotesTableHeader extends StatelessWidget {
  const QuotesTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      border: TableBorder(
          verticalInside: BorderSide(
        color: context.colorScheme.outline,
      )),
      columnWidths: const {
        0: FlexColumnWidth(4),
        1: FlexColumnWidth(4),
        2: FlexColumnWidth(4),
        3: FlexColumnWidth(2.5),
        4: FlexColumnWidth(2.5),
        5: FlexColumnWidth(3),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: context.colorScheme.primaryContainer,
            borderRadius: MBorderRadius.set(all: 10),
            border: Border.all(
              color: context.colorScheme.outline,
            ),
          ),
          children: [
            TableCell(
              child: MText(
                text: context.tr.symbol,
                color: context.colorScheme.scrim,
                weight: FontWeight.w400,
                size: FoontSize.font13,
                align: TextAlign.center,
              ).addPadding(vertical: 18),
            ),
            TableCell(
              child: MText(
                text: context.tr.ask,
                color: context.colorScheme.scrim,
                weight: FontWeight.w400,
                size: FoontSize.font13,
                align: TextAlign.center,
              ).addPadding(vertical: 18),
            ),
            TableCell(
              child: MText(
                text: context.tr.bid,
                color: context.colorScheme.scrim,
                weight: FontWeight.w400,
                size: FoontSize.font13,
                align: TextAlign.center,
              ).addPadding(vertical: 18),
            ),
            TableCell(
              child: MText(
                text: context.tr.spread,
                color: context.colorScheme.scrim,
                weight: FontWeight.w400,
                size: FoontSize.font13,
                align: TextAlign.center,
              ).addPadding(vertical: 18),
            ),
            TableCell(
              child: MText(
                text: context.tr.change,
                color: context.colorScheme.scrim,
                weight: FontWeight.w400,
                size: FoontSize.font13,
                align: TextAlign.center,
              ).addPadding(vertical: 18),
            ),
            TableCell(
              child: MText(
                text: context.tr.time,
                color: context.colorScheme.scrim,
                weight: FontWeight.w400,
                size: FoontSize.font13,
                align: TextAlign.center,
              ).addPadding(vertical: 18),
            ),
          ],
        )
      ],
    );
  }
}
