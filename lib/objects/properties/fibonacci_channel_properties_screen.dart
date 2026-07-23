import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/indicators/widgets/top_header_widget.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/objects/bottom_sheets/datepicker.dart';
import 'package:candle_chart/objects/properties/horizontal_line_properties_screen.dart';
import 'package:candle_chart/objects/properties/levels_editor_screen.dart';
import 'package:candle_chart/objects/widgets/object_style_widget.dart';
import 'package:candle_chart/objects/widgets/properties_boolean_item_widget.dart';
import 'package:candle_chart/objects/widgets/properties_item_widget.dart';
import 'package:candle_chart/widgets/paddings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class FibonacciChannelPropertiesScreen extends StatefulWidget {
  static const id = 'FibonacciChannelPropertiesScreen';
  final Function(ObjectType? type) onDone;
  final ObjectEntity? object;
  final List<KLineEntity> data;
  final ChartStyle chartStyle;

  const FibonacciChannelPropertiesScreen({
    super.key,
    required this.onDone,
    this.data = const [],
    required this.object,
    required this.chartStyle,
  });

  @override
  State<FibonacciChannelPropertiesScreen> createState() =>
      _FibonacciChannelPropertiesScreenState();
}

class _FibonacciChannelPropertiesScreenState
    extends State<FibonacciChannelPropertiesScreen> {
  late final ObjectEntity object = widget.object ?? ObjectEntity();
  late final TextEditingController point1, point2, point3;
  late final DateTime firstTime, lastTime, current1, current2, current3;
  final formats = [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn];
  String date1 = '', date2 = '', date3 = '';

  @override
  void initState() {
    final digits = widget.chartStyle.digits;
    point1 = TextEditingController(text: object.value.toStringAsFixed(digits));
    point2 = TextEditingController(text: object.value2.toStringAsFixed(digits));
    point3 = TextEditingController(text: object.value3.toStringAsFixed(digits));

    lastTime = chartProperties.getTime(widget.data.last.time);
    firstTime = chartProperties.getTime(widget.data[0].time);
    current1 = chartProperties.getTime(object.datetime);
    current2 = chartProperties.getTime(object.datetime2);
    current3 = chartProperties.getTime(
      object.datetime3 == 0 ? object.datetime : object.datetime3,
    );

    date1 = dateFormat(current1, formats);
    date2 = dateFormat(current2, formats);
    date3 = dateFormat(current3, formats);
    super.initState();
  }

  Widget _priceField(TextEditingController controller, void Function(double) set) {
    return SizedBox(
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
          if (value.isNotEmpty) set(double.parse(value));
        },
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.numberWithOptions(signed: false),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 11.0),
        ),
      ),
    );
  }

  Widget _dateRow(String date, DateTime current, void Function(DateTime) set) {
    return PropertiesItemWidget(
      title: context.tr.date,
      onTap: () {
        setDatePicker(
          maxDateTime: lastTime,
          minDateTime: firstTime,
          currentTime: current,
          context: context,
          onChange: (value) {
            if (value != null) {
              set(value);
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
    );
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
              await chartProperties.updateFibonacciChannel(object);
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
              child: _priceField(point1, (v) => object.value = v),
            ),
            Divider(height: 1.0, color: Colors.grey.withAlpha(40)),
            _dateRow(date1, current1, (v) {
              date1 = dateFormat(v, formats);
              object.datetime = v.millisecondsSinceEpoch;
            }),
            PropertiesItemWidget(
              title: context.tr.point2,
              margin: MPadding.set(top: 6.0),
              child: _priceField(point2, (v) => object.value2 = v),
            ),
            Divider(height: 1.0, color: Colors.grey.withAlpha(40)),
            _dateRow(date2, current2, (v) {
              date2 = dateFormat(v, formats);
              object.datetime2 = v.millisecondsSinceEpoch;
            }),
            PropertiesItemWidget(
              title: context.tr.point3,
              margin: MPadding.set(top: 6.0),
              child: _priceField(point3, (v) => object.value3 = v),
            ),
            Divider(height: 1.0, color: Colors.grey.withAlpha(40)),
            _dateRow(date3, current3, (v) {
              date3 = dateFormat(v, formats);
              object.datetime3 = v.millisecondsSinceEpoch;
            }),
            PropertiesTitleWidget(title: context.tr.levels),
            PropertiesItemWidget(
              title: context.tr.levels,
              margin: EdgeInsets.zero,
              onTap: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => LevelsEditorScreen(
                      object: object,
                      defaults: kFibonacciChannelLevels,
                    ),
                  ),
                );
                setState(() {});
              },
              child: LevelsPreview(
                object: object,
                defaults: kFibonacciChannelLevels,
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
    point3.dispose();
    super.dispose();
  }
}
