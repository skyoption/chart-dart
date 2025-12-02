import 'package:example/core/shared/color_palette_widget.dart';

import '../../../../core/consts/exports.dart';

class TradingColorPickerWidget extends StatelessWidget {
  final String title;
  final Color lightDefaultColor;
  final Color darkDefaultColor;
  final Function(Color color) onLightColorChange;
  final Function(Color color) onDarkColorChanged;

  const TradingColorPickerWidget({
    super.key,
    required this.title,
    required this.lightDefaultColor,
    required this.darkDefaultColor,
    required this.onLightColorChange,
    required this.onDarkColorChanged,
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
        border: Border.all(color: context.colorScheme.outline),
      ),
      child: Row(
        children: [
          MText(
            text: title,
            size: FoontSize.font17,
            color: context.colorScheme.onSurface,
            weight: FontWeight.w500,
          ).addPadding(start: 12),
          const Spacer(),
          ColorPaletteWidget(
            svgIconPath: Svgs.lightMode,
            onColorChanged: onLightColorChange,
            defaultColor: lightDefaultColor,
          ).addPadding(end: 12),
          ColorPaletteWidget(
            svgIconPath: Svgs.darkMode,
            onColorChanged: onDarkColorChanged,
            defaultColor: darkDefaultColor,
          ).addPadding(end: 12),
        ],
      ),
    );
  }
}
