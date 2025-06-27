import 'package:example/core/consts/exports.dart';

class AllSymbolsItemWidget extends StatefulWidget {
  const AllSymbolsItemWidget({super.key});

  @override
  State<AllSymbolsItemWidget> createState() => _AllSymbolsItemWidgtState();
}

class _AllSymbolsItemWidgtState extends State<AllSymbolsItemWidget> {
  bool check = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: MBorderRadius.set(all: 6.0),
        border: check ? null : Border.all(color: AppColors.highLight),
        color: check ? Colors.blue.withValues(alpha: 0.3) : Coolors.transparent,
      ),
      padding: const MPadding.set(all: 18.0),
      margin: const MPadding.set(bottom: 21.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MText(
            text: context.tr.allSymbols,
            size: FoontSize.font20,
            color: AppColors.black,
            weight: FontWeight.w500,
          ),
          if (check)
            const Icon(
              Icons.check,
              color: AppColors.black,
              size: 28.0,
            )
        ],
      ),
    ).addAction(onGesture: () {
      check = !check;
      setState(() {});
    });
  }
}
