import 'package:candle_chart/k_chart_plus.dart';
import 'package:flutter/material.dart';
import 'package:candle_chart/widgets/paddings.dart';

class TopHeaderWidget extends StatelessWidget {
  final String title;
  final String? doneText;
  final Function()? onBack;
  final Function()? onDone;
  const TopHeaderWidget(
      {super.key,
      required this.title,
      this.onBack,
      this.onDone,
      this.doneText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const MPadding.set(end: 21.0),
      child: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: InkWell(
              onTap: () => onBack?.call() ?? Navigator.of(context).pop(),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 21.0,
                color: KChartWidget.colors!.iconColor,
              ).addPadding(horizontal: 21.0, vertical: 14.0),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.center,
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ).addPadding(vertical: 14.0),
          ),
          if (onDone != null)
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: InkWell(
                onTap: () {
                  onDone?.call();
                },
                child: Text(
                  doneText ?? context.tr.done,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: KChartWidget.colors!.primary,
                      ),
                ).addPadding(vertical: 14.0),
              ),
            ),
        ],
      ),
    );
  }
}
