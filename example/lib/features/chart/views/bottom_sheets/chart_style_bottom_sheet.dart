import 'package:candle_chart/k_chart_widget.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/widgets/radio_item_widget.dart';
import 'package:example/core/widgets/top_bottom_sheet_widget.dart';

class ChooseChartStyleBottomSheet extends StatefulWidget {
  final GraphStyle graphStyle;
  final Function(GraphStyle graphStyle) onGraphStyleChanged;

  const ChooseChartStyleBottomSheet({
    super.key,
    required this.graphStyle,
    required this.onGraphStyleChanged,
  });

  @override
  State<ChooseChartStyleBottomSheet> createState() =>
      _ChooseChartStyleBottomSheetState();
}

class _ChooseChartStyleBottomSheetState
    extends State<ChooseChartStyleBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TopBottomSheetWidget(),
        MText(
          text: context.tr.graphStyle,
          size: FoontSize.font21,
          color: context.colorScheme.scrim,
          align: TextAlign.start,
          weight: FontWeight.w600,
        ).addPadding(horizontal: 21.0, bottom: 16.0),
        RadioItemWidget(
          title: context.tr.area,
          icon: MSvg(
            name: Svgs.area,
            width: 18.0,
            height: 18.0,
            color: context.colorScheme.scrim,
          ).addPadding(end: 8.0),
          index: 0,
          groupIndex: widget.graphStyle.index,
          onTap: () {
            context.pop();
            widget.onGraphStyleChanged(GraphStyle.area);
          },
        ),
        RadioItemWidget(
          title: context.tr.candles,
          icon: MSvg(
            name: Svgs.candle,
            width: 21.0,
            height: 21.0,
            color: context.colorScheme.scrim,
          ).addPadding(end: 8.0),
          index: 1,
          groupIndex: widget.graphStyle.index,
          onTap: () {
            context.pop();
            widget.onGraphStyleChanged(GraphStyle.candles);
          },
        ),
        RadioItemWidget(
          title: context.tr.line,
          icon: MSvg(
            name: Svgs.chart,
            width: 21.0,
            height: 21.0,
            color: context.colorScheme.scrim,
          ).addPadding(end: 8.0),
          index: 2,
          groupIndex: widget.graphStyle.index,
          onTap: () {
            context.pop();
            widget.onGraphStyleChanged(GraphStyle.line);
          },
        ),
      ],
    ).addPadding(bottom: 30.0);
  }
}

void showChooseChartStyleBottomSheet({
  required BuildContext context,
  required GraphStyle graphStyle,
  required Function(GraphStyle graphStyle) onGraphStyleChanged,
}) {
  showMBottomSheet(
    context: context,
    removeTransparentBackground: true,
    backgorundColor: context.colorScheme.primaryContainer,
    bottomSheet: ChooseChartStyleBottomSheet(
      graphStyle: graphStyle,
      onGraphStyleChanged: onGraphStyleChanged,
    ),
  );
}
