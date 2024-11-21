import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/entity/line_entity.dart';
import 'package:candle_chart/objects/horizontal_line_properties_screen.dart';
import 'package:candle_chart/objects/vertical_line_properties_screen.dart';
import 'package:candle_chart/objects/widgets/object_item_widget.dart';
import 'package:candle_chart/utils/icons.dart';
import 'package:flutter/material.dart';

class ObjectsScreen extends StatefulWidget {
  static const id = 'ObjectsScreen';

  final List<KLineEntity> data;
  final Function onDone;

  const ObjectsScreen({
    super.key,
    required this.onDone,
    this.data = const [],
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
                      size: 21.0,
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
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => HorizontalLinePropertiesScreen(
                      onDone: widget.onDone,
                    ),
                  ),
                );
              },
            ),
            ObjectItemWidget(
              iconSize: 30.0,
              icon: Svgs.verticalLine,
              title: 'Vertical Line',
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => VerticalLinePropertiesScreen(
                      onDone: widget.onDone,
                      data: widget.data,
                    ),
                  ),
                );
              },
            ),
            ObjectItemWidget(
              iconSize: 30.0,
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
