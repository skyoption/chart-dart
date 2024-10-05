import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/indicators/properties/parabolic_properties_screen.dart';
import 'package:candle_chart/objects/widgets/properties_item_widget.dart';
import 'package:candle_chart/indicators/properties/indicator_properties_screen.dart';
import 'package:candle_chart/indicators/new_indicator_screen.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';
import 'package:flutter/material.dart';

import 'properties/ichimoku_properties_screen.dart';

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
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => NewIndicatorScreen(
                      onDone: widget.onDone,
                    ),
                  ),
                );
              },
            ),
            ...chartProperties.indicators.asMap().entries.map(
              (e) {
                return Column(
                  children: [
                    Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
                    PropertiesItemWidget(
                      title: '${e.value.name} (${e.value.type?.name})',
                      margin: EdgeInsets.zero,
                      onTap: () => _onTap(e),
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }

  void _onTap(MapEntry<int, IndicatorEntity> e) {
    if (e.value.ichimoku != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => IchimokuPropertiesScreen(
            index: e.key,
            indicator: e.value,
            onDone: widget.onDone,
          ),
        ),
      );
    } else if (e.value.steps != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ParabolicPropertiesScreen(
            index: e.key,
            indicator: e.value,
            onDone: widget.onDone,
          ),
        ),
      );
    } else {
      final isENVELOPS = e.value.type?.name.contains('ENVELOPS') ?? false;
      final isMA = e.value.type?.name.contains('MA') ?? false;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => IndicatorPropertiesScreen(
            index: e.key,
            indicator: e.value,
            onDone: widget.onDone,
            haveDeviations: isENVELOPS,
            haveMethods: isENVELOPS || isMA,
            haveTwoBands: isENVELOPS,
            isENVELOPS: isENVELOPS,
          ),
        ),
      );
    }
  }
}
