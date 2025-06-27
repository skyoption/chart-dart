import 'package:example/core/consts/exports.dart';
import 'package:example/core/widgets/color_palette_widget.dart';

class ColorPickerWidget extends StatelessWidget {
  final String title;
  final Color defaultColor;
  final Function(Color color) onColorChanged;

  const ColorPickerWidget({
    super.key,
    required this.title,
    required this.defaultColor,
    required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      alignment: Alignment.center,
      margin: const MPadding.set(bottom: 12.0),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainer,
        borderRadius: MBorderRadius.set(all: 8.0),
      ),
      child: Row(
        children: [
          MText(
            text: title,
            size: FoontSize.font17,
            color: context.colorScheme.scrim,
            weight: FontWeight.w500,
          ).addPadding(bottom: 2, start: 12),
          const Spacer(),
          ColorPaletteWidget(
            onColorChanged: onColorChanged,
            defaultColor: defaultColor,
          ).addPadding(bottom: 2, end: 12),
        ],
      ),
    );
  }
}
