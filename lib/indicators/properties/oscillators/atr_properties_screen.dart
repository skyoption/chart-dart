import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/indicators/widgets/indicator_color_widget.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/objects/properties/horizontal_line_properties_screen.dart';
import 'package:candle_chart/objects/widgets/properties_item_widget.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../indicator_properties_screen.dart';

@immutable
class ATRPropertiesScreen extends StatefulWidget {
  final String? name;
  final IndicatorEntity? indicator;
  final int? windowId;
  final Function onDone;

  ATRPropertiesScreen({
    super.key,
    required this.onDone,
    this.name,
    this.windowId,
    this.indicator,
  });

  @override
  State<ATRPropertiesScreen> createState() => _ATRPropertiesScreenState();
}

class _ATRPropertiesScreenState extends State<ATRPropertiesScreen> {
  late final periodController = TextEditingController(text: '14');

  late String name = widget.name ?? widget.indicator!.name;
  IndicatorEntity? indicator;

  @override
  void initState() {
    if (widget.indicator != null) {
      indicator = widget.indicator;
      periodController.text = indicator!.period.toString();
    } else {
      indicator = IndicatorEntity(
        period: 14,
        name: widget.name!,
        type: IndicatorType.ATR,
        levels: [],
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
            PropertiesTitleWidget(
              title: name.toUpperCase(),
            ),
            PropertiesItemWidget(
              title: context.tr.period,
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
                    if (res != null) indicator!.period = res;
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
              title: context.tr.levels,
              margin: EdgeInsets.zero,
              subTitleColor: Colors.grey.withOpacity(0.8),
              subTitle: indicator!.levels.join(', '),
              onTap: () {},
            ),
            PropertiesTitleWidget(title: context.tr.visualization),
            PropertiesItemWidget(
              title: context.tr.timeframe,
              subTitle: context.tr.all_timeframes,
              margin: EdgeInsets.zero,
              subTitleColor: Colors.grey.withOpacity(0.8),
              onTap: () {},
            ),
            PropertiesTitleWidget(title: context.tr.style),
            PropertiesItemWidget(
              title: context.tr.pixel,
              subTitle: '${widget.indicator?.strokeWidth ?? 1} ${context.tr.pixel}',
              margin: EdgeInsets.zero,
              subTitleColor: Colors.grey.withOpacity(0.8),
              onTap: () {},
            ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            IndicatorColorWidget(
              title: context.tr.style,
              color: colorFromHex(indicator?.color ?? ''),
              onChange: (color, drawAsBackground) {
                indicator!.color = color.toHexString();
              },
            ),
          ],
        ),
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
    periodController.dispose();
    super.dispose();
  }
}
