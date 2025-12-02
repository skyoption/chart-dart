// ignore_for_file: must_be_immutable

import 'package:example/core/consts/exports.dart';
import 'package:example/core/shared/slug_widget.dart';

class BottomSheetItemWidget extends StatelessWidget {
  final String title;
  final String? icon, description;
  final String? suffix;
  final Widget? suffixWidget, prefixWidget;
  final double? iconSize;
  Color? color, slugColor, selectedColor;
  final Function onTap;
  final bool isSelected;

  BottomSheetItemWidget({
    super.key,
    required this.title,
    this.description,
    this.color,
    this.slugColor,
    this.selectedColor,
    required this.onTap,
    this.iconSize,
    this.prefixWidget,
    this.suffixWidget,
    this.isSelected = false,
    this.icon,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    color ??= context.colorScheme.onSurface;
    return Container(
      color: isSelected
          ? selectedColor ?? context.colorScheme.surfaceContainerLowest
          : context.colorScheme.scrim,
      padding: const MPadding.set(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                SlugWidget(
                  color: slugColor,
                  height: description != null ? 65.0 : 38.0,
                ),
                if (icon != null)
                  MSvg(
                    name: icon,
                    color: color,
                    height: iconSize ?? 21.0,
                  ).addPadding(end: 12.0),
                if (prefixWidget != null) prefixWidget!,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MText(
                        text: title,
                        color: color!,
                        size: FoontSize.font17,
                        weight: FontWeight.w400,
                      ),
                      if (description != null)
                        MText(
                          text: description,
                          color: context.colorScheme.onSurfaceVariant,
                          size: FoontSize.font13,
                          weight: FontWeight.w300,
                        ).addPadding(top: 6.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (suffix != null)
            MSvg(name: suffix, color: color, height: iconSize ?? 24.0),
          if (suffixWidget != null) suffixWidget!,
        ],
      ),
    ).addAction(onGesture: onTap);
  }
}
