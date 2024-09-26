import 'package:candle_chart/entity/line_entity.dart';
import 'package:candle_chart/functions/bottom_sheets/color_picker.dart';
import 'package:candle_chart/functions/object_properties_screen.dart';
import 'package:candle_chart/functions/widgets/properties_item_widget.dart';
import 'package:candle_chart/functions/widgets/svg.dart';
import 'package:candle_chart/utils/icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ObjectStyleWidget extends StatefulWidget {
  final Function(
    Color color,
    bool drawAsBackground,
    double lineHeight,
    LineStyle style,
  ) onChange;

  final bool hideDrawAsBackground;
  final bool hideStyle;

  const ObjectStyleWidget({
    super.key,
    required this.onChange,
    this.hideDrawAsBackground = false,
    this.hideStyle = false,
  });

  @override
  State<ObjectStyleWidget> createState() => _ObjectStyleWidgetState();
}

class _ObjectStyleWidgetState extends State<ObjectStyleWidget> {
  Color color = Colors.blueAccent;
  bool drawAsBackground = false;
  int index = 0;
  double lineHeight = 1;
  LineStyle style = LineStyle.normal;

  @override
  void initState() {
    widget.onChange(
      color,
      drawAsBackground,
      lineHeight,
      style,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PropertiesTitleWidget(title: 'style'),
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
                    'Style',
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
                            lineHeight,
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
                      children: [1.0, 2.0, 3.0, 4.0].asMap().entries.map(
                        (item) {
                          return Expanded(
                            child: Row(
                              children: [
                                InkResponse(
                                  onTap: () {
                                    lineHeight = item.value;
                                    setState(() {});
                                    widget.onChange(
                                      color,
                                      drawAsBackground,
                                      lineHeight,
                                      style,
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(1.0),
                                    padding: EdgeInsets.all(
                                      lineHeight == item.value ? 0.0 : 2.0,
                                    ),
                                    width:
                                        lineHeight == item.value ? 12.0 : 10.0,
                                    height:
                                        lineHeight == item.value ? 12.0 : 10.0,
                                    decoration: BoxDecoration(
                                      color: lineHeight == item.value
                                          ? Colors.black87
                                          : Colors.blueAccent,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.blueAccent,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                ),
                                if (item.key < 3)
                                  Expanded(
                                    child: Container(
                                      height: 1.0,
                                      color: Colors.blueAccent,
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
                        Svgs.longDashLine,
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
            title: 'Draw as background',
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
                      lineHeight,
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
        style = LineStyle.normal;
        break;
      case 1:
        style = LineStyle.longDash;
        break;
      case 2:
        style = LineStyle.dash;
        break;
    }
    widget.onChange(
      color,
      drawAsBackground,
      lineHeight,
      style,
    );
  }
}
