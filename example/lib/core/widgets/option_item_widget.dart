import 'package:example/core/consts/exports.dart';

class OptionItemWidget extends StatelessWidget {
  final String title;
  final String? icon;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? backgroundColor;
  const OptionItemWidget({
    super.key,
    required this.title,
    this.icon,
    this.backgroundColor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 70,
      duration: const Duration(milliseconds: 300),
      padding: const MPadding.set(horizontal: 8.0),
      decoration: BoxDecoration(
        color: isSelected
            ? backgroundColor ?? context.colorScheme.inversePrimary
            : Colors.transparent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              if (icon != null)
                MSvg(
                  name: icon!,
                  width: 20.0,
                  height: 20.0,
                  color: context.colorScheme.scrim,
                ).addPadding(end: 8),
              Expanded(
                child: MText(
                  text: title,
                  size: FoontSize.font16,
                  weight: FontWeight.w400,
                  color: context.colorScheme.scrim,
                ),
              ),
              if (isSelected)
                MSvg(
                  height: 18,
                  width: 18,
                  name: Svgs.lightCheckMarIcon,
                  color: context.colorScheme.scrim,
                )
            ],
          ).addPadding(horizontal: 8),
        ],
      ),
    ).addAction(onGesture: onTap);
  }
}
