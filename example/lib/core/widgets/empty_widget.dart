import 'package:example/core/widgets/custom_fade_animation.com.dart';

import '../consts/exports.dart';

class EmptyWidget extends StatelessWidget {
  final IconData? iconData;
  final String? svgIconPath;
  final double? iconSize;
  final String text;
  const EmptyWidget({
    super.key,
    this.iconData,
    this.iconSize,
    required this.text,
    this.svgIconPath,
  });

  @override
  Widget build(BuildContext context) {
    return CustomFadeAnimation(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (svgIconPath != null)
            MSvg(
              name: svgIconPath,
              color: context.colorScheme.scrim,
              width: 70,
              height: 70,
            ).addPadding(start: 6.0, end: 12.0, bottom: 21.0),
          if (iconData != null)
            Icon(
              iconData,
              size: 70,
            ).addPadding(start: 6.0, end: 12.0, bottom: 21.0),
          MText(
            text: text,
            color: context.colorScheme.scrim,
            size: FoontSize.font18,
            align: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
