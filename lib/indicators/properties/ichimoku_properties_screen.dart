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
  final Map<String, String> enTranslations = {
    'properties': 'Properties',
    'done': 'Done',
    'tenkan_sen': 'Tenkan-sen:',
    'kiju_sen': 'Kiju-sen:',
    'senkou_span_b': 'Senkou-span B:',
    'style': 'Style',
    'chikou_span': 'Chikou Span:',
    'up_kumo': 'Up Kumo:',
    'down_kumo': 'Down Kumo:',
  };

  final Map<String, String> arTranslations = {
    'properties': 'الخصائص',
    'done': 'تم',
    'tenkan_sen': 'تينكان-سن:',
    'kiju_sen': 'كيجو-سن:',
    'senkou_span_b': 'سينكو-سبان B:',
    'style': 'النمط',
    'chikou_span': 'شيكو سبان:',
    'up_kumo': 'كومو العلوي:',
    'down_kumo': 'كومو السفلي:',
  };

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
                    context.tr.properties,
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
                      context.tr.done,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PropertiesTitleWidget(title: name.toUpperCase()),
            PropertiesItemWidget(
              title: context.tr.tenkan_sen,
              child: buildTextField(tenkanSenController, (value) {
                final res = int.tryParse(value);
                if (res != null) indicator!.ichimoku!.tenkanSen = res;
              }),
            ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            PropertiesItemWidget(
              title: context.tr.kiju_sen,
              child: buildTextField(kijuSenController, (value) {
                final res = int.tryParse(value);
                if (res != null) indicator!.ichimoku!.kijuSen = res;
              }),
            ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            PropertiesItemWidget(
              title: context.tr.senkou_span_b,
              child: buildTextField(senkouSpanController, (value) {
                final res = int.tryParse(value);
                if (res != null) indicator!.ichimoku!.senkouSpan = res;
              }),
            ),
            PropertiesTitleWidget(title: context.tr.style),
            IndicatorColorWidget(
              title: context.tr.tenkan_sen,
              color: colorFromHex(indicator!.ichimoku!.tenkanSenColor!),
              onChange: (color, _) => indicator!.ichimoku!.tenkanSenColor = color.toHexString(),
            ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            IndicatorColorWidget(
              title: context.tr.kiju_sen,
              color: colorFromHex(indicator!.ichimoku!.kijuSenColor!),
              onChange: (color, _) => indicator!.ichimoku!.kijuSenColor = color.toHexString(),
            ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            IndicatorColorWidget(
              title: context.tr.chikou_span,
              color: colorFromHex(indicator!.ichimoku!.chikouSpanColor!),
              onChange: (color, _) => indicator!.ichimoku!.chikouSpanColor = color.toHexString(),
            ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            IndicatorColorWidget(
              title: context.tr.up_kumo,
              color: colorFromHex(indicator!.ichimoku!.upKumoColor!),
              onChange: (color, _) => indicator!.ichimoku!.upKumoColor = color.toHexString(),
            ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            IndicatorColorWidget(
              drawAsBackground: indicator!.drawAsBackground,
              hideDrawAsBackground: false,
              title: context.tr.down_kumo,
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

  Widget buildTextField(TextEditingController controller, Function(String) onChanged) {
    return SizedBox(
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
        onChanged: onChanged,
        controller: controller,
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
