import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/indicators/widgets/top_header_widget.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/objects/properties/horizontal_line_properties_screen.dart';
import 'package:candle_chart/objects/properties/rectangle_line_properties_screen.dart';
import 'package:candle_chart/objects/properties/trend_line_properties_screen.dart';
import 'package:candle_chart/objects/properties/vertical_line_properties_screen.dart';
import 'package:candle_chart/objects/widgets/object_item_widget.dart';
import 'package:candle_chart/objects/widgets/shortcut_object_item_widget.dart';
import 'package:candle_chart/utils/icons.dart';
import 'package:candle_chart/widgets/paddings.dart';
import 'package:flutter/material.dart';

class ObjectsScreen extends StatefulWidget {
  static const id = 'ObjectsScreen';
  final ChartStyle chartStyle;

  final List<KLineEntity> data;
  final Function(ObjectType? type) onDone;

  const ObjectsScreen({
    super.key,
    required this.onDone,
    required this.chartStyle,
    this.data = const [],
  });

  @override
  State<ObjectsScreen> createState() => _ObjectsScreenState();
}

class _ObjectsScreenState extends State<ObjectsScreen> {
  @override
  Widget build(BuildContext context) {
    final items = chartProperties.objects
        .where((i) => i.type != ObjectType.Position)
        .toList();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 60.0),
        child: SafeArea(
          child: TopHeaderWidget(
            title: context.tr.tools,
            onBack: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 16.0,
              children: [
                Expanded(
                  child: ShortcutObjectItemWidget(
                    icon: Svgs.horizontalLine,
                    title: context.tr.horizontalLine,
                    onTap: () {
                      widget.onDone(ObjectType.Horizontal);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Expanded(
                  child: ShortcutObjectItemWidget(
                    icon: Svgs.trendLine,
                    title: context.tr.trendLine,
                    onTap: () {
                      widget.onDone(ObjectType.Trend);
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ).addPadding(horizontal: 21.0, bottom: 16.0),
            Row(
              spacing: 16.0,
              children: [
                Expanded(
                  child: ShortcutObjectItemWidget(
                    icon: Svgs.verticalLine,
                    title: context.tr.verticalLine,
                    onTap: () {
                      widget.onDone(ObjectType.Vertical);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Expanded(
                  child: ShortcutObjectItemWidget(
                    icon: Svgs.rectangle,
                    title: context.tr.rectangle,
                    onTap: () {
                      widget.onDone(ObjectType.Rectangle);
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ).addPadding(horizontal: 21.0, bottom: 21.0),
            if (items.isNotEmpty)
              Padding(
                padding: MPadding.set(horizontal: 21.0, vertical: 8.0),
                child: Text(
                  context.tr.tools,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ...items.asMap().entries.map((e) {
              final id = '${e.value.frame.name} ${e.value.name}';
              return ObjectItemWidget(
                iconSize: 30.0,
                margin: EdgeInsets.zero,
                icon: _icon(e.value),
                hideArrow: true,
                id: id,
                title: id,
                subtitle: _name(e.value),
                onTap: () {
                  onTap(context, e.value, widget.data, widget.onDone,
                      widget.chartStyle);
                },
                onDelete: () async {
                  await onDelete(e.value.type, e.value.id, widget.onDone);
                  setState(() {});
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
}

Future<void> onDelete(
  ObjectType type,
  int id,
  Function(ObjectType? type) onDone,
) async {
  if (type == ObjectType.Horizontal) {
    await chartProperties.removeHorizontalLine(id);
  } else if (type == ObjectType.Vertical) {
    await chartProperties.removeVerticalLine(id);
  } else if (type == ObjectType.Rectangle) {
    await chartProperties.removeRectangle(id);
  } else if (type == ObjectType.Trend) {
    await chartProperties.removeTrendLine(id);
  }
  onDone(null);
}

void onTap(
  BuildContext context,
  ObjectEntity item,
  List<KLineEntity> data,
  Function(ObjectType? type) onDone,
  ChartStyle chartStyle,
) {
  if (item.type == ObjectType.Horizontal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HorizontalLinePropertiesScreen(
          onDone: onDone,
          object: item,
          chartStyle: chartStyle,
        ),
      ),
    );
  } else if (item.type == ObjectType.Vertical) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VerticalLinePropertiesScreen(
          onDone: onDone,
          data: data,
          chartStyle: chartStyle,
          object: item,
        ),
      ),
    );
  } else if (item.type == ObjectType.Rectangle) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RectangleLinePropertiesScreen(
          onDone: onDone,
          data: data,
          chartStyle: chartStyle,
          object: item,
        ),
      ),
    );
  } else if (item.type == ObjectType.Trend) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TrendLinePropertiesScreen(
          onDone: onDone,
          data: data,
          chartStyle: chartStyle,
          object: item,
        ),
      ),
    );
  }
}
