import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/objects/bottom_sheets/color_picker.dart';
import 'package:candle_chart/widgets/paddings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IndicatorColorWidget extends StatefulWidget {
  final Function(Color color, bool drawAsBackground) onChange;
  final String title;
  final bool? drawAsBackground, hideDrawAsBackground;
  final Color? color;

  const IndicatorColorWidget({
    super.key,
    required this.onChange,
    this.title = 'Style',
    this.color,
    this.drawAsBackground = false,
    this.hideDrawAsBackground = true,
  });

  @override
  State<IndicatorColorWidget> createState() => _IndicatorColorWidgetState();
}

class _IndicatorColorWidgetState extends State<IndicatorColorWidget> {
  late bool drawAsBackground = widget.drawAsBackground ?? false;
  late Color color = widget.color ?? Colors.blueAccent;
  int index = 0;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      widget.onChange(color, drawAsBackground);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 21.0,
      children: [
        Column(
          spacing: 6.0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: context.text.bodyMedium,
            ),
            GestureDetector(
              onTap: () {
                showPickerColor(
                  context,
                  pickerColor: color,
                  onColorChanged: (value) {
                    color = value;
                    setState(() {});
                    Future.delayed(Duration.zero, () {
                      widget.onChange(color, drawAsBackground);
                    });
                  },
                );
              },
              child: Container(
                height: 50.0,
                padding: MPadding.set(
                  horizontal: 16.0,
                ),
                decoration: BoxDecoration(
                  color: context.scheme.surfaceContainerHighest,
                  border: Border.all(color: context.scheme.outline),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    Container(
                      width: 30.0,
                      height: 30.0,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (widget.hideDrawAsBackground == false)
          Column(
            spacing: 6.0,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr.drawAsBackground,
                style: context.text.bodyMedium,
              ),
              GestureDetector(
                onTap: () => _onDrawAsBackgroundChanged(!drawAsBackground),
                child: Container(
                  height: 50.0,
                  padding: MPadding.set(start: 16.0, end: 4.0),
                  decoration: BoxDecoration(
                    color: context.scheme.surfaceContainerHighest,
                    border: Border.all(color: context.scheme.outline),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.tr.drawAsBackground,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      SizedBox(
                        height: 18.0,
                        child: Transform.scale(
                          scale: 0.7,
                          child: CupertinoSwitch(
                            value: drawAsBackground,
                            onChanged: _onDrawAsBackgroundChanged,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
      ],
    );
  }

  void _onDrawAsBackgroundChanged(bool value) {
    drawAsBackground = value;
    setState(() {});
    Future.delayed(Duration.zero, () {
      widget.onChange(color, drawAsBackground);
    });
  }
}
