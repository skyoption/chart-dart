import 'package:example/core/consts/exports.dart';
import 'package:example/core/shared/circular_chart_item_widget.dart';

class LinearChartItemWidget extends StatelessWidget {
  final List<ChartData> series;
  final String? title;
  final String? subtitle, description;

  const LinearChartItemWidget({
    super.key,
    required this.series,
    this.title,
    this.subtitle,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          MText(
            text: title,
            color: context.colorScheme.onSurface,
            size: FoontSize.font18,
            weight: FontWeight.w600,
          ).addPadding(bottom: 12.0),
        Row(
          children: series.map((item) {
            return Expanded(
              flex: item.value.toInt(),
              child: Container(
                height: 12,
                color: item.color,
              ),
            );
          }).toList(),
        ).addPadding(bottom: 12.0),
        Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          children: series.map((item) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 10.0,
                  width: 10.0,
                  margin: MPadding.set(end: 6.0, top: 4.0),
                  decoration: BoxDecoration(
                    color: item.color,
                    shape: BoxShape.circle,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MText(
                      text: item.name,
                      color: context.colorScheme.onSurface,
                      size: FoontSize.font14,
                      weight: FontWeight.w400,
                    ).addPadding(bottom: 6.0),
                    MText(
                      text: '${item.value.toTwoDecimal}%',
                      color: context.colorScheme.onSurface,
                      size: FoontSize.font14,
                      weight: FontWeight.w300,
                    )
                  ],
                ),
              ],
            );
          }).toList(),
        ).addPadding(end: 16.0)
      ],
    );
  }
}
