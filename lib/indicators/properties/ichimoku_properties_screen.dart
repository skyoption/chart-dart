import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/indicators/properties/indicator_properties_screen.dart';
import 'package:candle_chart/indicators/widgets/indicator_color_widget.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/objects/properties/horizontal_line_properties_screen.dart';
import 'package:candle_chart/objects/widgets/properties_item_widget.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

@immutable
class IchimokuPropertiesScreen extends StatefulWidget {
  final String? name;
  final IndicatorEntity? indicator;
  final Function onDone;
  final int? windowId;

  IchimokuPropertiesScreen({
    super.key,
    required this.onDone,
    this.name,
    this.indicator,
    this.windowId,
  });

  @override
  State<IchimokuPropertiesScreen> createState() =>
      _IchimokuPropertiesScreenState();
}

class _IchimokuPropertiesScreenState extends State<IchimokuPropertiesScreen> {
  late final tenkanSenController = TextEditingController(text: '9');
  late final kijuSenController = TextEditingController(text: '26');
  late final senkouSpanController = TextEditingController(text: '52');
  late String name = widget.name ?? widget.indicator!.name;
  IndicatorEntity? indicator;

  @override
  void initState() {
    if (widget.indicator != null) {
      indicator = widget.indicator;
      tenkanSenController.text = indicator!.ichimoku!.tenkanSen.toString();
      kijuSenController.text = indicator!.ichimoku!.kijuSen.toString();
      senkouSpanController.text = indicator!.ichimoku!.senkouSpan.toString();
    } else {
      indicator = IndicatorEntity(
        name: widget.name!,
        ichimoku: Ichimoku(),
        type: IndicatorType.ICHIMOKU,
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
                      color: KChartWidget.colors!.iconColor,
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
                            color: KChartWidget.colors!.primary,
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
              title: 'Tenkan-sen:',
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
                    final res = int.tryParse(value);
                    if (res != null) indicator!.ichimoku!.tenkanSen = res;
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
                        color: KChartWidget.colors!.primary,
                      ),
                  onChanged: (value) {
                    final res = int.tryParse(value);
                    if (res != null) indicator!.ichimoku!.kijuSen = res;
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
                        color: KChartWidget.colors!.primary,
                      ),
                  onChanged: (value) {
                    final res = int.tryParse(value);
                    if (res != null) indicator!.ichimoku!.senkouSpan = res;
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
              color: colorFromHex(indicator!.ichimoku!.tenkanSenColor!),
              onChange: (color, drawAsBackground) {
                indicator!.ichimoku!.tenkanSenColor = color.toHexString();
              },
            ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            IndicatorColorWidget(
              title: 'Kiju-sen:',
              color: colorFromHex(indicator!.ichimoku!.kijuSenColor!),
              onChange: (color, drawAsBackground) {
                indicator!.ichimoku!.kijuSenColor = color.toHexString();
              },
            ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            IndicatorColorWidget(
              title: 'Chikou Span:',
              color: colorFromHex(indicator!.ichimoku!.chikouSpanColor!),
              onChange: (color, drawAsBackground) {
                indicator!.ichimoku!.chikouSpanColor = color.toHexString();
              },
            ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            IndicatorColorWidget(
              title: 'Up Kumo:',
              color: colorFromHex(indicator!.ichimoku!.upKumoColor!),
              onChange: (color, drawAsBackground) {
                indicator!.ichimoku!.upKumoColor = color.toHexString();
              },
            ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            IndicatorColorWidget(
              drawAsBackground: indicator!.drawAsBackground,
              hideDrawAsBackground: false,
              title: 'Down Kumo:',
              color: colorFromHex(indicator!.ichimoku!.downKumoColor!),
              onChange: (color, drawAsBackground) {
                indicator!.ichimoku!.downKumoColor = color.toHexString();
                indicator!.drawAsBackground = drawAsBackground;
              },
            ),
          ],
        ),
      ),
    );
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
    kijuSenController.dispose();
    senkouSpanController.dispose();
    tenkanSenController.dispose();
    super.dispose();
  }
}
