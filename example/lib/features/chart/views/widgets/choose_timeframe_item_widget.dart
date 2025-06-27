import 'package:example/core/consts/exports.dart';

class ChooseTimeframeItemWidget extends StatelessWidget {
  final bool isSelected;
  final String title;
  final Function onTap;

  const ChooseTimeframeItemWidget({
    super.key,
    required this.isSelected,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected
            ? context.colorScheme.surfaceBright
            : context.colorScheme.surfaceContainer,
        borderRadius: MBorderRadius.set(all: 12.0),
      ),
      margin: const MPadding.set(start: 21.0),
      padding: const MPadding.set(all: 9.0),
      height: 45.0,
      width: 45.0,
      alignment: Alignment.center,
      child: MText(
        text: title,
        weight: FontWeight.w400,
        size: FoontSize.font14,
        color: context.colorScheme.scrim,
      ),
    ).addAction(
      onGesture: () {
        onTap();
      },
    );
  }
}
