import 'package:example/core/consts/exports.dart';

class QuoteTypeWidget extends StatefulWidget {
  final Function(int index) onChange;
  final int? initialIndex;
  final bool isEnabled;

  const QuoteTypeWidget({
    super.key,
    required this.onChange,
    this.initialIndex,
    this.isEnabled = true,
  });

  @override
  State<QuoteTypeWidget> createState() => _QuoteTypeWidgetState();
}

class _QuoteTypeWidgetState extends State<QuoteTypeWidget> {
  late final List<String> types = [
    context.tr.market,
    context.tr.limit,
    context.tr.stop
  ];

  int index = 0;

  @override
  void initState() {
    if (widget.initialIndex != null) {
      index = widget.initialIndex!;
    }
    widget.onChange(index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: types.asMap().entries.map((item) {
        final selected = index == item.key;
        return Container(
          decoration: BoxDecoration(
            color: selected ? Coolors.primaryColor : Coolors.transparent,
            borderRadius: MBorderRadius.set(all: 14.0),
          ),
          padding: const MPadding.set(horizontal: 21.0, vertical: 10.0),
          alignment: Alignment.center,
          child: MText(
            text: item.value,
            color: selected ? Coolors.white : Coolors.grey,
            weight: selected ? FontWeight.w400 : FontWeight.w300,
            size: FoontSize.font18,
          ),
        ).addAction(
          onGesture: () {
            if (widget.isEnabled) {
              index = item.key;
              setState(() {});
              widget.onChange(index);
            }
          },
        );
      }).toList(),
    );
  }
}
