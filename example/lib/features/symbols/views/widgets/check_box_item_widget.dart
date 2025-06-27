import 'package:example/core/consts/exports.dart';

class CheckBoxItemWidget extends StatefulWidget {
  final String title;
  final bool? initial;
  final bool isEnabled;
  final Function(bool value) onChange;

  const CheckBoxItemWidget({
    super.key,
    required this.title,
    required this.onChange,
    this.isEnabled = true,
    this.initial,
  });

  @override
  State<CheckBoxItemWidget> createState() => _CheckBoxItemWidgetState();
}

class _CheckBoxItemWidgetState extends State<CheckBoxItemWidget> {
  late bool check = widget.initial ?? false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 28.0,
          height: 28.0,
          decoration: BoxDecoration(
            color: check ? context.colorScheme.primary : Coolors.transparent,
            border: Border.all(
              color: check
                  ? context.colorScheme.primary
                  : context.colorScheme.outline,
              width: 1.5,
            ),
            borderRadius: MBorderRadius.set(all: 6.0),
          ),
          padding: const MPadding.set(all: 2.0),
          margin: const MPadding.set(end: 12.0),
          child: check
              ? const Icon(
                  Icons.check,
                  color: Coolors.white,
                  size: 20.0,
                )
              : null,
        ),
        MText(
          text: widget.title,
        )
      ],
    ).addAction(
      onGesture: () {
        if (widget.isEnabled) {
          check = !check;
          setState(() {});
          widget.onChange(check);
        }
      },
    );
  }
}
