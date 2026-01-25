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

class FavoritesIndicatorsTab extends StatefulWidget {
  final Function onDone;
  final ValueNotifier<String> search;

  const FavoritesIndicatorsTab({
    super.key,
    required this.onDone,
    required this.search,
  });

  @override
  State<FavoritesIndicatorsTab> createState() => _FavoritesIndicatorsTabState();
}

class _FavoritesIndicatorsTabState extends State<FavoritesIndicatorsTab> {
  @override
  Widget build(BuildContext context) {
    if (chartProperties.isEmptyFav) {
      return Text(
        context.tr.noFavoritesAppliedYet,
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
              if (chartProperties.isFav('moving_average') &&
                  context.tr.moving_average
                      .toLowerCase()
                      .contains(keyword.toLowerCase()))
                IndicatorItemWidget(
                  id: 'moving_average',
                  title: context.tr.moving_average,
                  onUnFav: () => setState(() {}),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => IndicatorPropertiesScreen(
                          id: 'moving_average',
                          name: context.tr.moving_average,
                          haveMethods: true,
                          onDone: widget.onDone,
                          period: 14,
                        ),
                      ),
                    );
                  },
                ),
              if (chartProperties.isFav('bollinger_bands') &&
                  context.tr.bollinger_bands
                      .toLowerCase()
                      .contains(keyword.toLowerCase()))
                IndicatorItemWidget(
                  id: 'bollinger_bands',
                  title: context.tr.bollinger_bands,
                  onUnFav: () => setState(() {}),
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
                        ),
                      ),
                    );
                  },
                ),
              if (chartProperties.isFav('envelops') &&
                  context.tr.envelops
                      .toLowerCase()
                      .contains(keyword.toLowerCase()))
                IndicatorItemWidget(
                  id: 'envelops',
                  onUnFav: () => setState(() {}),
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
                        ),
                      ),
                    );
                  },
                ),
              if (chartProperties.isFav('parabolic_sar') &&
                  context.tr.parabolic_sar
                      .toLowerCase()
                      .contains(keyword.toLowerCase()))
                IndicatorItemWidget(
                  id: 'parabolic_sar',
                  title: context.tr.parabolic_sar,
                  onUnFav: () => setState(() {}),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ParabolicPropertiesScreen(
                          name: context.tr.parabolic_sar,
                          onDone: widget.onDone,
                        ),
                      ),
                    );
                  },
                ),
              if (chartProperties.isFav('ichimoku_kinko_hyo') &&
                  context.tr.ichimoku_kinko_hyo
                      .toLowerCase()
                      .contains(keyword.toLowerCase()))
                IndicatorItemWidget(
                  id: 'ichimoku_kinko_hyo',
                  title: context.tr.ichimoku_kinko_hyo,
                  onUnFav: () => setState(() {}),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => IchimokuPropertiesScreen(
                          name: context.tr.ichimoku_kinko_hyo,
                          onDone: widget.onDone,
                        ),
                      ),
                    );
                  },
                ),
              if (chartProperties.isFav('stochastic_oscillator') &&
                  context.tr.stochastic_oscillator
                      .toLowerCase()
                      .contains(keyword.toLowerCase()))
                IndicatorItemWidget(
                  id: 'stochastic_oscillator',
                  onUnFav: () => setState(() {}),
                  title: context.tr.stochastic_oscillator,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SOPropertiesScreen(
                          name: context.tr.stochastic_oscillator,
                          onDone: widget.onDone,
                        ),
                      ),
                    );
                  },
                ),
              if (chartProperties.isFav('macd') &&
                  context.tr.macd.toLowerCase().contains(keyword.toLowerCase()))
                IndicatorItemWidget(
                  id: 'macd',
                  title: context.tr.macd,
                  onUnFav: () => setState(() {}),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MACDPropertiesScreen(
                          name: context.tr.macd,
                          onDone: widget.onDone,
                        ),
                      ),
                    );
                  },
                ),
              if (chartProperties.isFav('relative_strength_index') &&
                  context.tr.relative_strength_index
                      .toLowerCase()
                      .contains(keyword.toLowerCase()))
                IndicatorItemWidget(
                  id: 'relative_strength_index',
                  title: context.tr.relative_strength_index,
                  onUnFav: () => setState(() {}),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RSIPropertiesScreen(
                          name: context.tr.relative_strength_index,
                          onDone: widget.onDone,
                        ),
                      ),
                    );
                  },
                ),
              if (chartProperties.isFav('atr') &&
                  context.tr.average_true_range
                      .toLowerCase()
                      .contains(keyword.toLowerCase()))
                IndicatorItemWidget(
                  id: 'atr',
                  title: context.tr.average_true_range,
                  onUnFav: () => setState(() {}),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ATRPropertiesScreen(
                          name: context.tr.average_true_range,
                          onDone: widget.onDone,
                        ),
                      ),
                    );
                  },
                ),
              if (chartProperties.isFav('commodity_channel_index') &&
                  context.tr.commodity_channel_index
                      .toLowerCase()
                      .contains(keyword.toLowerCase()))
                IndicatorItemWidget(
                  id: 'commodity_channel_index',
                  title: context.tr.commodity_channel_index,
                  onUnFav: () => setState(() {}),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CCIPropertiesScreen(
                          name: context.tr.commodity_channel_index,
                          onDone: widget.onDone,
                        ),
                      ),
                    );
                  },
                ),
              if (chartProperties.isFav('demarker') &&
                  context.tr.demarker
                      .toLowerCase()
                      .contains(keyword.toLowerCase()))
                IndicatorItemWidget(
                  id: 'demarker',
                  title: context.tr.demarker,
                  onUnFav: () => setState(() {}),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DeMarkerPropertiesScreen(
                          name: context.tr.demarker,
                          onDone: widget.onDone,
                        ),
                      ),
                    );
                  },
                ),
              if (chartProperties.isFav('momentum') &&
                  context.tr.momentum
                      .toLowerCase()
                      .contains(keyword.toLowerCase()))
                IndicatorItemWidget(
                  id: 'momentum',
                  title: context.tr.momentum,
                  onUnFav: () => setState(() {}),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MOMPropertiesScreen(
                          name: context.tr.momentum,
                          onDone: widget.onDone,
                        ),
                      ),
                    );
                  },
                ),
              if (chartProperties.isFav('williams_percent_range') &&
                  context.tr.williams_percent_range
                      .toLowerCase()
                      .contains(keyword.toLowerCase()))
                IndicatorItemWidget(
                  id: 'williams_percent_range',
                  title: context.tr.williams_percent_range,
                  onUnFav: () => setState(() {}),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => WPRPropertiesScreen(
                          name: context.tr.williams_percent_range,
                          onDone: widget.onDone,
                        ),
                      ),
                    );
                  },
                ),
              if (chartProperties.isFav('money_flow_index') &&
                  context.tr.money_flow_index
                      .toLowerCase()
                      .contains(keyword.toLowerCase()))
                IndicatorItemWidget(
                  id: 'money_flow_index',
                  title: context.tr.money_flow_index,
                  onUnFav: () => setState(() {}),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MFIPropertiesScreen(
                          name: context.tr.money_flow_index,
                          onDone: widget.onDone,
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
}
