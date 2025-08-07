import 'package:candle_chart/entity/line_entity.dart';
import 'package:candle_chart/k_chart_widget.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/features/chart/logic/chart_cubit.dart';
import 'package:example/features/chart/views/widgets/chart_options_widget.dart';
import 'package:example/features/chart/views/widgets/chart_widget.dart';
import 'package:example/features/chart/views/widgets/choose_symbol_widget.dart';
import 'package:example/features/chart/views/widgets/choose_timeframe_widget.dart';
import 'package:example/features/chart/views/widgets/cursor_widget.dart';
import 'package:example/features/chart/views/widgets/symbol_options_widget.dart';
import 'package:example/features/chart/views/widgets/zoom_widget.dart';
import 'package:example/features/settings/logic/platform_settings_cubit.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';
import 'package:example/features/trade/logic/close_position_cubit.dart';
import 'package:example/features/trade/logic/modify_position_cubit.dart';
import 'package:example/features/trade/logic/orders_cubit.dart';
import 'package:example/features/trade/logic/positions_cubit.dart';
import 'package:example/features/trade/models/order_entity.dart';
import 'package:example/features/trade/models/position_entity.dart';
import 'package:example/injection/injectable.dart';

import 'widgets/full_size_widget.dart';

class ChartScreen extends StatefulWidget {
  final TabController? bottomNavController;
  final Function(bool isOpened) onFullSize;

  const ChartScreen({
    super.key,
    required this.onFullSize,
    this.bottomNavController,
  });

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

final key = GlobalKey<KChartWidgetState>();

class _ChartScreenState extends State<ChartScreen> {
  final hideGrid = ValueNotifier<bool>(true);
  final showOptions = ValueNotifier<bool>(true);
  final isFullscreen = ValueNotifier<bool>(false);
  final showUpdatePosition = ValueNotifier<bool>(false);
  final graphStyle = ValueNotifier<GraphStyle>(GraphStyle.candles);
  final timeframe = ValueNotifier<CandleTimeFormat>(CandleTimeFormat.M15);

  @override
  void initState() {
    if (widget.bottomNavController != null) {
      widget.bottomNavController!.addListener(chartTabActiveListener);
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.bottomNavController != null) {
      widget.bottomNavController!.removeListener(chartTabActiveListener);
    }
    showOptions.dispose();
    isFullscreen.dispose();
    timeframe.dispose();
    graphStyle.dispose();
    showUpdatePosition.dispose();
    hideGrid.dispose();
    super.dispose();
  }

  void chartTabActiveListener() {
    if (widget.bottomNavController != null &&
        widget.bottomNavController!.index == 1) {
      _resetChart();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<ModifyPositionCubit>()),
          BlocProvider(create: (context) => getIt<ClosePositionCubit>()),
        ],
        child: SafeArea(
          left: !context.isLandscape,
          minimum: context.isLandscape
              ? EdgeInsets.only(left: 12.0, top: 12.0, right: 12.0)
              : EdgeInsets.zero,
          child: Builder(
            builder: (context) {
              if (context.isLandscape) {
                return Row(
                  children: [
                    ValueListenableBuilder<bool>(
                      valueListenable: showOptions,
                      builder: (context, options, child) {
                        if (!options) return SizedBox();
                        return Expanded(child: buttonOptions(options));
                      },
                    ),
                    Expanded(flex: 3, child: chart()),
                  ],
                );
              }
              return Column(
                children: [
                  Expanded(child: chart()),
                  ValueListenableBuilder<bool>(
                    valueListenable: showOptions,
                    builder: (context, options, child) {
                      return buttonOptions(options);
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget chart() {
    final platform = context.read<PlatformSettingsCubit>();
    return Column(
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
                removeOrder: removeOrder,
                updateOrders: updateOrders,
                removePosition: removePosition,
                updatePositions: updatePositions,
              ).addPadding(top: 100.0),
              Column(
                spacing: 12.0,
                children: [
                  Row(
                    spacing: 12.0,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ChartOptionsWidget(
                        hideGrid: hideGrid,
                        onCursor: (cursor) {
                          key.currentState?.setCursor(cursor);
                        },
                        openObjects: () {
                          key.currentState?.openObjects();
                        },
                        openFunctions: () {
                          key.currentState?.openIndicators();
                        },
                        graphStyle: graphStyle,
                        onChangeStyle: (graphStyle) {
                          if (platform.settings.showAskLine) {
                            key.currentState!.updateAskAndBid(
                              LineEntity(
                                id: -20,
                                color: platform.settings.askColor,
                                value: context.read<ChartCubit>().ask!,
                              ),
                            );
                          } else {
                            key.currentState!.removeAskBid(-20);
                          }
                        },
                      ),
                      Expanded(
                        child: ChooseSymbolWidget(
                          onChanged: (symbol) {
                            _updateSymbol();
                          },
                        ),
                      ),

                      FullSizeWidget(
                        onGesture: () {
                          isFullscreen.value = !isFullscreen.value;
                          widget.onFullSize(isFullscreen.value);
                        },
                      ),
                      ZoomWidget(
                        onOptions: () {
                          showOptions.value = !showOptions.value;
                        },
                      ),
                      ValueListenableBuilder<CandleTimeFormat>(
                        valueListenable: timeframe,
                        builder: (context, value, child) {
                          return ChooseTimeframeWidget(
                            timeframe: value,
                            onChanged: (value) {
                              timeframe.value = value;
                              _resetChart();
                            },
                          );
                        },
                      ),
                      // TimeLimitWidget(
                      //   onGesture: () {},
                      // ),
                    ],
                  ),
                ],
              ).addPadding(horizontal: 21.0),
            ],
          ),
        ),
        if (context.isLandscape)
          ValueListenableBuilder<bool>(
            valueListenable: isFullscreen,
            builder: (context, fullscreen, child) {
              return SizedBox(height: fullscreen ? 0.0 : 75.0);
            },
          )
        else
          SizedBox(height: 20.0),
      ],
    );
  }

  Widget buttonOptions(bool options) => ValueListenableBuilder<bool>(
        valueListenable: isFullscreen,
        builder: (context, fullscreen, child) {
          if ((fullscreen && !options) || !options) {
            return SizedBox(
              height: !fullscreen && !options ? 50.0 : 0.0,
            );
          }
          return const SymbolOptionsWidget(
            type: TransactionOptions.market_order,
          ).addPadding(
            horizontal: 21.0,
            top: 8.0,
            bottom: fullscreen
                ? 0.0
                : !fullscreen
                    ? Platform.isIOS
                        ? context.isTablet
                            ? context.height * 0.07
                            : context.height * 0.062
                        : context.isGestureNavigation
                            ? context.height * 0.08
                            : context.height * 0.11
                    : 0.0,
          );
        },
      );

  Future<void> _updateSymbol() async {
    final quotesCubit = context.read<QuotesCubit>();
    showUpdatePosition.value = false;
    await Future.delayed(const Duration(milliseconds: 200));
    key.currentState?.updateDefaultSettings(
      frame: timeframe.value,
      symbol: quotesCubit.currentSymbol.value!.symbol,
    );
    key.currentState?.clearSLOrTPOrPosition();
    await Future.delayed(const Duration(milliseconds: 200));
    key.currentState?.setLoadedObjects();
    updatePositions();
    updateOrders();
  }

  Future<void> _resetChart() async {
    showUpdatePosition.value = false;
    _updateChart(offset: 0);
    key.currentState?.clearSLOrTPOrPosition();
    await Future.delayed(const Duration(milliseconds: 200));
    updatePositions();
    updateOrders();
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
    final symbol = quotesCubit.currentSymbol.value!.symbol;
    for (var item in cubit.positions) {
      if (symbol != item.groupSymbol) continue;
      if (item.sl != 0) {
        key.currentState?.addOrUpdateSLOrTPOrPosition(
          LineEntity(
            id: item.id * 5,
            color: platform.settings.stopLossColor,
            title: '#${item.id} ${context.tr.stopLossTitle}',
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
            title: '#${item.id} ${context.tr.takeProfitTitle}',
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
            title: '#${item.id} ${item.direction} ${item.volumeCurrent}',
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
    final symbol = quotesCubit.currentSymbol.value!.symbol;
    for (var item in cubit.orders) {
      if (symbol != item.symbol) continue;
      if (item.sl != 0) {
        key.currentState?.addOrUpdateSLOrTPOrPosition(
          LineEntity(
            id: item.id * 20,
            color: Colors.grey,
            title: '#${item.id} ${context.tr.stopLossTitle}',
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
            title: '#${item.id} ${context.tr.takeProfitTitle}',
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
            title: '#${item.id} ${item.direction} ${item.volume}',
            type: UpdatePosition.Price_Pending.name,
            value: item.openPrice,
            editable: false,
          ),
        );
      }
    }
  }

  Future<void> _updateChart({int offset = 0}) async {
    final chartCubit = context.read<ChartCubit>();
    final quotesCubit = context.read<QuotesCubit>();
    chartCubit.getCandles(
      timeFrame: timeframe.value,
      symbol: quotesCubit.currentSymbol.value!.symbol,
      offset: offset,
    );
    await Future.delayed(const Duration(milliseconds: 200));
    key.currentState?.updateDefaultSettings(
      frame: timeframe.value,
      symbol: quotesCubit.currentSymbol.value!.symbol,
    );
    key.currentState?.setLoadedObjects();
  }
}
