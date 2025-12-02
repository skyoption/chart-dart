import 'package:example/core/consts/exports.dart';

class ColumnValueItemWidget extends StatelessWidget {
  final String title;
  final dynamic subTitle;
  final CrossAxisAlignment? axisAlignment;
  final double iconSize, subTitleFontSize, titleFontSize;
  final FontWeight subTitleWeight, titleWeight;
  final Color? subTitleColor, titleColor, iconColor;
  final Widget? child, subChild, suffixSubChild, suffixChild;
  final TextDecoration subDecoration;
  final bool titleIsRisky, subTitleIsRisky;
  final String? icon;

  const ColumnValueItemWidget({
    super.key,
    required this.title,
    required this.subTitle,
    this.axisAlignment,
    this.suffixSubChild,
    this.suffixChild,
    this.iconColor,
    this.subChild,
    this.child,
    this.icon,
    this.iconSize = 13.0,
    this.titleFontSize = 16.0,
    this.subTitleFontSize = 14.0,
    this.subTitleWeight = FontWeight.w300,
    this.titleWeight = FontWeight.w500,
    this.subTitleColor,
    this.titleColor,
    this.subDecoration = TextDecoration.none,
    this.subTitleIsRisky = false,
    this.titleIsRisky = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: axisAlignment ?? CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (titleIsRisky)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: title.split('/').asMap().entries.map((item) {
                  return MText(
                    text: '${item.key == 1 ? '/' : ''}${item.value}',
                    size: titleFontSize,
                    color: titleIsRisky && item.key == 0
                        ? int.parse(item.value) <
                                (int.parse(title.split('/')[1]) * 0.5)
                            ? context.colorScheme.success
                            : int.parse(item.value) <
                                    (int.parse(title.split('/')[1]) * 0.75)
                                ? context.colorScheme.secondaryFixedDim
                                : context.colorScheme.error
                        : titleColor ?? context.colorScheme.onSurface,
                    weight: titleWeight,
                  );
                }).toList(),
              ).addPadding(bottom: 4.0)
            else
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (child != null) child!,
                  Flexible(
                    child: MText(
                      text: title,
                      size: titleFontSize,
                      color: titleColor ?? context.colorScheme.onSurface,
                      weight: titleWeight,
                    ),
                  ),
                  if (suffixChild != null) suffixChild!,
                ],
              ).addPadding(bottom: 4.0),
            if (icon != null)
              MSvg(
                name: icon,
                width: iconSize,
                height: iconSize,
                color: iconColor,
              ).addPadding(start: 4.0),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (subChild != null) subChild!,
            Flexible(
              child: subTitleIsRisky
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ...subTitle.split('/').asMap().entries.map((item) {
                          return MText(
                            text: '${item.key == 1 ? '/' : ''}${item.value}',
                            size: subTitleFontSize,
                            color: subTitleIsRisky && item.key == 0
                                ? int.parse(item.value) <
                                        (int.parse(subTitle.split('/')[1]) *
                                            0.5)
                                    ? context.colorScheme.success
                                    : int.parse(item.value) <
                                            (int.parse(subTitle.split('/')[1]) *
                                                0.75)
                                        ? context.colorScheme.secondaryFixedDim
                                        : context.colorScheme.error
                                : subTitleColor ??
                                    context.colorScheme.onSurface,
                            weight: subTitleWeight,
                          );
                        }),
                      ],
                    )
                  : MText(
                      text: subTitle.toString(),
                      size: subTitleFontSize,
                      weight: subTitleWeight,
                      decoration: subDecoration,
                      color: subTitleColor ?? context.colorScheme.onSurface,
                    ),
            ),
            if (suffixSubChild != null) suffixSubChild!,
          ],
        ),
      ],
    );
  }
}
