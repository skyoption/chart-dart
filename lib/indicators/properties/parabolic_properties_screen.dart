import 'package:candle_chart/utils/kprint.dart';
import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/indicators/properties/indicator_properties_screen.dart';
import 'package:candle_chart/indicators/widgets/indicator_color_widget.dart';
import 'package:candle_chart/objects/object_properties_screen.dart';
import 'package:candle_chart/objects/widgets/properties_item_widget.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

@immutable
class ParabolicPropertiesScreen extends StatefulWidget {
  String? name;
  IndicatorEntity? indicator;
  final int? index;
  final Function onDone;

  ParabolicPropertiesScreen({
    super.key,
    required this.onDone,
    this.name,
    this.index,
    this.indicator,
  });

  @override
  State<ParabolicPropertiesScreen> createState() =>
      _ParabolicPropertiesScreenState();
}

class _ParabolicPropertiesScreenState extends State<ParabolicPropertiesScreen> {
  late final stepsController = TextEditingController(text: '0.006');
  late final maximumController = TextEditingController(text: '0.006');

  @override
  void initState() {
    if (widget.indicator != null) {
      widget.name = widget.indicator!.name;
      stepsController.text = widget.indicator!.steps.toString();
      maximumController.text = widget.indicator!.maximum.toString();
    } else {
      widget.indicator = IndicatorEntity(
        maximum: 0.006,
        steps: 0.006,
        name: widget.name!,
        type: IndicatorType.PARABOLIC,
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
              title: 'Steps',
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
                    final res = double.tryParse(value);
                    if (res != null) widget.indicator?.steps = res;
                  },
                  autofocus: false,
                  controller: stepsController,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.numberWithOptions(signed: false),
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
              margin: EdgeInsets.zero,
            ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            PropertiesItemWidget(
              title: 'Maximum',
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
                    if (res != null) widget.indicator?.maximum = res;
                  },
                  controller: maximumController,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.numberWithOptions(signed: false),
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
            PropertiesTitleWidget(title: 'style'),
            IndicatorColorWidget(
              title: 'Style :',
              color: colorFromHex(widget.indicator!.color!),
              hideDrawAsBackground: false,
              drawAsBackground: widget.indicator!.drawAsBackground,
              onChange: (color, drawAsBackground) {
                widget.indicator?.color = color.toHexString();
                widget.indicator?.drawAsBackground = drawAsBackground;
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    stepsController.dispose();
    maximumController.dispose();
    super.dispose();
  }
}
