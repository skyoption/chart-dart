import 'package:example/core/consts/exports.dart';

class TwoOptionsWidget extends StatefulWidget {
  final List<String> options;
  final Function(int index) onChange;

  const TwoOptionsWidget({
    super.key,
    required this.options,
    required this.onChange,
  });

  @override
  State<TwoOptionsWidget> createState() => _TwoOptionsWidgetState();
}

class _TwoOptionsWidgetState extends State<TwoOptionsWidget> {
  int groupValue = 0;

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    return Column(
      children: [
        Container(
          padding: const MPadding.set(vertical: 6.0),
          decoration: BoxDecoration(
            color: Coolors.highlight,
            borderRadius: MBorderRadius.set(all: 12.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: widget.options.asMap().entries.map((item) {
              return MText(
                text: item.value,
                color: groupValue == item.key
                    ? context.colorScheme.onSurface
                    : context.colorScheme.onSurface,
                weight:
                    groupValue == item.key ? FontWeight.w500 : FontWeight.w300,
                size: FoontSize.font19,
              ).addAction(
                padding: const MPadding.set(horizontal: 21.0, vertical: 12.0),
                onGesture: () {
                  groupValue = item.key;
                  setState(() {});
                  widget.onChange(groupValue);
                },
              );
            }).toList(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: widget.options.asMap().entries.map((item) {
            return Container(
              height: 6.0,
              width: width * 0.3,
              decoration: BoxDecoration(
                color: groupValue == item.key
                    ? Coolors.black
                    : Coolors.transparent,
                borderRadius: MBorderRadius.set(all: 8.0),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
