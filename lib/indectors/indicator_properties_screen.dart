import 'dart:math';

import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/functions/object_properties_screen.dart';
import 'package:candle_chart/functions/widgets/object_style_widget.dart';
import 'package:candle_chart/functions/widgets/properties_item_widget.dart';
import 'package:candle_chart/indectors/apply_to_screen.dart';
import 'package:candle_chart/indectors/ma_methods_screen.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IndicatorPropertiesScreen extends StatefulWidget {
  final Function onDone;
  String? name;
  IndicatorEntity? indicator;
  final int? index;

  IndicatorPropertiesScreen({
    super.key,
    required this.onDone,
    this.name,
    this.index,
    this.indicator,
  });

  @override
  State<IndicatorPropertiesScreen> createState() =>
      _IndicatorPropertiesScreenState();
}

class _IndicatorPropertiesScreenState extends State<IndicatorPropertiesScreen> {
  late final periodController = TextEditingController(text: '5');
  late final shiftController = TextEditingController(text: '0');

  @override
  void initState() {
    if (widget.indicator != null) {
      widget.name = widget.indicator!.name;
      periodController.text = widget.indicator!.period.toString();
      shiftController.text = widget.indicator!.shift.toString();
    } else {
      widget.indicator = IndicatorEntity(
        period: 5,
        shift: 0,
        name: widget.name!,
        applyTo: ApplyTo.Close,
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
            PropertiesTitleWidget(title: widget.indicator!.name.toUpperCase()),
            PropertiesItemWidget(
              title: 'Period',
              child: SizedBox(
                width: 60.0,
                height: 18.0,
                child: TextField(
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Colors.blueAccent,
                      ),
                  onChanged: (value) {
                    final res = int.tryParse(value);
                    if (res != null) widget.indicator?.period = res;
                  },
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
                height: 18.0,
                child: TextField(
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
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            PropertiesItemWidget(
              title: 'Method',
              subTitle: _setMethod(widget.indicator?.type)?.name ?? 'Sample',
              margin: EdgeInsets.zero,
              subTitleColor: Colors.grey.withOpacity(0.8),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MAMethodsScreen(
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
              subTitle: widget.indicator?.applyTo.name ?? 'Close',
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
            PropertiesTitleWidget(title: 'LEVELS'),
            PropertiesItemWidget(
              title: 'Levels',
              margin: EdgeInsets.zero,
              subTitleColor: Colors.grey.withOpacity(0.8),
              onTap: () {},
            ),
            PropertiesTitleWidget(title: 'visualization'),
            PropertiesItemWidget(
              title: 'Timeframe',
              subTitle: 'All timeframes',
              margin: EdgeInsets.zero,
              subTitleColor: Colors.grey.withOpacity(0.8),
              onTap: () {},
            ),
            ObjectStyleWidget(
              hideStyle: true,
              hideDrawAsBackground: true,
              color: widget.indicator?.color,
              strokeWidth: widget.indicator?.strokeWidth,
              style: widget.indicator?.style,
              onChange: (color, drawAsBackground, strokeWidth, style) {
                widget.indicator?.style = style;
                widget.indicator?.strokeWidth = strokeWidth;
                widget.indicator?.color = color;
              },
            ),
          ],
        ),
      ),
    );
  }

  void _setType(method) {
    widget.indicator?.type = method == Methods.Exponential
        ? IndicatorType.EMA
        : method == Methods.Linear_Weighted
            ? IndicatorType.LINEARMA
            : method == Methods.Simple
                ? IndicatorType.SMA
                : IndicatorType.SMMA;
  }

  Methods? _setMethod(IndicatorType? type) {
    if (widget.indicator == null) return null;
    if (type == IndicatorType.EMA) {
      return Methods.Exponential;
    } else if (type == IndicatorType.LINEARMA) {
      return Methods.Linear_Weighted;
    } else if (type == IndicatorType.SMA) {
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
