import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/widgets/paddings.dart';
import 'package:candle_chart/widgets/radius.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteWidget extends StatelessWidget {
  final DismissDirection? direction;
  const DeleteWidget({super.key, this.direction});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.scheme.error,
        borderRadius: MBorderRadius.set(all: 8.0),
      ),
      padding: MPadding.set(horizontal: 21.0),
      child: Row(
        spacing: 4.0,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: direction == DismissDirection.startToEnd
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: [
          Icon(
            CupertinoIcons.delete_solid,
            color: context.scheme.onPrimary,
            size: 24.0,
          ),
          Text(
            context.tr.delete,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: context.scheme.onPrimary),
          ),
        ],
      ),
    );
  }
}
