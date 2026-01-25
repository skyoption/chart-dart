import 'package:candle_chart/indicators/widgets/cupertino_custom_sliding_segmented_control.dart';
import 'package:candle_chart/widgets/paddings.dart';
import 'package:flutter/material.dart';

class IndicatorInfoWidget extends StatefulWidget {
  final List<Widget> children;
  final List<String> options;
  const IndicatorInfoWidget(
      {super.key, required this.children, required this.options});

  @override
  State<IndicatorInfoWidget> createState() => _IndicatorInfoWidgetState();
}

class _IndicatorInfoWidgetState extends State<IndicatorInfoWidget> {
  final index = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CupertinoCustomSlidingSegmentedControl(
          options: widget.options,
          onChange: (value) {
            index.value = value;
          },
        ).addPadding(bottom: 16.0),
        ValueListenableBuilder(
          valueListenable: index,
          builder: (context, value, child) {
            return widget.children[index.value];
          },
        )
      ],
    );
  }

  @override
  void dispose() {
    index.dispose();
    super.dispose();
  }
}
