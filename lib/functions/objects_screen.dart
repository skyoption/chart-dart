import 'package:candle_chart/entity/line_entity.dart';
import 'package:candle_chart/functions/object_properties_screen.dart';
import 'package:candle_chart/functions/widgets/object_item_widget.dart';
import 'package:candle_chart/utils/icons.dart';
import 'package:flutter/material.dart';

class ObjectsScreen extends StatefulWidget {
  static const id = 'ObjectsScreen';

  final Function(LineEntity line) onDone;

  const ObjectsScreen({
    super.key,
    required this.onDone,
  });

  @override
  State<ObjectsScreen> createState() => _ObjectsScreenState();
}

class _ObjectsScreenState extends State<ObjectsScreen> {
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
                      size: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    'Objects',
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
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Lines',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            ObjectItemWidget(
              iconSize: 27.0,
              icon: Svgs.horizontalLine,
              title: 'Horizontal Line',
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => ObjectPropertiesScreen(
                      onDone: widget.onDone,
                    ),
                  ),
                );
              },
            ),
            ObjectItemWidget(
              iconSize: 22.0,
              icon: Svgs.verticalLine,
              title: 'Vertical Line',
              onTap: () {},
            ),
            ObjectItemWidget(
              iconSize: 22.0,
              icon: Svgs.trendLine,
              title: 'Trend Line',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
