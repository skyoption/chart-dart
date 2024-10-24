import 'package:candle_chart/widgets/paddings.dart';
import 'package:candle_chart/widgets/radius.dart';
import 'package:candle_chart/widgets/skeletons/skeletons.dart';
import 'package:flutter/material.dart';

class Loader {


  static Widget loadingSkeleton({
    double? height,
    double? width,
    MPadding padding = const MPadding.set(horizontal: 24.0, vertical: 12.0),
    MBorderRadius? borderRadius,
  }) {
    return Padding(
      padding: padding,
      child: SkeletonLine(
        style: SkeletonLineStyle(
          width: width,
          height: height,
          borderRadius: borderRadius ?? MBorderRadius.set(all: 16.0),
        ),
      ),
    );
  }

  static Widget loadingText({
    required double height,
    required double width,
    int count = 1,
    MPadding padding = const MPadding.set(horizontal: 24.0, vertical: 2.0),
  }) {
    return Padding(
      padding: padding,
      child: SkeletonParagraph(
        style: SkeletonParagraphStyle(
          lines: count,
          spacing: 6,
          lineStyle: SkeletonLineStyle(
            randomLength: true,
            height: height,
            borderRadius: BorderRadius.circular(5.0),
            maxLength: width,
            minLength: width * 0.7,
          ),
        ),
      ),
    );
  }
}
