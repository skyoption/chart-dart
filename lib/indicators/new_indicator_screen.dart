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
import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/k_chart_widget.dart';
import 'package:candle_chart/objects/widgets/properties_item_widget.dart';
import 'package:candle_chart/indicators/properties/indicator_properties_screen.dart';
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
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => IndicatorPropertiesScreen(
                      name: context.tr.moving_average,
                      haveMethods: true,
                      onDone: widget.onDone,
                      windowId: widget.windowId,
                    ),
                  ),
                );
              },
            ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            PropertiesItemWidget(
              title: context.tr.bollinger_bands,
              margin: EdgeInsets.zero,
              child: const SizedBox(),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => IndicatorPropertiesScreen(
                      name: context.tr.bollinger_bands,
                      haveDeviations: true,
                      haveMethods: false,
                      onDone: widget.onDone,
                      type: IndicatorType.BOLL,
                      windowId: widget.windowId,
                    ),
                  ),
                );
              },
            ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            PropertiesItemWidget(
              title: context.tr.envelops,
              margin: EdgeInsets.zero,
              child: const SizedBox(),
              onTap: () {
                Navigator.of(context).pushReplacement(
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
                    ),
                  ),
                );
              },
            ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            PropertiesItemWidget(
              title: context.tr.parabolic_sar,
              margin: EdgeInsets.zero,
              child: const SizedBox(),
              onTap: () {
                Navigator.of(context).pushReplacement(
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
          ],
        ),
      ),
    );
  }
}
