import 'package:candle_chart/k_chart_widget.dart';
import 'package:candle_chart/objects/widgets/properties_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:candle_chart/utils/context.dart';
import 'package:candle_chart/indicators/widgets/top_header_widget.dart';

enum Methods { Simple, Exponential, Smoothed, Linear_Weighted }

class IndicatorMethodsScreen extends StatefulWidget {
  final Function(Methods method) onMethod;
  final Methods? method;

  const IndicatorMethodsScreen({
    super.key,
    required this.onMethod,
    this.method,
  });

  @override
  State<IndicatorMethodsScreen> createState() => _IndicatorMethodsScreenState();
}

class _IndicatorMethodsScreenState extends State<IndicatorMethodsScreen> {
  late Methods method = widget.method ?? Methods.Simple;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 60.0),
        child: TopHeaderWidget(
          title: context.tr.method,
          onBack: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: Methods.values.asMap().entries.map((item) {
            return Column(
              children: [
                PropertiesItemWidget(
                  title: item.value.name.replaceAll('_', ' '),
                  margin: EdgeInsets.zero,
                  child: item.value == method
                      ? Icon(
                          Icons.check,
                          color: KChartWidget.colors!.primary,
                        )
                      : const SizedBox(height: 24.0),
                  onTap: () {
                    method = item.value;
                    setState(() {});
                    widget.onMethod(method);
                  },
                ),
                if (item.key != 3)
                  Divider(
                    height: 1.0,
                    color: Colors.grey.withValues(alpha: 0.4),
                  ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
