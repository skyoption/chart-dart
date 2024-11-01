import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/indicators/properties/indicator_properties_screen.dart';
import 'package:candle_chart/indicators/widgets/indicator_color_widget.dart';
import 'package:candle_chart/objects/object_properties_screen.dart';
import 'package:candle_chart/objects/widgets/properties_item_widget.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

@immutable
class MACDPropertiesScreen extends StatefulWidget {
  String? name;
  IndicatorEntity? indicator;
  final int? index;
  final Function onDone;

  MACDPropertiesScreen({
    super.key,
    required this.onDone,
    this.name,
    this.index,
    this.indicator,
  });

  @override
  State<MACDPropertiesScreen> createState() => _MACDPropertiesScreenState();
}

class _MACDPropertiesScreenState extends State<MACDPropertiesScreen> {
  late final FastEMAController = TextEditingController(text: '12');
  late final slowEMAController = TextEditingController(text: '26');
  late final MACDSMAController = TextEditingController(text: '9');

  @override
  void initState() {
    if (widget.indicator != null) {
      widget.name = widget.indicator!.name;
      FastEMAController.text = widget.indicator!.macd!.fastEma.toString();
      slowEMAController.text = widget.indicator!.macd!.slowEma.toString();
      MACDSMAController.text = widget.indicator!.macd!.macdSma.toString();
    } else {
      widget.indicator = IndicatorEntity(
        name: widget.name!,
        macd: MACD(),
        type: IndicatorType.MACD,
        isSecondary: true,
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 60.0),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 14.0,
              horizontal: 21.0,
            ),
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 21.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    'Properties',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: InkWell(
                    onTap: () {
                      if (widget.index == null) {
                        chartProperties.addSecondaryIndicator(widget.indicator!);
                      } else {
                        chartProperties.updateIndicator(
                          widget.index!,
                          widget.indicator!,
                        );
                      }
                      widget.onDone();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Done',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.blueAccent,
                          ),
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
            PropertiesTitleWidget(
              title: '${widget.indicator?.name.toUpperCase()}',
            ),
            PropertiesItemWidget(
              title: 'Fast EMA',
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
                    final res = int.tryParse(value);
                    if (res != null) widget.indicator!.macd!.fastEma = res;
                  },
                  autofocus: false,
                  controller: FastEMAController,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.numberWithOptions(signed: false),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 11.0),
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(3),
                    NumericalRangeFormatter(min: 1, max: 100),
                  ],
                ),
              ),
              margin: EdgeInsets.zero,
            ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            PropertiesItemWidget(
              title: 'Slow EMA',
              margin: EdgeInsets.zero,
              child: SizedBox(
                width: 60.0,
                height: 20.0,
                child: TextField(
                  cursorHeight: 12.0,
                  autofocus: false,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Colors.blueAccent,
                      ),
                  onChanged: (value) {
                    final res = int.tryParse(value);
                    if (res != null) widget.indicator!.macd!.slowEma = res;
                  },
                  controller: slowEMAController,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.numberWithOptions(signed: false),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 11.0),
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(3),
                    NumericalRangeFormatter(min: 1, max: 100),
                  ],
                ),
              ),
              onTap: () {},
            ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            PropertiesItemWidget(
              title: 'MACD SMA',
              margin: EdgeInsets.zero,
              child: SizedBox(
                width: 60.0,
                height: 20.0,
                child: TextField(
                  cursorHeight: 12.0,
                  autofocus: false,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Colors.blueAccent,
                      ),
                  onChanged: (value) {
                    final res = int.tryParse(value);
                    if (res != null) widget.indicator!.macd!.macdSma = res;
                  },
                  controller: MACDSMAController,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.numberWithOptions(signed: false),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 11.0),
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(3),
                    NumericalRangeFormatter(min: 1, max: 100),
                  ],
                ),
              ),
              onTap: () {},
            ),
            PropertiesTitleWidget(title: 'visualization'),
            PropertiesItemWidget(
              title: 'Timeframe',
              subTitle: 'All timeframes',
              margin: EdgeInsets.zero,
              subTitleColor: Colors.grey.withOpacity(0.8),
              onTap: () {},
            ),
            PropertiesTitleWidget(title: 'style'),
            IndicatorColorWidget(
              title: 'Main',
              color: colorFromHex(widget.indicator?.macd?.mainColor ?? ''),
              onChange: (color, drawAsBackground) {
                widget.indicator!.macd!.mainColor = color.toHexString();
              },
            ),
            Divider(height: 1.0, color: Colors.grey.withOpacity(0.4)),
            IndicatorColorWidget(
              title: 'Signal',
              color: colorFromHex(widget.indicator?.macd?.signalColor ?? ''),
              onChange: (color, drawAsBackground) {
                widget.indicator!.macd!.signalColor = color.toHexString();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    slowEMAController.dispose();
    MACDSMAController.dispose();
    FastEMAController.dispose();
    super.dispose();
  }
}
