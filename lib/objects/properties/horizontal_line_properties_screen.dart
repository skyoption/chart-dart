import 'package:candle_chart/indicators/widgets/top_header_widget.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/objects/widgets/object_style_widget.dart';
import 'package:candle_chart/objects/widgets/properties_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class HorizontalLinePropertiesScreen extends StatefulWidget {
  static const id = 'HorizontalLinePropertiesScreen';
  final Function(ObjectType? type) onDone;
  final ObjectEntity? object;
  final ChartStyle chartStyle;

  const HorizontalLinePropertiesScreen({
    super.key,
    required this.onDone,
    required this.object,
    required this.chartStyle,
  });

  @override
  State<HorizontalLinePropertiesScreen> createState() =>
      _HorizontalLinePropertiesScreenState();
}

class _HorizontalLinePropertiesScreenState
    extends State<HorizontalLinePropertiesScreen> {
  late final controller = TextEditingController(
      text: object.value.toStringAsFixed(widget.chartStyle.digits));

  late final ObjectEntity object = widget.object ?? ObjectEntity();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 50.0),
        child: SafeArea(
          child: TopHeaderWidget(
            title: context.tr.properties,
            onBack: () => Navigator.of(context).pop(),
            onDone: () async {
              Navigator.of(context).pop();
              await chartProperties.updateHorizontalLine(object);
              widget.onDone(null);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PropertiesTitleWidget(title: context.tr.parameters),
            PropertiesItemWidget(
              title: context.tr.name,
              subTitle: object.name,
              margin: EdgeInsets.zero,
            ),
            PropertiesTitleWidget(title: context.tr.coordinates),
            PropertiesItemWidget(
              title: context.tr.point,
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
                    if (value.isNotEmpty) {
                      object.value = double.parse(value);
                    }
                  },
                  controller: controller,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.numberWithOptions(signed: false),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 11.0),
                  ),
                ),
              ),
            ),
            PropertiesTitleWidget(title: context.tr.visualization),
            PropertiesItemWidget(
              title: context.tr.symbol,
              subTitle: object.symbol.toUpperCase(),
              margin: EdgeInsets.zero,
              subTitleColor: Colors.grey.withAlpha(80),
              onTap: () {},
            ),
            Divider(height: 1.0, color: Colors.grey.withAlpha(40)),
            PropertiesItemWidget(
              title: context.tr.timeframe,
              subTitle: object.frame.name,
              margin: EdgeInsets.zero,
              subTitleColor: Colors.grey.withAlpha(80),
              onTap: () {},
            ),
            ObjectStyleWidget(
              style: object.style,
              color: colorFromHex(object.color!),
              drawAsBackground: object.drawAsBackground,
              onChange: (color, drawAsBackground, lineHeight, style) {
                object.color = color.toHexString();
                object.drawAsBackground = drawAsBackground;
                object.height = lineHeight;
                object.style = style;
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class PropertiesTitleWidget extends StatelessWidget {
  final String title;

  const PropertiesTitleWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 21.0),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w400,
            ),
      ),
    );
  }
}
