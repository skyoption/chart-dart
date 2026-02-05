import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/indicators/widgets/dropdown_item_widget.dart';
import 'package:candle_chart/indicators/widgets/indicator_color_widget.dart';
import 'package:candle_chart/indicators/widgets/indicator_info_widget.dart';
import 'package:candle_chart/indicators/widgets/input_item_widget.dart';
import 'package:candle_chart/indicators/widgets/levels_item_widget.dart';
import 'package:candle_chart/k_chart_plus.dart';

import 'package:candle_chart/indicators/widgets/top_header_widget.dart';
import 'package:candle_chart/widgets/paddings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../main/indicator_properties_screen.dart';

@immutable
class MOMPropertiesScreen extends StatefulWidget {
  final String? name;
  final IndicatorEntity? indicator;
  final int? windowId;
  final Function onDone;

  MOMPropertiesScreen({
    super.key,
    required this.onDone,
    this.name,
    this.windowId,
    this.indicator,
  });

  @override
  State<MOMPropertiesScreen> createState() => _MOMPropertiesScreenState();
}

class _MOMPropertiesScreenState extends State<MOMPropertiesScreen> {
  late final periodController = TextEditingController(text: '14');

  late String name = widget.name ?? widget.indicator!.name;
  IndicatorEntity? indicator;

  @override
  void initState() {
    if (widget.indicator != null) {
      indicator = widget.indicator;
      periodController.text = indicator!.period.toString();
    } else {
      indicator = IndicatorEntity(
        key: 'momentum',
        period: 14,
        name: widget.name!,
        applyTo: ApplyTo.Close,
        type: IndicatorType.MOM,
        levels: [],
        windowId: widget.windowId ?? 0,
        isSecondary: true,
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 60.0),
        child: SafeArea(
          child: TopHeaderWidget(
            title: name,
            onBack: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: MPadding.set(horizontal: 21.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IndicatorInfoWidget(
                    options: [
                      context.tr.inputs,
                      // context.tr.visibility,
                      context.tr.style,
                    ],
                    children: [
                      Column(
                        spacing: 21.0,
                        children: [
                          InputItemWidget(
                            title: context.tr.period,
                            controller: periodController,
                            keyboardType:
                                TextInputType.numberWithOptions(signed: false),
                            onChanged: (value) {
                              final res = int.tryParse(value);
                              if (res != null) indicator?.period = res;
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(3),
                              NumericalRangeFormatter(min: 1, max: 100),
                            ],
                          ),
                          DropdownItemWidget<ApplyTo>(
                            title: context.tr.applyTo,
                            items: ApplyTo.values.toList(),
                            onTitle: (value) => value.name
                                .replaceAll('__', '/')
                                .replaceAll('_', ' '),
                            onChanged: (value) {
                              indicator?.applyTo = value;
                              setState(() {});
                            },
                          ),
                          LevelsItemWidget(
                            indicator: indicator!,
                            onChange: (color, levels) {
                              indicator!.levels = levels;
                              indicator!.levelsColor = color;
                            },
                          ),
                        ],
                      ),
                      // Column(
                      //   children: [
                      //     DropdownItemWidget<String>(
                      //       title: context.tr.timeframe,
                      //       items: [context.tr.all_timeframes],
                      //       onTitle: (value) => value,
                      //       onChanged: (value) {},
                      //     ),
                      //   ],
                      // ),
                      Column(
                        spacing: 21.0,
                        children: [
                          DropdownItemWidget<double>(
                            title: context.tr.pixels,
                            items: [1.0, 2.0, 3.0, 4.0],
                            onTitle: (value) => '$value ${context.tr.pixel}',
                            value: indicator?.strokeWidth,
                            onChanged: (pixel) {
                              indicator?.strokeWidth = pixel;
                              setState(() {});
                            },
                          ),
                          IndicatorColorWidget(
                            title: context.tr.style,
                            color: colorFromHex(indicator!.color!),
                            hideDrawAsBackground: false,
                            drawAsBackground: indicator!.drawAsBackground,
                            onChange: (color, drawAsBackground) {
                              indicator?.color = color.toHexString();
                              indicator?.drawAsBackground = drawAsBackground;
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: _onDone,
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

  void _onDone() async {
    if (widget.indicator == null) {
      await chartProperties.addSecondaryIndicator(
        indicator!,
        widget.windowId,
      );
    } else {
      await chartProperties.updateSecondaryIndicator(
        indicator!,
      );
    }
    widget.onDone();
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    periodController.dispose();
    super.dispose();
  }
}
