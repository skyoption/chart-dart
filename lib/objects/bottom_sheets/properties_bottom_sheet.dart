import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/entity/object_entity.dart';
import 'package:candle_chart/objects/objects_screen.dart';
import 'package:candle_chart/objects/widgets/object_item_widget.dart';
import 'package:flutter/material.dart';

class PropertiesBottomSheet extends StatefulWidget {
  final ObjectEntity item;
  final List<KLineEntity> data;
  final Function(ObjectType? type) onDone;

  const PropertiesBottomSheet({
    super.key,
    required this.item,
    required this.data,
    required this.onDone,
  });

  @override
  State<PropertiesBottomSheet> createState() => _PropertiesBottomSheetState();
}

class _PropertiesBottomSheetState extends State<PropertiesBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.0,
      child: Column(
        children: [
          ObjectItemWidget(
            hideArrow: true,
            backgroundColor: Colors.white,
            margin: EdgeInsets.zero,
            title: 'Properties',
            onTap: () {
              Navigator.of(context).pop();
              onTap(context, widget.item, widget.data, widget.onDone);
              widget.onDone(null);
            },
          ),
          Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
          ObjectItemWidget(
            hideArrow: true,
            backgroundColor: Colors.white,
            margin: EdgeInsets.zero,
            title: 'Delete',
            color: Colors.red,
            onTap: () {
              onDelete(widget.item.type, widget.item.id, widget.onDone);
              Navigator.of(context).pop();
              widget.onDone(null);
            },
          ),
          Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
          ObjectItemWidget(
            hideArrow: true,
            backgroundColor: Colors.white,
            margin: EdgeInsets.zero,
            title: 'Cancel',
            onTap: () {
              widget.onDone(null);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  void deactivate() {
    widget.onDone(null);
    super.deactivate();
  }
}

void showPropertiesBottomSheet({
  required BuildContext context,
  required ObjectEntity item,
  required List<KLineEntity> data,
  required Function(ObjectType? type) onDone,
}) {
  showBottomSheet(
    context: context,
    elevation: 3.0,
    showDragHandle: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25.0),
      side: BorderSide(color: Colors.grey.withOpacity(0.08)),
    ),
    builder: (context) => PropertiesBottomSheet(
      item: item,
      data: data,
      onDone: onDone,
    ),
  );
}
