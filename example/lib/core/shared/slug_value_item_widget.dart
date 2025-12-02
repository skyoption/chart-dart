import 'package:example/app.dart';
import 'package:example/core/framework/mtoast.dart';
import 'package:example/core/shared/slug_widget.dart';

import 'package:example/core/consts/exports.dart';

class SlugValueItemWidget extends StatelessWidget {
  final String title;
  final String value;
  final bool canCopy;
  final Widget? icon;
  final Color? titleColor, valueColor;
  final FontWeight titleWeight, valueWeight;
  final double titleFontSize, valueFontSize;

  const SlugValueItemWidget({
    super.key,
    required this.title,
    required this.value,
    this.canCopy = false,
    this.icon,
    this.titleColor,
    this.valueColor,
    this.titleWeight = FontWeight.w500,
    this.valueWeight = FontWeight.w400,
    this.titleFontSize = 16.0,
    this.valueFontSize = 14.0,
  });

  void copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: value));
    MToast.showSuccess(message: SkyTrading.tr.copiedToClipboard);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SlugWidget(),
        MText(
          text: title,
          size: titleFontSize,
          color: titleColor ?? context.colorScheme.onSurfaceVariant,
          weight: titleWeight,
        ),
        const Spacer(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (canCopy)
              const MSvg(name: Svgs.copy, width: 20, height: 20)
                  .addPadding(end: 8)
                  .addAction(onTap: () => copyToClipboard(context)),
            if (icon != null) icon!.addPadding(end: 8),
            MText(
              text: value,
              size: valueFontSize,
              color: valueColor ?? context.colorScheme.onSurface,
              weight: valueWeight,
            ),
          ],
        ),
      ],
    );
  }
}
