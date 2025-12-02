import 'package:example/core/consts/exports.dart';

class RadioItemWidget extends StatelessWidget {
  final String? title;
  final int index, groupIndex;
  final Widget? icon;
  final Function onTap;
  final bool enableSecondaryStyle;
  final bool showDivider;
  final Color? radioColor;
  final Color? textColor;
  const RadioItemWidget({
    super.key,
    this.title,
    required this.index,
    required this.groupIndex,
    required this.onTap,
    this.icon,
    this.enableSecondaryStyle = false,
    this.showDivider = true,
    this.radioColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return enableSecondaryStyle ? secondary(context) : normal(context);
  }

  Widget normal(BuildContext context) {
    return Column(
      children: [
        if (showDivider) MDividerItemWidget(color: context.colorScheme.outline),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (icon != null) icon!,
                MText(
                  text: title,
                  size: FoontSize.font16,
                  weight: FontWeight.w500,
                  color: textColor ?? context.colorScheme.onSurface,
                ).addPadding(end: 12.0),
              ],
            ),
            Container(
              width: 21.0,
              height: 21.0,
              decoration: BoxDecoration(
                border: Border.all(
                  color: radioColor ?? context.colorScheme.primary,
                ),
                shape: BoxShape.circle,
              ),
              padding: MPadding.set(all: 2.0),
              child: index == groupIndex
                  ? Container(
                      width: 19.0,
                      height: 19.0,
                      decoration: BoxDecoration(
                        color: radioColor ?? context.colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                    )
                  : null,
            ),
          ],
        ).addPadding(vertical: 2.0, horizontal: 21.0),
      ],
    ).addAction(onGesture: () => onTap());
  }

  Widget secondary(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 21.0,
              height: 21.0,
              decoration: BoxDecoration(
                border: Border.all(
                  color: radioColor ?? context.colorScheme.primary,
                ),
                shape: BoxShape.circle,
              ),
              padding: MPadding.set(all: 2.0),
              child: index == groupIndex
                  ? Container(
                      width: 19.0,
                      height: 19.0,
                      decoration: BoxDecoration(
                        color: radioColor ?? context.colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                    )
                  : null,
            ),
            Row(
              children: [
                if (title != null)
                  MText(
                    text: title,
                    size: FoontSize.font16,
                    weight: FontWeight.w500,
                    color: textColor ?? context.colorScheme.onSurface,
                  ).addPadding(end: 12.0),
                if (icon != null) icon!,
              ],
            ).addPadding(start: 8),
          ],
        ).addPadding(vertical: 2.0, horizontal: title != null ? 21.0 : 0),
      ],
    ).addAction(onGesture: () => onTap());
  }
}
