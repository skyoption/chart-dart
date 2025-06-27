import 'package:example/core/consts/exports.dart';

class QuoteTopBarWidget extends StatefulWidget {
  final ValueChanged onChanged;
  final List<String> items;
  final MainAxisAlignment mainAxisAlignment;
  final EdgeInsetsGeometry? margin;
  final Color activeColor, unActiveColor;

  const QuoteTopBarWidget({
    super.key,
    required this.onChanged,
    required this.items,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.unActiveColor = Coolors.transparent,
    this.activeColor = AppColors.primary,
    this.margin,
  });

  @override
  State<QuoteTopBarWidget> createState() => _QuoteTopBarWidgetState();
}

class _QuoteTopBarWidgetState extends State<QuoteTopBarWidget> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return MScroll(
      axis: Axis.horizontal,
      child: Row(
        mainAxisAlignment: widget.mainAxisAlignment,
        children: widget.items.asMap().entries.map((item) {
          final active = index == item.key;
          return Container(
            decoration: BoxDecoration(
              borderRadius: MBorderRadius.set(all: 14.0),
              color: active ? widget.activeColor : widget.unActiveColor,
            ),
            padding: const MPadding.set(vertical: 12.0, horizontal: 21.0),
            alignment: Alignment.center,
            margin: widget.margin ??
                const MPadding.set(end: 6.0, bottom: 21.0, top: 12.0),
            child: MText(
              text: item.value,
              size: FoontSize.font14,
              color: active ? AppColors.white : AppColors.grey,
              weight: active ? FontWeight.w600 : FontWeight.w500,
            ),
          ).addAction(
            onGesture: () {
              index = item.key;
              setState(() {});
              widget.onChanged(item.key);
            },
          );
        }).toList(),
      ),
    );
  }
}
