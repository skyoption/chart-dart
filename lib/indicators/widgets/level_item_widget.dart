import 'package:candle_chart/objects/widgets/properties_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LevelItemWidget extends StatefulWidget {
  final double level;
  final Function(double value) onChanged;

  const LevelItemWidget({
    super.key,
    required this.level,
    required this.onChanged,
  });

  @override
  State<LevelItemWidget> createState() => _LevelItemWidgetState();
}

class _LevelItemWidgetState extends State<LevelItemWidget> {
  late final levelController =
      TextEditingController(text: widget.level.toString());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PropertiesItemWidget(
          title: 'Description',
          child: SizedBox(
            width: 60.0,
            height: 20.0,
            child: TextField(
              cursorHeight: 12.0,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Colors.blueAccent,
                  ),
              onChanged: (value) {
                Future.delayed(Duration.zero, () {
                  final res = double.tryParse(value) ?? 0;
                  widget.onChanged(res);
                });
              },
              autofocus: false,
              controller: levelController,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.numberWithOptions(signed: false),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 11.0),
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(7),
              ],
            ),
          ),
          margin: EdgeInsets.zero,
        ),
        Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
      ],
    );
  }

  @override
  void dispose() {
    levelController.dispose();
    super.dispose();
  }
}
