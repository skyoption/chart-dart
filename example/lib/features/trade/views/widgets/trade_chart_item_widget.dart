import 'package:candle_chart/k_chart_widget.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/features/chart/views/widgets/chart_shortcut_widget.dart';
import 'package:example/features/chart/views/widgets/reset_zoom_widget.dart';
import 'package:example/features/chart/views/widgets/symbol_options_widget.dart';
import 'package:example/features/trade_history/views/bottom_sheets/date_time_bottom_sheet.dart';

class TradeChartItemWidget extends StatefulWidget {
  final ValueNotifier<ItemEntity> transition;

  const TradeChartItemWidget({super.key, required this.transition});

  @override
  State<TradeChartItemWidget> createState() => TradeChartItemWidgetState();
}

class TradeChartItemWidgetState extends State<TradeChartItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: ValueListenableBuilder<ItemEntity>(
            valueListenable: widget.transition,
            builder: (context, transitionType, child) {
              if (transitionType.value != TransactionOptions.market_order) {
                return SizedBox();
              }
              return Row(
                children: [
                  ValueListenableBuilder<GraphStyle>(
                    valueListenable: style,
                    builder: (context, value, child) {
                      final isCandle = value == GraphStyle.candles;
                      return Container(
                        height: 35.0,
                        decoration: BoxDecoration(
                          color: context.colorScheme.surfaceContainer,
                          borderRadius: MBorderRadius.set(all: 8.0),
                        ),
                        padding: const MPadding.set(horizontal: 12.0),
                        margin: const MPadding.set(horizontal: 12.0),
                        child: MSvg(
                          name: isCandle ? Svgs.activeCandle : Svgs.activeArea,
                          height: 21.0,
                          width: 21.0,
                        ).addAction(
                          onGesture: () {
                            if (isCandle) {
                              style.value = GraphStyle.area;
                            } else {
                              style.value = GraphStyle.candles;
                            }
                          },
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
                        return ResetZoomWidget(
                          onReset: () {
                            isResetZoom.value = false;
                            chartKey.currentState?.resetZoom();
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        ValueListenableBuilder<ItemEntity>(
          valueListenable: widget.transition,
          builder: (context, transitionType, child) {
            if (transitionType.value != TransactionOptions.market_order) {
              return SizedBox(height: 21.0);
            }
            return chart();
          },
        ),
      ],
    );
  }

  final style = ValueNotifier<GraphStyle>(GraphStyle.area);
  final isResetZoom = ValueNotifier<bool>(false);

  Widget chart() {
    return ChartShortcutWidget(
      graphStyle: style,
      isResetZoom: isResetZoom,
    ).addPadding(bottom: 16.0);
  }
}
