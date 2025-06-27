import 'package:example/core/consts/exports.dart';

class ChooseOptionWidget<T> extends StatefulWidget {
  final List<T> options;
  final String Function(T item) onItem;
  final String Function(T item)? onIcon;
  final Function(T item) onChange;
  final Color? activeColor;

  const ChooseOptionWidget({
    super.key,
    required this.options,
    required this.onItem,
    this.onIcon,
    required this.onChange,
    this.activeColor,
  });

  @override
  State<ChooseOptionWidget<T>> createState() => _ChooseOptionWidgetState<T>();
}

class _ChooseOptionWidgetState<T> extends State<ChooseOptionWidget<T>> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Coolors.highlight,
        borderRadius: MBorderRadius.set(all: 12.0),
      ),
      padding: const MPadding.set(all: 10.0),
      child: Row(
        children: widget.options.asMap().entries.map((item) {
          final color = item.key == index
              ? widget.activeColor ?? context.colorScheme.primary
              : context.colorScheme.outline;
          return Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: item.key == index ? Coolors.white : Coolors.highlight,
                borderRadius: MBorderRadius.set(all: 12.0),
              ),
              padding: const MPadding.set(horizontal: 8.0, vertical: 12.0),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.onIcon != null)
                    MSvg(
                      name: widget.onIcon!(item.value),
                      color: color,
                      height: 26.0,
                    ).addPadding(end: 12.0),
                  MText(
                    text: widget.onItem(item.value),
                    color: color,
                    size: FoontSize.font17,
                    weight: FontWeight.w400,
                  ),
                ],
              ),
            ).addAction(
              onGesture: () {
                setState(() {
                  index = item.key;
                });
                widget.onChange(item.value);
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
