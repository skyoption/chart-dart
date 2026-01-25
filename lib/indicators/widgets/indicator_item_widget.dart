import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/objects/widgets/svg.dart';
import 'package:candle_chart/utils/icons.dart';
import 'package:candle_chart/widgets/paddings.dart';
import 'package:flutter/material.dart';

class IndicatorItemWidget extends StatefulWidget {
  final String title, id;
  final Function? onTap, onUnFav;
  final EdgeInsets? margin;

  const IndicatorItemWidget({
    super.key,
    required this.title,
    required this.id,
    this.onTap,
    this.onUnFav,
    this.margin,
  });

  @override
  State<IndicatorItemWidget> createState() => _IndicatorItemWidgetState();
}

class _IndicatorItemWidgetState extends State<IndicatorItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap?.call(),
      child: Container(
        decoration: BoxDecoration(
          color: chartProperties.isApplied(widget.id)
              ? context.scheme.surfaceContainerLowest
              : context.scheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: MPadding.set(vertical: 10.0, horizontal: 12.0),
        margin: widget.margin ?? MPadding.set(bottom: 6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 6.0,
              children: [
                InkWell(
                  onTap: () {
                    chartProperties.fav(widget.id);
                    widget.onUnFav?.call();
                    setState(() {});
                  },
                  child: MSvg(
                    name: chartProperties.isFav(widget.id)
                        ? Svgs.fav
                        : Svgs.favOutline,
                    width: 24.0,
                    height: 24.0,
                  ),
                ),
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios_sharp,
              size: 16.0,
              color: context.scheme.onSurface,
            )
          ],
        ),
      ),
    );
  }
}
