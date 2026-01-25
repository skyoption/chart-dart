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
class SOPropertiesScreen extends StatefulWidget {
  final String? name;
  final IndicatorEntity? indicator;
  final int? windowId;
  final Function onDone;

  SOPropertiesScreen({
    super.key,
    required this.onDone,
    this.name,
    this.windowId,
    this.indicator,
  });

  @override
  State<SOPropertiesScreen> createState() => _SOPropertiesScreenState();
}

class _SOPropertiesScreenState extends State<SOPropertiesScreen> {
  final kPeriodController = TextEditingController(text: '5');
  final dPeriodController = TextEditingController(text: '3');
  final slowingController = TextEditingController(text: '3');

  late String name = widget.name ?? widget.indicator!.name;
  IndicatorEntity? indicator;

  @override
  void initState() {
    if (widget.indicator != null) {
      indicator = widget.indicator;
      kPeriodController.text = indicator!.stochastic!.kPeriod.toString();
      dPeriodController.text = indicator!.stochastic!.dPeriod.toString();
      slowingController.text = indicator!.stochastic!.slowing.toString();
    } else {
      indicator = IndicatorEntity(
        key: "stochastic_oscillator",
        name: widget.name!,
        type: IndicatorType.SO_SMA,
        stochastic: Stochastic(),
        levels: [20, 80],
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
                      context.tr.visibility,
                      context.tr.style,
                    ],
                    children: [
                      Column(
                        spacing: 21.0,
                        children: [
                          InputItemWidget(
                            title: context.tr.k_period,
                            onChanged: (value) {
                              final res = int.tryParse(value);
                              if (res != null)
                                indicator!.stochastic!.kPeriod = res;
                            },
                            controller: kPeriodController,
                            keyboardType:
                                TextInputType.numberWithOptions(signed: false),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(3),
                              NumericalRangeFormatter(min: 1, max: 100),
                            ],
                          ),
                          InputItemWidget(
                            onChanged: (value) {
                              final res = int.tryParse(value);
                              if (res != null)
                                indicator!.stochastic!.dPeriod = res;
                            },
                            title: context.tr.d_period,
                            controller: dPeriodController,
                            keyboardType:
                                TextInputType.numberWithOptions(signed: false),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(3),
                              NumericalRangeFormatter(min: 1, max: 100),
                            ],
                          ),
                          InputItemWidget(
                            onChanged: (value) {
                              final res = int.tryParse(value);
                              if (res != null)
                                indicator!.stochastic!.slowing = res;
                            },
                            title: context.tr.slowing,
                            controller: slowingController,
                            keyboardType:
                                TextInputType.numberWithOptions(signed: false),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(3),
                              NumericalRangeFormatter(min: 1, max: 100),
                            ],
                          ),
                          LevelsItemWidget(
                            indicator: indicator!,
                            onChange: (color, levels) {
                              indicator!.levels = levels;
                              indicator!.levelsColor = color;
                            },
                          ),
                          DropdownItemWidget<PriceField>(
                            title: context.tr.priceField,
                            items: PriceField.values,
                            onTitle: (value) => value.name.replaceAll('_', '/'),
                            value: indicator?.stochastic?.priceField,
                            onChanged: (value) {
                              indicator?.stochastic?.priceField = value;
                              setState(() {});
                            },
                          ),
                          DropdownItemWidget<Methods>(
                            title: context.tr.method,
                            items: Methods.values,
                            onTitle: (value) => value.name.replaceAll('_', ' '),
                            value: getType(),
                            onChanged: (value) {
                              setType(value);
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          DropdownItemWidget<String>(
                            title: context.tr.timeframe,
                            items: [context.tr.all_timeframes],
                            onTitle: (value) => value,
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                      Column(
                        spacing: 21.0,
                        children: [
                          IndicatorColorWidget(
                            title: context.tr.main,
                            color: colorFromHex(
                                indicator?.stochastic?.mainColor ?? ''),
                            onChange: (color, drawAsBackground) {
                              indicator?.stochastic?.mainColor =
                                  color.toHexString();
                            },
                          ),
                          IndicatorColorWidget(
                            title: context.tr.signal,
                            color: colorFromHex(
                                indicator?.stochastic?.signalColor ?? ''),
                            onChange: (color, drawAsBackground) {
                              indicator?.stochastic?.signalColor =
                                  color.toHexString();
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

  Methods? getType() {
    if (indicator?.type == IndicatorType.SO_EMA) return Methods.Exponential;
    if (indicator?.type == IndicatorType.SO_LINEAR)
      return Methods.Linear_Weighted;
    if (indicator?.type == IndicatorType.SO_SMA) return Methods.Simple;
    if (indicator?.type == IndicatorType.SO_SMMA) return Methods.Smoothed;
    return null;
  }

  void setType(method) {
    indicator?.type = method == Methods.Exponential
        ? IndicatorType.SO_EMA
        : method == Methods.Linear_Weighted
            ? IndicatorType.SO_LINEAR
            : method == Methods.Simple
                ? IndicatorType.SO_SMA
                : IndicatorType.SO_SMMA;
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
    dPeriodController.dispose();
    kPeriodController.dispose();
    slowingController.dispose();
    super.dispose();
  }
}
