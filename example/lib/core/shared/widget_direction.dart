import 'dart:math' as math;

import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/app_cubit.dart';

class WidgetDirection extends StatefulWidget {
  final Widget child;
  const WidgetDirection({super.key, required this.child});

  @override
  State<WidgetDirection> createState() => _WidgetDirectionState();
}

class _WidgetDirectionState extends State<WidgetDirection> {
  late AppCubit appCubit;

  @override
  void initState() {
    appCubit = context.read<AppCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: appCubit.isArSelected,
      builder: (context, isArSelected, child) {
        double transformY = isArSelected ? math.pi : 0;
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(transformY),
          child: widget.child,
        );
      },
    );
  }
}
