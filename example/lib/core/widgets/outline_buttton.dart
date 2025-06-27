import 'package:example/core/consts/exports.dart';

class MOutlineButton extends StatelessWidget {
  final double width, height, radius;
  final Color textColor, borderColor, iconColor;
  final double titleSize;
  final String? icon, title;
  final Function onTap;

  const MOutlineButton({
    super.key,
    this.width = 120.0,
    this.height = 60.0,
    this.radius = 16.0,
    this.borderColor = Coolors.black,
    this.textColor = Coolors.black,
    this.iconColor = Coolors.black,
    this.icon,
    this.title,
    this.titleSize = 20.0,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: MBorderRadius.set(all: radius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            MSvg(
              name: icon,
              color: iconColor,
              height: 20.0,
            ).addPadding(end: 12.0),
          if (title != null)
            MText(
              text: title,
              color: textColor,
              weight: FontWeight.w400,
              size: titleSize,
            ),
        ],
      ),
    ).addAction(onGesture: onTap);
  }
}
