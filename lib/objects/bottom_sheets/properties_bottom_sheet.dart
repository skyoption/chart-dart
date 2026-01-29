import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/indicators/widgets/select_item_widget.dart';
import 'package:candle_chart/indicators/widgets/top_bottom_sheet_widget.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/objects/objects_screen.dart';
import 'package:candle_chart/widgets/paddings.dart';
import 'package:flutter/material.dart';

class PropertiesBottomSheet extends StatefulWidget {
  final ObjectEntity item;
  final List<KLineEntity> data;
  final Function(ObjectType? type) onDone;
  final ChartStyle chartStyle;

  const PropertiesBottomSheet({
    super.key,
    required this.item,
    required this.data,
    required this.onDone,
    required this.chartStyle,
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
          TopBottomSheetWidget().addPadding(top: 21.0),
          Align(
            alignment: AlignmentDirectional.topStart,
            child: Text(
              context.tr.objectSettings,
              style: context.text.bodyMedium!.copyWith(
                color: context.scheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ).addPadding(start: 24.0, bottom: 16.0),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              onTap(context, widget.item, widget.data, widget.onDone,
                  widget.chartStyle);
              widget.onDone(null);
            },
            child: SelectItemWidget(
              isSelected: false,
              item: context.tr.properties,
            ),
          ),
          GestureDetector(
            onTap: () {
              onDelete(widget.item.type, widget.item.id, widget.onDone);
              Navigator.of(context).pop();
              widget.onDone(null);
            },
            child: SelectItemWidget(
              isSelected: false,
              item: context.tr.delete,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              widget.onDone(null);
            },
            child: SelectItemWidget(
              isSelected: false,
              item: context.tr.cancel,
            ),
          )
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
  required ChartStyle chartStyle,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: context.scheme.scrim,
    builder: (context) => PropertiesBottomSheet(
      item: item,
      data: data,
      onDone: onDone,
      chartStyle: chartStyle,
    ),
  );
}
