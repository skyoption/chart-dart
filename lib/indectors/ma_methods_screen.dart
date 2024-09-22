import 'package:candle_chart/functions/widgets/properties_item_widget.dart';
import 'package:flutter/material.dart';

enum MaMethods { Simple, Exponential, Smoothed, Linear_Weighted }

class MaMethodsScreen extends StatefulWidget {
  const MaMethodsScreen({super.key});

  @override
  State<MaMethodsScreen> createState() => _MaMethodsScreenState();
}

class _MaMethodsScreenState extends State<MaMethodsScreen> {
  MaMethods method = MaMethods.Simple;

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
          children: MaMethods.values.asMap().entries.map((item) {
            return Column(
              children: [
                PropertiesItemWidget(
                  title: item.value.name.replaceAll('_', ' '),
                  margin: EdgeInsets.zero,
                  child: item.value == method
                      ? Icon(Icons.check, color: Colors.blueAccent)
                      : const SizedBox(height: 24.0),
                  onTap: () {
                    method = item.value;
                    setState(() {});
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
