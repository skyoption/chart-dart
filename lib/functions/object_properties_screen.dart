import 'dart:math';

import 'package:candle_chart/entity/line_entity.dart';
import 'package:candle_chart/functions/widgets/object_item_widget.dart';
import 'package:candle_chart/functions/widgets/object_style_widget.dart';
import 'package:candle_chart/functions/widgets/properties_item_widget.dart';
import 'package:candle_chart/utils/icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ObjectPropertiesScreen extends StatefulWidget {
  static const id = 'ObjectPropertiesScreen';
  final Function(LineEntity line) onDone;

  const ObjectPropertiesScreen({
    super.key,
    required this.onDone,
  });

  @override
  State<ObjectPropertiesScreen> createState() => _ObjectPropertiesScreenState();
}

class _ObjectPropertiesScreenState extends State<ObjectPropertiesScreen> {
  late final controller = TextEditingController(text: line.value.toString());
  final rand = Random();
  final LineEntity line = LineEntity();

  @override
  void initState() {
    line.name = 'M15 Horizontal Line ${rand.nextInt(10000)}';
    line.symbol = 'EURUSD';
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
                      size: 16.0,
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
                      widget.onDone(line);
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
            PropertiesTitleWidget(title: 'Parameters'),
            PropertiesItemWidget(
              title: 'Name',
              subTitle: line.name,
              margin: EdgeInsets.zero,
            ),
            PropertiesTitleWidget(title: 'Coordinates'),
            PropertiesItemWidget(
              title: 'Point',
              child: SizedBox(
                width: 60.0,
                height: 18.0,
                child: TextField(
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.blueAccent,
                    fontSize: 12.0,
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      line.value = double.parse(value);
                    }
                  },
                  controller: controller,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.numberWithOptions(signed: false),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 11.0),
                  ),
                ),
              ),
            ),
            PropertiesTitleWidget(title: 'visualization'),
            PropertiesItemWidget(
              title: 'Symbol',
              subTitle: line.symbol,
              margin: EdgeInsets.zero,
              subTitleColor: Colors.grey.withOpacity(0.8),
              onTap: () {},
            ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            PropertiesItemWidget(
              title: 'Timeframe',
              subTitle: 'All timeframes',
              margin: EdgeInsets.zero,
              subTitleColor: Colors.grey.withOpacity(0.8),
              onTap: () {},
            ),
            ObjectStyleWidget(
              onChange: (color, drawAsBackground, lineHeight, style) {
                line.color = color;
                line.drawAsBackground = drawAsBackground;
                line.height = lineHeight;
                line.style = style;
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class PropertiesTitleWidget extends StatelessWidget {
  final String title;

  const PropertiesTitleWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w400,
            ),
      ),
    );
  }
}
