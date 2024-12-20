import 'package:candle_chart/k_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

// ignore: must_be_immutable
class PickerColorWidget extends StatefulWidget {
  Color pickerColor;
  final ValueChanged<Color> onColorChanged;

  PickerColorWidget({
    super.key,
    required this.pickerColor,
    required this.onColorChanged,
  });

  @override
  State<PickerColorWidget> createState() => _PickerColorWidgetState();
}

class _PickerColorWidgetState extends State<PickerColorWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pickerAreaHeightPercent = (size.width * 0.7) / (size.height * 0.52);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: size.width * 0.9,
          height: size.height * 0.52,
          child: Material(
            borderRadius: BorderRadius.circular(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ColorPicker(
                  pickerAreaBorderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  pickerColor: widget.pickerColor,
                  onColorChanged: (value) {
                    widget.pickerColor = value;
                    // setState(() {});
                  },
                  colorPickerWidth: size.width * 0.9,
                  pickerAreaHeightPercent: pickerAreaHeightPercent,
                ),
                InkWell(
                  onTap: () {
                    widget.onColorChanged(widget.pickerColor);
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 8.0,
                    ),
                    child: Text(
                      'Done',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: KChartWidget.colors!.primary,
                          ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

void showPickerColor(
  BuildContext context, {
  required Color pickerColor,
  required ValueChanged<Color> onColorChanged,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return PickerColorWidget(
        pickerColor: pickerColor,
        onColorChanged: onColorChanged,
      );
    },
  );
}
