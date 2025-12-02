import 'package:example/core/consts/exports.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartItemWidget extends StatelessWidget {
  final List<SplineSeries<SalesData, String>> series;
  final String? title;
  final Color? lineColor;
  final Widget? child;
  final double max;

  const ChartItemWidget({
    super.key,
    required this.series,
    this.title,
    this.child,
    this.lineColor,
    this.max = 150.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.35,
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLow,
        borderRadius: MBorderRadius.set(all: 20.0),
      ),
      padding: const MPadding.set(horizontal: 10.0, vertical: 16.0),
      margin: const MPadding.set(bottom: 21.0),
      child: Stack(
        children: [
          SfCartesianChart(
            borderColor: Colors.transparent,
            plotAreaBackgroundColor: Colors.transparent,
            plotAreaBorderColor: Colors.transparent,
            trackballBehavior: TrackballBehavior(
              activationMode: ActivationMode.singleTap,
              shouldAlwaysShow: true,
              enable: true,
              lineType: TrackballLineType.vertical,
              tooltipSettings: InteractiveTooltip(
                color: context.colorScheme.surfaceContainer,
                borderColor: context.colorScheme.surfaceContainer,
              ),
              builder: (context, details) {
                final title =
                    "${series[details.seriesIndex!].name}:${details.point!.y}";
                return Container(
                  height: 45.0,
                  width: title.length * 8.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: context.colorScheme.surfaceContainer,
                    borderRadius: MBorderRadius.set(all: 10.0),
                  ),
                  padding: const MPadding.set(all: 5.0),
                  child: Column(
                    children: [
                      MText(
                        text: '${details.point!.x} 2024',
                        color: context.colorScheme.onSurface,
                        size: FoontSize.font8,
                      ),
                      MText(
                        text: title,
                        color: context.colorScheme.onSurface,
                        size: FoontSize.font8,
                      ),
                    ],
                  ),
                );
              },
            ),
            enableSideBySideSeriesPlacement: true,
            primaryXAxis: CategoryAxis(
              majorGridLines: MajorGridLines(color: Colors.transparent),
            ),
            primaryYAxis: NumericAxis(
              maximum: max,
              interval: 50,
              axisLine: AxisLine(color: Colors.transparent),
              majorGridLines: MajorGridLines(
                color: context.colorScheme.outline,
              ),
            ),
            series: series,
          ).addPadding(top: child == null ? 60.0 : 90.0),
          Align(
            alignment: AlignmentDirectional.topStart,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title != null && lineColor != null)
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            if (lineColor != null)
                              Container(
                                height: 16.0,
                                width: 16.0,
                                margin: MPadding.set(end: 5.0),
                                decoration: BoxDecoration(
                                  color: lineColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            Expanded(
                              child: MText(
                                text: title,
                                color: context.colorScheme.onSurface,
                                size: FoontSize.font16,
                                weight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (title != null && lineColor == null)
                              MText(
                                text: title,
                                color: context.colorScheme.onSurface,
                                size: FoontSize.font18,
                                weight: FontWeight.w600,
                              ).addPadding(bottom: 4.0),
                            lineColor == null
                                ? Wrap(
                                    children: series.map((item) {
                                      return Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            height: 9.0,
                                            width: 9.0,
                                            margin: MPadding.set(end: 4.0),
                                            decoration: BoxDecoration(
                                              color: item.color,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          MText(
                                            text: item.name,
                                            color:
                                                context.colorScheme.onSurface,
                                            size: FoontSize.font14,
                                            weight: FontWeight.w300,
                                          )
                                        ],
                                      ).addPadding(end: 5.0);
                                    }).toList(),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                    if (child != null) Expanded(flex: 2, child: child!),
                  ],
                ),
              ],
            ).addPadding(horizontal: 8.0),
          )
        ],
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
