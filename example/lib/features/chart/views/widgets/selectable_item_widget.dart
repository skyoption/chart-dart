import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/functions.dart';
import 'package:example/core/shared/bottom_sheets/date_time_bottom_sheet.dart';

class SelectableItemWidget extends StatelessWidget {
  final ItemEntity item;
  final bool isSelected;
  final VoidCallback onTap;
  const SelectableItemWidget({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MText(
          text: item.name,
          size: 16.0,
          weight: FontWeight.w400,
          color: isSelected
              ? context.colorScheme.primary
              : context.colorScheme.onSurfaceDisabled,
        ).addPadding(bottom: 4.0),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: getTextWidth(item.name, 14.0),
          height: 4,
          decoration: BoxDecoration(
            color:
                isSelected ? context.colorScheme.primary : Colors.transparent,
            borderRadius: MBorderRadius.set(topStart: 8.0, topEnd: 8.0),
          ),
        ),
      ],
    ).addAction(onGesture: onTap);
  }
}
