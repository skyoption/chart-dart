import 'package:candle_chart/entity/line_entity.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:example/features/chart/views/widgets/reset_zoom_widget.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/features/chart/logic/chart_cubit.dart';
import 'package:example/features/platform_settings/logic/platform_settings_cubit.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';
import 'package:candle_chart/entity/k_line_entity.dart';

class ChartShortcutWidget extends StatefulWidget {
  const ChartShortcutWidget({
    super.key,
    required this.graphStyle,
    this.initialSymbol,
  });

  final ValueNotifier<GraphStyle> graphStyle;
  final String? initialSymbol;

  @override
  State<ChartShortcutWidget> createState() => _ChartShortcutWidgetState();
}

final chartKey = GlobalKey<KChartWidgetState>();

class _ChartShortcutWidgetState extends State<ChartShortcutWidget> {
  bool showLoading = true;
  ValueNotifier<bool> isResetZoom = ValueNotifier(false);

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 150), () {
      final cubit = context.read<QuotesCubit>();

      // If we have an initial symbol, set it first and skip default settings
      if (widget.initialSymbol != null) {
        final symbol = cubit.getSymbol(widget.initialSymbol!);
        if (symbol != null) {
          cubit.currentSymbol.value = symbol;
          _updateChart(0, widget.initialSymbol!);
        }
      } else {
        // Only get default settings if no initial symbol is provided
        chartProperties.getDefaultSettings(
          onGetting: onGettingSettings,
        );
        if (cubit.currentSymbol.value != null) {
          _updateChart(0, cubit.currentSymbol.value!.symbol);
        }
      }
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
              height: 350.0,
              child: Stack(
                children: [
                  FlowBuilder<QuotesCubit>(
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
                                hideGrid: true,
                                graphStyle: graphStyle,
                                onUpdatePosition: (position, newValue) {},
                                onZoomingStart: (value) {
                                  isResetZoom.value = !value;
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
                                  iconSize: 30.0,
                                  sizeText: 10.0,
                                  rightPadding:
                                      context.isLandscape ? 0.0 : 10.0,
                                  areaLineWidth:
                                      platform.settings.chartLineSize,
                                ),
                                chartColors: ChartColors(
                                  bgColor: context.colorScheme.surface,
                                  defaultTextColor:
                                      context.colorScheme.onSurface,
                                  maxColor: context.colorScheme.onSurface,
                                  iconColor: context.colorScheme.onSurface,
                                  primary: context.colorScheme.primary,
                                  optionsColor: context.colorScheme.onSurface,
                                  ask: platform.settings.askColor,
                                  bid: platform.settings.bidColor,
                                  lineChartColor:
                                      platform.settings.chartThemeColor,
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
                  Align(
                    alignment: Alignment.topLeft,
                    child: ValueListenableBuilder<bool>(
                      valueListenable: isResetZoom,
                      builder: (context, value, child) {
                        if (!value) return const SizedBox();
                        return Padding(
                          padding: const MPadding.set(top: 16.0),
                          child: ResetZoomWidget(
                            onReset: () {
                              isResetZoom.value = false;
                              chartKey.currentState?.resetZoom();
                            },
                          ),
                        );
                      },
                    ).addPadding(horizontal: context.isLandscape ? 12.0 : 21.0),
                  ),
                ],
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
          title: (value) => '',
        ),
      );
    }
    if (cubit.ask != null && platform.settings.showAskLine) {
      chartKey.currentState!.updateAskAndBid(
        LineEntity(
          id: -20,
          color: platform.settings.askColor,
          value: cubit.ask!,
          title: (value) => '',
        ),
      );
    } else {
      chartKey.currentState!.removeAskBid(-20);
    }
  }

  void onGettingSettings(
    CandleTimeFormat frame,
    String symbol,
    List<KLineEntity> candles,
  ) {
    if (symbol.isNotEmpty) {
      final quotesCubit = context.read<QuotesCubit>();
      final chartCubit = context.read<ChartCubit>();
      chartCubit.setSettings(
          timeFrame: frame, symbol: symbol, candles: candles);

      // Only set currentSymbol if:
      // 1. No initial symbol was provided, OR
      // 2. The current symbol is null, OR
      // 3. The current symbol is different from the intended symbol
      final currentSymbol = quotesCubit.currentSymbol.value;
      final shouldSetSymbol = widget.initialSymbol == null ||
          currentSymbol == null ||
          currentSymbol.symbol != symbol;

      if (shouldSetSymbol) {
        quotesCubit.currentSymbol.value = quotesCubit.getSymbol(symbol);
      }
    }
  }

  void _updateChart(offset, symbol) {
    final chartCubit = context.read<ChartCubit>();
    chartCubit.getCandles(symbol: symbol, offset: offset);
  }
}
