import 'package:flutter/cupertino.dart';
import 'package:example/core/consts/exports.dart';

class CupertinoCustomSlidingSegmentedControl extends StatefulWidget {
  final Function(int) onChange;
  final List<String> options;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;

  const CupertinoCustomSlidingSegmentedControl({
    super.key,
    required this.onChange,
    required this.options,
    this.padding,
    this.fontSize,
    this.backgroundColor = AppColors.highLight,
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
        padding: widget.padding ??
            const MPadding.set(
              vertical: 3.0,
              horizontal: 4.0,
            ),
        child: Text(
          widget.options[i],
          style: TextStyle(
            color: _selectedSegment == i
                ? AppColors.white
                : context.colorScheme.onSurface,
            fontSize: widget.fontSize ?? 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _set();
    return MScroll(
      axis: Axis.horizontal,
      child: CupertinoSlidingSegmentedControl<int>(
        backgroundColor: context.colorScheme.surfaceContainer,
        thumbColor: context.colorScheme.primary,
        padding: const MPadding.set(horizontal: 8.0, vertical: 6.0),
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
    );
  }
}
