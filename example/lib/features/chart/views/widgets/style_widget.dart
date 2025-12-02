import 'package:candle_chart/k_chart_widget.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/features/chart/views/bottom_sheets/chart_style_bottom_sheet.dart';

class StyleWidget extends StatelessWidget {
  final ValueNotifier<GraphStyle> graphStyle;
  final Function(GraphStyle graphStyle) onGraphStyleChanged;
  final Function onGesture;

  const StyleWidget({
    super.key,
    required this.graphStyle,
    required this.onGraphStyleChanged,
    required this.onGesture,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<GraphStyle>(
      valueListenable: graphStyle,
      builder: (context, graphStyle, child) {
        return MSvg(
          name: Svgs.candles,
          width: 24.0,
          height: 24.0,
          color: context.colorScheme.onSurface,
        ).addAction(
          onGesture: () {
            onGesture();
            showChooseChartStyleBottomSheet(
              context: context,
              graphStyle: graphStyle,
              onGraphStyleChanged: (graphStyle) {
                this.graphStyle.value = graphStyle;
                onGraphStyleChanged(graphStyle);
              },
            );
          },
        );
      },
    );
  }
}
