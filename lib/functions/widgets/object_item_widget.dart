import 'package:candle_chart/functions/widgets/svg.dart';
import 'package:flutter/material.dart';

class ObjectItemWidget extends StatelessWidget {
  final String? icon, title;
  final Function onTap;
  final double? iconSize;
  final Widget? child;
  final Color? color;

  const ObjectItemWidget({
    super.key,
    this.icon,
    this.title,
    this.child,
    this.color,
    required this.onTap,
    this.iconSize = 25.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        color: Colors.grey.withOpacity(0.2),
        padding: EdgeInsetsDirectional.symmetric(
          vertical: 16.0,
          horizontal: 21.0,
        ),
        margin: EdgeInsets.only(bottom: 6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (iconSize != null && icon != null)
                  Container(
                    width: iconSize! + 5,
                    margin: EdgeInsetsDirectional.only(end: 12.0),
                    child: MSvg(
                      name: icon,
                      width: iconSize,
                      height: iconSize,
                    ),
                  ),
                Text(
                  title!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: color,
                      ),
                ),
              ],
            ),
            if (child != null) child!,
            if (child == null)
              Icon(
                Icons.arrow_forward_ios_sharp,
                size: 20.0,
                color: color ?? Colors.black,
              )
          ],
        ),
      ),
    );
  }
}
