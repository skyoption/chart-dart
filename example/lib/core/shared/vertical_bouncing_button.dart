import 'package:example/core/consts/exports.dart';

enum VButtonType { outline, filled }

class VBouncingButton extends StatelessWidget {
  final double width, height, radius;
  final Color textColor, color, iconColor;
  final double titleSize;
  final String? icon, title;
  final Function onTap;
  final TextStyle? titleStyle;
  final VButtonType type;
  final Gradient? gradient;
  const VBouncingButton({
    super.key,
    this.width = 140.0,
    this.height = 70.0,
    this.radius = 8.0,
    this.color = Coolors.blue,
    this.textColor = Coolors.white,
    this.iconColor = Coolors.white,
    this.icon,
    this.title,
    this.titleStyle,
    this.titleSize = 14.0,
    required this.onTap,
    this.type = VButtonType.filled,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: type == VButtonType.outline ? Border.all(color: color) : null,
        color: type == VButtonType.filled ? color : null,
        borderRadius: MBorderRadius.set(all: radius),
        gradient: gradient,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) MSvg(name: icon, color: iconColor, height: 20.0),
          if (title != null)
            MText(
              text: title,
              color: textColor,
              weight: FontWeight.w400,
              size: titleSize,
              style: titleStyle,
            ),
        ],
      ),
    ).addAction(onGesture: onTap);
  }
}
