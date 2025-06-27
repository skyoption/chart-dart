import 'package:example/core/consts/exports.dart';
import 'package:example/features/symbols/views/widgets/currencies_item_widget.dart';

class SelectSymbolWidget extends StatefulWidget {
  final Function onAdd;

  const SelectSymbolWidget({
    super.key,
    required this.onAdd,
  });

  @override
  State<SelectSymbolWidget> createState() => _SelectSymbolWidgetState();
}

class _SelectSymbolWidgetState extends State<SelectSymbolWidget> {
  bool check = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: check ? null : Border.all(color: Coolors.grey.withOpacity(0.3)),
        borderRadius: MBorderRadius.set(all: 10.0),
        color: check ? Colors.blue.withOpacity(0.3) : Coolors.transparent,
      ),
      margin: const MPadding.set(top: 12.0),
      padding: const MPadding.set(vertical: 12.0, horizontal: 14.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CurrenciesItemWidget(
                      size: 28.0,
                      item: '',
                    ),
                    MText(
                      text: 'symbol',
                      color: Coolors.primaryColor,
                      weight: FontWeight.w600,
                      size: FoontSize.font16,
                    ),
                  ],
                ),
                MText(
                  text: 'U.S DOLLAR VS CANADIAN DOLLAR',
                  color: AppColors.highLight909090,
                  weight: FontWeight.w400,
                  size: FoontSize.font14,
                ).addPadding(vertical: 5.0),
              ],
            ).addPadding(end: 21.0),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.secondColor, width: 1.2),
              shape: BoxShape.rectangle,
              borderRadius: MBorderRadius.set(all: 4.0),
            ),
            padding: const MPadding.set(all: 3.0),
            width: 25.0,
            height: 25.0,
            child: check
                ? const Icon(
                    Icons.check,
                    color: AppColors.secondColor,
                    size: 18.0,
                  )
                : null,
          )
        ],
      ),
    ).addAction(
      onGesture: () {
        check = !check;
        setState(() {});
      },
    );
  }
}
