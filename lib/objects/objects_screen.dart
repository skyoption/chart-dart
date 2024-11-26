import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/entity/object_entity.dart';
import 'package:candle_chart/objects/add_objects_screen.dart';
import 'package:candle_chart/objects/properties/horizontal_line_properties_screen.dart';
import 'package:candle_chart/objects/properties/rectangle_line_properties_screen.dart';
import 'package:candle_chart/objects/properties/trend_line_properties_screen.dart';
import 'package:candle_chart/objects/properties/vertical_line_properties_screen.dart';
import 'package:candle_chart/objects/widgets/object_item_widget.dart';
import 'package:candle_chart/objects/widgets/svg.dart';
import 'package:candle_chart/utils/icons.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';
import 'package:candle_chart/widgets/paddings.dart';
import 'package:flutter/material.dart';

class ObjectsScreen extends StatefulWidget {
  static const id = 'ObjectsScreen';

  final List<KLineEntity> data;
  final Function(ObjectType? type) onDone;

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
        preferredSize: const Size(double.infinity, 60.0),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 16.0,
            ),
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 26.0,
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
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => AddObjectsScreen(
                            onDone: widget.onDone,
                          ),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.add,
                      size: 21.0,
                      color: Colors.black,
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
                'Add Object',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    widget.onDone(ObjectType.Trend);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 35.0,
                    margin: EdgeInsetsDirectional.only(end: 21.0),
                    child: MSvg(
                      name: Svgs.trendLine,
                      width: 30.0,
                      height: 30.0,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.onDone(ObjectType.Horizontal);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 35.0,
                    margin: EdgeInsetsDirectional.only(end: 21.0),
                    child: MSvg(
                      name: Svgs.horizontalLine,
                      width: 35.0,
                      height: 35.0,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.onDone(ObjectType.Vertical);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 35.0,
                    margin: EdgeInsetsDirectional.only(end: 21.0),
                    child: MSvg(
                      name: Svgs.verticalLine,
                      width: 30.0,
                      height: 30.0,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.onDone(ObjectType.Rectangle);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 35.0,
                    margin: EdgeInsetsDirectional.only(end: 21.0),
                    child: MSvg(
                      name: Svgs.rectangle,
                      width: 30.0,
                      height: 30.0,
                    ),
                  ),
                ),
              ],
            ).addPadding(horizontal: 21.0, vertical: 8.0),
            if (chartProperties.objects.isNotEmpty)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: Text(
                  'Objects',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
            ...chartProperties.objects.asMap().entries.map((e) {
              final id = '${e.value.frame.name} ${e.value.name}';
              return ObjectItemWidget(
                iconSize: 30.0,
                icon: _icon(e.value),
                hideArrow: true,
                id: id,
                title: id,
                subtitle: _name(e.value),
                onTap: () {
                  _onTap(e.value);
                },
                onDelete: () {
                  _onDelete(e.value.type, e.value.id);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  String _icon(ObjectEntity item) {
    if (item.type == ObjectType.Horizontal) {
      return Svgs.horizontalLine;
    } else if (item.type == ObjectType.Vertical) {
      return Svgs.verticalLine;
    } else if (item.type == ObjectType.Rectangle) {
      return Svgs.rectangle;
    } else if (item.type == ObjectType.Trend) {
      return Svgs.trendLine;
    }
    return '';
  }

  String _name(ObjectEntity item) {
    if (item.type == ObjectType.Horizontal ||
        item.type == ObjectType.Vertical ||
        item.type == ObjectType.Trend) {
      return '${item.type.name} Line';
    } else if (item.type == ObjectType.Rectangle) {
      return item.type.name;
    }
    return '';
  }

  void _onDelete(ObjectType type, int id) async {
    if (type == ObjectType.Horizontal) {
      await chartProperties.removeHorizontalLine(id);
    } else if (type == ObjectType.Vertical) {
      await chartProperties.removeVerticalLine(id);
    } else if (type == ObjectType.Rectangle) {
      await chartProperties.removeRectangle(id);
    } else if (type == ObjectType.Trend) {
      await chartProperties.removeTrendLine(id);
    }
    setState(() {});
    widget.onDone(null);
  }

  void _onTap(ObjectEntity item) {
    if (item.type == ObjectType.Horizontal) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HorizontalLinePropertiesScreen(
            onDone: widget.onDone,
            object: item,
          ),
        ),
      );
    } else if (item.type == ObjectType.Vertical) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => VerticalLinePropertiesScreen(
            onDone: widget.onDone,
            data: widget.data,
            object: item,
          ),
        ),
      );
    } else if (item.type == ObjectType.Rectangle) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => RectangleLinePropertiesScreen(
            onDone: widget.onDone,
            data: widget.data,
            object: item,
          ),
        ),
      );
    } else if (item.type == ObjectType.Trend) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => TrendLinePropertiesScreen(
            onDone: widget.onDone,
            data: widget.data,
            object: item,
          ),
        ),
      );
    }
  }
}
