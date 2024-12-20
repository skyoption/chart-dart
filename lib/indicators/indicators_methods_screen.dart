import 'package:candle_chart/k_chart_widget.dart';
import 'package:candle_chart/objects/widgets/properties_item_widget.dart';
import 'package:flutter/material.dart';

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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 14.0,
              horizontal: 21.0,
            ),
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 21.0,
                      color: KChartWidget.colors!.iconColor,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    'Method',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ],
            ),
          ),
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
                  Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
