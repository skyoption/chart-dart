import 'package:candle_chart/entity/line_entity.dart';
import 'package:candle_chart/entity/trade_entity.dart';
import 'package:candle_chart/k_chart_plus.dart'
    show
        KChartWidgetState,
        GraphStyle,
        CandleTimeFormat,
        KChartWidget,
        ChartColors,
        ChartStyle,
        TimeFormat;
import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/functions.dart';
import 'package:example/features/chart/views/widgets/chart_update_position_widget.dart';
import 'package:example/features/chart/views/widgets/reset_zoom_widget.dart';
import 'package:example/features/chart/logic/chart_cubit.dart';
import 'package:example/features/platform_settings/logic/platform_settings_cubit.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';
import 'package:example/features/main/models/connected_account_info_entity.dart';
import 'package:example/features/trade/logic/orders_cubit.dart';
import 'package:example/features/trade/logic/positions_cubit.dart';
import 'package:example/features/trade/models/order_entity.dart';
import 'package:example/features/trade/models/position_entity.dart';
import 'package:example/features/trade_history/logic/history_positions_cubit.dart';

enum UpdatePosition { TP, SL, Price, TP_Pending, SL_Pending, Price_Pending }

class ChartWidget extends StatefulWidget {
  const ChartWidget({
    super.key,
    required this.chartKey,
    required this.timeframe,
    required this.removeOrder,
    required this.removePosition,
    required this.updateOrders,
    required this.updatePositions,
    required this.graphStyle,
    required this.showUpdatePosition,
    required this.hideGrid,
    required this.isCursor,
  });

  final ValueNotifier<bool> hideGrid;
  final ValueNotifier<GraphStyle> graphStyle;
  final ValueNotifier<CandleTimeFormat> timeframe;
  final ValueNotifier<bool> showUpdatePosition;
  final ValueNotifier<bool> isCursor;
  final Function(OrderEntity item) removeOrder;
  final Function(PositionEntity item) removePosition;
  final Function updateOrders;
  final Function updatePositions;
  final GlobalKey<KChartWidgetState> chartKey;

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class UpdatedPosition {
  ValueNotifier<LineEntity> item;
  ValueNotifier<double> newValue;

  UpdatedPosition({required this.item, required this.newValue});
}

class _ChartWidgetState extends State<ChartWidget> {
  bool showLoading = true;
  UpdatedPosition? position;
  bool isInitial = true;
  bool showOptions = true;
  ValueNotifier<bool> isResetZoom = ValueNotifier(false);
  double tpValue = 0, initTpValue = 0;
  double slValue = 0, initSlValue = 0;
  List<int> editableSLOrTP = [];
  List<TradeEntity> trades = [];

  void _setTrades() {
    final cubit = context.read<PositionsCubit>();
    final historyCubit = context.read<HistoryPositionsCubit>();
    final currentTrades = cubit.positions.map((e) {
      return TradeEntity(
        id: e.id,
        openTime: e.openTime,
        openPrice: e.openPrice,
        isBuy: e.direction == 'BUY',
      );
    }).toList();
    final historyTrades = historyCubit.positions.map((e) {
      return TradeEntity(
        id: e.id,
        openTime: e.openTime,
        openPrice: e.openPrice,
        isBuy: e.direction == 'BUY',
        closeTime: e.closeTime,
        closePrice: e.closePrice,
      );
    }).toList();
    trades = [...currentTrades, ...historyTrades];
    kPrint('Trades ${trades.map((e) => e.openTime).toList()}');
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FlowBuilder<QuotesCubit>(
          builder: (context, state, quotesCubit) {
            if (quotesCubit.symbols.isEmpty) return const SizedBox();
            _setTrades();
            return ValueListenableBuilder<SymbolEntity?>(
              valueListenable: quotesCubit.currentSymbol,
              builder: (context, symbol, child) {
                return FlowBuilder<PlatformSettingsCubit>(
                  builder: (context, state, platform) {
                    return Container(
                      constraints: BoxConstraints(
                        maxWidth: constraints.maxWidth,
                        maxHeight: constraints.maxHeight,
                      ),
                      child: Stack(
                        children: [
                          FlowBuilder<PositionsCubit>(
                            buildWhenCubit: (cubit) => false,
                            listener: (context, state, cubit) {
                              if (state.type == StateType.delete) {
                                widget.removePosition(state.data);
                              } else {
                                _resetSlAndTp();
                                widget.updatePositions();
                              }
                            },
                            builder: (context, state, cubit) {
                              return FlowBuilder<OrdersCubit>(
                                buildWhenCubit: (cubit) => false,
                                listener: (context, state, cubit) {
                                  if (state.type == StateType.delete) {
                                    widget.removeOrder(state.data);
                                  } else {
                                    _resetSlAndTp();
                                    widget.updateOrders();
                                  }
                                },
                                builder: (context, state, cubit) {
                                  return FlowBuilder<ChartCubit>(
                                    buildWhenCubit: (cubit) {
                                      widget.chartKey.currentState
                                          ?.getIndicators();
                                      return cubit.state.type ==
                                          StateType.success;
                                    },
                                    listener: (context, state, cubit) {
                                      _updateAskAndBid(
                                        quotesCubit,
                                        cubit,
                                        platform,
                                      );
                                    },
                                    builder: (context, state, cubit) {
                                      return ValueListenableBuilder<GraphStyle>(
                                        valueListenable: widget.graphStyle,
                                        builder: (context, graphStyle, child) {
                                          return ValueListenableBuilder<bool>(
                                            valueListenable: widget.hideGrid,
                                            builder:
                                                (context, hideGrid, child) {
                                                  return Container(
                                                    constraints: BoxConstraints(
                                                      maxWidth:
                                                          constraints.maxWidth,
                                                      maxHeight:
                                                          constraints.maxHeight,
                                                    ),
                                                    child: KChartWidget(
                                                      trades: trades,
                                                      key: widget.chartKey,
                                                      editableSLOrTP:
                                                          editableSLOrTP,
                                                      hideGrid: hideGrid,
                                                      graphStyle: graphStyle,
                                                      onUpdatePosition:
                                                          onUpdatePosition,
                                                      onZoomingStart: (value) {
                                                        isResetZoom.value =
                                                            !value;
                                                      },
                                                      onLoadMore: (value) {
                                                        if (value) {
                                                          _updateChart();
                                                        }
                                                      },
                                                      chartStyle: ChartStyle(
                                                        scaleStep: 0.000048,
                                                        isSmallChart:
                                                            context.isLandscape,
                                                        gridRows: 8,
                                                        iconSize: 30.0,
                                                        sizeText: 10.0,
                                                        candleWidth: 10.5,
                                                        candleLineWidth: 1.2,
                                                        rightPadding:
                                                            context.isLandscape
                                                            ? 0.0
                                                            : 10.0,
                                                        areaLineWidth: platform
                                                            .settings
                                                            .chartLineSize,
                                                        rightEmptySpace: 200.0,
                                                        initialRightDistance:
                                                            300.0,
                                                      ),
                                                      chartColors: ChartColors(
                                                        bgColor: context
                                                            .colorScheme
                                                            .surface,
                                                        defaultTextColor:
                                                            context
                                                                .colorScheme
                                                                .onSurface,
                                                        maxColor: context
                                                            .colorScheme
                                                            .onSurface,
                                                        iconColor: context
                                                            .colorScheme
                                                            .onSurface,
                                                        primary: context
                                                            .colorScheme
                                                            .primary,
                                                        dnColor: platform
                                                            .settings
                                                            .candleDownColor,
                                                        upColor: platform
                                                            .settings
                                                            .candleUpColor,
                                                        optionsColor: context
                                                            .colorScheme
                                                            .onSurface,
                                                        ask: platform
                                                            .settings
                                                            .askColor,
                                                        bid: platform
                                                            .settings
                                                            .bidColor,
                                                        lineChartColor: platform
                                                            .settings
                                                            .chartThemeColor,
                                                        areaColor: platform
                                                            .settings
                                                            .areaColor,
                                                        stopLoss: platform
                                                            .settings
                                                            .stopLossColor,
                                                        takeProfit: platform
                                                            .settings
                                                            .takeProfitColor,
                                                        gridColor: platform
                                                            .settings
                                                            .chartGridColor,
                                                        cursorColor: platform
                                                            .settings
                                                            .cursorColor,
                                                      ),
                                                      fixedLength: 2,
                                                      timeFormat: TimeFormat
                                                          .YEAR_MONTH_DAY,
                                                      mBaseHeight:
                                                          constraints.maxHeight,
                                                      initialScale: 0.4,
                                                      secondaryRetro:
                                                          context.isLandscape
                                                          ? 0.15
                                                          : 0.32,
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
                            },
                          ),
                          ValueListenableBuilder<ConnectedAccountInfoEntity?>(
                            valueListenable: context
                                .read<PositionsCubit>()
                                .account,
                            builder: (context, account, child) {
                              final isMainAccount =
                                  account?.isMainAccount ?? true;
                              if (!isMainAccount) {
                                return const SizedBox.shrink();
                              }
                              return ValueListenableBuilder(
                                valueListenable: widget.showUpdatePosition,
                                builder: (context, value, child) {
                                  if (position == null) {
                                    return const SizedBox.shrink();
                                  }
                                  return AnimatedPositioned(
                                    duration: const Duration(milliseconds: 300),
                                    bottom: value ? 0 : -1000,
                                    child: ChartUpdatePositionWidget(
                                      key: UniqueKey(),
                                      initialPosition: (item) {
                                        if (isInitial) {
                                          slValue = item.sl;
                                          tpValue = item.tp;
                                          initSlValue = item.sl;
                                          initTpValue = item.tp;
                                          isInitial = false;
                                        }
                                      },
                                      positionLine: position!.item,
                                      updatedValue: position!.newValue,
                                      onCancel: (item) => _onCancel(item),
                                      onFinish: (position) =>
                                          _onFinish(position),
                                      onSl: (item, value) => _onSl(item, value),
                                      onTp: (item, value) => _onTp(item, value),
                                      onUpdateSlAndTp: (item) =>
                                          _onUpdateSlAndTp(item),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child:
                                ValueListenableBuilder<bool>(
                                  valueListenable: widget.isCursor,
                                  builder: (context, isCursor, child) {
                                    return ValueListenableBuilder<bool>(
                                      valueListenable: isResetZoom,
                                      builder: (context, value, child) {
                                        if (!value) return const SizedBox();
                                        return Padding(
                                          padding: MPadding.set(
                                            top: isCursor ? 100.0 : 40.0,
                                          ),
                                          child: ResetZoomWidget(
                                            onReset: () {
                                              isResetZoom.value = false;
                                              widget.chartKey.currentState
                                                  ?.resetZoom();
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ).addPadding(
                                  horizontal: context.isLandscape ? 12.0 : 12.0,
                                ),
                          ),
                          // if (symbol != null && symbol.isMarketClose)
                          //   Positioned(
                          //     top: 21.0,
                          //     left: 0,
                          //     right: 0,
                          //     bottom: 0,
                          //     child: Container(
                          //       color: Colors.black54,
                          //       alignment: Alignment.center,
                          //       child: Column(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         children: [
                          //           MText(
                          //             text: context.tr.marketCurrentlyClosed,
                          //             color: context.colorScheme.onSurface,
                          //             size: FoontSize.font16,
                          //             weight: FontWeight.w500,
                          //           ).addPadding(bottom: 8.0),
                          //           MarketOpenCounter(
                          //             onCountdownFinished: () {
                          //               context
                          //                   .read<QuotesCubit>()
                          //                   .setCurrentSymbol(symbol);
                          //             },
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                        ],
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

  void _onUpdateSlAndTp(PositionEntity item) {
    final symbol = context.read<QuotesCubit>().currentSymbol.value;
    if (symbol == null) return;
    tpValue = double.parse(tpValue.toStringAsFixed(symbol.digits));
    slValue = double.parse(slValue.toStringAsFixed(symbol.digits));
    context.router.push(
      EditPositionRoute(
        position: item
          ..sl = slValue
          ..tp = tpValue,
        onSuccess: () {
          position = null;
          widget.showUpdatePosition.value = false;
        },
      ),
    );
  }

  void _onSl(PositionEntity item, bool value) {
    if (!value) {
      _removeSl(item);
      return;
    }
    final maxPrice = widget.chartKey.currentState!.maxPrice;
    final minPrice = widget.chartKey.currentState!.minPrice;
    if (item.direction == 'SELL') {
      slValue = (maxPrice + item.openPrice) / 2;
    } else {
      slValue = (item.openPrice + minPrice) / 2;
    }
    _drawSL(item, slValue);
  }

  void _onTp(PositionEntity item, bool value) {
    if (!value) {
      _removeTp(item);
      return;
    }
    final minPrice = widget.chartKey.currentState!.minPrice;
    final maxPrice = widget.chartKey.currentState!.maxPrice;
    if (item.direction == 'SELL') {
      tpValue = (item.openPrice + minPrice) / 2;
    } else {
      tpValue = (item.openPrice + maxPrice) / 2;
    }
    _drawTp(item, tpValue);
  }

  void _resetSlAndTp() {
    slValue = 0;
    tpValue = 0;
    initSlValue = 0;
    initTpValue = 0;
    position?.item.dispose();
    position?.newValue.dispose();
    position = null;
    isInitial = true;
  }

  void _onFinish(PositionEntity item) {
    _resetSlAndTp();
    _removeSl(item);
    _removeTp(item);
    editableSLOrTP.clear();
    widget.showUpdatePosition.value = false;
    widget.updatePositions();
    widget.updateOrders();
  }

  void _drawSL(PositionEntity item, double value) {
    final platform = context.read<PlatformSettingsCubit>();
    widget.chartKey.currentState?.addOrUpdateSLOrTPOrPosition(
      LineEntity(
        id: item.id * 5,
        color: platform.settings.stopLossColor,
        title: (value) {
          return '#${item.id} ${context.tr.stopLoss} (${_drawPrice(item, item.openPrice, value)} ${context.tr.usd})';
        },
        type: UpdatePosition.SL.name,
        value: value,
        editable: true,
      ),
    );
    editableSLOrTP.add(item.id * 5);
  }

  void _drawTp(PositionEntity item, double value) {
    final platform = context.read<PlatformSettingsCubit>();
    widget.chartKey.currentState?.addOrUpdateSLOrTPOrPosition(
      LineEntity(
        id: item.id * 10,
        color: platform.settings.takeProfitColor,
        title: (value) {
          return '#${item.id} ${context.tr.takeProfit} (${_drawPrice(item, item.openPrice, value)} ${context.tr.usd})';
        },
        type: UpdatePosition.TP.name,
        value: value,
        editable: true,
      ),
    );
    editableSLOrTP.add(item.id * 10);
  }

  void _removeSl(PositionEntity item) {
    slValue = 0;
    initSlValue = 0;
    widget.chartKey.currentState?.removeSLOrTPOrPosition(item.id * 5);
    editableSLOrTP.remove(item.id * 5);
  }

  void _removeTp(PositionEntity item) {
    tpValue = 0;
    initTpValue = 0;
    widget.chartKey.currentState?.removeSLOrTPOrPosition(item.id * 10);
    editableSLOrTP.remove(item.id * 10);
  }

  double _drawPrice(
    PositionEntity item,
    double entryPrice,
    double targetPrice,
  ) {
    final symbol = context.read<QuotesCubit>().currentSymbol.value;
    if (symbol == null) return 0;
    final result = priceToMoney(
      entryPrice: entryPrice,
      targetPrice: targetPrice,
      decimalPlaces: 2,
      contractSize: symbol.contractSize,
      volume: item.volumeCurrent,
      profitRatio: symbol.profitRatio,
    );
    return result;
  }

  void _onCancel(PositionEntity item) {
    _resetSlAndTp();
    _removeSl(item);
    _removeTp(item);
    editableSLOrTP.clear();
    widget.showUpdatePosition.value = false;
    context.read<PositionsCubit>().resetPositions();
    context.read<OrdersCubit>().resetOrders();
  }

  void _updateAskAndBid(
    QuotesCubit quotesCubit,
    ChartCubit cubit,
    PlatformSettingsCubit platform,
  ) {
    widget.chartKey.currentState!.setLoadedCandles(candles: cubit.items);
    if (cubit.bid != null) {
      widget.chartKey.currentState!.updateAskAndBid(
        LineEntity(
          id: -10,
          color: platform.settings.bidColor,
          value: cubit.bid!,
          title: (value) => '',
        ),
      );
    }
    if (cubit.ask != null && platform.settings.showAskLine) {
      widget.chartKey.currentState!.updateAskAndBid(
        LineEntity(
          id: -20,
          color: platform.settings.askColor,
          value: cubit.ask!,
          title: (value) => '',
        ),
      );
    } else {
      widget.chartKey.currentState!.removeAskBid(-20);
    }
  }

  void _updateChart() {
    final chartCubit = context.read<ChartCubit>();
    final quotesCubit = context.read<QuotesCubit>();
    chartCubit.getCandles(
      timeFrame: widget.timeframe.value,
      symbol: quotesCubit.currentSymbol.value!.symbol,
      offset: chartCubit.offset + 1,
    );
  }

  void onUpdatePosition(LineEntity line, double newValue) {
    if (line.positionType == UpdatePosition.TP) {
      tpValue = newValue;
      initTpValue = newValue;
    }
    if (line.positionType == UpdatePosition.SL) {
      slValue = newValue;
      initSlValue = newValue;
    }
    if (!line.isOrder) {
      if (position != null) {
        position?.item.value = line;
        position?.newValue.value = newValue;
      } else {
        position = UpdatedPosition(
          item: ValueNotifier(line),
          newValue: ValueNotifier(newValue),
        );
      }
      widget.showUpdatePosition.value = true;
    }
  }
}

extension OnLine on LineEntity {
  UpdatePosition get positionType {
    final index = UpdatePosition.values.indexWhere((e) {
      return e.name == type;
    });
    return UpdatePosition.values[index];
  }

  bool get isOrder {
    return positionType == UpdatePosition.SL_Pending ||
        positionType == UpdatePosition.TP_Pending ||
        positionType == UpdatePosition.Price_Pending;
  }

  int get positionId {
    switch (positionType) {
      case UpdatePosition.SL:
        return id ~/ 5;
      case UpdatePosition.TP:
        return id ~/ 10;
      case UpdatePosition.Price:
        return id ~/ 15;
      case UpdatePosition.SL_Pending:
        return id ~/ 20;
      case UpdatePosition.TP_Pending:
        return id ~/ 25;
      case UpdatePosition.Price_Pending:
        return id ~/ 30;
    }
  }
}
