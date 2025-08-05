import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/pick_option.dart';

class CDropDown<T> extends StatefulWidget {
  final String? title;
  final List<PickOption<T>> options;
  final ValueChanged<PickOption<T>?> onSelection;
  final String? hint;
  final String? Function(PickOption<T>?)? validator;
  final AutovalidateMode autovalidateMode;
  final dynamic initialValue;

  const CDropDown({
    super.key,
    this.title,
    required this.options,
    required this.onSelection,
    this.hint,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.initialValue,
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
              title: widget.title,
              inFill: false,
              options: widget.options,
              setInitial: initialItem,
              titleSize: FoontSize.font17,
              titleColor: context.colorScheme.scrim,
              hint: widget.hint ?? context.tr.selectYourAnswer,
              hintColor: context.colorScheme.onSurface,
              iconSize: 16,
              borderColor: state.hasError
                  ? context.colorScheme.error
                  : context.colorScheme.outline,
              borderRadius: 10,
              textColor: context.colorScheme.scrim,
              selectedItemColor: context.colorScheme.scrim,
              textSize: FoontSize.font16,
              onChanged: (value) {
                widget.onSelection(value);
                Future.delayed(const Duration(milliseconds: 100), () {
                  state.didChange(value);
                });
              },
              itemTitle: (PickOption<T> item) => item.label,
            ),
            if (state.errorText != null)
              MText(
                text: state.errorText!,
                size: 12.0,
                weight: FontWeight.w400,
                color: context.colorScheme.error,
              ).addPadding(top: 8)
          ],
        ).addPadding(bottom: 12.0);
      },
    );
  }
}
