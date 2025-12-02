import 'package:example/core/consts/exports.dart';
import 'package:overlay_tooltip/overlay_tooltip.dart';

class GuideToolTipConfig {
  final String title;
  final String description;
  final int displayIndex;
  final TooltipVerticalPosition? verticalPosition;
  final TooltipHorizontalPosition? horizontalPosition;

  GuideToolTipConfig({
    required this.title,
    required this.description,
    required this.displayIndex,
    this.verticalPosition,
    this.horizontalPosition,
  });
}

class GuideTooltipWidget extends StatelessWidget {
  final GuideToolTipConfig config;
  final Widget child;

  const GuideTooltipWidget({
    super.key,
    required this.config,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return OverlayTooltipItem(
      displayIndex: config.displayIndex,
      tooltipVerticalPosition:
          config.verticalPosition ?? TooltipVerticalPosition.BOTTOM,
      tooltipHorizontalPosition:
          config.horizontalPosition ?? TooltipHorizontalPosition.CENTER,
      tooltip: (controller) => Container(
        margin: MPadding.set(top: 12.0),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 12,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 20,
              spreadRadius: 4,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MText(
              text: config.title,
              size: 14,
              weight: FontWeight.bold,
              color: Colors.black,
            ),
            const SizedBox(height: 6),
            MText(text: config.description, size: 12, color: Colors.grey[600]!),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MBouncingButton(
                  onTap: () => controller.dismiss(),
                  title: context.tr.skip,
                  borderRadius: 6.0,
                  height: 32.0,
                  width: 60.0,
                  color: Colors.grey[400]!,
                  textSize: 12.0,
                  textColor: Colors.black,
                ),
                const SizedBox(width: 6),
                MBouncingButton(
                  onTap: () => controller.next(),
                  title: context.tr.next,
                  borderRadius: 6.0,
                  height: 32.0,
                  width: 60.0,
                  color: context.colorScheme.primary,
                  textSize: 12.0,
                ),
              ],
            ),
          ],
        ),
      ),
      child: child,
    );
  }
}
