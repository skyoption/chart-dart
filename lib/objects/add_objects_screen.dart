import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/entity/object_entity.dart';
import 'package:candle_chart/objects/properties/horizontal_line_properties_screen.dart';
import 'package:candle_chart/objects/properties/vertical_line_properties_screen.dart';
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
        preferredSize: const Size(double.infinity, 50.0),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
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
                    'Add Object',
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
        // padding: EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              child: Text(
                'Lines',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            ObjectItemWidget(
              iconSize: 35.0,
              icon: Svgs.horizontalLine,
              title: 'Horizontal Line',
              onTap: () {
                widget.onDone(ObjectType.Horizontal);
                Navigator.of(context).pop();
              },
            ),
            ObjectItemWidget(
              iconSize: 30.0,
              icon: Svgs.verticalLine,
              title: 'Vertical Line',
              onTap: () {
                widget.onDone(ObjectType.Vertical);
                Navigator.of(context).pop();
              },
            ),
            ObjectItemWidget(
              iconSize: 30.0,
              icon: Svgs.trendLine,
              title: 'Trend Line',
              onTap: () {
                widget.onDone(ObjectType.Trend);
                Navigator.of(context).pop();
              },
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              child: Text(
                'Shapes',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            ObjectItemWidget(
              iconSize: 30.0,
              icon: Svgs.rectangle,
              title: 'Rectangle',
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
