import 'package:candle_chart/entity/line_entity.dart';
import 'package:candle_chart/k_chart_plus.dart' show chartProperties;
import 'package:candle_chart/k_chart_widget.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/consts/tool_tips_config.dart';
import 'package:example/features/chart/views/widgets/chart_options_widget.dart';
import 'package:example/features/chart/views/widgets/chart_widget.dart';
import 'package:example/features/chart/views/widgets/choose_symbol_widget.dart';
import 'package:example/features/chart/views/widgets/choose_timeframe_widget.dart';
import 'package:example/features/chart/views/widgets/symbol_options_widget.dart';
import 'package:example/features/chart/views/widgets/zoom_widget.dart';
import 'package:example/core/framework/functions.dart';
import 'package:example/core/framework/orientation_helper.dart';
import 'package:example/core/shared/guide_tooltip_widget.dart';
import 'package:example/features/chart/logic/chart_cubit.dart';
import 'package:example/features/platform_settings/logic/platform_settings_cubit.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';
import 'package:example/features/main/models/connected_account_info_entity.dart';
import 'package:example/features/trade/logic/orders_cubit.dart';
import 'package:example/features/trade/logic/positions_cubit.dart';
import 'package:example/features/trade/models/order_entity.dart';
import 'package:example/features/trade/models/position_entity.dart';
import 'package:candle_chart/entity/k_line_entity.dart';
import 'widgets/full_size_widget.dart';

@RoutePage()
class ChartScreen extends StatefulWidget {
  final ValueNotifier<bool> isFullscreen;
  final SymbolEntity? currentSymbol;

  const ChartScreen(
      {super.key, required this.isFullscreen, this.currentSymbol});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

final key = GlobalKey<KChartWidgetState>();

class _ChartScreenState extends State<ChartScreen>
    with AutoRouteAwareStateMixin, WidgetsBindingObserver {
  // ValueNotifiers
  final hideGrid = ValueNotifier<bool>(true);
  final showOptions = ValueNotifier<bool>(true);
  final isCursor = ValueNotifier<bool>(false);
  final showUpdatePosition = ValueNotifier<bool>(false);
  final graphStyle = ValueNotifier<GraphStyle>(GraphStyle.candles);
  final timeframe = ValueNotifier<CandleTimeFormat>(CandleTimeFormat.M15);
  Orientation? _lastOrientation;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      chartProperties.getDefaultSettings(
        onGetting: onGettingSettings,
      );
      _lastOrientation = MediaQuery.of(context).orientation;
    });
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeMetrics() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final newOrientation = MediaQuery.of(context).orientation;

      if (newOrientation != _lastOrientation) {
        _lastOrientation = newOrientation;

        final isLandscape = newOrientation == Orientation.landscape;
        widget.isFullscreen.value = isLandscape;
      }
    });

    super.didChangeMetrics();
  }

  void onGettingSettings(
    CandleTimeFormat frame,
    String symbol,
    List<KLineEntity> candles,
  ) async {
    kPrint('onGettingSettings: $frame, $symbol ${candles.length}');
    if (symbol.isNotEmpty) {
      final quotesCubit = context.read<QuotesCubit>();
      final chartCubit = context.read<ChartCubit>();
      timeframe.value = frame;
      chartCubit.setSettings(
        timeFrame: frame,
        symbol: symbol,
        candles: candles,
      );
      quotesCubit.setTimeframe(frame);
      quotesCubit.setSymbol(symbol);
      Future.delayed(const Duration(seconds: 1), () {
        updatePositions();
        updateOrders();
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    showOptions.dispose();
    timeframe.dispose();
    graphStyle.dispose();
    showUpdatePosition.dispose();
    hideGrid.dispose();
    isCursor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final platform = context.read<PlatformSettingsCubit>();
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ValueListenableBuilder<bool>(
            valueListenable: widget.isFullscreen,
            builder: (context, fullscreen, child) {
              return SafeArea(
                left: !context.isLandscape,
                minimum: context.isLandscape
                    ? const EdgeInsets.only(
                        left: 12.0,
                        top: 10.0,
                        right: 12.0,
                      )
                    : EdgeInsets.zero,
                child: context.isLandscape
                    ? Container(
                        constraints: BoxConstraints(
                          maxWidth: constraints.maxWidth,
                          maxHeight: constraints.maxHeight,
                        ),
                        child: Column(
                          children: [
                            Expanded(child: _buildChart(platform)),
                            ValueListenableBuilder<bool>(
                              valueListenable: showOptions,
                              builder: (context, options, _) {
                                if (!options) {
                                  return const SizedBox.shrink();
                                }
                                return _buildOptionsPanel();
                              },
                            ),
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          Expanded(child: _buildChart(platform)),
                          _buildOptionsPanel(),
                        ],
                      ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildChart(PlatformSettingsCubit platform) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          constraints: BoxConstraints(
            maxWidth: constraints.maxWidth,
            maxHeight: constraints.maxHeight,
          ),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    ChartWidget(
                      chartKey: key,
                      timeframe: timeframe,
                      graphStyle: graphStyle,
                      hideGrid: hideGrid,
                      showUpdatePosition: showUpdatePosition,
                      isCursor: isCursor,
                      removeOrder: removeOrder,
                      updateOrders: updateOrders,
                      removePosition: removePosition,
                      updatePositions: updatePositions,
                    ).addPadding(top: 40),
                    _buildChartHeader(platform),
                  ],
                ),
              ),
              if (!context.isLandscape) const SizedBox(height: 20.0),
            ],
          ),
        );
      },
    );
  }

  Widget _buildChartHeader(PlatformSettingsCubit platform) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          constraints: BoxConstraints(
            maxWidth: constraints.maxWidth,
            maxHeight: constraints.maxHeight,
          ),
          child: ValueListenableBuilder(
            valueListenable: showOptions,
            builder: (context, options, child) {
              return _chartOptions(platform);
            },
          ),
        ).addPadding(horizontal: 21.0);
      },
    );
  }

  Widget _chartOptions(PlatformSettingsCubit platform) {
    return LayoutBuilder(
      builder: (context, headerConstraints) {
        return Row(
          spacing: 12.0,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GuideTooltipWidget(
              config: ChartTooltip.chartOptions.config,
              child: _chartOptionsWidget(platform),
            ),
            Expanded(
              child: GuideTooltipWidget(
                config: ChartTooltip.symbolSelection.config,
                child: ChooseSymbolWidget(
                  onViewAll: () {
                    if (context.isLandscape) {
                      OrientationHelper.lockToPortrait();
                    }
                  },
                  onChanged: (symbol) => _updateSymbol(symbol),
                ),
              ),
            ),
            if (!context.isLandscape)
              GuideTooltipWidget(
                config: ChartTooltip.fullscreenToggle.config,
                child: FullSizeWidget(isFullscreen: widget.isFullscreen),
              ),
            GuideTooltipWidget(
              config: ChartTooltip.zoomOptions.config,
              child: ValueListenableBuilder<ConnectedAccountInfoEntity?>(
                valueListenable: context.read<PositionsCubit>().account,
                builder: (context, account, child) {
                  final isMainAccount = account?.isMainAccount ?? true;
                  if (!isMainAccount) return const SizedBox.shrink();
                  return ZoomWidget(
                      onOptions: () => showOptions.value = !showOptions.value);
                },
              ),
            ),
            if (!context.isTablet)
              GuideTooltipWidget(
                config: ChartTooltip.screenRotation.config,
                child: Container(
                  decoration: BoxDecoration(
                    color: context.colorScheme.surfaceContainerLow,
                    borderRadius: MBorderRadius.set(all: 10.0),
                  ),
                  height: 45.0,
                  width: 45.0,
                  child: Icon(
                    Icons.screen_rotation,
                    color: context.colorScheme.onSurface,
                    size: 24.0,
                  ),
                ).addAction(
                  onTap: () async {
                    if (context.isLandscape) {
                      await OrientationHelper.lockToPortrait();
                    } else {
                      await OrientationHelper.lockToLandscape();
                    }
                  },
                ),
              ),
            ValueListenableBuilder<CandleTimeFormat>(
              valueListenable: timeframe,
              builder: (context, value, child) {
                return GuideTooltipWidget(
                  config: ChartTooltip.timeframeSelection.config,
                  child: ChooseTimeframeWidget(
                    timeframe: value,
                    onChanged: (value) {
                      timeframe.value = value;
                      _resetChart();
                    },
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _chartOptionsWidget(PlatformSettingsCubit platform) {
    return ChartOptionsWidget(
      onCursor: (cursor) {
        isCursor.value = cursor;
        key.currentState?.setCursor(cursor);
      },
      hideGrid: hideGrid,
      openObjects: () => key.currentState?.openObjects(),
      openFunctions: () => key.currentState?.openIndicators(),
      graphStyle: graphStyle,
      onChangeStyle: (graphStyle) {
        if (platform.settings.showAskLine) {
          key.currentState!.updateAskAndBid(
            LineEntity(
              id: -20,
              color: platform.settings.askColor,
              value: context.read<ChartCubit>().ask!,
              title: (value) => '',
            ),
          );
        } else {
          key.currentState!.removeAskBid(-20);
        }
      },
    );
  }

  /// Calculates dynamic bottom padding based on device type, orientation, and fullscreen state
  double _calculateBottomPadding(BuildContext context, bool fullscreen) {
    // No padding for tablets
    if (context.isTablet) return 0.0;

    // No padding for landscape orientation
    if (context.isLandscape) return 0.0;
    // No padding when in fullscreen mode
    if (fullscreen) return 0.0;
    // Platform-specific padding for portrait mode
    return Platform.isIOS ? 85.0 : 105.0;
  }

  Widget _buildOptionsPanel() {
    return ValueListenableBuilder<ConnectedAccountInfoEntity?>(
      valueListenable: context.read<PositionsCubit>().account,
      builder: (context, account, child) {
        final isMainAccount = account?.isMainAccount ?? true;
        if (!isMainAccount) {
          return SizedBox(height: context.isLandscape ? 0 : 50);
        }
        return LayoutBuilder(
          builder: (context, constraints) {
            return ValueListenableBuilder<bool>(
              valueListenable: showOptions,
              builder: (context, options, child) {
                return ValueListenableBuilder<bool>(
                  valueListenable: widget.isFullscreen,
                  builder: (context, fullscreen, child) {
                    if ((fullscreen && !options) || !options) {
                      return SizedBox(
                          height: !fullscreen && !options ? 50.0 : 0.0);
                    }
                    return Container(
                      constraints: BoxConstraints(
                        maxWidth: constraints.maxWidth,
                        maxHeight: constraints.maxHeight,
                      ),
                      child: GuideTooltipWidget(
                        config: ChartTooltip.tradingPanel.config,
                        child: const SymbolOptionsWidget(
                          type: TransactionOptions.market_order,
                        ).addPadding(
                          horizontal: 21.0,
                          top: 8.0,
                          bottom: _calculateBottomPadding(context, fullscreen),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  Future<void> _resetChart() async {
    showUpdatePosition.value = false;
    _updateChart(offset: 0);
    key.currentState?.clearSLOrTPOrPosition();
    await Future.delayed(const Duration(milliseconds: 300));
    updatePositions();
    updateOrders();
  }

  Future<void> _updateSymbol(String symbol) async {
    key.currentState?.goToEnd();
    showUpdatePosition.value = false;
    final quotesCubit = context.read<QuotesCubit>();
    quotesCubit.setSymbol(symbol);
    key.currentState?.clearSLOrTPOrPosition();
    await Future.delayed(const Duration(milliseconds: 200));
    key.currentState?.setLoadedObjects();
    key.currentState?.goToEnd();
    if (mounted) context.read<PositionsCubit>().resetPositions();
    if (mounted) context.read<OrdersCubit>().resetOrders();
  }

  @override
  void didInitTabRoute(TabPageRoute? previousRoute) {
    _resetChart();
    super.didInitTabRoute(previousRoute);
  }

  @override
  void didChangeTabRoute(TabPageRoute previousRoute) {
    _resetChart();
    super.didChangeTabRoute(previousRoute);
  }

  @override
  void didUpdateWidget(covariant ChartScreen oldWidget) {
    if (oldWidget.currentSymbol != widget.currentSymbol) {
      if (widget.currentSymbol != null) {
        _updateSymbol(widget.currentSymbol!.symbol);
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  void removePosition(PositionEntity item) {
    key.currentState?.removeSLOrTPOrPosition(item.id * 15);
    if (item.sl != 0) {
      key.currentState?.removeSLOrTPOrPosition(item.id * 5);
    }
    if (item.tp != 0) {
      key.currentState?.removeSLOrTPOrPosition(item.id * 10);
    }
  }

  void updatePositions() {
    final quotesCubit = context.read<QuotesCubit>();
    final cubit = context.read<PositionsCubit>();
    final platform = context.read<PlatformSettingsCubit>();
    if (quotesCubit.currentSymbol.value == null) return;
    final symbol = quotesCubit.currentSymbol.value!.symbol;
    for (var item in cubit.positions) {
      if (symbol != item.groupSymbol) continue;
      if (item.sl != 0) {
        key.currentState?.addOrUpdateSLOrTPOrPosition(
          LineEntity(
            id: item.id * 5,
            color: platform.settings.stopLossColor,
            title: (value) {
              return '#${item.id} ${context.tr.stopLoss} (${_drawPrice(item.volumeCurrent, item.openPrice, value)} ${context.tr.usd})';
            },
            type: UpdatePosition.SL.name,
            value: item.sl,
            editable: true,
          ),
        );
      }
      if (item.tp != 0) {
        key.currentState?.addOrUpdateSLOrTPOrPosition(
          LineEntity(
            id: item.id * 10,
            color: platform.settings.takeProfitColor,
            title: (value) {
              return '#${item.id} ${context.tr.takeProfit} (${_drawPrice(item.volumeCurrent, item.openPrice, value)} ${context.tr.usd})';
            },
            type: UpdatePosition.TP.name,
            value: item.tp,
            editable: true,
          ),
        );
      }
      if (item.openPrice != 0) {
        key.currentState?.addOrUpdateSLOrTPOrPosition(
          LineEntity(
            id: item.id * 15,
            color: platform.settings.tradeColor,
            title: (value) {
              return '#${item.id} ${item.direction} ${item.volumeCurrent}';
            },
            type: UpdatePosition.Price.name,
            value: item.openPrice,
          ),
        );
      }
    }
  }

  void removeOrder(OrderEntity item) {
    key.currentState?.removeSLOrTPOrPosition(item.id * 30);
    if (item.sl != 0) {
      key.currentState?.removeSLOrTPOrPosition(item.id * 20);
    }
    if (item.tp != 0) {
      key.currentState?.removeSLOrTPOrPosition(item.id * 25);
    }
  }

  void updateOrders() {
    final quotesCubit = context.read<QuotesCubit>();
    final cubit = context.read<OrdersCubit>();
    if (quotesCubit.currentSymbol.value == null) return;
    final symbol = quotesCubit.currentSymbol.value!.symbol;
    for (var item in cubit.orders) {
      if (symbol != item.symbol) continue;
      if (item.sl != 0) {
        key.currentState?.addOrUpdateSLOrTPOrPosition(
          LineEntity(
            id: item.id * 20,
            color: Colors.grey,
            title: (value) {
              return '#${item.id} ${context.tr.stopLoss} (${_drawPrice(item.volume, item.openPrice, value)} ${context.tr.usd})';
            },
            type: UpdatePosition.SL_Pending.name,
            value: item.sl,
            editable: false,
          ),
        );
      }
      if (item.tp != 0) {
        key.currentState?.addOrUpdateSLOrTPOrPosition(
          LineEntity(
            id: item.id * 25,
            color: Colors.grey,
            title: (value) {
              return '#${item.id} ${context.tr.takeProfit} (${_drawPrice(item.volume, item.openPrice, value)} ${context.tr.usd})';
            },
            type: UpdatePosition.TP_Pending.name,
            value: item.tp,
            editable: false,
          ),
        );
      }
      if (item.openPrice != 0) {
        key.currentState?.addOrUpdateSLOrTPOrPosition(
          LineEntity(
            id: item.id * 30,
            color: Colors.grey,
            title: (value) {
              return '#${item.id} ${item.direction} ${item.volume}';
            },
            type: UpdatePosition.Price_Pending.name,
            value: item.openPrice,
            editable: false,
          ),
        );
      }
    }
  }

  double _drawPrice(double volume, double entryPrice, double targetPrice) {
    final symbol = context.read<QuotesCubit>().currentSymbol.value;
    if (symbol == null) return 0;
    final result = priceToMoney(
      entryPrice: entryPrice,
      targetPrice: targetPrice,
      decimalPlaces: 2,
      contractSize: symbol.contractSize,
      volume: volume,
      profitRatio: symbol.profitRatio,
    );
    return result;
  }

  Future<void> _updateChart({int offset = 0}) async {
    final chartCubit = context.read<ChartCubit>();
    final quotesCubit = context.read<QuotesCubit>();
    if (quotesCubit.currentSymbol.value != null) {
      chartCubit.getCandles(
        timeFrame: timeframe.value,
        symbol: quotesCubit.currentSymbol.value!.symbol,
        offset: offset,
      );
      await Future.delayed(const Duration(milliseconds: 300));
      chartCubit.updateAskAndBid(
        ask: quotesCubit.currentSymbol.value!.ask,
        bid: quotesCubit.currentSymbol.value!.bid,
      );
      await key.currentState?.setLoadedObjects();
      if (offset == 0) key.currentState?.goToEnd();
    }
  }
}
