import 'package:candle_chart/objects/widgets/properties_item_widget.dart';
import 'package:candle_chart/widgets/paddings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PropertiesBooleanItemWidget extends StatefulWidget {
  final String title;
  final bool? value;
  final Function(bool value) onChange;

  const PropertiesBooleanItemWidget({
    super.key,
    this.value,
    required this.onChange,
    required this.title,
  });

  @override
  State<PropertiesBooleanItemWidget> createState() =>
      _PropertiesBooleanItemWidgetState();
}

class _PropertiesBooleanItemWidgetState
    extends State<PropertiesBooleanItemWidget> {
  late bool value = widget.value ?? false;

  @override
  Widget build(BuildContext context) {
    return PropertiesItemWidget(
      margin: MPadding.set(),
      title: widget.title,
      child: SizedBox(
        height: 18.0,
        child: Transform.scale(
          scale: 0.7,
          child: CupertinoSwitch(
            value: value,
            activeColor: Colors.blueAccent,
            onChanged: (res) {
              value = res;
              setState(() {});
              widget.onChange(res);
            },
          ),
        ),
      ),
    );
  }
}
