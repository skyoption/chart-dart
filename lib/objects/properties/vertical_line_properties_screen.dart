import 'dart:math';

import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/entity/object_entity.dart';
import 'package:candle_chart/objects/properties/horizontal_line_properties_screen.dart';
import 'package:candle_chart/objects/widgets/object_style_widget.dart';
import 'package:candle_chart/objects/widgets/properties_item_widget.dart';
import 'package:candle_chart/utils/date_format_util.dart';
import 'package:candle_chart/utils/kprint.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class VerticalLinePropertiesScreen extends StatefulWidget {
  static const id = 'VerticalLinePropertiesScreen';
  final Function(ObjectType? type) onDone;
  final ObjectEntity? object;
  final List<KLineEntity> data;

  const VerticalLinePropertiesScreen({
    super.key,
    required this.onDone,
    this.data = const [],
    required this.object,
  });

  @override
  State<VerticalLinePropertiesScreen> createState() =>
      _VerticalLinePropertiesScreenState();
}

class _VerticalLinePropertiesScreenState
    extends State<VerticalLinePropertiesScreen> {

  late final ObjectEntity object = widget.object ?? ObjectEntity();
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
                      await chartProperties.updateVerticalLine(object);
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
            PropertiesTitleWidget(title: 'Coordinates'),
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
            ObjectStyleWidget(  style: object.style,
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
