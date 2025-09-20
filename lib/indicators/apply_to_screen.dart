import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/indicators/widgets/top_header_widget.dart';
import 'package:candle_chart/objects/widgets/properties_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:candle_chart/k_chart_plus.dart';

class ApplyToScreen extends StatefulWidget {
  final Function(ApplyTo apply) onApply;
  final ApplyTo? apply;
  final bool showIndicatorsOption;

  const ApplyToScreen({
    super.key,
    required this.onApply,
    this.apply,
    this.showIndicatorsOption = false,
  });

  @override
  State<ApplyToScreen> createState() => _ApplyToScreenState();
}

class _ApplyToScreenState extends State<ApplyToScreen> {
  late ApplyTo applyTo = widget.apply ?? ApplyTo.Close;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 60.0),
        child: SafeArea(
          child: TopHeaderWidget(
            title: context.tr.applyTo,
            onBack: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: ApplyTo.values.asMap().entries.map((item) {
            if (item.value.name.contains('Indicator') &&
                !widget.showIndicatorsOption) {
              return const SizedBox();
            }
            return Column(
              children: [
                PropertiesItemWidget(
                  title: item.value.name
                      .replaceAll('_', ' ')
                      .replaceAll('__', '/'),
                  margin: EdgeInsets.zero,
                  child: item.value == applyTo
                      ? Icon(
                          Icons.check,
                          color: KChartWidget.colors!.primary,
                        )
                      : const SizedBox(height: 24.0),
                  onTap: () {
                    applyTo = item.value;
                    setState(() {});
                    widget.onApply(applyTo);
                  },
                ),
                if (item.key != ApplyTo.values.length - 1)
                  Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
