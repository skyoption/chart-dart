import 'package:example/core/consts/exports.dart';
import 'package:example/features/trade_history/views/widgets/all_symbols_item_widget.dart';
import 'package:example/features/trade_history/views/widgets/symbols_category_item_widget.dart';

class SelectSymbolScreen extends StatefulWidget {
  static const id = 'SelectSymbolScreen';

  const SelectSymbolScreen({super.key});

  @override
  State<SelectSymbolScreen> createState() => _SelectSymbolScreenState();
}

class _SelectSymbolScreenState extends State<SelectSymbolScreen> {
  @override
  Widget build(BuildContext context) {
    final height = context.height;
    final width = context.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(width, height * 0.12),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.arrow_back,
                    color: Coolors.black,
                    size: 30.0,
                  ).addAction(
                    padding: const MPadding.set(end: 12.0),
                    onGesture: () {
                      context.pop();
                    },
                  ),
                  MText(
                    text: context.tr.selectSymbols,
                    color: Coolors.primaryColor,
                    weight: FontWeight.w600,
                    size: FoontSize.font22,
                  ),
                ],
              ).addPadding(bottom: 12.0, top: 21.0),
              MTextFiled(
                prefix: const MSvg(
                  name: Svgs.search,
                  height: 28.0,
                  width: 28.0,
                  color: AppColors.highLight909090,
                ),
                hintText: context.tr.findSymbol,
                hintColor: AppColors.highLight909090,
                hintSize: FoontSize.font14,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                fillColor: AppColors.highLight,
                textSize: FoontSize.font18,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {},
                contentPadding: const MPadding.set(
                  vertical: 12.0,
                  horizontal: 16.0,
                ),
              ),
            ],
          ).addPadding(horizontal: 21.0),
        ),
      ),
      body: MScroll(
        padding: MPadding.set(horizontal: 21.0, bottom: 30.0),
        child: Column(
          children: [
            AllSymbolsItemWidget(),
            MDividerItemWidget(padding: MPadding.set(vertical: 12.0)),
            SymbolsCategoryItemWidget(title: context.tr.forex),
            SymbolsCategoryItemWidget(title: context.tr.metals),
            SymbolsCategoryItemWidget(title: context.tr.indexes),
          ],
        ),
      ),
    );
  }
}
