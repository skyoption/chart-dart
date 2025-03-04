
import 'package:candle_chart/entity/object_entity.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/objects/bottom_sheets/color_picker.dart';
import 'package:candle_chart/objects/properties/horizontal_line_properties_screen.dart';
import 'package:candle_chart/objects/widgets/properties_item_widget.dart';
import 'package:candle_chart/objects/widgets/svg.dart';
import 'package:candle_chart/utils/icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ObjectStyleWidget extends StatefulWidget {
  final Function(
    Color color,
    bool drawAsBackground,
    double strokeWidth,
    ObjectStyle style,
  ) onChange;

  final bool hideDrawAsBackground;
  final bool hideStyle;

  final Color? color;
  final bool? drawAsBackground;
  final double? strokeWidth;
  final ObjectStyle? style;

  const ObjectStyleWidget({
    super.key,
    required this.onChange,
    this.hideDrawAsBackground = false,
    this.hideStyle = false,
    this.color,
    this.drawAsBackground,
    this.strokeWidth,
    this.style,
  });

  @override
  State<ObjectStyleWidget> createState() => _ObjectStyleWidgetState();
}

class _ObjectStyleWidgetState extends State<ObjectStyleWidget> {
  late Color color = widget.color ?? Colors.blueAccent;
  late bool drawAsBackground = widget.drawAsBackground ?? false;
  int index = 0;
  double strokeWidth = 1.0;
  late ObjectStyle style = widget.style ?? ObjectStyle.normal;

  @override
  void initState() {
    if (widget.strokeWidth != null) strokeWidth = widget.strokeWidth!;
    widget.onChange(
      color,
      drawAsBackground,
      strokeWidth,
      style,
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PropertiesTitleWidget(title: context.tr.style),
        Container(
          color: Colors.grey.withOpacity(0.2),
          padding: EdgeInsetsDirectional.symmetric(
            vertical: 12.0,
            horizontal: 12.0,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.tr.style,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  MSvg(
                    name: [
                      Svgs.horizontalLine,
                      Svgs.longDashLine,
                      Svgs.dashLine,
                    ][index],
                    width: 30.0,
                    height: 30.0,
                    fit: BoxFit.fill,
                    color: color,
                  )
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      showPickerColor(
                        context,
                        pickerColor: color,
                        onColorChanged: (value) {
                          color = value;
                          setState(() {});
                          widget.onChange(
                            color,
                            drawAsBackground,
                            strokeWidth,
                            style,
                          );
                        },
                      );
                    },
                    child: Container(
                      width: 30.0,
                      height: 30.0,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    flex: 8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [1.0, 1.5, 2.0, 2.5].asMap().entries.map(
                            (item) {
                          return Expanded(
                            child: Row(
                              children: [
                                InkResponse(
                                  onTap: () {
                                    strokeWidth = item.value;
                                    setState(() {});
                                    widget.onChange(
                                      color,
                                      drawAsBackground,
                                      strokeWidth,
                                      style,
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(1.0),
                                    padding: EdgeInsets.all(
                                      strokeWidth == item.value ? 0.0 : 2.0,
                                    ),
                                    width: (item.value * 1.5) + 10,
                                    height: (item.value * 1.5) + 10,
                                    decoration: BoxDecoration(
                                      color: strokeWidth == item.value
                                          ? Colors.black87
                                          : color,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: color,
                                        width: 1.2,
                                      ),
                                    ),
                                  ),
                                ),
                                if (item.key < 3)
                                  Expanded(
                                    child: Container(
                                      height: 1.0,
                                      color: color,
                                    ),
                                  )
                              ],
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  )
                ],
              ),
              SizedBox(height: 8.0),
              if (!widget.hideStyle)
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 21.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: Row(
                      children: [
                        Svgs.horizontalLine,
                        // Svgs.longDashLine,
                        Svgs.dashLine,
                      ].asMap().entries.map(
                            (item) {
                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                index = item.key;
                                setState(() {});
                                _setStyle(index);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 2.0),
                                decoration: BoxDecoration(
                                  color: index == item.key
                                      ? Colors.white10
                                      : Colors.grey.withOpacity(0.2),
                                  borderRadius: index == item.key
                                      ? BorderRadius.circular(4.0)
                                      : null,
                                ),
                                child: MSvg(
                                  name: item.value,
                                  width: 25.0,
                                  height: 25.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (!widget.hideDrawAsBackground)
          Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
        if (!widget.hideDrawAsBackground)
          PropertiesItemWidget(
            title: context.tr.drawAsBackground,
            child: SizedBox(
              height: 18.0,
              child: Transform.scale(
                scale: 0.7,
                child: CupertinoSwitch(
                  value: drawAsBackground,
                  activeColor: Colors.blueAccent,
                  onChanged: (value) {
                    drawAsBackground = !drawAsBackground;
                    setState(() {});
                    widget.onChange(
                      color,
                      drawAsBackground,
                      strokeWidth,
                      style,
                    );
                  },
                ),
              ),
            ),
          ),
      ],
    );
  }


  void _setStyle(index) {
    switch (index) {
      case 0:
        style = ObjectStyle.normal;
        break;
      case 1:
        style = ObjectStyle.dash;
        break;
    }
    widget.onChange(
      color,
      drawAsBackground,
      strokeWidth,
      style,
    );
  }
}
