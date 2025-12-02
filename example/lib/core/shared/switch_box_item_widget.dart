import 'package:example/core/consts/exports.dart';

class SwitchBoxItemWidget extends StatefulWidget {
  final String title;
  final bool? initial;
  final bool isEnabled;
  final Widget? child;
  final Function(bool value)? onChange;
  final String? Function(bool?)? validator;
  final AutovalidateMode? autovalidateMode;
  final bool noExtened;
  final double textSize;
  final FontWeight fontWeight;
  final Color? activeTrackColor;
  final Color? inactiveThumbColor;
  final Color? activeColor;
  final Color? thumbColor;

  const SwitchBoxItemWidget({
    super.key,
    required this.title,
    this.onChange,
    this.isEnabled = true,
    this.initial,
    this.child,
    this.noExtened = false,
    this.textSize = 15.0,
    this.fontWeight = FontWeight.w300,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.activeColor,
    this.thumbColor,
  });

  @override
  State<SwitchBoxItemWidget> createState() => _SwitchBoxItemWidgetState();
}

class _SwitchBoxItemWidgetState extends State<SwitchBoxItemWidget> {
  late bool check = widget.initial ?? false;

  @override
  void didUpdateWidget(covariant SwitchBoxItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initial != widget.initial) {
      setState(() {
        check = widget.initial ?? check;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final child = FormField<bool>(
      autovalidateMode: widget.autovalidateMode,
      validator: widget.validator,
      builder: (FormFieldState<bool> state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 30.0,
                  width: 40.0,
                  child: Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      value: check,
                      onChanged: (value) {
                        if (widget.isEnabled) {
                          check = !check;
                          setState(() {});
                          state.didChange(check);
                          if (widget.onChange != null) widget.onChange!(check);
                        }
                      },
                      activeTrackColor: widget.activeTrackColor ??
                          context.colorScheme.primary,
                      inactiveThumbColor:
                          widget.inactiveThumbColor ?? Coolors.grey,
                      activeColor:
                          widget.activeColor ?? context.colorScheme.surface,
                      thumbColor: WidgetStateProperty.resolveWith((states) {
                        return widget.thumbColor ?? context.colorScheme.border;
                      }),
                    ),
                  ),
                ).addPadding(end: 12.0),
                Expanded(
                  child: Wrap(
                    children: [
                      MText(
                        text: widget.title,
                        size: widget.textSize,
                        maxLines: 20,
                        weight: widget.fontWeight,
                        color: context.colorScheme.onSurface,
                      ).addPadding(end: 4.0),
                      if (widget.child != null) widget.child!,
                    ],
                  ),
                ),
              ],
            ).addAction(
              onGesture: () {
                if (widget.isEnabled) {
                  check = !check;
                  setState(() {});
                  state.didChange(check);
                  if (widget.onChange != null) widget.onChange!(check);
                }
              },
            ),
            if (state.errorText != null)
              MText(
                text: state.errorText!,
                size: 12.0,
                weight: FontWeight.w400,
                color: context.colorScheme.error,
              ).addPadding(top: 8),
          ],
        );
      },
    );
    if (widget.noExtened) {
      return child;
    }
    return Expanded(child: child);
  }
}
