import 'package:candle_chart/entity/line_entity.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:example/core/builder/flow_builder.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/features/chart/logic/chart_cubit.dart';
import 'package:example/features/chart/views/widgets/chart_update_position_widget.dart';
import 'package:example/features/chart/views/widgets/reset_zoom_widget.dart';
import 'package:example/features/settings/logic/platform_settings_cubit.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';
import 'package:example/features/trade/logic/orders_cubit.dart';
import 'package:example/features/trade/logic/positions_cubit.dart';
import 'package:example/features/trade/models/order_entity.dart';
import 'package:example/features/trade/models/position_entity.dart';

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
  });

  final ValueNotifier<bool> hideGrid;
  final ValueNotifier<GraphStyle> graphStyle;
  final ValueNotifier<CandleTimeFormat> timeframe;
  final ValueNotifier<bool> showUpdatePosition;
  final Function(OrderEntity item) removeOrder;
  final Function(PositionEntity item) removePosition;
  final Function updateOrders;
  final Function updatePositions;
  final GlobalKey<KChartWidgetState> chartKey;

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class UpdatedPosition {
  final LineEntity item;
  final double newValue;

  UpdatedPosition({
    required this.item,
    required this.newValue,
  });
}

class _ChartWidgetState extends State<ChartWidget> {
  bool showLoading = true;
  UpdatedPosition? position;
  bool showOptions = true;
  ValueNotifier<bool> isResetZoom = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final quotesCubit = context.read<QuotesCubit>();
    return ValueListenableBuilder<SymbolEntity?>(
      valueListenable: quotesCubit.currentSymbol,
      builder: (context, symbol, child) {
        if (symbol == null) return const SizedBox();
        return FlowBuilder<PlatformSettingsCubit>(
          builder: (context, state, platform) {
            return Stack(
              children: [
                FlowBuilder<PositionsCubit>(
                  buildWhenCubit: (cubit) => false,
                  listener: (context, state, cubit) {
                    if (state.type == StateType.delete) {
                      widget.removePosition(state.data);
                    } else {
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
                          widget.updateOrders();
                        }
                      },
                      builder: (context, state, cubit) {
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
                                return ValueListenableBuilder<bool>(
                                  valueListenable: widget.hideGrid,
                                  builder: (context, hideGrid, child) {
                                    return KChartWidget(
                                      key: widget.chartKey,
                                      hideGrid: hideGrid,
                                      graphStyle: graphStyle,
                                      onUpdatePosition: onUpdatePosition,
                                      onZoomingStart: (value) {
                                        isResetZoom.value = !value;
                                      },
                                      onLoadMore: (value) {
                                        _updateChart();
                                      },
                                      onGettingSettings: onGettingSettings,
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
                                        iconColor:
                                            context.colorScheme.onSurface,
                                        primary: context.colorScheme.primary,
                                        optionsColor:
                                            context.colorScheme.onSurface,
                                        ask: platform.settings.askColor,
                                        bid: platform.settings.bidColor,
                                        lineChartColor:
                                            platform.settings.chartThemeColor,
                                        areaColor: platform.settings.areaColor,
                                        stopLoss:
                                            platform.settings.stopLossColor,
                                        takeProfit:
                                            platform.settings.takeProfitColor,
                                        gridColor:
                                            platform.settings.chartGridColor,
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
                        );
                      },
                    );
                  },
                ),
                ValueListenableBuilder(
                  valueListenable: widget.showUpdatePosition,
                  builder: (context, value, child) {
                    if (position == null) {
                      return const SizedBox.shrink();
                    }
                    return AnimatedPositioned(
                      duration: const Duration(milliseconds: 300),
                      bottom: value ? 0 : -1000,
                      child: ChartUpdatePositionWidget(
                        onCancel: () {
                          widget.showUpdatePosition.value = false;
                          widget.chartKey.currentState!
                              .addOrUpdateSLOrTPOrPosition(position!.item);
                        },
                        onFinish: () {
                          widget.showUpdatePosition.value = false;
                        },
                        positionLine: position!.item,
                        updatedValue: position!.newValue,
                      ),
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
                            widget.chartKey.currentState?.resetZoom();
                          },
                        ),
                      );
                    },
                  ).addPadding(horizontal: context.isLandscape ? 12.0 : 21.0),
                ),
              ],
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
    widget.chartKey.currentState!.setLoadedCandles(candles: cubit.items);
    if (cubit.bid != null) {
      widget.chartKey.currentState!.updateAskAndBid(
        LineEntity(
          id: -10,
          color: platform.settings.bidColor,
          value: cubit.bid!,
        ),
      );
    }
    if (cubit.ask != null && platform.settings.showAskLine) {
      widget.chartKey.currentState!.updateAskAndBid(
        LineEntity(
          id: -20,
          color: platform.settings.askColor,
          value: cubit.ask!,
        ),
      );
    } else {
      widget.chartKey.currentState!.removeAskBid(-20);
    }
  }

  void onGettingSettings(CandleTimeFormat frame, String symbol) {
    if (symbol.isNotEmpty) {
      final quotesCubit = context.read<QuotesCubit>();
      final chartCubit = context.read<ChartCubit>();
      chartCubit.setSettings(timeFrame: frame, symbol: symbol);
      quotesCubit.currentSymbol.value = quotesCubit.getSymbol(symbol);
      kPrint(frame);
      widget.timeframe.value = frame;
    }
  }

  void _updateChart() {
    final chartCubit = context.read<ChartCubit>();
    final quotesCubit = context.read<QuotesCubit>();
    kPrint(quotesCubit.currentSymbol.value!.symbol);
    chartCubit.getCandles(
      timeFrame: widget.timeframe.value,
      symbol: quotesCubit.currentSymbol.value!.symbol,
      offset: chartCubit.offset + 1,
    );
  }

  void onUpdatePosition(LineEntity position, double newValue) {
    if (!position.isOrder) {
      this.position = UpdatedPosition(item: position, newValue: newValue);
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
