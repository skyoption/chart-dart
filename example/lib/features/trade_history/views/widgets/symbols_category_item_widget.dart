import 'package:example/core/consts/exports.dart';
import 'package:example/features/trade_history/views/widgets/select_symbol_item_widget.dart';

class SymbolsCategoryItemWidget extends StatefulWidget {
  final String title;

  const SymbolsCategoryItemWidget({
    super.key,
    required this.title,
  });

  @override
  State<SymbolsCategoryItemWidget> createState() =>
      _SymbolsCategoryItemWidgetState();
}

class _SymbolsCategoryItemWidgetState extends State<SymbolsCategoryItemWidget> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const MSvg(
              name: Svgs.folder,
              height: 24.0,
              color: AppColors.secondColor,
            ).addPadding(end: 14.0),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MText(
                    text: widget.title,
                    size: FoontSize.font18,
                    weight: FontWeight.w600,
                    color: AppColors.secondColor,
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.secondColor,
                    size: 35.0,
                  ).addAction(
                    onGesture: () {
                      show = !show;
                      setState(() {});
                    },
                  )
                ],
              ),
            ),
          ],
        ),
        const MDividerItemWidget(padding: MPadding.set(vertical: 12.0)),
        if (show)
          Column(
            children: List.generate(5, (index) {
              return SelectSymbolWidget(
                onAdd: () {},
              );
            }),
          ).addPadding(bottom: 21.0)
      ],
    );
  }
}
