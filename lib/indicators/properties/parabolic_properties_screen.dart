import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/indicators/properties/indicator_properties_screen.dart';
import 'package:candle_chart/indicators/widgets/indicator_color_widget.dart';
import 'package:candle_chart/indicators/widgets/top_header_widget.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/objects/properties/horizontal_line_properties_screen.dart';
import 'package:candle_chart/objects/widgets/properties_item_widget.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';
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
            onDone: () {
              _onDone();
            },
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
              title: context.tr.steps,
              child: SizedBox(
                width: 60.0,
                height: 20.0,
                child: TextField(
                  cursorHeight: 12.0,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: KChartWidget.colors!.primary,
                      ),
                  onChanged: (value) {
                    final res = double.tryParse(value);
                    if (res != null) indicator?.steps = res;
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
              title: context.tr.maximum,
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
                        color: KChartWidget.colors!.primary,
                      ),
                  onChanged: (value) {
                    final res = double.tryParse(value);
                    if (res != null) indicator?.maximum = res;
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
            PropertiesTitleWidget(title: context.tr.style),
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
