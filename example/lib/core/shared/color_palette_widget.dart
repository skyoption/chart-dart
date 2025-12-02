import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:example/core/consts/exports.dart';

class ColorPaletteWidget extends StatelessWidget {
  final Color defaultColor;
  final List<Color> colors;
  final Function(Color color) onColorChanged;
  final String? svgIconPath;
  final IconData? iconData;
  const ColorPaletteWidget({
    super.key,
    this.colors = const [
      Colors.red,
      Colors.pink,
      Colors.purple,
      Colors.indigo,
      Colors.blue,
      Colors.lightBlue,
      Colors.cyan,
      Colors.teal,
      Colors.green,
      Colors.lightGreen,
      Colors.lime,
      Colors.yellow,
      Colors.amber,
      Colors.orange,
      Colors.deepOrange,
      Colors.red,
    ],
    required this.onColorChanged,
    required this.defaultColor,
    this.svgIconPath,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return ColorPickerDialog(
                pickerColor: defaultColor,
                onColorChanged: onColorChanged,
              );
            },
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
            gradient: SweepGradient(colors: colors),
          ),
          child: svgIconPath != null
              ? Center(
                  child: MSvg(
                    name: svgIconPath!,
                    color: Colors.white,
                    width: 16,
                    height: 16,
                  ),
                )
              : Icon(iconData ?? Icons.edit, size: 16, color: Colors.white),
        ),
      ),
    );
  }
}

class ColorPickerDialog extends StatefulWidget {
  final Color pickerColor;
  final void Function(Color pickedColor) onColorChanged;

  const ColorPickerDialog({
    super.key,
    required this.pickerColor,
    required this.onColorChanged,
  });

  @override
  State<ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  late Color pickedColor = widget.pickerColor;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 400,
        height: 620,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.tr.pickColor,
              style: TextStyle(
                fontSize: FoontSize.font18,
                fontWeight: FontWeight.w600,
                color: context.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: ColorPicker(
                  hexInputBar: true,
                  paletteType: PaletteType.hueWheel,
                  enableAlpha: false,
                  pickerColor: widget.pickerColor,
                  onColorChanged: (value) {
                    pickedColor = value;
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Directionality(
              textDirection: TextDirection.rtl,
              child: MBouncingButton(
                height: 50.0,
                title: context.tr.done,
                color: context.colorScheme.primary,
                titleStyle: TextStyle(
                  fontSize: FoontSize.font16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                onTap: () {
                  widget.onColorChanged(pickedColor);
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
