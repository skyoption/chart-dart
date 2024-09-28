import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/functions/widgets/properties_item_widget.dart';
import 'package:flutter/material.dart';

class ApplyToScreen extends StatefulWidget {
  final Function(ApplyTo apply) onApply;
  final ApplyTo? apply;

  const ApplyToScreen({
    super.key,
    required this.onApply,
    this.apply,
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
        preferredSize: const Size(double.infinity, 50.0),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 12.0,
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
          children: ApplyTo.values.asMap().entries.map((item) {
            return Column(
              children: [
                PropertiesItemWidget(
                  title: item.value.name
                      .replaceAll('_', ' ')
                      .replaceAll('\$', '/'),
                  margin: EdgeInsets.zero,
                  child: item.value == applyTo
                      ? Icon(Icons.check, color: Colors.blueAccent)
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
