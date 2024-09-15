import 'package:candle_chart/functions/widgets/svg.dart';
import 'package:flutter/material.dart';

class ObjectItemWidget extends StatelessWidget {
  final String icon, title;
  final Function onTap;
  final double iconSize;

  const ObjectItemWidget({
    super.key,
    required this.icon,
    required this.title,
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
          vertical: 10.0,
          horizontal: 12.0,
        ),
        margin: EdgeInsets.only(bottom: 6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 30.0,
                  margin: EdgeInsetsDirectional.only(end: 12.0),
                  child: MSvg(
                    name: icon,
                    width: iconSize,
                    height: iconSize,
                  ),
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios_sharp,
              size: 20.0,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
