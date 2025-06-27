import 'package:example/core/consts/exports.dart';

class SheetSelectionItem extends StatelessWidget {
  final bool isSelected;
  final bool hideIcon;
  final String name;
  final bool isAscending;
  final Function() onTap;
  const SheetSelectionItem({
    super.key,
    required this.isSelected,
    this.hideIcon = false,
    required this.name,
    required this.isAscending,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MText(
              text: name,
              color: isSelected
                  ? context.colorScheme.inversePrimary
                  : context.colorScheme.scrim,
              size: FoontSize.font16,
              weight: FontWeight.w400,
            ),
            if (isSelected && !hideIcon)
              Icon(
                isAscending ? Icons.arrow_upward : Icons.arrow_downward,
                color: context.colorScheme.inversePrimary,
              )
          ],
        ),
        MDividerItemWidget(
          color: context.colorScheme.outline,
          padding: const MPadding.set(vertical: 24.0),
        ),
      ],
    ).addAction(onGesture: onTap);
  }
}
