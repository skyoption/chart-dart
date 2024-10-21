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
class IchimokuPropertiesScreen extends StatefulWidget {
  String? name;
  IndicatorEntity? indicator;
  final int? index;
  final Function onDone;

  IchimokuPropertiesScreen({
    super.key,
    required this.onDone,
    this.name,
    this.index,
    this.indicator,
  });

  @override
  State<IchimokuPropertiesScreen> createState() =>
      _IchimokuPropertiesScreenState();
}

class _IchimokuPropertiesScreenState extends State<IchimokuPropertiesScreen> {
  late final tenkanSenController = TextEditingController(text: '9');
  late final kijuSenController = TextEditingController(text: '26');
  late final senkouSpanController = TextEditingController(text: '52');

  @override
  void initState() {
    if (widget.indicator != null) {
      widget.name = widget.indicator!.name;
      tenkanSenController.text =
          widget.indicator!.ichimoku!.tenkanSen.toString();
      kijuSenController.text = widget.indicator!.ichimoku!.kijuSen.toString();
      senkouSpanController.text =
          widget.indicator!.ichimoku!.senkouSpan.toString();
    } else {
      widget.indicator = IndicatorEntity(
        name: widget.name!,
        ichimoku: Ichimoku(),
        type: IndicatorType.ICHIMOKU,
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
              title: 'Tenkan-sen:',
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
                    if (res != null)
                      widget.indicator!.ichimoku!.tenkanSen = res;
                  },
                  autofocus: false,
                  controller: tenkanSenController,
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
              title: 'Kiju-sen:',
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
                    if (res != null) widget.indicator!.ichimoku!.kijuSen = res;
                  },
                  controller: kijuSenController,
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
              onTap: () {},
            ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            PropertiesItemWidget(
              title: 'Senkou-span B:',
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
                    if (res != null)
                      widget.indicator!.ichimoku!.senkouSpan = res;
                  },
                  controller: senkouSpanController,
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
              onTap: () {},
            ),
            PropertiesTitleWidget(title: 'style'),
            IndicatorColorWidget(
              title: 'Tenkan-sen:',
              color: colorFromHex(widget.indicator!.ichimoku!.tenkanSenColor!),
              onChange: (color, drawAsBackground) {
                widget.indicator!.ichimoku!.tenkanSenColor = color.toHexString();
              },
            ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            IndicatorColorWidget(
              title: 'Kiju-sen:',
              color: colorFromHex(widget.indicator!.ichimoku!.kijuSenColor!),
              onChange: (color, drawAsBackground) {
                widget.indicator!.ichimoku!.kijuSenColor = color.toHexString();
              },
            ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            IndicatorColorWidget(
              title: 'Chikou Span:',
              color: colorFromHex(widget.indicator!.ichimoku!.chikouSpanColor!),
              onChange: (color, drawAsBackground) {
                widget.indicator!.ichimoku!.chikouSpanColor = color.toHexString();
              },
            ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            IndicatorColorWidget(
              title: 'Up Kumo:',
              color:colorFromHex( widget.indicator!.ichimoku!.upKumoColor!),
              onChange: (color, drawAsBackground) {
                widget.indicator!.ichimoku!.upKumoColor = color.toHexString();
              },
            ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            IndicatorColorWidget(
              drawAsBackground: widget.indicator!.drawAsBackground,
              hideDrawAsBackground: false,
              title: 'Down Kumo:',
              color: colorFromHex(widget.indicator!.ichimoku!.downKumoColor!),
              onChange: (color, drawAsBackground) {
                widget.indicator!.ichimoku!.downKumoColor = color.toHexString();
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
    kijuSenController.dispose();
    senkouSpanController.dispose();
    tenkanSenController.dispose();
    super.dispose();
  }
}
