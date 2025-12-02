import 'package:example/core/consts/exports.dart';

class QuoteDetailsItemWidget extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueColor, titleColor;
  final bool hideDivider;
  final FontWeight fontWeight;

  const QuoteDetailsItemWidget({
    super.key,
    required this.title,
    required this.value,
    this.valueColor,
    this.titleColor,
    this.hideDivider = false,
    this.fontWeight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!hideDivider)
          MDividerItemWidget(
            color: context.colorScheme.outline,
            padding: const MPadding.set(vertical: 12.0),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MText(
              text: title,
              size: FoontSize.font13,
              weight: fontWeight,
              color: titleColor ?? context.colorScheme.onSurface,
            ),
            MText(
              text: value,
              color: valueColor ?? context.colorScheme.outline,
              size: FoontSize.font12,
              weight: fontWeight,
            ),
          ],
        ),
      ],
    );
  }
}
