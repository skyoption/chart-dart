import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/objects/widgets/properties_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:candle_chart/k_chart_plus.dart';

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
                      color: Colors.black,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    context.tr.priceField,
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
