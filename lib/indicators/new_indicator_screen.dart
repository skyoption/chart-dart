import 'package:candle_chart/indicators/properties/ichimoku_properties_screen.dart';
import 'package:candle_chart/indicators/properties/parabolic_properties_screen.dart';
import 'package:candle_chart/k_chart_widget.dart';
import 'package:candle_chart/objects/widgets/properties_item_widget.dart';
import 'package:candle_chart/indicators/properties/indicator_properties_screen.dart';
import 'package:flutter/material.dart';

class NewIndicatorScreen extends StatefulWidget {
  final Function onDone;

  const NewIndicatorScreen({
    super.key,
    required this.onDone,
  });

  @override
  State<NewIndicatorScreen> createState() => _NewIndicatorScreenState();
}

class _NewIndicatorScreenState extends State<NewIndicatorScreen> {
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
                      color: Colors.black,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    'Add Indicator',
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
        // padding: EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'TREND',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            PropertiesItemWidget(
              title: 'Moving Average',
              margin: EdgeInsets.zero,
              child: const SizedBox(),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => IndicatorPropertiesScreen(
                      onDone: widget.onDone,
                      name: 'Moving Average',
                      haveMethods: true,
                    ),
                  ),
                );
              },
            ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            PropertiesItemWidget(
              title: 'Bollinger Bands',
              margin: EdgeInsets.zero,
              child: const SizedBox(),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => IndicatorPropertiesScreen(
                      onDone: widget.onDone,
                      name: 'Bollinger Bands',
                      haveDeviations: true,
                      haveMethods: false,
                      type: IndicatorType.BOLL,
                    ),
                  ),
                );
              },
            ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            PropertiesItemWidget(
              title: 'Envelops',
              margin: EdgeInsets.zero,
              child: const SizedBox(),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => IndicatorPropertiesScreen(
                      onDone: widget.onDone,
                      name: 'Envelops',
                      haveDeviations: true,
                      haveMethods: true,
                      haveTwoBands: true,
                      isENVELOPS: true,
                      type: IndicatorType.SMA_ENVELOPS,
                    ),
                  ),
                );
              },
            ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            PropertiesItemWidget(
              title: 'Parabolic SAR',
              margin: EdgeInsets.zero,
              child: const SizedBox(),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => ParabolicPropertiesScreen(
                      onDone: widget.onDone,
                      name: 'Parabolic SAR',
                    ),
                  ),
                );
              },
            ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            PropertiesItemWidget(
              title: 'Ichimoku Kinko Hyo',
              margin: EdgeInsets.zero,
              child: const SizedBox(),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => IchimokuPropertiesScreen(
                      onDone: widget.onDone,
                      name: 'Ichimoku Kinko Hyo',
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: 8.0,
                end: 8.0,
                top: 12.0,
                bottom: 8.0,
              ),
              child: Text(
                'OSCILLATORS',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            PropertiesItemWidget(
              title: 'Force Index',
              margin: EdgeInsets.zero,
              child: const SizedBox(),
              onTap: () {},
            ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            PropertiesItemWidget(
              title: 'MACD',
              margin: EdgeInsets.zero,
              child: const SizedBox(),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
