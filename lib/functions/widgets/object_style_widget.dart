import 'package:candle_chart/functions/bottom_sheets/color_picker.dart';
import 'package:candle_chart/functions/object_properties_screen.dart';
import 'package:candle_chart/functions/widgets/properties_item_widget.dart';
import 'package:candle_chart/functions/widgets/svg.dart';
import 'package:candle_chart/utils/icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ObjectStyleWidget extends StatefulWidget {
  const ObjectStyleWidget({super.key});

  @override
  State<ObjectStyleWidget> createState() => _ObjectStyleWidgetState();
}

class _ObjectStyleWidgetState extends State<ObjectStyleWidget> {
  Color color = Colors.blueAccent;
  bool drawAsBackground = false;
  int index = 0;

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
                    color: color,
                  )
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      showPickerColor(
                        context,
                        pickerColor: color,
                        onColorChanged: (value) {
                          color = value;
                          setState(() {});
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
                  )
                ],
              ),
              SizedBox(height: 8.0),
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
        Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
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
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
