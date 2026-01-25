import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/indicators/properties/indicator_levels_screen.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/widgets/paddings.dart';
import 'package:flutter/material.dart';

class LevelsItemWidget extends StatefulWidget {
  final IndicatorEntity indicator;
  final Function(String color, List<double> levels) onChange;

  const LevelsItemWidget(
      {super.key, required this.indicator, required this.onChange});

  @override
  State<LevelsItemWidget> createState() => _LevelsItemWidgetState();
}

class _LevelsItemWidgetState extends State<LevelsItemWidget> {
  final controller = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.text = widget.indicator.levels.join(', ');
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 6.0,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr.levels,
          style: context.text.bodyMedium,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => IndicatorLevelsScreen(
                  color: widget.indicator.levelsColor ?? '',
                  setLevels: (color, levels) {
                    widget.indicator.levels = levels;
                    widget.indicator.levelsColor = color;
                    controller.text = widget.indicator.levels.join(', ');
                  },
                  levels: widget.indicator.levels,
                ),
              ),
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
                Icons.arrow_forward_ios_outlined,
                color: context.scheme.onSurface,
                size: 16.0,
              ).addPadding(start: 4.0, end: 16.0),
              hintText: context.tr.selectItem,
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
}
