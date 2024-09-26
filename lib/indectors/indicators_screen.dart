import 'package:candle_chart/functions/widgets/object_item_widget.dart';
import 'package:candle_chart/functions/widgets/properties_item_widget.dart';
import 'package:candle_chart/indectors/new_indicator_screen.dart';
import 'package:candle_chart/utils/icons.dart';
import 'package:flutter/material.dart';

class IndicatorsScreen extends StatefulWidget {
  final Function onDone;

  const IndicatorsScreen({
    super.key,
    required this.onDone,
  });

  @override
  State<IndicatorsScreen> createState() => _IndicatorsScreenState();
}

class _IndicatorsScreenState extends State<IndicatorsScreen> {
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
                    'Indicators',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PropertiesItemWidget(
              title: 'Main window',
              margin: EdgeInsets.zero,
              titleColor: Colors.blueAccent,
              child: Icon(
                Icons.add_circle_outline_rounded,
                color: Colors.blueAccent,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NewIndicatorScreen(
                      onDone: widget.onDone,
                    ),
                  ),
                );
              },
            ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            PropertiesItemWidget(
              title: 'Moving Average',
              margin: EdgeInsets.zero,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NewIndicatorScreen(
                      onDone: widget.onDone,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
