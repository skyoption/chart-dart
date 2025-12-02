import 'package:example/core/consts/exports.dart';
import 'package:example/features/symbols/views/widgets/currencies_item_widget.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';

class ChooseSymbolItemWidget extends StatelessWidget {
  final bool isSelected;
  final SymbolEntity item;
  final bool showFavorite;
  const ChooseSymbolItemWidget({
    super.key,
    required this.isSelected,
    required this.item,
    this.showFavorite = true,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 70.0,
      duration: const Duration(milliseconds: 300),
      padding: const MPadding.set(horizontal: 12.0),
      decoration: BoxDecoration(
        color: isSelected
            ? context.colorScheme.onPrimaryContainer
            : Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CurrenciesItemWidget(
                value: item,
                size: 26.0,
              ),
              MText(
                text: item.symbol,
                color: context.colorScheme.onSurface,
                size: FoontSize.font18,
              )
            ],
          ),
          Row(
            children: [
              if (isSelected)
                MSvg(
                  height: 14.0,
                  width: 14.0,
                  name: Svgs.lightCheckMarIcon,
                  color: context.colorScheme.onSurface,
                ).addPadding(horizontal: 12.0),
              if (showFavorite)
                ValueListenableBuilder(
                  valueListenable: item.isFavChange,
                  builder: (context, value, child) {
                    return MSvg(
                      name: Svgs.fav,
                      color: value
                          ? context.colorScheme.warning
                          : context.colorScheme.onSurface,
                      height: 21.0,
                    ).addAction(
                      onGesture: () {
                        context.read<QuotesCubit>().setFav(item, !value);
                      },
                      padding: const MPadding.set(horizontal: 3.0),
                    );
                  },
                )
            ],
          ),
        ],
      ),
    );
  }
}
