import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/widgets/paddings.dart';
import 'package:flutter/cupertino.dart';

class CupertinoCustomSlidingSegmentedControl extends StatefulWidget {
  final Function(int) onChange;
  final List<String> options;
  const CupertinoCustomSlidingSegmentedControl({
    super.key,
    required this.onChange,
    required this.options,
  });

  @override
  State<CupertinoCustomSlidingSegmentedControl> createState() =>
      _CupertinoCustomSlidingSegmentedControlState();
}

class _CupertinoCustomSlidingSegmentedControlState
    extends State<CupertinoCustomSlidingSegmentedControl> {
  int _selectedSegment = 0;
  Map<int, Widget> map = {};

  void _set() {
    for (int i = 0; i < widget.options.length; i++) {
      map[i] = Padding(
        padding: const MPadding.set(vertical: 6.0, horizontal: 4.0),
        child: Text(
          widget.options[i],
          style: context.text.bodyMedium!.copyWith(
            color: _selectedSegment == i
                ? context.scheme.onPrimary
                : context.scheme.onSurfaceVariant,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _set();
    return Row(
      children: [
        Expanded(
          child: CupertinoSlidingSegmentedControl<int>(
            backgroundColor: context.scheme.surfaceContainerLow,
            thumbColor: context.scheme.primary,
            // This represents the currently selected segmented control.
            groupValue: _selectedSegment,
            // Callback that sets the selected segmented control.
            onValueChanged: (int? value) {
              if (value != null) {
                _selectedSegment = value;
                setState(() {});
                widget.onChange(value);
              }
            },
            children: map,
          ),
        ),
      ],
    );
  }
}
