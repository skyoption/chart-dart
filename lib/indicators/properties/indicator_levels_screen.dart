import 'package:candle_chart/indicators/widgets/indicator_color_widget.dart';
import 'package:candle_chart/indicators/widgets/input_item_widget.dart';
import 'package:candle_chart/indicators/widgets/top_header_widget.dart';
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
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              levels = [...levels, 0];
              setState(() {});
            },
            child: Container(
              height: 50.0,
              margin: MPadding.set(horizontal: 21.0, top: 12.0),
              decoration: BoxDecoration(
                border: Border.all(color: context.scheme.primary),
                borderRadius: BorderRadius.circular(6.0),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 4.0,
                children: [
                  Icon(
                    Icons.add,
                    color: context.scheme.primary,
                  ),
                  Text(
                    context.tr.addLevel,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: context.scheme.primary,
                        ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...levels.asMap().entries.map((item) {
                    return InputItemWidget(
                      title: context.tr.description,
                      onRemove: () {
                        levels.removeAt(item.key);
                        setState(() {});
                      },
                      controller:
                          TextEditingController(text: item.value.toString()),
                      keyboardType:
                          TextInputType.numberWithOptions(signed: false),
                      onChanged: (value) {
                        Future.delayed(Duration.zero, () {
                          levels[item.key] = double.tryParse(value) ?? 0;
                          setState(() {});
                        });
                      },
                    ).addPadding(horizontal: 21.0, top: 21.0);
                  }),
                  IndicatorColorWidget(
                    title: context.tr.style,
                    color: colorFromHex(color),
                    onChange: (value, drawAsBackground) {
                      color = value.toHexString();
                    },
                  ).addPadding(top: 21.0, horizontal: 21.0),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              widget.setLevels(color, levels);
              Navigator.of(context).pop();
            },
            child: Container(
              height: 50.0,
              margin: MPadding.set(
                horizontal: 21.0,
                top: 21.0,
                bottom: context.bottomPadding,
              ),
              decoration: BoxDecoration(
                color: context.scheme.primary,
                borderRadius: BorderRadius.circular(6.0),
              ),
              alignment: Alignment.center,
              child: Text(
                context.tr.apply,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: context.scheme.onPrimary,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
