import 'package:candle_chart/indicators/properties/ichimoku_properties_screen.dart';
import 'package:candle_chart/indicators/properties/oscillators/atr_properties_screen.dart';
import 'package:candle_chart/indicators/properties/oscillators/cci_properties_screen.dart';
import 'package:candle_chart/indicators/properties/oscillators/dem_properties_screen.dart';
import 'package:candle_chart/indicators/properties/oscillators/macd_properties_screen.dart';
import 'package:candle_chart/indicators/properties/oscillators/mom_properties_screen.dart';
import 'package:candle_chart/indicators/properties/oscillators/so_properties_screen.dart';
import 'package:candle_chart/indicators/properties/oscillators/wpr_properties_screen.dart';
import 'package:candle_chart/indicators/properties/parabolic_properties_screen.dart';
import 'package:candle_chart/indicators/properties/oscillators/rsi_properties_screen.dart';
import 'package:candle_chart/indicators/properties/volumes/mfi_properties_screen.dart';
import 'package:candle_chart/objects/widgets/properties_item_widget.dart';
import 'package:candle_chart/indicators/properties/indicator_properties_screen.dart';
import 'package:candle_chart/widgets/paddings.dart';
import 'package:flutter/material.dart';
import 'package:candle_chart/k_chart_plus.dart';

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
                    context.tr.add_indicator,
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
        padding: MPadding.set(bottom: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                context.tr.trend,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            PropertiesItemWidget(
              title: context.tr.moving_average,
              margin: EdgeInsets.zero,
              child: const SizedBox(),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => IndicatorPropertiesScreen(
                      name: context.tr.moving_average,
                      haveMethods: true,
                      onDone: widget.onDone,
                      windowId: widget.windowId,
                      period: 14,
                    ),
                  ),
                );
              },
            ),
            Divider(height: 1.0, color: Colors.grey.withAlpha(40)),
            PropertiesItemWidget(
              title: context.tr.bollinger_bands,
              margin: EdgeInsets.zero,
              child: const SizedBox(),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => IndicatorPropertiesScreen(
                      name: context.tr.bollinger_bands,
                      haveDeviations: true,
                      haveMethods: false,
                      onDone: widget.onDone,
                      type: IndicatorType.BOLL,
                      windowId: widget.windowId,
                      deviations: 2,
                      period: 20,
                      shift: 0,
                    ),
                  ),
                );
              },
            ),
            Divider(height: 1.0, color: Colors.grey.withAlpha(40)),
            PropertiesItemWidget(
              title: context.tr.envelops,
              margin: EdgeInsets.zero,
              child: const SizedBox(),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => IndicatorPropertiesScreen(
                      name: context.tr.envelops,
                      haveDeviations: true,
                      haveMethods: true,
                      haveTwoBands: true,
                      isENVELOPS: true,
                      onDone: widget.onDone,
                      type: IndicatorType.ENVELOPS_SMA,
                      windowId: widget.windowId,
                      period: 14,
                      shift: 0,
                      deviations: 0.1,
                    ),
                  ),
                );
              },
            ),
            Divider(height: 1.0, color: Colors.grey.withAlpha(40)),
            PropertiesItemWidget(
              title: context.tr.parabolic_sar,
              margin: EdgeInsets.zero,
              child: const SizedBox(),
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
            Divider(height: 1.0, color: Colors.grey.withAlpha(40)),
            PropertiesItemWidget(
              title: context.tr.ichimoku_kinko_hyo,
              margin: EdgeInsets.zero,
              child: const SizedBox(),
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
              padding: EdgeInsetsDirectional.only(
                start: 8.0,
                end: 8.0,
                top: 12.0,
                bottom: 8.0,
              ),
              child: Text(
                context.tr.oscillators,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            PropertiesItemWidget(
              title: context.tr.stochastic_oscillator,
              margin: EdgeInsets.zero,
              child: const SizedBox(),
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
            Divider(height: 1.0, color: Colors.grey.withAlpha(40)),
            PropertiesItemWidget(
              title: context.tr.macd,
              margin: EdgeInsets.zero,
              child: const SizedBox(),
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
            Divider(height: 1.0, color: Colors.grey.withAlpha(40)),
            PropertiesItemWidget(
              title: context.tr.relative_strength_index,
              margin: EdgeInsets.zero,
              child: const SizedBox(),
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
            Divider(height: 1.0, color: Colors.grey.withAlpha(40)),
            PropertiesItemWidget(
              title: context.tr.average_true_range,
              margin: EdgeInsets.zero,
              child: const SizedBox(),
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
            Divider(height: 1.0, color: Colors.grey.withAlpha(40)),
            PropertiesItemWidget(
              title: context.tr.commodity_channel_index,
              margin: EdgeInsets.zero,
              child: const SizedBox(),
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
            Divider(height: 1.0, color: Colors.grey.withAlpha(40)),
            PropertiesItemWidget(
              title: context.tr.demarker,
              margin: EdgeInsets.zero,
              child: const SizedBox(),
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
            Divider(height: 1.0, color: Colors.grey.withAlpha(40)),
            PropertiesItemWidget(
              title: context.tr.momentum,
              margin: EdgeInsets.zero,
              child: const SizedBox(),
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
            Divider(height: 1.0, color: Colors.grey.withAlpha(40)),
            PropertiesItemWidget(
              title: context.tr.williams_percent_range,
              margin: EdgeInsets.zero,
              child: const SizedBox(),
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
              padding: EdgeInsetsDirectional.only(
                start: 8.0,
                end: 8.0,
                top: 12.0,
                bottom: 8.0,
              ),
              child: Text(
                context.tr.volumes,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            PropertiesItemWidget(
              title: context.tr.money_flow_index,
              margin: EdgeInsets.zero,
              child: const SizedBox(),
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
