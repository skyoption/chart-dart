import 'package:example/core/consts/exports.dart';

class ResetZoomWidget extends StatelessWidget {
  final Function onReset;

  const ResetZoomWidget({
    super.key,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.0,
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLow,
        borderRadius: MBorderRadius.set(all: 10.0),
      ),
      padding: MPadding.set(horizontal: 12.0),
      child: Icon(
        Icons.refresh_outlined,
        color: context.colorScheme.onSurface,
      ),
    ).addAction(onGesture: onReset);
  }
}
