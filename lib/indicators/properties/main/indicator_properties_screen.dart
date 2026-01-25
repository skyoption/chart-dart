import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/indicators/widgets/dropdown_item_widget.dart';
import 'package:candle_chart/indicators/widgets/indicator_color_widget.dart';
import 'package:candle_chart/indicators/widgets/indicator_info_widget.dart';
import 'package:candle_chart/indicators/widgets/levels_item_widget.dart';
import 'package:candle_chart/indicators/widgets/top_header_widget.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/indicators/widgets/input_item_widget.dart';
import 'package:candle_chart/widgets/paddings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class IndicatorPropertiesScreen extends StatefulWidget {
  final String? name;
  final String id;
  final IndicatorEntity? indicator;
  final Function onDone;
  final IndicatorType type;
  final int? windowId;
  final bool haveDeviations,
      haveMethods,
      haveTimeframe,
      haveLevels,
      havePixels,
      haveTwoBands,
      isENVELOPS;

  final double deviations;
  final int period;
  final int shift;

  IndicatorPropertiesScreen({
    super.key,
    required this.onDone,
    this.name,
    required this.id,
    this.windowId,
    this.indicator,
    this.haveDeviations = false,
    this.haveTimeframe = false,
    this.havePixels = true,
    this.haveLevels = false,
    this.haveMethods = false,
    this.haveTwoBands = false,
    this.isENVELOPS = false,
    this.type = IndicatorType.MA_SMA,
    this.deviations = 2,
    this.period = 20,
    this.shift = 0,
  });

  @override
  State<IndicatorPropertiesScreen> createState() =>
      _IndicatorPropertiesScreenState();
}

class _IndicatorPropertiesScreenState extends State<IndicatorPropertiesScreen> {
  late final periodController =
      TextEditingController(text: widget.period.toString());
  late final shiftController =
      TextEditingController(text: widget.shift.toString());
  late final deviationsController =
      TextEditingController(text: widget.deviations.toString());
  late String name = widget.name ?? widget.indicator!.name;
  IndicatorEntity? indicator;

  @override
  void initState() {
    if (widget.indicator != null) {
      indicator = widget.indicator;
      periodController.text = indicator!.period.toString();
      shiftController.text = indicator!.shift.toString();
      deviationsController.text = indicator!.deviations.toString();
    } else {
      indicator = IndicatorEntity(
        key: widget.id,
        period: widget.period,
        shift: widget.shift,
        name: widget.name!,
        applyTo: ApplyTo.Close,
        type: widget.type,
        deviations: widget.deviations,
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
            title: indicator?.name ?? '',
            onBack: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: MPadding.set(horizontal: 21.0, top: 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IndicatorInfoWidget(
                    options: [
                      context.tr.inputs,
                      context.tr.visibility,
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
                          InputItemWidget(
                            title: context.tr.shift,
                            controller: shiftController,
                            keyboardType:
                                TextInputType.numberWithOptions(signed: false),
                            onChanged: (value) {
                              final res = int.tryParse(value);
                              if (res != null) indicator?.shift = res;
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(4),
                              NumericalRangeFormatter(min: 1, max: 1000),
                            ],
                          ),
                          if (widget.haveDeviations)
                            InputItemWidget(
                              title: context.tr.deviations,
                              controller: deviationsController,
                              keyboardType: TextInputType.numberWithOptions(
                                  signed: false),
                              onChanged: (value) {
                                final res = double.tryParse(value);
                                if (res != null) indicator?.deviations = res;
                              },
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(6),
                                NumericalDoubleRangeFormatter(min: 0, max: 100),
                              ],
                            ),
                          if (widget.haveMethods)
                            DropdownItemWidget<Methods>(
                              title: context.tr.method,
                              items: Methods.values.toList(),
                              onTitle: (value) =>
                                  value.name.replaceAll('_', ' '),
                              onChanged: (value) {
                                _setType(value);
                                setState(() {});
                              },
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
                          if (widget.haveLevels)
                            LevelsItemWidget(
                              indicator: indicator!,
                              onChange: (color, levels) {
                                indicator!.levels = levels;
                                indicator!.levelsColor = color;
                              },
                            ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: MPadding.set(bottom: 21.0),
                            child: DropdownItemWidget<String>(
                              title: context.tr.timeframe,
                              items: [context.tr.all_timeframes],
                              onTitle: (value) => value,
                              onChanged: (value) {},
                            ),
                          ),
                        ],
                      ),
                      Column(
                        spacing: 21.0,
                        children: [
                          if (widget.havePixels)
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
                            title:
                                widget.haveTwoBands ? 'Upper Band ' : 'Style ',
                            color: colorFromHex(indicator?.color ?? ''),
                            hideDrawAsBackground: widget.haveTwoBands,
                            drawAsBackground: indicator?.drawAsBackground,
                            onChange: (color, drawAsBackground) {
                              indicator?.color = color.toHexString();
                              if (!widget.haveTwoBands) {
                                indicator?.drawAsBackground = drawAsBackground;
                              }
                            },
                          ),
                          if (widget.haveTwoBands)
                            IndicatorColorWidget(
                              title: context.tr.lower_band,
                              hideDrawAsBackground: false,
                              drawAsBackground: indicator?.drawAsBackground,
                              color: colorFromHex(indicator?.secondColor ?? ''),
                              onChange: (color, drawAsBackground) {
                                indicator?.secondColor = color.toHexString();
                                indicator?.drawAsBackground = drawAsBackground;
                              },
                            )
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

  void _setType(method) {
    if (widget.isENVELOPS) {
      indicator?.type = method == Methods.Exponential
          ? IndicatorType.ENVELOPS_EMA
          : method == Methods.Linear_Weighted
              ? IndicatorType.ENVELOPS_LINEAR
              : method == Methods.Simple
                  ? IndicatorType.ENVELOPS_SMA
                  : IndicatorType.ENVELOPS_SMMA;
    } else {
      indicator?.type = method == Methods.Exponential
          ? IndicatorType.MA_EMA
          : method == Methods.Linear_Weighted
              ? IndicatorType.MA_LINEAR
              : method == Methods.Simple
                  ? IndicatorType.MA_SMA
                  : IndicatorType.MA_SMMA;
    }
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

  @override
  void dispose() {
    periodController.dispose();
    shiftController.dispose();
    super.dispose();
  }
}

Methods? setMethod(IndicatorEntity? indicator) {
  if (indicator == null) return null;
  if (indicator.type.name.contains('EMA')) {
    return Methods.Exponential;
  } else if (indicator.type.name.contains('LINEAR')) {
    return Methods.Linear_Weighted;
  } else if (indicator.type.name.contains('SMA')) {
    return Methods.Simple;
  } else {
    return Methods.Smoothed;
  }
}

class NumericalRangeFormatter extends TextInputFormatter {
  final double min;
  final double max;

  NumericalRangeFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '') {
      return newValue;
    } else if (int.parse(newValue.text) < min) {
      return TextEditingValue().copyWith(text: min.toStringAsFixed(2));
    } else {
      return int.parse(newValue.text) > max ? oldValue : newValue;
    }
  }
}

class NumericalDoubleRangeFormatter extends TextInputFormatter {
  final double min;
  final double max;

  NumericalDoubleRangeFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '') {
      return newValue;
    } else if (double.parse(newValue.text) < min) {
      return TextEditingValue().copyWith(text: min.toStringAsFixed(4));
    } else {
      return double.parse(newValue.text) > max ? oldValue : newValue;
    }
  }
}
