import 'package:example/core/consts/exports.dart';

class StatusWidget extends StatelessWidget {
  final Color color;
  final String? title, icon;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final double? iconSize;
  final double? width, height;
  final BorderRadiusGeometry? borderRadius;

  const StatusWidget({
    super.key,
    required this.color,
    this.title,
    this.icon,
    this.padding,
    this.textStyle,
    this.iconSize,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius ?? MBorderRadius.set(all: 4.0),
      ),
      padding: padding ?? MPadding.set(horizontal: 8.0, vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            MSvg(
              name: icon,
              width: iconSize ?? 14.0,
              height: iconSize ?? 14.0,
              color: Colors.white,
            ).addPadding(end: 5.0),
          if (title != null)
            MText(
              text: title,
              size: FoontSize.font12,
              color: Colors.white,
              weight: FontWeight.w400,
              style: textStyle,
            ),
        ],
      ),
    );
  }
}
