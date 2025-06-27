
import '../../../../../core/consts/exports.dart';

class TradeValueItemWidget extends StatelessWidget {
  final String title, value;
  final Color titleColor, valueColor;
  final double titleSize, valueSize;
  final FontWeight titleWeight, valueWeight;
  final bool hideValue;

  const TradeValueItemWidget({
    super.key,
    required this.title,
    required this.value,
    this.titleColor = const Color(0xffEBBD4B),
    this.valueColor = const Color(0xffffffff),
    this.titleSize = FoontSize.font12,
    this.valueSize = FoontSize.font12,
    this.titleWeight = FontWeight.w500,
    this.valueWeight = FontWeight.w500,
    this.hideValue = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MText(
          text: title,
          size: titleSize,
          weight: titleWeight,
          color: titleColor,
        ).addPadding(bottom: 2.0),
        if (!hideValue)
          MText(
            text: value,
            size: valueSize,
            weight: valueWeight,
            color: valueColor,
          )
      ],
    );
  }
}
