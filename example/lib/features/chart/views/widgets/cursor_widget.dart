import 'package:example/core/consts/exports.dart';

class CursorWidget extends StatefulWidget {
  final Function(bool cursor) onGesture;

  const CursorWidget({super.key, required this.onGesture});

  @override
  State<CursorWidget> createState() => _CursorWidgetState();
}

class _CursorWidgetState extends State<CursorWidget> {
  bool cursor = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.0,
      width: 45.0,
      decoration: BoxDecoration(
        color: cursor
            ? context.colorScheme.surfaceBright
            : context.colorScheme.surfaceContainerLow,
        borderRadius: MBorderRadius.set(all: 10.0),
      ),
      alignment: Alignment.center,
      child: MSvg(
        name: Svgs.cursor,
        color: context.colorScheme.scrim,
        height: 21.0,
      ),
    ).addAction(
      onGesture: () {
        cursor = !cursor;
        setState(() {});
        widget.onGesture(cursor);
      },
    );
  }
}
