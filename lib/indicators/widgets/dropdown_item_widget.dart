import 'package:candle_chart/indicators/bottom_sheets/select_item_bottom_sheet.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/widgets/paddings.dart';
import 'package:flutter/material.dart';

class DropdownItemWidget<T> extends StatefulWidget {
  final String title;
  final List<T> items;
  final String Function(T value) onTitle;
  final void Function(T value)? onChanged;
  final T? value;

  const DropdownItemWidget(
      {super.key,
      required this.title,
      required this.items,
      required this.onTitle,
      this.value,
      this.onChanged});

  @override
  State<DropdownItemWidget<T>> createState() => _DropdownItemWidgetState<T>();
}

class _DropdownItemWidgetState<T> extends State<DropdownItemWidget<T>> {
  final controller = TextEditingController();
  T? currentSort;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.value != null) {
        currentSort = widget.value;
        controller.text = widget.onTitle(currentSort!);
        widget.onChanged?.call(currentSort!);
      } else if (widget.items.isNotEmpty) {
        currentSort = widget.items.first;
        controller.text = widget.onTitle(currentSort!);
        widget.onChanged?.call(currentSort!);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 6.0,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: context.text.bodyMedium,
        ),
        GestureDetector(
          onTap: () {
            showSelectItemBottomSheet(
              context: context,
              items: widget.items,
              onTitle: widget.onTitle,
              currentSort: currentSort,
              onChanged: (value) {
                controller.text = widget.onTitle(value);
                currentSort = value;
                widget.onChanged?.call(value);
              },
              title: widget.title,
            );
          },
          child: TextField(
            controller: controller,
            style: context.text.bodySmall,
            enabled: false,
            decoration: InputDecoration(
              suffixIconConstraints: const BoxConstraints(
                minWidth: 20.0,
                minHeight: 20.0,
              ),
              suffixIcon: Icon(
                Icons.keyboard_arrow_down_outlined,
                color: context.scheme.onSurface,
              ).addPadding(start: 4.0, end: 16.0),
              hintText: context.tr.pleaseChooseItem,
              hintStyle: context.text.bodySmall!.copyWith(
                color: context.scheme.onSurfaceDisabled,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: BorderSide(color: context.scheme.outline),
              ),
              filled: true,
              fillColor: context.scheme.surfaceContainerHighest,
              contentPadding: const MPadding.set(horizontal: 16.0),
            ),
            textAlign: TextAlign.start,
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
