import 'dart:math';

import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/entity/object_entity.dart';
import 'package:candle_chart/objects/properties/horizontal_line_properties_screen.dart';
import 'package:candle_chart/objects/widgets/object_style_widget.dart';
import 'package:candle_chart/objects/widgets/properties_boolean_item_widget.dart';
import 'package:candle_chart/objects/widgets/properties_item_widget.dart';
import 'package:candle_chart/utils/date_format_util.dart';
import 'package:candle_chart/utils/kprint.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';
import 'package:candle_chart/widgets/paddings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class RectangleLinePropertiesScreen extends StatefulWidget {
  static const id = 'RectangleLinePropertiesScreen';
  final Function(ObjectType? type) onDone;
  final ObjectEntity? object;
  final List<KLineEntity> data;

  const RectangleLinePropertiesScreen({
    super.key,
    required this.onDone,
    this.data = const [],
    required this.object,
  });

  @override
  State<RectangleLinePropertiesScreen> createState() =>
      _RectangleLinePropertiesScreenState();
}

class _RectangleLinePropertiesScreenState
    extends State<RectangleLinePropertiesScreen> {
  late final ObjectEntity object = widget.object ?? ObjectEntity();
  late final point1 =
      TextEditingController(text: object.value.toStringAsFixed(2));
  late final point2 =
      TextEditingController(text: object.value2.toStringAsFixed(2));
  late final lastTime =
      DateTime.fromMillisecondsSinceEpoch(widget.data.last.time!);
  final formats = [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn];
  String date = '';

  @override
  void initState() {
    date = dateFormat(lastTime, formats);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 50.0),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 12.0,
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
                    onTap: () async {
                      Navigator.of(context).pop();
                      await chartProperties.updateRectangle(object);
                      widget.onDone(null);
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
            PropertiesTitleWidget(title: 'Parameters'),
            PropertiesItemWidget(
              title: 'Name',
              subTitle: object.name,
              margin: EdgeInsets.zero,
            ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            PropertiesBooleanItemWidget(
              value: object.isFill,
              title: 'Fill',
              onChange: (value) {
                object.isFill = value;
              },
            ),
            PropertiesTitleWidget(title: 'Coordinates'),
            PropertiesItemWidget(
              title: 'Point 1',
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
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            PropertiesItemWidget(
              title: 'Date',
              onTap: () async {
                final res = await showDatePicker(
                  initialEntryMode: DatePickerEntryMode.calendarOnly,
                  context: context,
                  firstDate: DateTime(1900),
                  lastDate: lastTime,
                );
                if (res != null) {
                  date = dateFormat(res, formats);
                  object.datetime = res.millisecondsSinceEpoch;
                  setState(() {});
                }
              },
              child: Text(
                date,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            PropertiesItemWidget(
              title: 'Point 2',
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
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            PropertiesItemWidget(
              title: 'Date',
              onTap: () async {
                final res = await showDatePicker(
                  initialEntryMode: DatePickerEntryMode.calendarOnly,
                  context: context,
                  firstDate: DateTime(1900),
                  lastDate: lastTime,
                );
                if (res != null) {
                  date = dateFormat(res, formats);
                  object.datetime = res.millisecondsSinceEpoch;
                  setState(() {});
                }
              },
              child: Text(
                date,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            PropertiesTitleWidget(title: 'visualization'),
            PropertiesItemWidget(
              title: 'Symbol',
              subTitle: object.symbol.toUpperCase(),
              margin: EdgeInsets.zero,
              subTitleColor: Colors.grey.withOpacity(0.8),
              onTap: () {},
            ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            PropertiesItemWidget(
              title: 'Timeframe',
              subTitle: object.frame.name,
              margin: EdgeInsets.zero,
              subTitleColor: Colors.grey.withOpacity(0.8),
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
