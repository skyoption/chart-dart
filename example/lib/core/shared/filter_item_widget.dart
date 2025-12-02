// ignore_for_file: must_be_immutable

import 'package:example/core/consts/exports.dart';
import 'package:example/core/shared/radio_item_widget.dart';

class FilterItemWidget extends StatelessWidget {
  final int index, groupIndex;
  final String title;
  final Function onTap;

  const FilterItemWidget({
    super.key,
    required this.onTap,
    required this.title,
    required this.index,
    required this.groupIndex,
  });

  @override
  Widget build(BuildContext context) {
    return RadioItemWidget(
      title: title,
      index: index,
      groupIndex: groupIndex,
      onTap: () => onTap(),
    );
  }
}
