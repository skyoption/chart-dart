import 'package:candle_chart/k_chart_widget.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/widgets/top_bottom_sheet_widget.dart';
import 'package:example/features/chart/views/widgets/choose_timeframe_category_widget.dart';

// ignore: must_be_immutable
class ChooseTimeframeBottomSheet extends StatefulWidget {
  CandleTimeFormat timeframe;
  final Function(CandleTimeFormat timeframe) onChanged;

  ChooseTimeframeBottomSheet({
    super.key,
    required this.timeframe,
    required this.onChanged,
  });

  @override
  State<ChooseTimeframeBottomSheet> createState() =>
      _ChooseTimeframeBottomSheetState();
}

class _ChooseTimeframeBottomSheetState
    extends State<ChooseTimeframeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TopBottomSheetWidget(),
        MText(
          text: context.tr.timeframe,
          size: FoontSize.font21,
          color: context.colorScheme.onSurface,
          align: TextAlign.start,
          weight: FontWeight.w600,
        ).addPadding(horizontal: 21.0, bottom: 16.0),
        // ChooseTimeframeCategoryWidget(
        //   title: context.tr.seconds,
        //   items: const [CandleTimeFormat.S5],
        //   selected: widget.timeframe,
        //   onTap: (selected) {
        //     widget.timeframe = selected;
        //     setState(() {});
        //     widget.onChanged(selected);
        //     AutoRouterX(context).maybePop();
        //   },
        // ).addPadding(bottom: 12.0),
        ChooseTimeframeCategoryWidget(
          title: context.tr.minute,
          items: const [
            CandleTimeFormat.M1,
            CandleTimeFormat.M5,
            CandleTimeFormat.M15,
            CandleTimeFormat.M30
          ],
          selected: widget.timeframe,
          onTap: (selected) {
            widget.timeframe = selected;
            setState(() {});
            widget.onChanged(selected);
            AutoRouterX(context).pop();
          },
        ).addPadding(bottom: 12.0),
        ChooseTimeframeCategoryWidget(
          title: context.tr.hour,
          items: const [
            CandleTimeFormat.H1,
            CandleTimeFormat.H4,
          ],
          selected: widget.timeframe,
          onTap: (selected) {
            widget.timeframe = selected;
            setState(() {});
            widget.onChanged(selected);
            AutoRouterX(context).pop();
          },
        ).addPadding(bottom: 12.0),
        ChooseTimeframeCategoryWidget(
          title: context.tr.more,
          items: const [
            CandleTimeFormat.D1,
            CandleTimeFormat.W1,
            CandleTimeFormat.MN1,
          ],
          selected: widget.timeframe,
          onTap: (selected) {
            widget.timeframe = selected;
            setState(() {});
            widget.onChanged(selected);
            AutoRouterX(context).pop();
          },
        ),
      ],
    ).addPadding(bottom: 30.0);
  }
}

void showChooseTimeframeBottomSheet({
  required BuildContext context,
  required CandleTimeFormat timeframe,
  required Function(CandleTimeFormat timeframe) onChanged,
}) {
  showMBottomSheet(
    context: context,
    removeTransparentBackground: true,
    backgorundColor: context.colorScheme.scrim,
    bottomSheet: ChooseTimeframeBottomSheet(
      timeframe: timeframe,
      onChanged: onChanged,
    ),
  );
}
