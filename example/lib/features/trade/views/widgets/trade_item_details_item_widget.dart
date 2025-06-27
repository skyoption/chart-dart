import 'package:example/core/consts/exports.dart';

class TradeItemDetailsItemWidget extends StatelessWidget {
  final String title, value;
  final Color? color;
  const TradeItemDetailsItemWidget({
    super.key,
    required this.title,
    required this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MText(
          text: title,
          color: color ?? context.colorScheme.onSurface,
          size: FoontSize.font16,
        ),
        MText(
          text: value,
          color: color ?? context.colorScheme.onSurface,
          size: FoontSize.font14,
        ),
      ],
    ).addPadding(bottom: 10.0);
  }
}
