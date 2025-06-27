import 'package:flash/flash.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/main.dart';

class MToast {
  static void showError({
    required String message,
  }) {
    _showCustomToast(
      context: SkyTrading.context,
      content: message,
      boxColor: rootContext.context.colorScheme.error,
    );
  }

  static void showSuccess({
    required String message,
  }) {
    _showCustomToast(
      context: SkyTrading.context,
      content: message,
      boxColor: rootContext.context.colorScheme.primary,
    );
  }

  static void showTradeStatus({
    required String message,
    required Color color,
    dynamic Function(FlashController<dynamic>)? onBuild,
  }) {
    _showCustomToast(
      context: SkyTrading.context,
      content: message,
      flashPosition: FlashPosition.top,
      mainAxisAlignment: MainAxisAlignment.start,
      boxColor: color,
      duration: const Duration(seconds: 2),
      fontWeight: FontWeight.w500,
      fontSize: FoontSize.font18,
      hideDismissIcon: true,
      dismissDirections: [FlashDismissDirection.vertical],
      onBuild: onBuild,
    );
  }

  static Future<Object?> _showCustomToast({
    required BuildContext context,
    required String content,
    required Color boxColor,
    Function(FlashController controller)? onBuild,
    Duration? duration,
    FlashPosition? flashPosition,
    MainAxisAlignment? mainAxisAlignment,
    FontWeight? fontWeight,
    double? fontSize,
    bool hideDismissIcon = false,
    List<FlashDismissDirection>? dismissDirections,
  }) {
    return showFlash(
      barrierDismissible: true,
      context: context,
      persistent: true,
      transitionDuration: const Duration(milliseconds: 400),
      duration: duration ?? const Duration(seconds: 4),
      builder: (context, controller) {
        if (onBuild != null) onBuild(controller);
        return Column(
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.end,
          children: [
            Flash(
              position: flashPosition ?? FlashPosition.bottom,
              dismissDirections:
                  dismissDirections ?? const [FlashDismissDirection.endToStart],
              controller: controller,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: boxColor,
                  borderRadius: MBorderRadius.set(all: 12.0),
                ),
                padding: const MPadding.set(vertical: 12.0, start: 12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: MText(
                        text: content,
                        weight: fontWeight ?? FontWeight.w400,
                        size: fontSize ?? FoontSize.font16,
                        color: Coolors.white,
                        maxLines: 5,
                        autoSized: true,
                      ).addPadding(end: hideDismissIcon ? 0 : 21.0),
                    ),
                    if (!hideDismissIcon)
                      const Icon(
                        Icons.clear,
                        color: Coolors.white,
                        size: 16.0,
                      ).addAction(
                        padding: const MPadding.set(horizontal: 12.0),
                        onGesture: () => controller.dismiss(),
                      )
                  ],
                ),
              ),
            ).addPadding(
              top: 80.0,
              bottom: 50.0,
              horizontal: hideDismissIcon ? 16 : 0,
            ),
          ],
        );
      },
    );
  }
}
