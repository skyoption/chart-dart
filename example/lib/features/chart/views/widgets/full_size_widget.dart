import 'package:example/core/consts/exports.dart';

class FullSizeWidget extends StatefulWidget {
  final Function() onGesture;

  const FullSizeWidget({super.key, required this.onGesture});

  @override
  State<FullSizeWidget> createState() => _FullSizeWidgetState();
}

class _FullSizeWidgetState extends State<FullSizeWidget> {
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
        name: Svgs.zoom,
        color: context.colorScheme.scrim,
        height: 21.0,
      ),
    ).addAction(
      onGesture: () {
        zoom = !zoom;
        setState(() {});
        widget.onGesture();
      },
    );
  }
}
