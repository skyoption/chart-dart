import 'package:example/core/consts/exports.dart';

class RotationWidget extends StatefulWidget {
  const RotationWidget({super.key});

  @override
  State<RotationWidget> createState() => _RotationWidgetState();
}

class _RotationWidgetState extends State<RotationWidget> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft
    ]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  bool isPortraitUp = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.0,
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainer,
        borderRadius: MBorderRadius.set(all: 8.0),
      ),
      padding: const MPadding.set(horizontal: 12.0),
      child: Icon(
        Icons.rotate_90_degrees_ccw_rounded,
        color: context.colorScheme.scrim,
        size: 21.0,
      ),
    ).addAction(
      onGesture: () {
        if (isPortraitUp) {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeRight,
          ]);
        } else {
          SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp],
          );
        }
        isPortraitUp = !isPortraitUp;
      },
    );
  }
}
