import 'package:example/core/consts/exports.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TradeChartItemWidget extends StatefulWidget {
  final SymbolEntity symbol;

  const TradeChartItemWidget({super.key, required this.symbol});

  @override
  State<TradeChartItemWidget> createState() => TradeChartItemWidgetState();
}

class TradeChartItemWidgetState extends State<TradeChartItemWidget> {
  List<double> asks = [];
  List<double> bids = [];
  List<DateTime> times = [];

  void clear() {
    asks = [];
    bids = [];
    times = [];
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.symbol.askChange,
      builder: (context, ask, child) {
        return ValueListenableBuilder(
          valueListenable: widget.symbol.bidChange,
          builder: (context, bid, child) {
            bids.add(bid);
            asks.add(ask);
            times.add(DateTime.now());
            final maximum = ask + ((ask - bid) * 8);
            final minimum = bid - ((ask - bid) * 8);
            return SfCartesianChart(
              borderColor: Colors.transparent,
              selectionType: SelectionType.series,
              tooltipBehavior: TooltipBehavior(
                shouldAlwaysShow: false,
                canShowMarker: true,
                enable: false,
                activationMode: ActivationMode.singleTap,
                opacity: 0.0,
                builder: (data, point, series, pointIndex, seriesIndex) {
                  return Container(
                    height: 40.0,
                    width: seriesIndex == 0 ? 120.0 : 190.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: context.colorScheme.outline,
                      borderRadius: MBorderRadius.set(all: 16.0),
                    ),
                    padding: const MPadding.set(
                      horizontal: 21.0,
                      vertical: 8.0,
                    ),
                    child: MText(
                      text: data.x.toString(),
                      color: context.colorScheme.onSurface,
                      size: FoontSize.font16,
                    ),
                  );
                },
              ),
              primaryYAxis: NumericAxis(
                maximum: maximum,
                minimum: minimum,
                majorGridLines: MajorGridLines(
                  color: context.colorScheme.outline,
                ),
                interval: (maximum - minimum) / 8,
                opposedPosition: true,
                labelStyle: TextStyle(color: context.colorScheme.onSurface),
                decimalPlaces: 5,
              ),
              plotAreaBorderColor: Colors.transparent,
              crosshairBehavior: CrosshairBehavior(
                shouldAlwaysShow: true,
                enable: true,
                lineType: CrosshairLineType.both,
                activationMode: ActivationMode.singleTap,
              ),
              primaryXAxis: CategoryAxis(
                majorGridLines: MajorGridLines(
                  color: context.colorScheme.outline,
                ),
              ),
              enableSideBySideSeriesPlacement: true,
              series: [
                SplineSeries<ChartValue, String>(
                  name: context.tr.ask,
                  color: Colors.red,
                  width: 1.0,
                  dataSource:
                      asks.where((e) => e != 0).toList().asMap().entries.map((
                    e,
                  ) {
                    return ChartValue(
                      times[e.key].toIso8601String().toLastTimeMMSS,
                      e.value,
                    );
                  }).toList(),
                  xValueMapper: (ChartValue sales, int index) => sales.x,
                  yValueMapper: (ChartValue sales, int index) => sales.y,
                ),
                SplineSeries<ChartValue, String>(
                  name: context.tr.bid,
                  color: Colors.green,
                  width: 1.0,
                  dataSource:
                      bids.where((e) => e != 0).toList().asMap().entries.map((
                    e,
                  ) {
                    return ChartValue(
                      times[e.key].toIso8601String().toLastTimeMMSS,
                      e.value,
                    );
                  }).toList(),
                  xValueMapper: (ChartValue sales, int index) => sales.x,
                  yValueMapper: (ChartValue sales, int index) => sales.y,
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class ChartValue {
  ChartValue(this.x, this.y);

  final String x;
  final double y;
}
