import 'package:example/core/consts/exports.dart';
import 'package:example/core/consts/jsons.dart';
import 'package:example/core/shared/skeletons/skeletons.dart';

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
          padding: MPadding.set(horizontal: 12.0, vertical: 12.0),
          child: Column(
            children: [
              MLottieImage(
                name: Jsons.loading,
                width: 90,
                height: 50,
                fit: BoxFit.fitHeight,
              ).addPadding(bottom: 4.0),
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
