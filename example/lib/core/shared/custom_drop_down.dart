import 'package:example/core/consts/exports.dart';
import 'package:example/core/consts/pick_option.dart';

class CDropDown<T> extends StatefulWidget {
  final String? title;
  final List<PickOption<T>> options;
  final ValueChanged<PickOption<T>?> onSelection;
  final String? hint;
  final String? Function(PickOption<T>?)? validator;
  final AutovalidateMode autovalidateMode;
  final dynamic initialValue;
  final double bottomPadding;
  final double? height;
  final EdgeInsetsGeometry? dropdownPadding;
  final Color? fillColor;
  const CDropDown({
    super.key,
    this.title,
    required this.options,
    required this.onSelection,
    this.height,
    this.hint,
    this.dropdownPadding,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.initialValue,
    this.bottomPadding = 12.0,
    this.fillColor,
  });

  @override
  State<CDropDown<T>> createState() => _CDropDownState<T>();
}

class _CDropDownState<T> extends State<CDropDown<T>> {
  PickOption<T>? initialItem;

  @override
  void initState() {
    if (widget.initialValue != null) {
      int index = widget.options.indexWhere(
        (element) => element.value == widget.initialValue,
      );
      if (index != -1) initialItem = widget.options[index];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<PickOption<T>>(
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,
      builder: (FormFieldState<PickOption<T>> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MDropDown<PickOption<T>>(
              height: widget.height,
              title: widget.title,
              inFill: false,
              options: widget.options,
              setInitial: initialItem,
              dropdownPadding: widget.dropdownPadding ??
                  MPadding.set(horizontal: 21.0, vertical: 4.0),
              titlePadding: MPadding.set(bottom: 6.0, top: 12.0),
              textSize: FoontSize.font16,
              titleSize: FoontSize.font17,
              titleWeight: FontWeight.w500,
              backgroundColor: widget.fillColor,
              titleColor: context.colorScheme.onSurface,
              hint: widget.hint ?? context.tr.selectYourAnswer,
              hintColor: context.colorScheme.surfaceDisabled,
              iconSize: 24,
              borderColor: state.hasError
                  ? context.colorScheme.error
                  : context.colorScheme.outline,
              borderRadius: 8.0,
              textColor: context.colorScheme.onSurface,
              selectedItemColor: context.colorScheme.onSurface,
              onChanged: (value) {
                widget.onSelection(value);
                Future.delayed(Duration.zero, () => state.didChange(value));
              },
              itemTitle: (PickOption<T> item) => item.label,
            ),
            if (state.errorText != null)
              MText(
                text: state.errorText!,
                size: 12.0,
                weight: FontWeight.w400,
                color: context.colorScheme.error,
              ).addPadding(top: 8),
          ],
        ).addPadding(bottom: widget.bottomPadding);
      },
    );
  }
}
