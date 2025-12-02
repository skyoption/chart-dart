import 'package:example/core/consts/exports.dart';

class FullSizeWidget extends StatefulWidget {
  final ValueNotifier<bool> isFullscreen;

  const FullSizeWidget({super.key, required this.isFullscreen});

  @override
  State<FullSizeWidget> createState() => _FullSizeWidgetState();
}

class _FullSizeWidgetState extends State<FullSizeWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.isFullscreen,
      builder: (context, isFullscreen, child) {
        return Container(
          height: 45.0,
          width: 45.0,
          decoration: BoxDecoration(
            color: isFullscreen
                ? context.colorScheme.surfaceBright
                : context.colorScheme.surfaceContainerLow,
            borderRadius: MBorderRadius.set(all: 10.0),
          ),
          alignment: Alignment.center,
          child: MSvg(
            name: Svgs.zoom,
            color: context.colorScheme.onSurface,
            height: 21.0,
          ),
        ).addAction(
          onGesture: () {
            widget.isFullscreen.value = !isFullscreen;
          },
        );
      },
    );
  }
}
