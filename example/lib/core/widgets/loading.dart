import 'package:candle_chart/widgets/skeletons/skeletons.dart';
import 'package:example/core/consts/jsons.dart';

import '../consts/exports.dart';

class Loading {
  static Widget loader(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.black38,
            borderRadius: MBorderRadius.set(all: 9.0),
          ),
          padding: const MPadding.set(horizontal: 12.0, bottom: 12.0),
          child: Column(
            children: [
              const MLottieImage(
                name: Jsons.loading,
                width: 100,
                height: 60,
                fit: BoxFit.fitHeight,
              ),
              MText(
                text: context.tr.loading,
                color: Colors.white,
                size: FoontSize.font12,
                weight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ],
    );
  }

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
