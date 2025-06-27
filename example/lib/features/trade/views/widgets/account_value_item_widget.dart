import 'package:example/core/consts/exports.dart';

class AccountValueItemWidget extends StatelessWidget {
  final String title, subTitle;
  final MainAxisAlignment? axisAlignment;
  final double iconSize, containerSize, fontSize;
  final FontWeight subTitleWeight;

  const AccountValueItemWidget({
    super.key,
    required this.title,
    required this.subTitle,
    this.axisAlignment,
    this.iconSize = 26.0,
    this.fontSize = 20.0,
    this.containerSize = 50.0,
    this.subTitleWeight = FontWeight.w300,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MText(
          text: title,
          size: FoontSize.font15,
          color: Coolors.white,
          weight: FontWeight.w600,
        ).addPadding(bottom: 6.0),
        MText(
          text: subTitle.length > 10 ? subTitle.substring(0, 10) : subTitle,
          size: FoontSize.font15,
          weight: FontWeight.w600,
          color: Coolors.white,
        ),
      ],
    );
  }
}
