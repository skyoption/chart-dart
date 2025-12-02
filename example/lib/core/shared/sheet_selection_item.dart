import 'package:example/core/consts/exports.dart';

import 'bottom_sheet_item_widget.dart';

class FilterItemWidget extends StatelessWidget {
  final bool isSelected;
  final bool hideIcon;
  final String name;
  final bool isAscending;
  final Function() onTap;
  final Color? slugColor, arrowColor;
  const FilterItemWidget({
    super.key,
    required this.isSelected,
    required this.name,
    this.hideIcon = false,
    this.isAscending = false,
    required this.onTap,
    this.slugColor,
    this.arrowColor,
  });

  @override
  Widget build(BuildContext context) {
    return BottomSheetItemWidget(
      slugColor: slugColor,
      title: name,
      onTap: onTap,
      isSelected: isSelected,
      suffixWidget: isSelected && !hideIcon
          ? Icon(
              isAscending ? Icons.arrow_upward : Icons.arrow_downward,
              color: arrowColor ?? context.colorScheme.tertiary,
            )
          : null,
    );
  }
}
