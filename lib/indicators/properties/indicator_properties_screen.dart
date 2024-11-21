import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/indicators/indicator_pixels_screen.dart';
import 'package:candle_chart/indicators/widgets/indicator_color_widget.dart';
import 'package:candle_chart/objects/horizontal_line_properties_screen.dart';
import 'package:candle_chart/objects/widgets/properties_item_widget.dart';
import 'package:candle_chart/indicators/apply_to_screen.dart';
import 'package:candle_chart/indicators/indicators_methods_screen.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/utils/kprint.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class IndicatorPropertiesScreen extends StatefulWidget {
  final String? name;
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

  IndicatorPropertiesScreen({
    super.key,
    required this.onDone,
    this.name,
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
  });

  @override
  State<IndicatorPropertiesScreen> createState() =>
      _IndicatorPropertiesScreenState();
}

class _IndicatorPropertiesScreenState extends State<IndicatorPropertiesScreen> {
  late final periodController = TextEditingController(text: '5');
  late final shiftController = TextEditingController(text: '0');
  late final deviationsController = TextEditingController(text: '2.000');
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
        period: 5,
        shift: 0,
        name: widget.name!,
        applyTo: ApplyTo.Close,
        type: widget.type,
        deviations: widget.haveDeviations ? 2.000 : null,
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
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 14.0,
              horizontal: 21.0,
            ),
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 21.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    'Properties',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: InkWell(
                    onTap: () {
                      _onDone();
                    },
                    child: Text(
                      'Done',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.blueAccent,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        // padding: EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PropertiesTitleWidget(
              title: '${name.toUpperCase()}',
            ),
            PropertiesItemWidget(
              title: 'Period',
              child: SizedBox(
                width: 60.0,
                height: 20.0,
                child: TextField(
                  cursorHeight: 12.0,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Colors.blueAccent,
                      ),
                  onChanged: (value) {
                    final res = int.tryParse(value);
                    if (res != null) indicator?.period = res;
                  },
                  autofocus: false,
                  controller: periodController,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.numberWithOptions(signed: false),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 11.0),
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(3),
                    NumericalRangeFormatter(min: 1, max: 100),
                  ],
                ),
              ),
              margin: EdgeInsets.zero,
            ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            PropertiesItemWidget(
              title: 'Shift',
              margin: EdgeInsets.zero,
              child: SizedBox(
                width: 60.0,
                height: 20.0,
                child: TextField(
                  cursorHeight: 12.0,
                  autofocus: false,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Colors.blueAccent,
                      ),
                  onChanged: (value) {
                    final res = int.tryParse(value);
                    if (res != null) indicator?.shift = res;
                  },
                  controller: shiftController,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.numberWithOptions(signed: false),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 11.0),
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(4),
                    NumericalRangeFormatter(min: 1, max: 1000),
                  ],
                ),
              ),
              onTap: () {},
            ),
            if (widget.haveDeviations)
              Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            if (widget.haveDeviations)
              PropertiesItemWidget(
                title: 'Deviations',
                margin: EdgeInsets.zero,
                child: SizedBox(
                  width: 60.0,
                  height: 20.0,
                  child: TextField(
                    cursorHeight: 12.0,
                    autofocus: false,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Colors.blueAccent,
                        ),
                    onChanged: (value) {
                      final res = double.tryParse(value);
                      if (res != null) indicator?.deviations = res;
                    },
                    controller: deviationsController,
                    textAlignVertical: TextAlignVertical.center,
                    keyboardType:
                        TextInputType.numberWithOptions(signed: false),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 11.0),
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(6),
                      NumericalDoubleRangeFormatter(min: 0, max: 100),
                    ],
                  ),
                ),
                onTap: () {},
              ),
            if (widget.haveMethods)
              Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            if (widget.haveMethods)
              PropertiesItemWidget(
                title: 'Method',
                subTitle: (setMethod(indicator)?.name ?? 'Sample')
                    .replaceAll('_', ' '),
                margin: EdgeInsets.zero,
                subTitleColor: Colors.grey.withOpacity(0.8),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => IndicatorMethodsScreen(
                        method: setMethod(indicator),
                        onMethod: (method) {
                          _setType(method);
                          setState(() {});
                        },
                      ),
                    ),
                  );
                },
              ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            PropertiesItemWidget(
              title: 'Apply To',
              subTitle: indicator!.applyTo.name
                  .replaceAll('__', '/')
                  .replaceAll('_', ' '),
              margin: EdgeInsets.zero,
              subTitleColor: Colors.grey.withOpacity(0.8),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ApplyToScreen(
                      apply: indicator?.applyTo,
                      showIndicatorsOption: indicator?.isSecondary == true,
                      onApply: (apply) {
                        indicator?.applyTo = apply;
                        setState(() {});
                      },
                    ),
                  ),
                );
              },
            ),
            if (widget.haveLevels) PropertiesTitleWidget(title: 'LEVELS'),
            if (widget.haveLevels)
              PropertiesItemWidget(
                title: 'Levels',
                margin: EdgeInsets.zero,
                subTitleColor: Colors.grey.withOpacity(0.8),
                onTap: () {},
              ),
            if (widget.haveTimeframe)
              PropertiesTitleWidget(title: 'visualization'),
            if (widget.haveTimeframe)
              PropertiesItemWidget(
                title: 'Timeframe',
                subTitle: 'All timeframes',
                margin: EdgeInsets.zero,
                subTitleColor: Colors.grey.withOpacity(0.8),
                onTap: () {},
              ),
            PropertiesTitleWidget(title: 'style'),
            if (widget.havePixels)
              PropertiesItemWidget(
                title: 'Pixel',
                subTitle: '${indicator?.strokeWidth ?? 1} Pixel',
                margin: EdgeInsets.zero,
                subTitleColor: Colors.grey.withOpacity(0.8),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => IndicatorPixelsScreen(
                        pixel: indicator?.strokeWidth,
                        onConfirm: (pixel) {
                          indicator?.strokeWidth = pixel;
                          setState(() {});
                        },
                      ),
                    ),
                  );
                },
              ),
            if (widget.havePixels)
              Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            IndicatorColorWidget(
              title: widget.haveTwoBands ? 'Upper Band ' : 'Style ',
              color: colorFromHex(indicator?.color ?? ''),
              hideDrawAsBackground: widget.haveTwoBands,
              drawAsBackground: indicator?.drawAsBackground,
              onChange: (color, drawAsBackground) {
                indicator?.color = color.toHexString();
                if (!widget.haveTwoBands) {
                  indicator?.drawAsBackground = drawAsBackground;
                }
              },
              // hideStyle: true,
              // strokeWidth: indicator?.strokeWidth,
              // style: indicator?.style,
              // onChange: (color, drawAsBackground, strokeWidth, style) {
              //   indicator?.style = style;
              //   indicator?.strokeWidth = strokeWidth;
              //   indicator?.color = color;
              // },
            ),
            if (widget.haveTwoBands)
              Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            if (widget.haveTwoBands)
              IndicatorColorWidget(
                title: 'Lower Band ',
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

  void _onDone() {
    if (indicator!.isSecondary) {
      if (widget.indicator == null) {
        chartProperties.addSecondaryIndicator(indicator!, widget.windowId);
      } else {
        chartProperties.updateSecondaryIndicator(indicator!);
      }
    } else {
      if (widget.indicator == null) {
        chartProperties.addIndicator(indicator!);
      } else {
        chartProperties.updateIndicator(indicator!);
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
