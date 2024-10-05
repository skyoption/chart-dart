import 'package:candle_chart/objects/bottom_sheets/color_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IndicatorColorWidget extends StatefulWidget {
  final Function(Color color) onChange;
  final String title;

  final Color? color;

  const IndicatorColorWidget({
    super.key,
    required this.onChange,
    this.title = 'Style :',
    this.color,
  });

  @override
  State<IndicatorColorWidget> createState() => _IndicatorColorWidgetState();
}

class _IndicatorColorWidgetState extends State<IndicatorColorWidget> {
  late Color color = widget.color ?? Colors.blueAccent;
  int index = 0;

  @override
  void initState() {
    widget.onChange(color);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.2),
      padding: EdgeInsetsDirectional.symmetric(
        vertical: 12.0,
        horizontal: 12.0,
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
                      widget.onChange(color);
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
    );
  }
}
