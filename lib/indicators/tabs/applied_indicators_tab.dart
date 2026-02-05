import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/indicators/new_indicator_screen.dart';
import 'package:candle_chart/indicators/properties/main/indicator_properties_screen.dart';
import 'package:candle_chart/indicators/properties/oscillators/atr_properties_screen.dart';
import 'package:candle_chart/indicators/properties/oscillators/cci_properties_screen.dart';
import 'package:candle_chart/indicators/properties/oscillators/dem_properties_screen.dart';
import 'package:candle_chart/indicators/properties/oscillators/macd_properties_screen.dart';
import 'package:candle_chart/indicators/properties/oscillators/mom_properties_screen.dart';
import 'package:candle_chart/indicators/properties/oscillators/rsi_properties_screen.dart';
import 'package:candle_chart/indicators/properties/oscillators/so_properties_screen.dart';
import 'package:candle_chart/indicators/properties/oscillators/wpr_properties_screen.dart';
import 'package:candle_chart/indicators/properties/main/parabolic_properties_screen.dart';
import 'package:candle_chart/indicators/properties/volumes/mfi_properties_screen.dart';
import 'package:candle_chart/indicators/widgets/indicator_item_widget.dart';
import 'package:candle_chart/objects/widgets/delete_widget.dart';
import 'package:candle_chart/widgets/paddings.dart';
import 'package:flutter/material.dart';
import 'package:candle_chart/k_chart_plus.dart';

import '../properties/main/ichimoku_properties_screen.dart';

class AppliedIndicatorsTab extends StatefulWidget {
  final Function onDone;
  final ValueNotifier<String> search;

  const AppliedIndicatorsTab({
    super.key,
    required this.onDone,
    required this.search,
  });

  @override
  State<AppliedIndicatorsTab> createState() => _AppliedIndicatorsTabState();
}

class _AppliedIndicatorsTabState extends State<AppliedIndicatorsTab> {
  DismissDirection? direction;

  @override
  Widget build(BuildContext context) {
    if (chartProperties.isEmptyApplied) {
      return Text(
        context.tr.noIndicatorsAppliedYet,
        style: context.text.bodyMedium,
      ).addPadding(top: context.h * 0.3);
    }
    return SingleChildScrollView(
      padding: MPadding.set(bottom: context.bottomPadding),
      child: ValueListenableBuilder(
        valueListenable: widget.search,
        builder: (context, keyword, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (chartProperties.indicators.isNotEmpty)
                _windowWidget(
                  title: context.tr.main_window,
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
                  if (keyword.isNotEmpty &&
                      !_getIndicatorName(e.value)
                          .toLowerCase()
                          .contains(keyword.toLowerCase())) {
                    return const SizedBox.shrink();
                  }
                  return Dismissible(
                    key: Key(e.value.id.toString()),
                    onUpdate: (details) {
                      direction = details.direction;
                      setState(() {});
                    },
                    onDismissed: (value) async {
                      await chartProperties.removeIndicator(e.key);
                      widget.onDone();
                      setState(() {});
                    },
                    background: DeleteWidget(direction: direction),
                    child: IndicatorItemWidget(
                      id: e.value.key,
                      title: _getIndicatorName(e.value),
                      onTap: () => _onTap(e.value, null),
                      margin: EdgeInsets.zero,
                    ),
                  ).addPadding(top: 6.0);
                },
              ),
              if (chartProperties.indicators.isNotEmpty)
                const SizedBox(height: 30.0),
              ...chartProperties.secondaries.entries.map(
                (e) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _windowWidget(
                        title: '${context.tr.window} ${e.key}',
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
                        if (keyword.isNotEmpty &&
                            !_getIndicatorName(item.value)
                                .toLowerCase()
                                .contains(keyword.toLowerCase())) {
                          return const SizedBox.shrink();
                        }
                        return Dismissible(
                          key: Key(item.value.id.toString()),
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
                          background: DeleteWidget(direction: direction),
                          child: IndicatorItemWidget(
                            id: item.value.key,
                            title: _getIndicatorName(item.value),
                            margin: EdgeInsets.zero,
                            onTap: () => _onTap(item.value, e.key),
                          ),
                        ).addPadding(top: 6.0);
                      })
                    ],
                  ).addPadding(bottom: 12.0);
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _windowWidget({required String title, required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: context.scheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: MPadding.set(vertical: 10.0, horizontal: 12.0),
        margin: MPadding.set(bottom: 6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: context.scheme.primary),
            ),
            Icon(
              Icons.add_circle_outline_rounded,
              color: KChartWidget.colors!.primary,
            ),
          ],
        ),
      ),
    );
  }

  String _getIndicatorName(IndicatorEntity item) {
    if (item.type.name.contains('LINEAR')) {
      return '${item.name} (Linear Weighted)';
    } else if (item.type.name.contains('SMMA')) {
      return '${item.name} (Smoothed)';
    } else if (item.type.name.contains('EMA')) {
      return '${item.name} (Exponential)';
    } else if (item.type.name.contains('SMA')) {
      return '${item.name} (Simple)';
    }
    return '${item.name}';
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
            id: item.key,
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
