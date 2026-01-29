import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/indicators/widgets/top_header_widget.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/objects/bottom_sheets/datepicker.dart';
import 'package:candle_chart/objects/properties/horizontal_line_properties_screen.dart';
import 'package:candle_chart/objects/widgets/object_style_widget.dart';
import 'package:candle_chart/objects/widgets/properties_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class VerticalLinePropertiesScreen extends StatefulWidget {
  static const id = 'VerticalLinePropertiesScreen';
  final Function(ObjectType? type) onDone;
  final ObjectEntity? object;
  final List<KLineEntity> data;
  final ChartStyle chartStyle;

  const VerticalLinePropertiesScreen({
    super.key,
    required this.onDone,
    this.data = const [],
    required this.object,
    required this.chartStyle,
  });

  @override
  State<VerticalLinePropertiesScreen> createState() =>
      _VerticalLinePropertiesScreenState();
}

class _VerticalLinePropertiesScreenState
    extends State<VerticalLinePropertiesScreen> {
  late final ObjectEntity object = widget.object ?? ObjectEntity();
  late final TextEditingController point;
  late final DateTime firstTime, lastTime, currentTime;
  final formats = [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn];
  String date = '';

  @override
  void initState() {
    ///points
    point = TextEditingController(
      text: object.value.toStringAsFixed(widget.chartStyle.digits),
    );

    ///datetime
    lastTime = chartProperties.getTime(widget.data.last.time);
    firstTime = chartProperties.getTime(widget.data[0].time);
    currentTime = chartProperties.getTime(widget.object!.datetime);

    ///date
    date = dateFormat(currentTime, formats);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 50.0),
        child: SafeArea(
          child: TopHeaderWidget(
            title: context.tr.properties,
            onBack: () => Navigator.of(context).pop(),
            onDone: () async {
              Navigator.of(context).pop();
              await chartProperties.updateVerticalLine(object);
              widget.onDone(null);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PropertiesTitleWidget(title: context.tr.parameters), // استبدال النص
            PropertiesItemWidget(
              title: context.tr.name, // استبدال النص
              subTitle: object.name,
              margin: EdgeInsets.zero,
            ),
            PropertiesTitleWidget(
                title: context.tr.coordinates), // استبدال النص
            PropertiesItemWidget(
              title: context.tr.date, // استبدال النص
              onTap: () async {
                setDatePicker(
                  maxDateTime: lastTime,
                  minDateTime: firstTime,
                  currentTime: currentTime,
                  context: context,
                  onChange: (value) {
                    if (value != null) {
                      date = dateFormat(value, formats);
                      object.datetime = value.millisecondsSinceEpoch;
                      setState(() {});
                    }
                  },
                );
              },
              child: Text(
                date,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            PropertiesTitleWidget(
                title: context.tr.visualization), // استبدال النص
            PropertiesItemWidget(
              title: context.tr.symbol, // استبدال النص
              subTitle: object.symbol.toUpperCase(),
              margin: EdgeInsets.zero,
              subTitleColor: Colors.grey.withAlpha(80),
              onTap: () {},
            ),
            Divider(height: 1.0, color: Colors.grey.withAlpha(40)),
            PropertiesItemWidget(
              title: context.tr.timeframe, // استبدال النص
              subTitle: object.frame.name,
              margin: EdgeInsets.zero,
              subTitleColor: Colors.grey.withAlpha(80),
              onTap: () {},
            ),
            ObjectStyleWidget(
              style: object.style,
              color: colorFromHex(object.color!),
              drawAsBackground: object.drawAsBackground,
              onChange: (color, drawAsBackground, lineHeight, style) {
                object.color = color.toHexString();
                object.drawAsBackground = drawAsBackground;
                object.height = lineHeight;
                object.style = style;
              },
            ),
          ],
        ),
      ),
    );
  }
}
