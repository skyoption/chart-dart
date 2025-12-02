import 'package:example/core/consts/exports.dart';

class MSwitchWidget extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color? activeTrackColor,
      activeThumbColor,
      inactiveTrackColor,
      inactiveThumbColor;

  const MSwitchWidget({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeTrackColor,
    this.activeThumbColor,
    this.inactiveTrackColor,
    this.inactiveThumbColor,
  });

  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
      value: value,
      onChanged: onChanged,
      activeColor: activeThumbColor ?? Colors.white,
      activeTrackColor: activeTrackColor ?? context.colorScheme.primary,
      inactiveThumbColor: inactiveThumbColor ?? context.colorScheme.onSurface,
      inactiveTrackColor: inactiveTrackColor ?? context.colorScheme.surface,
    );
  }
}
