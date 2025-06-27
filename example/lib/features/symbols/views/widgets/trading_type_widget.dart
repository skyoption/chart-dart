import 'package:example/core/consts/exports.dart';

class TradingTypeWidget extends StatefulWidget {
  final Function(int index) onChange;
  final int? updateOrderIndex;
  final bool isEnabled;

  const TradingTypeWidget({
    Key? key,
    required this.onChange,
    this.updateOrderIndex,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  State<TradingTypeWidget> createState() => _TradingTypeWidgetState();
}

class _TradingTypeWidgetState extends State<TradingTypeWidget> {
  late final List<OptionEntity> types = [
    OptionEntity(
      title: context.tr.sell,
      value: Svgs.sell,
    ),
    OptionEntity(
      title: context.tr.buy,
      value: Svgs.buy,
    ),
  ];

  int index = -1;

  @override
  void initState() {
    if (widget.updateOrderIndex != null) {
      index = widget.updateOrderIndex!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.0,
      child: Stack(
        children: [
          PositionedDirectional(
            bottom: 2.5,
            start: 0.0,
            end: 0.0,
            child: Container(
              height: 1.0,
              color: Coolors.highlight2,
              width: double.infinity,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: types.asMap().entries.map((item) {
              final selected = index == item.key;
              final color = index == 0
                  ? const Color(0xffFF6470)
                  : const Color(0xff0969DA);
              return Column(
                children: [
                  Row(
                    children: [
                      MSvg(
                        name: item.value.value,
                        color: selected ? color : Coolors.grey,
                        height: 16.0,
                      ).addPadding(end: 12.0),
                      MText(
                        text: item.value.title,
                        color: selected ? color : Coolors.grey,
                        weight: selected ? FontWeight.w400 : FontWeight.w300,
                      ),
                    ],
                  ),
                  Container(
                    height: 6.0,
                    width: 120.0,
                    margin: const MPadding.set(top: 12.0),
                    decoration: BoxDecoration(
                      color: selected ? color : Coolors.transparent,
                      borderRadius: MBorderRadius.set(all: 14.0),
                    ),
                  )
                ],
              ).addAction(
                onGesture: () {
                  if (widget.isEnabled) {
                    if (index == item.key) {
                      index = -1;
                    } else {
                      index = item.key;
                    }
                    setState(() {});
                    widget.onChange(index);
                  }
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class OptionEntity {
  final String title;
  final String value;

  OptionEntity({
    required this.title,
    required this.value,
  });
}
