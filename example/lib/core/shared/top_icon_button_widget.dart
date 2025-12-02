import 'package:example/core/consts/exports.dart';

class TopIconButtonWidget extends StatelessWidget {
  final String icon;
  final Function onTap;
  final double height, width, iconSize;
  final Color? borderColor, backgroundColor;
  final String? title;
  final bool iconTransparent;
  const TopIconButtonWidget({
    super.key,
    required this.icon,
    required this.onTap,
    this.width = 50.0,
    this.iconSize = 21.0,
    this.height = 35.0,
    this.title,
    this.borderColor,
    this.backgroundColor,
    this.iconTransparent = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? context.colorScheme.surfaceContainer,
        borderRadius: MBorderRadius.set(all: 8.0),
        border: Border.all(color: borderColor ?? Colors.transparent),
      ),
      width: (title == null) ? width : width + 60,
      height: height,
      padding: const MPadding.set(vertical: 7.0),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null)
            MText(
              text: title,
              color: context.colorScheme.onSurface,
              size: FoontSize.font13,
              weight: FontWeight.w400,
            ).addPadding(horizontal: 8.0),
          MSvg(
            name: icon,
            color: iconTransparent ? null : context.colorScheme.onSurface,
            height: iconSize,
          ),
        ],
      ),
    ).addAction(onGesture: onTap);
  }
}
