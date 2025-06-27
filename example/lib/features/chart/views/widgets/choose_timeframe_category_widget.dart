import 'package:candle_chart/k_chart_widget.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/features/chart/views/widgets/choose_timeframe_item_widget.dart';

class ChooseTimeframeCategoryWidget extends StatelessWidget {
  final String title;
  final List<CandleTimeFormat> items;
  final CandleTimeFormat selected;
  final Function(CandleTimeFormat selected) onTap;

  const ChooseTimeframeCategoryWidget({
    super.key,
    required this.title,
    required this.items,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MText(
          text: title,
          size: FoontSize.font14,
          weight: FontWeight.w400,
          color: context.colorScheme.onSurfaceVariant,
        ).addPadding(horizontal: 21.0, bottom: 14.0),
        Row(
          children: items.map(
            (item) {
              return ChooseTimeframeItemWidget(
                title: item.name,
                isSelected: selected == item,
                onTap: () {
                  onTap(item);
                },
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}
