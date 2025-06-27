import 'package:candle_chart/k_chart_widget.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/features/chart/views/bottom_sheets/time_frame_bottom_sheet.dart';

class ChooseTimeframeWidget extends StatefulWidget {
  final CandleTimeFormat timeframe;
  final Function(CandleTimeFormat timeframe) onChanged;
  const ChooseTimeframeWidget({
    super.key,
    required this.onChanged,
    required this.timeframe,
  });

  @override
  State<ChooseTimeframeWidget> createState() => _ChooseTimeframeWidgetState();
}

class _ChooseTimeframeWidgetState extends State<ChooseTimeframeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceBright,
        borderRadius: MBorderRadius.set(all: 12.0),
      ),
      padding: const MPadding.set(all: 9.0),
      height: 45.0,
      width: 45.0,
      alignment: Alignment.center,
      child: MText(
        text: widget.timeframe.name,
        weight: FontWeight.w400,
        size: FoontSize.font14,
        color: context.colorScheme.scrim,
      ),
    ).addAction(
      onGesture: () {
        showChooseTimeframeBottomSheet(
          context: context,
          timeframe: widget.timeframe,
          onChanged: widget.onChanged,
        );
      },
    );
  }
}
