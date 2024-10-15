import 'package:candle_chart/objects/widgets/svg.dart';
import 'package:flutter/material.dart';

class PropertiesItemWidget extends StatelessWidget {
  final String? subTitle;
  final String title;
  final Function? onTap;
  final Color subTitleColor, titleColor;
  final EdgeInsetsGeometry? margin;
  final Widget? child;
  final double? height;

  const PropertiesItemWidget({
    super.key,
    required this.title,
    this.subTitle,
    this.onTap,
    this.margin,
    this.child,
    this.height,
    this.subTitleColor = Colors.blueAccent,
    this.titleColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        height: height,
        color: Colors.grey.withOpacity(0.2),
        padding: EdgeInsetsDirectional.symmetric(
          vertical: 16.0,
          horizontal: 12.0,
        ),
        margin: margin ?? EdgeInsets.only(bottom: 6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: titleColor,
                  ),
            ),
            if (child != null)
              child!
            else
              Row(
                children: [
                  if (subTitle != null)
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 10.0),
                      child: Text(
                        subTitle!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: subTitleColor,
                            ),
                      ),
                    ),
                  if (onTap != null)
                    Icon(
                      Icons.arrow_forward_ios_sharp,
                      size: 16.0,
                      color: Colors.black,
                    ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
