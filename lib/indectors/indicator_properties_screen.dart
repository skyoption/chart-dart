import 'dart:math';

import 'package:candle_chart/functions/object_properties_screen.dart';
import 'package:candle_chart/functions/widgets/object_style_widget.dart';
import 'package:candle_chart/functions/widgets/properties_item_widget.dart';
import 'package:candle_chart/indectors/apply_to_screen.dart';
import 'package:candle_chart/indectors/ma_methods_screen.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:flutter/material.dart';

class IndicatorPropertiesScreen extends StatefulWidget {
  final Function onDone;

  const IndicatorPropertiesScreen({
    super.key,
    required this.onDone,
  });

  @override
  State<IndicatorPropertiesScreen> createState() =>
      _IndicatorPropertiesScreenState();
}

class _IndicatorPropertiesScreenState extends State<IndicatorPropertiesScreen> {
  late final periodController = TextEditingController(text: '5');
  late final shiftController = TextEditingController(text: '0');

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
                    onTap: () {
                      widget.onDone();
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
            PropertiesTitleWidget(title: 'MOVING AVERAGE'),
            PropertiesItemWidget(
              title: 'Period',
              child: SizedBox(
                width: 60.0,
                height: 18.0,
                child: TextField(
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Colors.blueAccent,
                      ),
                  onChanged: (value) {},
                  controller: periodController,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.numberWithOptions(signed: false),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 11.0),
                  ),
                ),
              ),
              margin: EdgeInsets.zero,
            ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            PropertiesItemWidget(
              title: 'Shift',
              margin: EdgeInsets.zero,
              child: SizedBox(
                width: 60.0,
                height: 18.0,
                child: TextField(
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Colors.blueAccent,
                      ),
                  onChanged: (value) {},
                  controller: shiftController,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.numberWithOptions(signed: false),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 11.0),
                  ),
                ),
              ),
              onTap: () {},
            ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            PropertiesItemWidget(
              title: 'Method',
              subTitle: 'Sample',
              margin: EdgeInsets.zero,
              subTitleColor: Colors.grey.withOpacity(0.8),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MaMethodsScreen(),
                  ),
                );
              },
            ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            PropertiesItemWidget(
              title: 'Apply To',
              subTitle: 'Close',
              margin: EdgeInsets.zero,
              subTitleColor: Colors.grey.withOpacity(0.8),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ApplyToScreen(),
                  ),
                );
              },
            ),
            PropertiesTitleWidget(title: 'LEVELS'),
            PropertiesItemWidget(
              title: 'Levels',
              margin: EdgeInsets.zero,
              subTitleColor: Colors.grey.withOpacity(0.8),
              onTap: () {},
            ),
            PropertiesTitleWidget(title: 'visualization'),
            PropertiesItemWidget(
              title: 'Timeframe',
              subTitle: 'All timeframes',
              margin: EdgeInsets.zero,
              subTitleColor: Colors.grey.withOpacity(0.8),
              onTap: () {},
            ),
            ObjectStyleWidget(
              hideDrawAsBackground: true,
              onChange: (color, drawAsBackground, lineHeight, style) {},
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    periodController.dispose();
    shiftController.dispose();
    super.dispose();
  }
}
