import 'dart:ui';

import 'package:overlay_tooltip/overlay_tooltip.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/app_prefs.dart';
import 'package:example/injection/injectable.dart';

class GuideTooltipScaffold extends StatefulWidget {
  final Widget child;
  final VoidCallback? onInit;
  final VoidCallback? onDone;
  final String preferenceKey;
  final bool startWhenEnabled;

  const GuideTooltipScaffold({
    super.key,
    required this.child,
    required this.preferenceKey,
    this.onInit,
    this.onDone,
    this.startWhenEnabled = true,
  });

  @override
  State<GuideTooltipScaffold> createState() => _GuideTooltipScaffoldState();
}

class _GuideTooltipScaffoldState extends State<GuideTooltipScaffold> {
  late final TooltipController _tooltipController;

  @override
  void initState() {
    super.initState();
    _tooltipController = TooltipController();
    _tooltipController.onDone(_onDone);

    // Call onInit callback if provided
    widget.onInit?.call();
  }

  void _onDone() {
    // Mark onboarding as completed
    getIt<AppPreferences>().putData(widget.preferenceKey, true);

    // Call onDone callback if provided
    widget.onDone?.call();
  }

  @override
  void dispose() {
    _tooltipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OverlayTooltipScaffold(
      controller: _tooltipController,
      preferredOverlay: BackdropFilter(
        blendMode: BlendMode.srcOver,
        filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
        child: Container(
          color: Colors.black.withValues(alpha: 0.3),
          width: double.infinity,
          height: double.infinity,
        ),
      ),
      tooltipAnimationCurve: Curves.easeInOut,
      tooltipAnimationDuration: const Duration(milliseconds: 300),
      startWhen: (initializedWidgetLength) async {
        if (!widget.startWhenEnabled) return false;

        // Start tooltips if user hasn't completed onboarding
        return !getIt<AppPreferences>().getData(widget.preferenceKey, false) &&
            initializedWidgetLength >= 1;
        // return false;
      },
      builder: (context) => widget.child,
    );
  }
}
