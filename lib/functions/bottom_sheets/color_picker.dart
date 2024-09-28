import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 320.0,
          height: 410.0,
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
                  colorPickerWidth: 320.0,
                  pickerAreaHeightPercent: 0.6,
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
                            color: Colors.blueAccent,
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
