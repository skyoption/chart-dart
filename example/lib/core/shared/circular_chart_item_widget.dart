import 'package:example/core/consts/exports.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CircularChartItemWidget extends StatelessWidget {
  final List<ChartData> series;
  final String? title;
  final String? subtitle, description;
  final double max, size;

  const CircularChartItemWidget({
    super.key,
    required this.series,
    this.title,
    this.subtitle,
    this.description,
    this.max = 150.0,
    this.size = 250.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLow,
        borderRadius: MBorderRadius.set(all: 18.0),
      ),
      padding: const MPadding.set(horizontal: 10.0, top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            MText(
              text: title,
              color: context.colorScheme.onSurface,
              size: FoontSize.font18,
              weight: FontWeight.w600,
            ).addPadding(end: 21.0, start: 12.0),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  width: size,
                  height: size,
                  child: SfCircularChart(
                    annotations: <CircularChartAnnotation>[
                      CircularChartAnnotation(
                        widget: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MText(
                              text: subtitle,
                              color: context.colorScheme.onSurface,
                              size: FoontSize.font20,
                              weight: FontWeight.w600,
                            ),
                            MText(
                              text: description,
                              color: context.colorScheme.primary,
                              size: FoontSize.font32,
                              weight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                    ],
                    series: <CircularSeries>[
                      DoughnutSeries<ChartData, String>(
                        strokeWidth: 12.0,
                        dataSource: series,
                        pointColorMapper: (ChartData data, _) => data.color,
                        xValueMapper: (ChartData data, _) => data.name,
                        yValueMapper: (ChartData data, _) => data.value,
                        innerRadius: '80%',
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: series.map((item) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 10.0,
                              width: 10.0,
                              margin: MPadding.set(end: 6.0),
                              decoration: BoxDecoration(
                                color: item.color,
                                shape: BoxShape.circle,
                              ),
                            ),
                            MText(
                              text: item.name,
                              color: context.colorScheme.onSurface,
                              size: FoontSize.font14,
                              weight: FontWeight.w400,
                            ),
                            if (item.onTap != null)
                              Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: context.colorScheme.onSurface,
                                size: 21.0,
                              ),
                          ],
                        ),
                        MText(
                          text: '${item.value}%',
                          color: context.colorScheme.onSurface,
                          size: FoontSize.font14,
                          weight: FontWeight.w300,
                        ),
                      ],
                    ).addAction(
                      padding: MPadding.set(bottom: 5.0),
                      onTap: () {
                        if (item.onTap != null) {
                          item.onTap!();
                        }
                      },
                    );
                  }).toList(),
                ).addPadding(end: 16.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData({
    required this.value,
    required this.color,
    required this.name,
    this.onTap,
  });

  final String name;
  final double value;
  final Function? onTap;
  final Color color;
}
