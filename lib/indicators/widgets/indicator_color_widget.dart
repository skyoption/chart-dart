import 'package:candle_chart/objects/bottom_sheets/color_picker.dart';
import 'package:candle_chart/objects/widgets/properties_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IndicatorColorWidget extends StatefulWidget {
  final Function(Color color, bool drawAsBackground) onChange;
  final String title;
  final bool drawAsBackground, hideDrawAsBackground;
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

  late bool drawAsBackground = widget.drawAsBackground;
  late Color color = widget.color ?? Colors.blueAccent;
  int index = 0;

  @override
  void initState() {
    widget.onChange(color, drawAsBackground);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.grey.withOpacity(0.2),
          padding: EdgeInsetsDirectional.symmetric(
            vertical: 12.0,
            horizontal: 16.0,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showPickerColor(
                        context,
                        pickerColor: color,
                        onColorChanged: (value) {
                          color = value;
                          setState(() {});
                          widget.onChange(color, drawAsBackground);
                        },
                      );
                    },
                    child: Container(
                      width: 30.0,
                      height: 30.0,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (!widget.hideDrawAsBackground)
          Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
        if (!widget.hideDrawAsBackground)
          PropertiesItemWidget(
            height: 55.0,
            title: 'Draw as background',
            child: SizedBox(
              height: 18.0,
              child: Transform.scale(
                scale: 0.7,
                child: CupertinoSwitch(
                  value: drawAsBackground,
                  activeColor: Colors.blueAccent,
                  onChanged: (value) {
                    drawAsBackground = !drawAsBackground;
                    setState(() {});
                    widget.onChange(
                      color,
                      drawAsBackground,
                    );
                  },
                ),
              ),
            ),
          ),
      ],
    );
  }
}
