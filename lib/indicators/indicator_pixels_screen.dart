import 'package:candle_chart/k_chart_widget.dart';
import 'package:candle_chart/objects/widgets/properties_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:candle_chart/utils/context.dart';
import 'package:candle_chart/indicators/widgets/top_header_widget.dart';

class IndicatorPixelsScreen extends StatefulWidget {
  final Function(double pixel) onConfirm;
  final double? pixel;

  const IndicatorPixelsScreen({
    super.key,
    required this.onConfirm,
    this.pixel,
  });

  @override
  State<IndicatorPixelsScreen> createState() => _IndicatorPixelsScreenState();
}

class _IndicatorPixelsScreenState extends State<IndicatorPixelsScreen> {
  late double pixel = widget.pixel ?? 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 50.0),
        child: SafeArea(
          child: TopHeaderWidget(
            title: context.tr.pixels,
            onBack: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [1.0, 2.0, 3.0, 4.0].asMap().entries.map((item) {
            return Column(
              children: [
                PropertiesItemWidget(
                  title: '${item.value.toInt()} Pixel',
                  margin: EdgeInsets.zero,
                  child: item.value == pixel
                      ? Icon(
                          Icons.check,
                          color: KChartWidget.colors!.primary,
                        )
                      : const SizedBox(height: 24.0),
                  onTap: () {
                    pixel = item.value;
                    setState(() {});
                    widget.onConfirm(pixel);
                  },
                ),
                if (item.key != 3)
                  Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
