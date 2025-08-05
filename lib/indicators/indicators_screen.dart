import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/indicators/new_indicator_screen.dart';
import 'package:candle_chart/indicators/properties/indicator_properties_screen.dart';
import 'package:candle_chart/indicators/properties/oscillators/atr_properties_screen.dart';
import 'package:candle_chart/indicators/properties/oscillators/cci_properties_screen.dart';
import 'package:candle_chart/indicators/properties/oscillators/dem_properties_screen.dart';
import 'package:candle_chart/indicators/properties/oscillators/macd_properties_screen.dart';
import 'package:candle_chart/indicators/properties/oscillators/mom_properties_screen.dart';
import 'package:candle_chart/indicators/properties/oscillators/rsi_properties_screen.dart';
import 'package:candle_chart/indicators/properties/oscillators/so_properties_screen.dart';
import 'package:candle_chart/indicators/properties/oscillators/wpr_properties_screen.dart';
import 'package:candle_chart/indicators/properties/parabolic_properties_screen.dart';
import 'package:candle_chart/indicators/properties/volumes/mfi_properties_screen.dart';
import 'package:candle_chart/objects/widgets/properties_item_widget.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';
import 'package:candle_chart/widgets/paddings.dart';
import 'package:flutter/material.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/utils/context.dart';

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
                      color: KChartWidget.colors!.iconColor,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    context.tr.indicators,
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
              title: context.tr.main_window,
              margin: EdgeInsets.zero,
              titleColor: KChartWidget.colors!.primary,
              child: Icon(
                Icons.add_circle_outline_rounded,
                color: KChartWidget.colors!.primary,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NewIndicatorScreen(
                      onDone: () {
                        widget.onDone();
                        setState(() {});
                      },
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
                  onDismissed: (value) async {
                    await chartProperties.removeIndicator(e.key);
                    widget.onDone();
                  },
                  background: Container(
                    color: Colors.red.withAlpha(10),
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
                      Divider(height: 1.0, color: Colors.grey.withAlpha(40)),
                      PropertiesItemWidget(
                        margin: EdgeInsets.zero,
                        title: name,
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
                      title: '${context.tr.window} ${e.key}',
                      margin: EdgeInsets.zero,
                      titleColor: KChartWidget.colors!.primary,
                      child: Icon(
                        Icons.add_circle_outline_rounded,
                        color: KChartWidget.colors!.primary,
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => NewIndicatorScreen(
                              onDone: () {
                                widget.onDone();
                                setState(() {});
                              },
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
                        onDismissed: (value) async {
                          await chartProperties
                              .removeSecondaryIndicator(item.value);
                          widget.onDone();
                          setState(() {});
                        },
                        background: Container(
                          color: Colors.red.withAlpha(10),
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
                              color: Colors.grey.withAlpha(40),
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
    if (item.type == IndicatorType.ICHIMOKU) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => IchimokuPropertiesScreen(
            indicator: item,
            windowId: windowId,
            onDone: () {
              widget.onDone();
              setState(() {});
            },
          ),
        ),
      );
    } else if (item.type == IndicatorType.ATR) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ATRPropertiesScreen(
            indicator: item,
            windowId: windowId,
            onDone: () {
              widget.onDone();
              setState(() {});
            },
          ),
        ),
      );
    } else if (item.type == IndicatorType.CCI) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CCIPropertiesScreen(
            indicator: item,
            windowId: windowId,
            onDone: () {
              widget.onDone();
              setState(() {});
            },
          ),
        ),
      );
    } else if (item.type == IndicatorType.DEM) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DeMarkerPropertiesScreen(
            indicator: item,
            windowId: windowId,
            onDone: () {
              widget.onDone();
              setState(() {});
            },
          ),
        ),
      );
    } else if (item.type == IndicatorType.MOM) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MOMPropertiesScreen(
            indicator: item,
            windowId: windowId,
            onDone: () {
              widget.onDone();
              setState(() {});
            },
          ),
        ),
      );
    } else if (item.type == IndicatorType.SO_EMA ||
        item.type == IndicatorType.SO_LINEAR ||
        item.type == IndicatorType.SO_SMA ||
        item.type == IndicatorType.SO_SMMA) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SOPropertiesScreen(
            indicator: item,
            windowId: windowId,
            onDone: () {
              widget.onDone();
              setState(() {});
            },
          ),
        ),
      );
    } else if (item.type == IndicatorType.WPR) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => WPRPropertiesScreen(
            indicator: item,
            windowId: windowId,
            onDone: () {
              widget.onDone();
              setState(() {});
            },
          ),
        ),
      );
    } else if (item.type == IndicatorType.MFI) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MFIPropertiesScreen(
            indicator: item,
            windowId: windowId,
            onDone: () {
              widget.onDone();
              setState(() {});
            },
          ),
        ),
      );
    } else if (item.type == IndicatorType.MACD) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MACDPropertiesScreen(
            indicator: item,
            windowId: windowId,
            onDone: () {
              widget.onDone();
              setState(() {});
            },
          ),
        ),
      );
    } else if (item.type == IndicatorType.RSI) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => RSIPropertiesScreen(
            indicator: item,
            windowId: windowId,
            onDone: () {
              widget.onDone();
              setState(() {});
            },
          ),
        ),
      );
    } else if (item.type == IndicatorType.PARABOLIC) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ParabolicPropertiesScreen(
            indicator: item,
            windowId: windowId,
            onDone: () {
              widget.onDone();
              setState(() {});
            },
          ),
        ),
      );
    } else {
      final isENVELOPS = item.type.name.contains('ENVELOPS');
      final isMA = item.type.name.contains('MA');
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => IndicatorPropertiesScreen(
            indicator: item,
            windowId: windowId,
            onDone: () {
              widget.onDone();
              setState(() {});
            },
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
