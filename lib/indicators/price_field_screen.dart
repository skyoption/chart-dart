import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/objects/widgets/properties_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/indicators/widgets/top_header_widget.dart';

class PriceFieldScreen extends StatefulWidget {
  final Function(PriceField field) onApply;
  final PriceField? field;

  const PriceFieldScreen({
    super.key,
    required this.onApply,
    this.field,
  });

  @override
  State<PriceFieldScreen> createState() => _PriceFieldScreenState();
}

class _PriceFieldScreenState extends State<PriceFieldScreen> {
  late PriceField field = widget.field ?? PriceField.Low_High;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 60.0),
        child: SafeArea(
          child: TopHeaderWidget(
            title: context.tr.priceField,
            onBack: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: PriceField.values.asMap().entries.map((item) {
            return Column(
              children: [
                PropertiesItemWidget(
                  title: item.value.name.replaceAll('_', '/'),
                  margin: EdgeInsets.zero,
                  child: item.value == field
                      ? Icon(Icons.check, color: Colors.blueAccent)
                      : const SizedBox(height: 24.0),
                  onTap: () {
                    field = item.value;
                    setState(() {});
                    widget.onApply(field);
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
