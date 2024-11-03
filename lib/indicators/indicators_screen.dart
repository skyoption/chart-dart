import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/indicators/properties/macd_properties_screen.dart';
import 'package:candle_chart/indicators/properties/parabolic_properties_screen.dart';
import 'package:candle_chart/indicators/properties/rsi_properties_screen.dart';
import 'package:candle_chart/k_chart_widget.dart';
import 'package:candle_chart/objects/widgets/properties_item_widget.dart';
import 'package:candle_chart/indicators/properties/indicator_properties_screen.dart';
import 'package:candle_chart/indicators/new_indicator_screen.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';
import 'package:candle_chart/widgets/paddings.dart';
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
  DismissDirection? direction;

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
                final name = '${e.value.name} (${e.value.type.name})';
                return Dismissible(
                  key: Key('${e.value.id}'),
                  onUpdate: (details) {
                    direction = details.direction;
                    setState(() {});
                  },
                  onDismissed: (value) {
                    chartProperties.removeIndicator(e.key);
                    widget.onDone();
                  },
                  background: Container(
                    color: Colors.red.withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 21.0),
                      child: Row(
                        mainAxisAlignment:
                            direction == DismissDirection.startToEnd
                                ? MainAxisAlignment.start
                                : MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.delete_outline_outlined,
                            color: Colors.red,
                            size: 28.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
                      PropertiesItemWidget(
                        title: name,
                        margin: EdgeInsets.zero,
                        onTap: () => _onTap(e.value, null),
                      ),
                    ],
                  ),
                );
              },
            ),
            ...chartProperties.secondaries.entries.map(
              (e) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PropertiesItemWidget(
                      title: 'Window ${e.key}',
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
                              windowId: e.key,
                            ),
                          ),
                        );
                      },
                    ),
                    ...e.value.asMap().entries.map((item) {
                      final name =
                          '${item.value.name} (${item.value.type.name})';
                      return Dismissible(
                        key: Key('${item.value.id}'),
                        onUpdate: (details) {
                          direction = details.direction;
                          setState(() {});
                        },
                        onDismissed: (value) {
                          chartProperties.removeSecondaryIndicator(item.value);
                          widget.onDone();
                          setState(() {});
                        },
                        background: Container(
                          color: Colors.red.withOpacity(0.1),
                          child: Padding(
                            padding: MPadding.set(horizontal: 21.0),
                            child: Row(
                              mainAxisAlignment:
                                  direction == DismissDirection.startToEnd
                                      ? MainAxisAlignment.start
                                      : MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.delete_outline_outlined,
                                  color: Colors.red,
                                  size: 28.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            Divider(
                              height: 1.0,
                              color: Colors.grey.withOpacity(0.4),
                            ),
                            PropertiesItemWidget(
                              title: name,
                              margin: EdgeInsets.zero,
                              onTap: () => _onTap(item.value, e.key),
                            ),
                          ],
                        ),
                      );
                    })
                  ],
                ).addPadding(top: 30.0);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onTap(IndicatorEntity item, int? windowId) {
    if (item.ichimoku != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => IchimokuPropertiesScreen(
            indicator: item,
            windowId: windowId,
            onDone: widget.onDone,
          ),
        ),
      );
    } else if (item.macd != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => MACDPropertiesScreen(
            indicator: item,
            windowId: windowId,
            onDone: widget.onDone,
          ),
        ),
      );
    } else if (item.type == IndicatorType.RSI) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => RSIPropertiesScreen(
            indicator: item,
            windowId: windowId,
            onDone: widget.onDone,
          ),
        ),
      );
    } else if (item.steps != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ParabolicPropertiesScreen(
            indicator: item,
            windowId: windowId,
            onDone: widget.onDone,
          ),
        ),
      );
    } else {
      final isENVELOPS = item.type.name.contains('ENVELOPS') ?? false;
      final isMA = item.type.name.contains('MA') ?? false;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => IndicatorPropertiesScreen(
            indicator: item,
            windowId: windowId,
            onDone: widget.onDone,
            haveDeviations: isENVELOPS || item.type == IndicatorType.BOLL,
            haveMethods: isENVELOPS || isMA,
            haveTwoBands: isENVELOPS,
            isENVELOPS: isENVELOPS,
          ),
        ),
      );
    }
  }
}
