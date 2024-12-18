// ignore_for_file: must_be_immutable

import 'package:candle_chart/utils/date_util.dart';
import 'package:flutter/material.dart';

class TimeFrameWidget extends StatefulWidget {
  CandleTimeFormat frame;
  final Function(CandleTimeFormat frame) onSelectTimeFrame;

  TimeFrameWidget({
    super.key,
    required this.onSelectTimeFrame,
    required this.frame,
  });

  @override
  State<TimeFrameWidget> createState() => _TimeFrameWidgetState();
}

class _TimeFrameWidgetState extends State<TimeFrameWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsetsDirectional.only(end: 60.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: CandleTimeFormat.values.map(
          (item) {
            return InkWell(
              onTap: () {
                widget.frame = item;
                setState(() {});
                widget.onSelectTimeFrame(item);
              },
              child: Text(
                item.name,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: item == widget.frame ? Colors.blue : Colors.black,
                    ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
