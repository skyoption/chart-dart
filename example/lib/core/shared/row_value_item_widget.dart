import 'package:example/app.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/mtoast.dart';

class RowValueItemWidget extends StatelessWidget {
  final String title;
  final dynamic subTitle;
  final MainAxisAlignment? axisAlignment;
  final double iconSize, containerSize, subTitleFontSize, titleFontSize;
  final FontWeight subTitleWeight, titleWeight;
  final Color? subTitleColor, titleColor;
  final bool canCopySubtitle, disableBottomPadding, titleIsRisky;
  final Widget? subtitleIcon;
  final bool ellipsisSubtitle;
  final int subTitleMaxChars;
  final bool ellipsisTitle;
  final int titleMaxChars;
  final TextDecoration subTitleDecoration;
  final Color? subTitleDecorationColor;
  const RowValueItemWidget({
    super.key,
    required this.title,
    this.subTitle,
    this.axisAlignment,
    this.iconSize = 26.0,
    this.titleFontSize = 16.0,
    this.subTitleFontSize = 14.0,
    this.containerSize = 50.0,
    this.subTitleWeight = FontWeight.w300,
    this.titleWeight = FontWeight.w500,
    this.subTitleColor,
    this.titleColor,
    this.canCopySubtitle = false,
    this.titleIsRisky = false,
    this.subtitleIcon,
    this.disableBottomPadding = false,
    this.ellipsisSubtitle = false,
    this.subTitleMaxChars = 20,
    this.ellipsisTitle = false,
    this.titleMaxChars = 20,
    this.subTitleDecoration = TextDecoration.none,
    this.subTitleDecorationColor,
  });

  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    MToast.showSuccess(message: SkyTrading.tr.copiedToClipboard);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: axisAlignment ?? MainAxisAlignment.spaceBetween,
      children: [
        if (ellipsisTitle)
          MText(
            text: title.length > titleMaxChars
                ? "${title.substring(0, titleMaxChars)}.."
                : title,
            size: titleFontSize,
            color: titleColor ?? context.colorScheme.onSurface,
            weight: titleWeight,
          )
        else
          MText(
            text: title,
            size: titleFontSize,
            color: titleColor ?? context.colorScheme.onSurface,
            weight: titleWeight,
          ),
        if (subTitle != null)
          Row(
            children: [
              if (canCopySubtitle)
                MSvg(
                  name: Svgs.copy,
                  width: 21.0,
                  height: 21.0,
                  color: context.colorScheme.primary,
                )
                    .addPadding(end: 8)
                    .addAction(onTap: () => copyToClipboard(subTitle)),
              if (subtitleIcon != null) subtitleIcon!.addPadding(end: 8),
              if (titleIsRisky)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...subTitle.split('/').asMap().entries.map((item) {
                      return MText(
                        text: '${item.key == 1 ? '/' : ''}${item.value}',
                        style: TextStyle(
                          fontSize: subTitleFontSize,
                          fontWeight: subTitleWeight,
                          color: titleIsRisky && item.key == 0
                              ? int.parse(item.value) <
                                      (int.parse(subTitle.split('/')[1]) * 0.5)
                                  ? context.colorScheme.success
                                  : int.parse(item.value) <
                                          (int.parse(subTitle.split('/')[1]) *
                                              0.75)
                                      ? context.colorScheme.secondaryFixedDim
                                      : context.colorScheme.error
                              : subTitleColor ?? context.colorScheme.onSurface,
                          decoration: subTitleDecoration,
                          decorationColor: subTitleDecorationColor ??
                              context.colorScheme.onSurface,
                        ),
                      );
                    }),
                  ],
                )
              else if (ellipsisSubtitle)
                MText(
                  text: subTitle.toString().length > subTitleMaxChars
                      ? "${subTitle.toString().substring(0, subTitleMaxChars)}.."
                      : subTitle.toString(),
                  size: subTitleFontSize,
                  weight: subTitleWeight,
                  color: subTitleColor ?? context.colorScheme.onSurface,
                )
              else
                MText(
                  text: subTitle.toString(),
                  size: subTitleFontSize,
                  weight: subTitleWeight,
                  color: subTitleColor ?? context.colorScheme.onSurface,
                ),
            ],
          ),
      ],
    ).addPadding(bottom: disableBottomPadding ? 0 : 6.0);
  }
}
