import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/indicators/indicator_levels_screen.dart';
import 'package:candle_chart/indicators/indicator_pixels_screen.dart';
import 'package:candle_chart/indicators/widgets/indicator_color_widget.dart';
import 'package:candle_chart/objects/object_properties_screen.dart';
import 'package:candle_chart/objects/widgets/properties_item_widget.dart';
import 'package:candle_chart/indicators/apply_to_screen.dart';
import 'package:candle_chart/indicators/indicators_methods_screen.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/utils/kprint.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'indicator_properties_screen.dart';

@immutable
class RSIPropertiesScreen extends StatefulWidget {
  String? name;
  IndicatorEntity? indicator;
  final int? index;
  final Function onDone;

  RSIPropertiesScreen({
    super.key,
    required this.onDone,
    this.name,
    this.index,
    this.indicator,
  });

  @override
  State<RSIPropertiesScreen> createState() => _RSIPropertiesScreenState();
}

class _RSIPropertiesScreenState extends State<RSIPropertiesScreen> {
  late final periodController = TextEditingController(text: '5');

  @override
  void initState() {
    if (widget.indicator != null) {
      widget.name = widget.indicator!.name;
      periodController.text = widget.indicator!.period.toString();
    } else {
      widget.indicator = IndicatorEntity(
        period: 5,
        name: widget.name!,
        applyTo: ApplyTo.Close,
        type: IndicatorType.RSI,
        levels: [30, 70],
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
                      if (widget.index == null) {
                        chartProperties.addSecondaryIndicator(widget.indicator!);
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
              title: 'Apply To',
              subTitle: (widget.indicator?.applyTo.name ?? 'Close')
                  .replaceAll('_', ' ')
                  .replaceAll('__', '/'),
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
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            PropertiesItemWidget(
              title: 'Levels',
              margin: EdgeInsets.zero,
              subTitleColor: Colors.grey.withOpacity(0.8),
              subTitle: widget.indicator?.levels.join(', '),
              onTap: () {
                kPrint(widget.indicator?.levelsColor);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => IndicatorLevelsScreen(
                      color: widget.indicator?.levelsColor ?? '',
                      setLevels: (color, levels) {
                        widget.indicator?.levels = levels;
                        widget.indicator?.levelsColor = color;
                        setState(() {});
                        kPrint(widget.indicator?.levelsColor);
                      },
                      levels: widget.indicator?.levels,
                    ),
                  ),
                );
              },
            ),
            PropertiesTitleWidget(title: 'visualization'),
            PropertiesItemWidget(
              title: 'Timeframe',
              subTitle: 'All timeframes',
              margin: EdgeInsets.zero,
              subTitleColor: Colors.grey.withOpacity(0.8),
              onTap: () {},
            ),
            PropertiesTitleWidget(title: 'style'),
            PropertiesItemWidget(
              title: 'Pixel',
              subTitle: '${widget.indicator?.strokeWidth ?? 1} Pixel',
              margin: EdgeInsets.zero,
              subTitleColor: Colors.grey.withOpacity(0.8),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => IndicatorPixelsScreen(
                      pixel: widget.indicator?.strokeWidth,
                      onConfirm: (pixel) {
                        widget.indicator?.strokeWidth = pixel;
                        setState(() {});
                      },
                    ),
                  ),
                );
              },
            ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            IndicatorColorWidget(
              title: 'Style ',
              color: colorFromHex(widget.indicator?.color ?? ''),
              onChange: (color, drawAsBackground) {
                widget.indicator?.color = color.toHexString();
              },
              // hideStyle: true,
              // strokeWidth: widget.indicator?.strokeWidth,
              // style: widget.indicator?.style,
              // onChange: (color, drawAsBackground, strokeWidth, style) {
              //   widget.indicator?.style = style;
              //   widget.indicator?.strokeWidth = strokeWidth;
              //   widget.indicator?.color = color;
              // },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    periodController.dispose();
    super.dispose();
  }
}
