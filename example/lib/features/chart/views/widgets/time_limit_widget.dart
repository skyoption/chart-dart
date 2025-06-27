import 'package:example/core/consts/exports.dart';

class TimeLimitWidget extends StatefulWidget {
  final Function() onGesture;

  const TimeLimitWidget({super.key, required this.onGesture});

  @override
  State<TimeLimitWidget> createState() => _TimeLimitWidgetState();
}

class _TimeLimitWidgetState extends State<TimeLimitWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.0,
      width: 45.0,
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLow,
        borderRadius: MBorderRadius.set(all: 10.0),
      ),
      alignment: Alignment.center,
      child: MSvg(
        name: Svgs.timeLimit,
        color: context.colorScheme.scrim,
        height: 24.0,
      ),
    ).addAction(onGesture: widget.onGesture);
  }
}
