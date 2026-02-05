import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/indicators/properties/main/indicator_properties_screen.dart';
import 'package:candle_chart/indicators/widgets/dropdown_item_widget.dart';
import 'package:candle_chart/indicators/widgets/indicator_color_widget.dart';
import 'package:candle_chart/indicators/widgets/indicator_info_widget.dart';
import 'package:candle_chart/indicators/widgets/input_item_widget.dart';
import 'package:candle_chart/indicators/widgets/top_header_widget.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/widgets/paddings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

@immutable
class ParabolicPropertiesScreen extends StatefulWidget {
  final String? name;
  final IndicatorEntity? indicator;
  final Function onDone;
  final int? windowId;

  ParabolicPropertiesScreen({
    super.key,
    required this.onDone,
    this.name,
    this.windowId,
    this.indicator,
  });

  @override
  State<ParabolicPropertiesScreen> createState() =>
      _ParabolicPropertiesScreenState();
}

class _ParabolicPropertiesScreenState extends State<ParabolicPropertiesScreen> {
  late final stepsController = TextEditingController(text: '0.02');
  late final maximumController = TextEditingController(text: '0.2');

  late String name = widget.name ?? widget.indicator!.name;
  IndicatorEntity? indicator;

  @override
  void initState() {
    if (widget.indicator != null) {
      indicator = widget.indicator;
      stepsController.text = indicator!.steps.toString();
      maximumController.text = indicator!.maximum.toString();
    } else {
      indicator = IndicatorEntity(
        key: "parabolic_sar",
        maximum: 0.2,
        steps: 0.02,
        name: widget.name!,
        type: IndicatorType.PARABOLIC,
        windowId: widget.windowId ?? 0,
        isSecondary: (widget.windowId ?? 0) != 0,
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
            title: context.tr.properties,
            onBack: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
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
                            title: context.tr.steps,
                            controller: stepsController,
                            keyboardType:
                                TextInputType.numberWithOptions(signed: false),
                            onChanged: (value) {
                              final res = double.tryParse(value);
                              if (res != null) indicator?.steps = res;
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(6),
                              NumericalDoubleRangeFormatter(min: 0, max: 100),
                            ],
                          ),
                          InputItemWidget(
                            title: context.tr.maximum,
                            controller: maximumController,
                            keyboardType:
                                TextInputType.numberWithOptions(signed: false),
                            onChanged: (value) {
                              final res = double.tryParse(value);
                              if (res != null) indicator?.maximum = res;
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(6),
                              NumericalDoubleRangeFormatter(min: 0, max: 100),
                            ],
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

  @override
  void dispose() {
    stepsController.dispose();
    maximumController.dispose();
    super.dispose();
  }

  void _onDone() async {
    if (indicator!.isSecondary) {
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
    } else {
      if (widget.indicator == null) {
        await chartProperties.addIndicator(
          indicator!,
        );
      } else {
        await chartProperties.updateIndicator(
          indicator!,
        );
      }
    }
    widget.onDone();
    Navigator.of(context).pop();
  }
}
