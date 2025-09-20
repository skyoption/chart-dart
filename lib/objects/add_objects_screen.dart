import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/indicators/widgets/top_header_widget.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/objects/widgets/object_item_widget.dart';
import 'package:candle_chart/utils/icons.dart';
import 'package:flutter/material.dart';

class AddObjectsScreen extends StatefulWidget {
  static const id = 'AddObjectsScreen';

  final List<KLineEntity> data;
  final Function(ObjectType? type) onDone;

  const AddObjectsScreen({
    super.key,
    required this.onDone,
    this.data = const [],
  });

  @override
  State<AddObjectsScreen> createState() => _AddObjectsScreenState();
}

class _AddObjectsScreenState extends State<AddObjectsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 60.0),
        child: SafeArea(
          child: TopHeaderWidget(
            title: context.tr.addObject,
            onBack: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              child: Text(
                context.tr.lines,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            ObjectItemWidget(
              iconSize: 35.0,
              icon: Svgs.horizontalLine,
              title: context.tr.horizontalLine,
              margin: EdgeInsets.zero,
              onTap: () {
                widget.onDone(ObjectType.Horizontal);
                Navigator.of(context).pop();
              },
            ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            ObjectItemWidget(
              iconSize: 30.0,
              icon: Svgs.verticalLine,
              title: context.tr.verticalLine,
              margin: EdgeInsets.zero,
              onTap: () {
                widget.onDone(ObjectType.Vertical);
                Navigator.of(context).pop();
              },
            ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            ObjectItemWidget(
              iconSize: 30.0,
              icon: Svgs.trendLine,
              title: context.tr.trendLine,
              margin: EdgeInsets.zero,
              onTap: () {
                widget.onDone(ObjectType.Trend);
                Navigator.of(context).pop();
              },
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              child: Text(
                context.tr.shapes,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            ObjectItemWidget(
              iconSize: 30.0,
              icon: Svgs.rectangle,
              title: context.tr.rectangle,
              onTap: () {
                widget.onDone(ObjectType.Rectangle);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
