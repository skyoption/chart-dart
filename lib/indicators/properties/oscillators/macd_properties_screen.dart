import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/indicators/properties/main/indicator_properties_screen.dart';
import 'package:candle_chart/indicators/widgets/indicator_color_widget.dart';
import 'package:candle_chart/indicators/widgets/indicator_info_widget.dart';
import 'package:candle_chart/indicators/widgets/input_item_widget.dart';
import 'package:candle_chart/k_chart_plus.dart';

import 'package:candle_chart/indicators/widgets/top_header_widget.dart';
import 'package:candle_chart/widgets/paddings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class MACDPropertiesScreen extends StatefulWidget {
  final String? name;
  final IndicatorEntity? indicator;
  final int? windowId;
  final Function onDone;

  MACDPropertiesScreen({
    super.key,
    required this.onDone,
    this.name,
    this.windowId,
    this.indicator,
  });

  @override
  State<MACDPropertiesScreen> createState() => _MACDPropertiesScreenState();
}

class _MACDPropertiesScreenState extends State<MACDPropertiesScreen> {
  late final FastEMAController = TextEditingController(text: '12');
  late final slowEMAController = TextEditingController(text: '26');
  late final MACDSMAController = TextEditingController(text: '9');

  late String name = widget.name ?? widget.indicator!.name;
  IndicatorEntity? indicator;

  @override
  void initState() {
    if (widget.indicator != null) {
      indicator = widget.indicator;
      FastEMAController.text = indicator!.macd!.fastEma.toString();
      slowEMAController.text = indicator!.macd!.slowEma.toString();
      MACDSMAController.text = indicator!.macd!.macdSma.toString();
    } else {
      indicator = IndicatorEntity(
        key: "macd",
        name: widget.name!,
        macd: MACD(),
        levels: [0],
        type: IndicatorType.MACD,
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
                            title: context.tr.fast_ema,
                            controller: FastEMAController,
                            keyboardType:
                                TextInputType.numberWithOptions(signed: false),
                            onChanged: (value) {
                              final res = int.tryParse(value);
                              if (res != null) indicator!.macd!.fastEma = res;
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(3),
                              NumericalRangeFormatter(min: 1, max: 100),
                            ],
                          ),
                          InputItemWidget(
                            title: context.tr.slow_ema,
                            keyboardType:
                                TextInputType.numberWithOptions(signed: false),
                            onChanged: (value) {
                              final res = int.tryParse(value);
                              if (res != null) indicator!.macd!.slowEma = res;
                            },
                            controller: slowEMAController,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(3),
                              NumericalRangeFormatter(min: 1, max: 100),
                            ],
                          ),
                          InputItemWidget(
                            title: context.tr.macd_sma,
                            onChanged: (value) {
                              final res = int.tryParse(value);
                              if (res != null) indicator!.macd!.macdSma = res;
                            },
                            controller: MACDSMAController,
                            keyboardType:
                                TextInputType.numberWithOptions(signed: false),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(3),
                              NumericalRangeFormatter(min: 1, max: 100),
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
                            title: context.tr.main,
                            color:
                                colorFromHex(indicator?.macd?.mainColor ?? ''),
                            onChange: (color, drawAsBackground) {
                              indicator!.macd!.mainColor = color.toHexString();
                            },
                          ),
                          IndicatorColorWidget(
                            title: context.tr.signal,
                            color: colorFromHex(
                                indicator?.macd?.signalColor ?? ''),
                            onChange: (color, drawAsBackground) {
                              indicator!.macd!.signalColor =
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
    slowEMAController.dispose();
    MACDSMAController.dispose();
    FastEMAController.dispose();
    super.dispose();
  }
}
