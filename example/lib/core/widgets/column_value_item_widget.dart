import 'package:example/core/consts/exports.dart';

class ColumnValueItemWidget extends StatelessWidget {
  final String title, subTitle;
  final CrossAxisAlignment? axisAlignment;
  final double iconSize, containerSize, subTitleFontSize, titleFontSize;
  final FontWeight subTitleWeight, titleWeight;
  final Color? subTitleColor, titleColor;
  final Widget? subChild;
  final bool titleIsRisky;

  const ColumnValueItemWidget({
    super.key,
    required this.title,
    required this.subTitle,
    this.axisAlignment,
    this.subChild,
    this.iconSize = 26.0,
    this.titleFontSize = 16.0,
    this.subTitleFontSize = 14.0,
    this.containerSize = 50.0,
    this.subTitleWeight = FontWeight.w300,
    this.titleWeight = FontWeight.w500,
    this.subTitleColor,
    this.titleColor,
    this.titleIsRisky = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: axisAlignment ?? CrossAxisAlignment.start,
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
                        ? AppColors.primary
                        : int.parse(item.value) <
                                (int.parse(title.split('/')[1]) * 0.75)
                            ? AppColors.black
                            : AppColors.red
                    : titleColor ?? AppColors.black,
                weight: titleWeight,
              );
            }).toList(),
          ).addPadding(bottom: 2.0)
        else
          MText(
            text: title,
            size: titleFontSize,
            color: titleColor ?? context.colorScheme.scrim,
            weight: titleWeight,
          ).addPadding(bottom: 2.0),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (subChild != null) subChild!,
            MText(
              text: subTitle,
              size: subTitleFontSize,
              weight: subTitleWeight,
              color: subTitleColor ?? context.colorScheme.onSurface,
            ),
          ],
        ),
      ],
    );
  }
}
