import 'package:candle_chart/entity/line_entity.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:example/core/builder/flow_builder.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/features/chart/logic/chart_cubit.dart';
import 'package:example/features/settings/logic/platform_settings_cubit.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';

class ChartShortcutWidget extends StatefulWidget {
  const ChartShortcutWidget({
    super.key,
    required this.graphStyle,
    required this.isResetZoom,
  });

  final ValueNotifier<GraphStyle> graphStyle;
  final ValueNotifier<bool> isResetZoom;
  @override
  State<ChartShortcutWidget> createState() => _ChartShortcutWidgetState();
}

final chartKey = GlobalKey<KChartWidgetState>();

class _ChartShortcutWidgetState extends State<ChartShortcutWidget> {
  bool showLoading = true;

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 150), () {
      chartProperties.getDefaultSettings(
        onGettingSettings: onGettingSettings,
      );
      final cubit = context.read<QuotesCubit>();
      _updateChart(0, cubit.currentSymbol.value!.symbol);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final quotesCubit = context.read<QuotesCubit>();
    return ValueListenableBuilder<SymbolEntity?>(
      valueListenable: quotesCubit.currentSymbol,
      builder: (context, symbol, child) {
        if (symbol == null) return const SizedBox();
        return FlowBuilder<PlatformSettingsCubit>(
          builder: (context, state, platform) {
            return SizedBox(
              height: 280.0,
              child: FlowBuilder<QuotesCubit>(
                builder: (context, state, quotesCubit) {
                  return FlowBuilder<ChartCubit>(
                    buildWhenCubit: (cubit) {
                      return cubit.state.type == StateType.success;
                    },
                    listener: (context, state, cubit) {
                      _updateAskAndBid(quotesCubit, cubit, platform);
                    },
                    builder: (context, state, cubit) {
                      return ValueListenableBuilder<GraphStyle>(
                        valueListenable: widget.graphStyle,
                        builder: (context, graphStyle, child) {
                          return KChartWidget(
                            key: chartKey,
                            graphStyle: graphStyle,
                            onUpdatePosition: (position, newValue) {},
                            onZoomingStart: (value) {
                              widget.isResetZoom.value = !value;
                            },
                            onLoadMore: (value) {
                              if (value) {
                                _updateChart(
                                  cubit.offset + 1,
                                  quotesCubit.currentSymbol.value!.symbol,
                                );
                              }
                            },
                            chartStyle: ChartStyle(
                              isSmallChart: true,
                              iconSize: 30.0,
                              sizeText: 10.0,
                              gridColumns: 3,
                              gridRows: 9,
                              rightPadding: context.isLandscape ? 0.0 : 10.0,
                              areaLineWidth: platform.settings.chartLineSize,
                            ),
                            chartColors: ChartColors(
                              bgColor: context.colorScheme.surface,
                              defaultTextColor: context.colorScheme.onSurface,
                              maxColor: context.colorScheme.onSurface,
                              iconColor: context.colorScheme.onSurface,
                              primary: context.colorScheme.primary,
                              optionsColor: context.colorScheme.onSurface,
                              ask: platform.settings.askColor,
                              bid: platform.settings.bidColor,
                              lineChartColor: platform.settings.chartThemeColor,
                              areaColor: platform.settings.areaColor,
                              stopLoss: platform.settings.stopLossColor,
                              takeProfit: platform.settings.takeProfitColor,
                              gridColor: platform.settings.chartGridColor,
                            ),
                            fixedLength: 2,
                            timeFormat: TimeFormat.YEAR_MONTH_DAY,
                            mBaseHeight: context.height,
                          );
                        },
                      );
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  void _updateAskAndBid(
    QuotesCubit quotesCubit,
    ChartCubit cubit,
    PlatformSettingsCubit platform,
  ) {
    chartKey.currentState!.setLoadedCandles(candles: cubit.items);
    if (cubit.bid != null) {
      chartKey.currentState!.updateAskAndBid(
        LineEntity(
          id: -10,
          color: platform.settings.bidColor,
          value: cubit.bid!,
        ),
      );
    }
    if (cubit.ask != null && platform.settings.showAskLine) {
      chartKey.currentState!.updateAskAndBid(
        LineEntity(
          id: -20,
          color: platform.settings.askColor,
          value: cubit.ask!,
        ),
      );
    } else {
      chartKey.currentState!.removeAskBid(-20);
    }
  }

  void onGettingSettings(CandleTimeFormat frame, String symbol) {
    if (symbol.isNotEmpty) {
      final quotesCubit = context.read<QuotesCubit>();
      final chartCubit = context.read<ChartCubit>();
      chartCubit.setSettings(timeFrame: frame, symbol: symbol);
      quotesCubit.currentSymbol.value = quotesCubit.getSymbol(symbol);
    }
  }

  void _updateChart(offset, symbol) {
    final chartCubit = context.read<ChartCubit>();
    chartCubit.getCandles(
      symbol: symbol,
      offset: offset,
    );
  }
}
