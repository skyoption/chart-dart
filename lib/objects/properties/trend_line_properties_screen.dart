import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/indicators/widgets/top_header_widget.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/objects/bottom_sheets/datepicker.dart';
import 'package:candle_chart/objects/properties/horizontal_line_properties_screen.dart';
import 'package:candle_chart/objects/widgets/object_style_widget.dart';
import 'package:candle_chart/objects/widgets/properties_boolean_item_widget.dart';
import 'package:candle_chart/objects/widgets/properties_item_widget.dart';
import 'package:candle_chart/widgets/paddings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class TrendLinePropertiesScreen extends StatefulWidget {
  static const id = 'TrendLinePropertiesScreen';
  final Function(ObjectType? type) onDone;
  final ObjectEntity? object;
  final List<KLineEntity> data;

  const TrendLinePropertiesScreen({
    super.key,
    required this.onDone,
    this.data = const [],
    required this.object,
  });

  @override
  State<TrendLinePropertiesScreen> createState() =>
      _TrendLinePropertiesScreenState();
}

class _TrendLinePropertiesScreenState extends State<TrendLinePropertiesScreen> {
  late final ObjectEntity object = widget.object ?? ObjectEntity();
  late final TextEditingController point1, point2;
  late final DateTime firstTime, lastTime, current1, current2;
  final formats = [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn];
  String date1 = '', date2 = '';

  @override
  void initState() {
    ///points
    point1 = TextEditingController(text: object.value.toStringAsFixed(2));
    point2 = TextEditingController(text: object.value2.toStringAsFixed(2));

    ///datetime
    lastTime = DateTime.fromMillisecondsSinceEpoch(widget.data.last.time);
    firstTime = DateTime.fromMillisecondsSinceEpoch(widget.data[0].time);
    current1 = DateTime.fromMillisecondsSinceEpoch(widget.object!.datetime);
    current2 = DateTime.fromMillisecondsSinceEpoch(widget.object!.datetime2);

    ///date
    date1 = dateFormat(current1, formats);
    date2 = dateFormat(current2, formats);
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
              await chartProperties.updateTrendLine(object);
              widget.onDone(null);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PropertiesTitleWidget(title: context.tr.parameters),
            PropertiesItemWidget(
              title: context.tr.name,
              subTitle: object.name,
              margin: EdgeInsets.zero,
            ),
            Divider(height: 1.0, color: Colors.grey.withAlpha(40)),
            PropertiesBooleanItemWidget(
              title: context.tr.rayRight,
              value: object.rayRight,
              onChange: (value) {
                object.rayRight = value;
              },
            ),
            Divider(height: 1.0, color: Colors.grey.withAlpha(40)),
            PropertiesBooleanItemWidget(
              title: context.tr.rayLift,
              value: object.rayLift,
              onChange: (value) {
                object.rayLift = value;
              },
            ),
            PropertiesTitleWidget(title: context.tr.coordinates),
            PropertiesItemWidget(
              title: context.tr.point1,
              margin: MPadding.set(),
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
                    if (value.isNotEmpty) {
                      object.value = double.parse(value);
                    }
                  },
                  controller: point1,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.numberWithOptions(signed: false),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 11.0),
                  ),
                ),
              ),
            ),
            Divider(height: 1.0, color: Colors.grey.withAlpha(40)),
            PropertiesItemWidget(
              title: context.tr.date,
              onTap: () {
                setDatePicker(
                  maxDateTime: lastTime,
                  minDateTime: firstTime,
                  currentTime: current1,
                  context: context,
                  onChange: (value) {
                    if (value != null) {
                      date1 = dateFormat(value, formats);
                      object.datetime = value.millisecondsSinceEpoch;
                      setState(() {});
                    }
                  },
                );
              },
              child: Text(
                date1,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            PropertiesItemWidget(
              title: context.tr.point2,
              margin: MPadding.set(top: 6.0),
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
                    if (value.isNotEmpty) {
                      object.value2 = double.parse(value);
                    }
                  },
                  controller: point2,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.numberWithOptions(signed: false),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 11.0),
                  ),
                ),
              ),
            ),
            Divider(height: 1.0, color: Colors.grey.withAlpha(40)),
            PropertiesItemWidget(
              title: context.tr.date,
              onTap: () {
                setDatePicker(
                  context: context,
                  maxDateTime: lastTime,
                  minDateTime: firstTime,
                  currentTime: current2,
                  onChange: (value) {
                    if (value != null) {
                      date2 = dateFormat(value, formats);
                      object.datetime2 = value.millisecondsSinceEpoch;
                      setState(() {});
                    }
                  },
                );
              },
              child: Text(
                date2,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            PropertiesTitleWidget(title: context.tr.visualization),
            PropertiesItemWidget(
              title: context.tr.symbol,
              subTitle: object.symbol.toUpperCase(),
              margin: EdgeInsets.zero,
              subTitleColor: Colors.grey.withAlpha(80),
              onTap: () {},
            ),
            Divider(height: 1.0, color: Colors.grey.withAlpha(40)),
            PropertiesItemWidget(
              title: context.tr.timeframe,
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

  @override
  void dispose() {
    point1.dispose();
    point2.dispose();
    super.dispose();
  }
}
