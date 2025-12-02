import 'package:example/core/consts/exports.dart';

class CheckBoxItemWidget extends StatefulWidget {
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
  final TextDecoration textDecoration;
  final Function? onTap;
  final Color? textColor;
  const CheckBoxItemWidget({
    super.key,
    required this.title,
    this.onChange,
    this.isEnabled = true,
    this.initial,
    this.onTap,
    this.child,
    this.noExtened = false,
    this.textSize = 16.0,
    this.fontWeight = FontWeight.w400,
    this.textDecoration = TextDecoration.none,
    this.textColor,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  @override
  State<CheckBoxItemWidget> createState() => _CheckBoxItemWidgetState();
}

class _CheckBoxItemWidgetState extends State<CheckBoxItemWidget> {
  late bool check = widget.initial ?? false;

  @override
  void didUpdateWidget(covariant CheckBoxItemWidget oldWidget) {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 22.0,
                  height: 22.0,
                  decoration: BoxDecoration(
                    color: check
                        ? context.colorScheme.primary
                        : Coolors.transparent,
                    border: Border.all(
                        color: state.hasError
                            ? context.colorScheme.error
                            : context.colorScheme.primary,
                        width: 1.5),
                    borderRadius: MBorderRadius.set(all: 6.0),
                  ),
                  padding: const MPadding.set(all: 2.0),
                  margin: const MPadding.set(end: 8.0),
                  child: check
                      ? const Icon(
                          Icons.check,
                          color: Coolors.white,
                          size: 16.0,
                        )
                      : null,
                ),
                Expanded(
                  child: Wrap(
                    children: [
                      MText(
                        maxLines: 20,
                        text: widget.title,
                        style: TextStyle(
                          decorationStyle: TextDecorationStyle.solid,
                          decorationColor:
                              widget.textColor ?? context.colorScheme.onSurface,
                          fontSize: widget.textSize,
                          fontWeight: widget.fontWeight,
                          decoration: widget.textDecoration,
                          color:
                              widget.textColor ?? context.colorScheme.onSurface,
                        ),
                      ).addAction(
                        padding: MPadding.set(end: 4.0),
                        onGesture: widget.onTap,
                      ),
                      if (widget.child != null) widget.child!,
                    ],
                  ),
                )
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
    return Expanded(
      child: child,
    );
  }
}
