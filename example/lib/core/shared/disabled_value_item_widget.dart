import 'package:example/core/consts/exports.dart';

class DisabledValueItemWidget extends StatefulWidget {
  final String? title;
  final String? hint;
  final String? initialValue;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final AutovalidateMode autovalidateMode;
  final Color? fillColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? hintColor;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final double iconSize;
  final Widget? prefix;
  final bool showArrow;

  const DisabledValueItemWidget({
    super.key,
    this.title,
    this.hint,
    this.initialValue,
    this.controller,
    this.onTap,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.fillColor,
    this.borderColor,
    this.textColor,
    this.hintColor,
    this.height,
    this.width,
    this.padding,
    this.borderRadius = 8.0,
    this.iconSize = 24.0,
    this.prefix,
    this.showArrow = true,
  });

  @override
  State<DisabledValueItemWidget> createState() =>
      _DisabledValueItemWidgetState();
}

class _DisabledValueItemWidgetState extends State<DisabledValueItemWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    if (widget.initialValue != null && widget.controller == null) {
      _controller.text = widget.initialValue!;
    }
  }

  @override
  void didUpdateWidget(covariant DisabledValueItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != null && widget.controller == null) {
      _controller.text = widget.initialValue!;
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,
      builder: (FormFieldState<String> state) {
        _controller.addListener(() {
          if (state.value != _controller.text) {
            state.didChange(_controller.text);
          }
        });
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.title != null)
              MText(
                text: widget.title!,
                size: FoontSize.font17,
                weight: FontWeight.w500,
                color: context.colorScheme.onSurface,
              ).addPadding(bottom: 6.0, top: 12.0),
            Container(
              height: widget.height,
              width: widget.width,
              decoration: BoxDecoration(
                color: widget.fillColor,
                border: Border.all(
                  color: state.hasError
                      ? context.colorScheme.error
                      : widget.borderColor ?? context.colorScheme.outline,
                ),
                borderRadius: MBorderRadius.set(all: widget.borderRadius),
              ),
              padding: widget.padding ??
                  const MPadding.set(horizontal: 16.0, vertical: 4.0),
              child: Row(
                children: [
                  if (widget.prefix != null)
                    widget.prefix!.addPadding(end: 12.0),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      enabled: false,
                      style: TextStyle(
                        color:
                            widget.textColor ?? context.colorScheme.onSurface,
                        fontSize: FoontSize.font16,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        hintText: widget.hint,
                        hintStyle: TextStyle(
                          color: widget.hintColor ??
                              context.colorScheme.surfaceDisabled,
                          fontSize: FoontSize.font16,
                          fontWeight: FontWeight.w400,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  if (widget.showArrow)
                    MSvg(
                      name: Svgs.dropdown,
                      color: context.colorScheme.onSurface,
                    ),
                ],
              ),
            ).addAction(onGesture: widget.onTap),
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
  }
}
