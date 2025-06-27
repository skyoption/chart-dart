import 'package:example/core/consts/exports.dart';

class BottomSheetItemWidget extends StatelessWidget {
  final String title;
  final String? icon;
  final String? suffix;
  final double? iconSize;
  final Color? color;
  final Function onTap;
  final bool isDivider;

  const BottomSheetItemWidget({
    super.key,
    required this.title,
    this.color,
    required this.onTap,
    this.iconSize,
    this.icon,
    this.suffix,
    this.isDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pop();
        onTap();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (icon != null)
                    MSvg(
                      name: icon,
                      color: color ?? context.colorScheme.scrim,
                      height: iconSize ?? 21.0,
                    ).addPadding(end: 16.0),
                  MText(
                    text: title,
                    color: color ?? context.colorScheme.scrim,
                    size: FoontSize.font16,
                    weight: FontWeight.w400,
                  ),
                ],
              ),
              if (suffix != null)
                MSvg(
                  name: suffix,
                  color: color ?? context.colorScheme.scrim,
                  height: iconSize ?? 21.0,
                ),
            ],
          ),
          if (isDivider)
            MDividerItemWidget(
              color: context.colorScheme.outline,
              padding: const MPadding.set(vertical: 21.0),
            ),
        ],
      ),
    );
  }
}
