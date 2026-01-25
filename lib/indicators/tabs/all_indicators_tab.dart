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
import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/widgets/paddings.dart';
import 'package:flutter/material.dart';

class AllIndicatorsTab extends StatefulWidget {
  final Function onDone;
  final ValueNotifier<String> search;

  const AllIndicatorsTab({
    super.key,
    required this.onDone,
    required this.search,
  });

  @override
  State<AllIndicatorsTab> createState() => _AllIndicatorsTabState();
}

class _AllIndicatorsTabState extends State<AllIndicatorsTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: MPadding.set(bottom: context.bottomPadding),
      child: ValueListenableBuilder(
        valueListenable: widget.search,
        builder: (context, keyword, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (context.tr.moving_average
                  .toLowerCase()
                  .contains(keyword.toLowerCase()))
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
                          onDone: onDone,
                          period: 14,
                        ),
                      ),
                    );
                  },
                ),
              if (context.tr.bollinger_bands
                  .toLowerCase()
                  .contains(keyword.toLowerCase()))
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
                          onDone: onDone,
                          type: IndicatorType.BOLL,
                          deviations: 2,
                          period: 20,
                          shift: 0,
                        ),
                      ),
                    );
                  },
                ),
              if (context.tr.envelops
                  .toLowerCase()
                  .contains(keyword.toLowerCase()))
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
                          onDone: onDone,
                          type: IndicatorType.ENVELOPS_SMA,
                          period: 14,
                          shift: 0,
                          deviations: 0.1,
                        ),
                      ),
                    );
                  },
                ),
              if (context.tr.parabolic_sar
                  .toLowerCase()
                  .contains(keyword.toLowerCase()))
                IndicatorItemWidget(
                  id: 'parabolic_sar',
                  title: context.tr.parabolic_sar,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ParabolicPropertiesScreen(
                          name: context.tr.parabolic_sar,
                          onDone: onDone,
                        ),
                      ),
                    );
                  },
                ),
              if (context.tr.ichimoku_kinko_hyo
                  .toLowerCase()
                  .contains(keyword.toLowerCase()))
                IndicatorItemWidget(
                  id: 'ichimoku_kinko_hyo',
                  title: context.tr.ichimoku_kinko_hyo,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => IchimokuPropertiesScreen(
                          name: context.tr.ichimoku_kinko_hyo,
                          onDone: onDone,
                        ),
                      ),
                    );
                  },
                ),
              if (keyword.isEmpty)
                Padding(
                  padding: MPadding.set(top: 12.0, bottom: 12.0),
                  child: Text(
                    context.tr.oscillators,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              if (context.tr.stochastic_oscillator
                  .toLowerCase()
                  .contains(keyword.toLowerCase()))
                IndicatorItemWidget(
                  id: 'stochastic_oscillator',
                  title: context.tr.stochastic_oscillator,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SOPropertiesScreen(
                          name: context.tr.stochastic_oscillator,
                          onDone: onDone,
                        ),
                      ),
                    );
                  },
                ),
              if (context.tr.macd.toLowerCase().contains(keyword.toLowerCase()))
                IndicatorItemWidget(
                  id: 'macd',
                  title: context.tr.macd,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MACDPropertiesScreen(
                          name: context.tr.macd,
                          onDone: onDone,
                        ),
                      ),
                    );
                  },
                ),
              if (context.tr.relative_strength_index
                  .toLowerCase()
                  .contains(keyword.toLowerCase()))
                IndicatorItemWidget(
                  id: 'relative_strength_index',
                  title: context.tr.relative_strength_index,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RSIPropertiesScreen(
                          name: context.tr.relative_strength_index,
                          onDone: onDone,
                        ),
                      ),
                    );
                  },
                ),
              if (context.tr.average_true_range
                  .toLowerCase()
                  .contains(keyword.toLowerCase()))
                IndicatorItemWidget(
                  id: 'atr',
                  title: context.tr.average_true_range,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ATRPropertiesScreen(
                          name: context.tr.average_true_range,
                          onDone: onDone,
                        ),
                      ),
                    );
                  },
                ),
              if (context.tr.commodity_channel_index
                  .toLowerCase()
                  .contains(keyword.toLowerCase()))
                IndicatorItemWidget(
                  id: 'commodity_channel_index',
                  title: context.tr.commodity_channel_index,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CCIPropertiesScreen(
                          name: context.tr.commodity_channel_index,
                          onDone: onDone,
                        ),
                      ),
                    );
                  },
                ),
              if (context.tr.demarker
                  .toLowerCase()
                  .contains(keyword.toLowerCase()))
                IndicatorItemWidget(
                  id: 'demarker',
                  title: context.tr.demarker,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DeMarkerPropertiesScreen(
                          name: context.tr.demarker,
                          onDone: onDone,
                        ),
                      ),
                    );
                  },
                ),
              if (context.tr.momentum
                  .toLowerCase()
                  .contains(keyword.toLowerCase()))
                IndicatorItemWidget(
                  id: 'momentum',
                  title: context.tr.momentum,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MOMPropertiesScreen(
                          name: context.tr.momentum,
                          onDone: onDone,
                        ),
                      ),
                    );
                  },
                ),
              if (context.tr.williams_percent_range
                  .toLowerCase()
                  .contains(keyword.toLowerCase()))
                IndicatorItemWidget(
                  id: 'williams_percent_range',
                  title: context.tr.williams_percent_range,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => WPRPropertiesScreen(
                          name: context.tr.williams_percent_range,
                          onDone: onDone,
                        ),
                      ),
                    );
                  },
                ),
              if (keyword.isEmpty)
                Padding(
                  padding: MPadding.set(top: 12.0, bottom: 12.0),
                  child: Text(
                    context.tr.volumes,
                    style: context.text.labelLarge,
                  ),
                ),
              if (context.tr.money_flow_index
                  .toLowerCase()
                  .contains(keyword.toLowerCase()))
                IndicatorItemWidget(
                  id: 'money_flow_index',
                  title: context.tr.money_flow_index,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MFIPropertiesScreen(
                          name: context.tr.money_flow_index,
                          onDone: onDone,
                        ),
                      ),
                    );
                  },
                ),
            ],
          );
        },
      ),
    );
  }

  void onDone() {
    widget.onDone();
    setState(() {});
  }
}
