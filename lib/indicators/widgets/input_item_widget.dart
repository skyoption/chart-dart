import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/widgets/paddings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputItemWidget extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final Function? onRemove;
  final TextInputType? keyboardType;

  const InputItemWidget(
      {super.key,
      required this.title,
      required this.controller,
      this.inputFormatters,
      this.onChanged,
      this.onRemove,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 6.0,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: context.text.bodyMedium,
            ),
            if (onRemove != null)
              InkWell(
                onTap: () => onRemove?.call(),
                child: Icon(
                  CupertinoIcons.delete_solid,
                  color: context.scheme.error,
                  size: 18.0,
                ),
              ).addPadding(bottom: 4.0),
          ],
        ),
        TextField(
          controller: controller,
          style: context.text.bodySmall,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            prefixIconConstraints: const BoxConstraints(
              minWidth: 20.0,
              minHeight: 20.0,
            ),
            suffixIconConstraints: const BoxConstraints(
              minWidth: 20.0,
              minHeight: 20.0,
            ),
            prefixIcon: InkWell(
              onTap: () {},
              child: Icon(
                Icons.remove,
                color: context.scheme.primary,
              ).addPadding(start: 16.0, end: 4.0),
            ),
            suffixIcon: InkWell(
              onTap: () {},
              child: Icon(
                Icons.add,
                color: context.scheme.primary,
              ).addPadding(start: 4.0, end: 16.0),
            ),
            hintText: context.tr.value,
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
          textAlign: TextAlign.center,
          onChanged: onChanged,
          inputFormatters: inputFormatters,
        )
      ],
    );
  }
}
