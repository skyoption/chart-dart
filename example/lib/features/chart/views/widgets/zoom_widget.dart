import 'package:example/core/consts/exports.dart';

class ZoomWidget extends StatefulWidget {
  final Function onOptions;

  const ZoomWidget({
    super.key,
    required this.onOptions,
  });

  @override
  State<ZoomWidget> createState() => _ZoomWidgetState();
}

class _ZoomWidgetState extends State<ZoomWidget> {
  bool zoom = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.0,
      width: 45.0,
      decoration: BoxDecoration(
        color: zoom
            ? context.colorScheme.surfaceBright
            : context.colorScheme.surfaceContainerLow,
        borderRadius: MBorderRadius.set(all: 10.0),
      ),
      alignment: Alignment.center,
      child: MSvg(
        name: context.isDarkTheme ? Svgs.zoomInOut : Svgs.zoomLight,
        width: 26.0,
        height: 26.0,
      ),
    ).addAction(
      onGesture: () {
        zoom = !zoom;
        setState(() {});
        widget.onOptions();
      },
    );
  }
}
