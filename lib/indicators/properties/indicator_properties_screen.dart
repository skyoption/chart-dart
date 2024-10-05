import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/indicators/widgets/indicator_color_widget.dart';
import 'package:candle_chart/objects/object_properties_screen.dart';
import 'package:candle_chart/objects/widgets/properties_item_widget.dart';
import 'package:candle_chart/indicators/apply_to_screen.dart';
import 'package:candle_chart/indicators/indicators_methods_screen.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

@immutable
class IndicatorPropertiesScreen extends StatefulWidget {
  String? name;
  IndicatorEntity? indicator;
  final int? index;
  final Function onDone;
  final IndicatorType type;
  final bool haveDeviations,
      haveMethods,
      haveTimeframe,
      haveLevels,
      haveTwoBands,
      isENVELOPS;

  IndicatorPropertiesScreen({
    super.key,
    required this.onDone,
    this.name,
    this.index,
    this.indicator,
    this.haveDeviations = false,
    this.haveTimeframe = false,
    this.haveLevels = false,
    this.haveMethods = false,
    this.haveTwoBands = false,
    this.isENVELOPS = false,
    this.type = IndicatorType.SMA_MA,
  });

  @override
  State<IndicatorPropertiesScreen> createState() =>
      _IndicatorPropertiesScreenState();
}

class _IndicatorPropertiesScreenState extends State<IndicatorPropertiesScreen> {
  late final periodController = TextEditingController(text: '5');
  late final shiftController = TextEditingController(text: '0');
  late final deviationsController = TextEditingController(text: '2.000');

  @override
  void initState() {
    if (widget.indicator != null) {
      widget.name = widget.indicator!.name;
      periodController.text = widget.indicator!.period.toString();
      shiftController.text = widget.indicator!.shift.toString();
      deviationsController.text = widget.indicator!.deviations.toString();
    } else {
      widget.indicator = IndicatorEntity(
        period: 5,
        shift: 0,
        name: widget.name!,
        applyTo: ApplyTo.Close,
        type: widget.type,
        deviations: widget.haveDeviations ? 2.000 : null,
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 50.0),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 12.0,
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
                      if (widget.index == null) {
                        chartProperties.addIndicator(widget.indicator!);
                        widget.onDone();
                      } else {
                        chartProperties.updateIndicator(
                          widget.index!,
                          widget.indicator!,
                        );
                        widget.onDone();
                      }
                      Navigator.of(context).pop();
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
              title: '${widget.indicator?.name.toUpperCase()}',
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
                    if (res != null) widget.indicator?.period = res;
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
                    if (res != null) widget.indicator?.shift = res;
                  },
                  controller: shiftController,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.numberWithOptions(signed: false),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 11.0),
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(2),
                    NumericalRangeFormatter(min: 1, max: 5),
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
                      if (res != null) widget.indicator?.deviations = res;
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
                      LengthLimitingTextInputFormatter(1),
                      NumericalRangeFormatter(min: 1, max: 5),
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
                subTitle: (_setMethod(widget.indicator?.type)?.name ?? 'Sample')
                    .replaceAll('_', ' '),
                margin: EdgeInsets.zero,
                subTitleColor: Colors.grey.withOpacity(0.8),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => IndicatorMethodsScreen(
                        method: _setMethod(widget.indicator?.type),
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
              subTitle: (widget.indicator?.applyTo.name ?? 'Close')
                  .replaceAll('_', ' ')
                  .replaceAll('\$', '/'),
              margin: EdgeInsets.zero,
              subTitleColor: Colors.grey.withOpacity(0.8),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ApplyToScreen(
                      apply: widget.indicator?.applyTo,
                      onApply: (apply) {
                        widget.indicator?.applyTo = apply;
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
            IndicatorColorWidget(
              title: widget.haveTwoBands ? 'Upper Band :' : 'Style :',
              color: widget.indicator?.color,
              onChange: (color) {
                widget.indicator?.color = color;
              },
              // hideStyle: true,
              // hideDrawAsBackground: true,
              // strokeWidth: widget.indicator?.strokeWidth,
              // style: widget.indicator?.style,
              // onChange: (color, drawAsBackground, strokeWidth, style) {
              //   widget.indicator?.style = style;
              //   widget.indicator?.strokeWidth = strokeWidth;
              //   widget.indicator?.color = color;
              // },
            ),
            if (widget.haveTwoBands)
              Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            if (widget.haveTwoBands)
              IndicatorColorWidget(
                title: 'Lower Band :',
                color: widget.indicator?.secondColor,
                onChange: (color) {
                  widget.indicator?.secondColor = color;
                },
              ),
          ],
        ),
      ),
    );
  }

  void _setType(method) {
    if (widget.isENVELOPS) {
      widget.indicator?.type = method == Methods.Exponential
          ? IndicatorType.EMA_ENVELOPS
          : method == Methods.Linear_Weighted
              ? IndicatorType.LINEAR_ENVELOPS
              : method == Methods.Simple
                  ? IndicatorType.SMA_ENVELOPS
                  : IndicatorType.SMMA_ENVELOPS;
    } else {
      widget.indicator?.type = method == Methods.Exponential
          ? IndicatorType.EMA_MA
          : method == Methods.Linear_Weighted
              ? IndicatorType.LINEAR_MA
              : method == Methods.Simple
                  ? IndicatorType.SMA_MA
                  : IndicatorType.SMMA_MA;
    }
  }

  Methods? _setMethod(IndicatorType? type) {
    if (widget.indicator == null || type == null) return null;
    if (type.name.contains('EMA')) {
      return Methods.Exponential;
    } else if (type.name.contains('LINEAR')) {
      return Methods.Linear_Weighted;
    } else if (type.name.contains('SMA')) {
      return Methods.Simple;
    } else {
      return Methods.Smoothed;
    }
  }

  @override
  void dispose() {
    periodController.dispose();
    shiftController.dispose();
    super.dispose();
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
