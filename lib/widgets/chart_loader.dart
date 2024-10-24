import 'dart:math';

import 'package:candle_chart/widgets/loaders.dart';
import 'package:candle_chart/widgets/paddings.dart';
import 'package:candle_chart/widgets/radius.dart';
import 'package:flutter/widgets.dart';

class ChartLoader extends StatelessWidget {
  ChartLoader({super.key});

  final random = Random();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.8,
      alignment: AlignmentDirectional.bottomCenter,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: SingleChildScrollView(
              reverse: true,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(400, (index) {
                  double height = random.nextInt(120).toDouble();
                  final padding = random.nextInt(150).toDouble();
                  final space = random.nextInt(80).toDouble();
                  height = height < 10 ? 10.0 : height;
                  final lineHeight = height + (space < 20 ? 20.0 : space);
                  return SizedBox(
                    height: lineHeight,
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Loader.loadingSkeleton(
                          height: lineHeight,
                          width: 1.5,
                          borderRadius: MBorderRadius.set(all: 2.0),
                          padding: MPadding.set(),
                        ),
                        Loader.loadingSkeleton(
                          height: height,
                          width: 12.0,
                          borderRadius: MBorderRadius.set(all: 2.0),
                          padding: MPadding.set(),
                        ),
                      ],
                    ),
                  ).addPadding(top: padding, end: 3.0);
                }),
              ),
            ).addPadding(end: 15.0, bottom: 50.0),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(
              19,
              (index) {
                return Loader.loadingSkeleton(
                  height: 12.0,
                  width: 40.0,
                  borderRadius: MBorderRadius.set(all: 2.0),
                  padding: const MPadding.set(horizontal: 6.0, top: 15.5),
                );
              },
            ),
          ).addPadding(bottom: 20.0),
        ],
      ),
    );
  }
}
