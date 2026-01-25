import 'package:candle_chart/indicators/properties/main/ichimoku_properties_screen.dart';
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
import 'package:candle_chart/indicators/widgets/top_header_widget.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/widgets/paddings.dart';
import 'package:flutter/material.dart';

class NewIndicatorScreen extends StatefulWidget {
  final Function onDone;
  final int? windowId;

  const NewIndicatorScreen({
    super.key,
    required this.onDone,
    this.windowId,
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
          child: TopHeaderWidget(
            title: context.tr.add_indicator,
            onBack: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: MPadding.set(
          bottom: context.bottomPadding,
          horizontal: 21.0,
          top: 12.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IndicatorItemWidget(
              id: 'moving_average',
              title: context.tr.moving_average,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => IndicatorPropertiesScreen(
                      id: 'moving_average',
                      name: context.tr.moving_average,
                      haveMethods: true,
                      onDone: widget.onDone,
                      period: 14,
                      windowId: widget.windowId,
                    ),
                  ),
                );
              },
            ),
            IndicatorItemWidget(
              id: 'bollinger_bands',
              title: context.tr.bollinger_bands,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => IndicatorPropertiesScreen(
                      id: 'bollinger_bands',
                      name: context.tr.bollinger_bands,
                      haveDeviations: true,
                      haveMethods: false,
                      onDone: widget.onDone,
                      type: IndicatorType.BOLL,
                      deviations: 2,
                      period: 20,
                      shift: 0,
                      windowId: widget.windowId,
                    ),
                  ),
                );
              },
            ),
            IndicatorItemWidget(
              id: 'envelops',
              title: context.tr.envelops,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => IndicatorPropertiesScreen(
                      id: 'envelops',
                      name: context.tr.envelops,
                      haveDeviations: true,
                      haveMethods: true,
                      haveTwoBands: true,
                      isENVELOPS: true,
                      onDone: widget.onDone,
                      type: IndicatorType.ENVELOPS_SMA,
                      period: 14,
                      shift: 0,
                      deviations: 0.1,
                      windowId: widget.windowId,
                    ),
                  ),
                );
              },
            ),
            IndicatorItemWidget(
              id: 'parabolic_sar',
              title: context.tr.parabolic_sar,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ParabolicPropertiesScreen(
                      name: context.tr.parabolic_sar,
                      onDone: widget.onDone,
                      windowId: widget.windowId,
                    ),
                  ),
                );
              },
            ),
            IndicatorItemWidget(
              id: 'ichimoku_kinko_hyo',
              title: context.tr.ichimoku_kinko_hyo,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => IchimokuPropertiesScreen(
                      name: context.tr.ichimoku_kinko_hyo,
                      onDone: widget.onDone,
                      windowId: widget.windowId,
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: MPadding.set(top: 12.0, bottom: 12.0),
              child: Text(
                context.tr.oscillators,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            IndicatorItemWidget(
              id: 'stochastic_oscillator',
              title: context.tr.stochastic_oscillator,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SOPropertiesScreen(
                      name: context.tr.stochastic_oscillator,
                      onDone: widget.onDone,
                      windowId: widget.windowId,
                    ),
                  ),
                );
              },
            ),
            IndicatorItemWidget(
              id: 'macd',
              title: context.tr.macd,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MACDPropertiesScreen(
                      name: context.tr.macd,
                      onDone: widget.onDone,
                      windowId: widget.windowId,
                    ),
                  ),
                );
              },
            ),
            IndicatorItemWidget(
              id: 'relative_strength_index',
              title: context.tr.relative_strength_index,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RSIPropertiesScreen(
                      name: context.tr.relative_strength_index,
                      onDone: widget.onDone,
                      windowId: widget.windowId,
                    ),
                  ),
                );
              },
            ),
            IndicatorItemWidget(
              id: 'atr',
              title: context.tr.average_true_range,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ATRPropertiesScreen(
                      name: context.tr.average_true_range,
                      onDone: widget.onDone,
                      windowId: widget.windowId,
                    ),
                  ),
                );
              },
            ),
            IndicatorItemWidget(
              id: 'commodity_channel_index',
              title: context.tr.commodity_channel_index,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CCIPropertiesScreen(
                      name: context.tr.commodity_channel_index,
                      onDone: widget.onDone,
                      windowId: widget.windowId,
                    ),
                  ),
                );
              },
            ),
            IndicatorItemWidget(
              id: 'demarker',
              title: context.tr.demarker,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DeMarkerPropertiesScreen(
                      name: context.tr.demarker,
                      onDone: widget.onDone,
                      windowId: widget.windowId,
                    ),
                  ),
                );
              },
            ),
            IndicatorItemWidget(
              id: 'momentum',
              title: context.tr.momentum,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MOMPropertiesScreen(
                      name: context.tr.momentum,
                      onDone: widget.onDone,
                      windowId: widget.windowId,
                    ),
                  ),
                );
              },
            ),
            IndicatorItemWidget(
              id: 'williams_percent_range',
              title: context.tr.williams_percent_range,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => WPRPropertiesScreen(
                      name: context.tr.williams_percent_range,
                      onDone: widget.onDone,
                      windowId: widget.windowId,
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: MPadding.set(top: 12.0, bottom: 12.0),
              child: Text(
                context.tr.volumes,
                style: context.text.labelLarge,
              ),
            ),
            IndicatorItemWidget(
              id: 'money_flow_index',
              title: context.tr.money_flow_index,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MFIPropertiesScreen(
                      name: context.tr.money_flow_index,
                      onDone: widget.onDone,
                      windowId: widget.windowId,
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
