import 'package:candle_chart/indicators/widgets/select_item_widget.dart';
import 'package:candle_chart/indicators/widgets/top_bottom_sheet_widget.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/widgets/paddings.dart';
import 'package:flutter/material.dart';

class SelectItemBottomSheet<T> extends StatefulWidget {
  final String title;
  final List<T> items;
  final String Function(T value) onTitle;
  final void Function(T value)? onChanged;
  final T? currentSort;

  const SelectItemBottomSheet({
    super.key,
    required this.title,
    required this.items,
    required this.onTitle,
    this.onChanged,
    this.currentSort,
  });

  @override
  State<SelectItemBottomSheet<T>> createState() =>
      _SelectItemBottomSheetState<T>();
}

class _SelectItemBottomSheetState<T> extends State<SelectItemBottomSheet<T>> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TopBottomSheetWidget().addPadding(top: 21.0),
        Align(
          alignment: AlignmentDirectional.topStart,
          child: Text(
            widget.title,
            style: context.text.bodyMedium!.copyWith(
              color: context.scheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ).addPadding(start: 24.0, bottom: 16.0),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              final item = widget.items[index];
              final isSelected = item == widget.currentSort;
              return InkWell(
                onTap: () {
                  widget.onChanged?.call(item);
                  Navigator.pop(context);
                },
                child: SelectItemWidget(
                  isSelected: isSelected,
                  item: widget.onTitle(item),
                ),
              );
            },
          ),
        )
      ],
    ).addPadding(bottom: 30.0);
  }
}

void showSelectItemBottomSheet<T>({
  required BuildContext context,
  required List<T> items,
  required String Function(T value) onTitle,
  required void Function(T value)? onChanged,
  required String title,
  T? currentSort,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: context.scheme.scrim,
    builder: (context) => SelectItemBottomSheet(
      title: title,
      items: items,
      onTitle: onTitle,
      onChanged: onChanged,
      currentSort: currentSort,
    ),
  );
}
