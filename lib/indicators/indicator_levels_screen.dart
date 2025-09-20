import 'package:candle_chart/indicators/widgets/indicator_color_widget.dart';
import 'package:candle_chart/indicators/widgets/level_item_widget.dart';
import 'package:candle_chart/indicators/widgets/top_header_widget.dart';
import 'package:candle_chart/objects/widgets/properties_item_widget.dart';
import 'package:candle_chart/widgets/paddings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:candle_chart/utils/context.dart';

class IndicatorLevelsScreen extends StatefulWidget {
  final Function(String color, List<double> levels) setLevels;
  final List<double>? levels;
  final String color;

  const IndicatorLevelsScreen({
    super.key,
    required this.setLevels,
    required this.color,
    this.levels,
  });

  @override
  State<IndicatorLevelsScreen> createState() => _IndicatorLevelsScreenState();
}

class _IndicatorLevelsScreenState extends State<IndicatorLevelsScreen> {
  late List<double> levels = widget.levels ?? [];
  late String color = widget.color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 60.0),
        child: SafeArea(
          child: TopHeaderWidget(
            title: context.tr.levels,
            onBack: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...levels.asMap().entries.map((item) {
              return LevelItemWidget(
                level: item.value,
                onChanged: (value) {
                  Future.delayed(Duration.zero, () {
                    levels[item.key] = value;
                    setState(() {});
                    widget.setLevels(color, levels);
                  });
                },
              );
            }),
            PropertiesItemWidget(
              title: context.tr.addLevel,
              showArrow: false,
              onTap: () {
                levels = [...levels, 0];
                setState(() {});
                widget.setLevels(color, levels);
              },
            ),
            IndicatorColorWidget(
              title: context.tr.style,
              color: colorFromHex(color),
              onChange: (value, drawAsBackground) {
                color = value.toHexString();
                widget.setLevels(color, levels);
              },
            ).addPadding(top: 21.0),
          ],
        ),
      ),
    );
  }
}
