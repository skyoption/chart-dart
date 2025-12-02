import 'package:example/core/consts/exports.dart';

class OptionItemWidget extends StatelessWidget {
  final String? title;
  final String? svgIconPath;
  final Widget? icon;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? backgroundColor, selectedColor, slugColor;
  final Widget? child;
  const OptionItemWidget({
    super.key,
    this.title,
    this.svgIconPath,
    this.backgroundColor,
    required this.isSelected,
    required this.onTap,
    this.icon,
    this.child,
    this.selectedColor,
    this.slugColor,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      color: isSelected
          ? selectedColor ?? context.colorScheme.inversePrimary
          : Colors.transparent,
      padding: MPadding.set(all: 12.0),
      child: child ??
          Row(
            children: [
              Container(
                width: 2,
                height: 35.0,
                color: slugColor ?? context.colorScheme.primary,
                margin: MPadding.set(end: 12.0),
              ),
              if (icon != null) icon!,
              if (svgIconPath != null)
                SizedBox(
                  width: 34.0,
                  height: 34.0,
                  child: Center(
                    child: MSvg(
                      name: svgIconPath!,
                      width: 20.0,
                      height: 20.0,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ).addPadding(end: 12.0),
              if (title != null)
                Expanded(
                  child: MText(
                    text: title,
                    size: FoontSize.font16,
                    weight: FontWeight.w400,
                    color: context.colorScheme.onSurface,
                  ),
                ),
            ],
          ),
    ).addAction(onGesture: onTap);
  }
}
