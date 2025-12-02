import 'package:example/core/consts/exports.dart';
import 'package:example/core/shared/option_item_widget.dart';
import 'package:example/core/shared/top_bottom_sheet_widget.dart';

class ChangeCurrenciesDropDownWidget extends StatelessWidget {
  final double? width;
  const ChangeCurrenciesDropDownWidget({super.key, this.width});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: width ?? 130,
          margin: const MPadding.set(bottom: 8.0),
          decoration: BoxDecoration(
            border: Border.all(color: context.colorScheme.outline),
            borderRadius: MBorderRadius.set(all: 10.0),
          ),
          child: FlowBuilder<CurrencyChanged>(
            buildWhenState: (previous, current) {
              return current.type == StateType.success;
            },
            builder: (context, state, cubit) {
              return Container(
                height: context.isLandscape ? 45.0 : 50.0,
                padding: const MPadding.set(horizontal: 8.0),
                constraints: BoxConstraints(
                  maxWidth: constraints.maxWidth,
                  maxHeight: constraints.maxHeight,
                ),
                decoration: BoxDecoration(
                  color: context.colorScheme.surfaceContainerLow,
                  border: Border.all(color: context.colorScheme.outline),
                  borderRadius: MBorderRadius.set(all: 10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MSvg(
                      key: ValueKey(cubit.getCurrency.name),
                      name: cubit.getCurrency.name,
                      width: 24.0,
                      height: 24.0,
                    ).addPadding(end: 5.0),
                    MText(
                      text: cubit.getCurrency.name,
                      color: context.colorScheme.onSurface,
                      weight: context.isLandscape
                          ? FontWeight.w400
                          : FontWeight.w500,
                      size: context.isLandscape
                          ? FoontSize.font13
                          : FoontSize.font16,
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: context.colorScheme.onSurface,
                      size: 24.0,
                    ).addPadding(end: 5.0),
                  ],
                ),
              ).addAction(
                onGesture: () {
                  showChooseCurrencyBottomSheet(
                    context: context,
                    onCurrencyPick: cubit.change,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

class ChooseCurrencyBottomSheet extends StatelessWidget {
  final Function(Currencies currency) onCurrencyPick;
  const ChooseCurrencyBottomSheet({super.key, required this.onCurrencyPick});

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<CurrencyChanged>(
      buildWhenState: (previous, current) {
        return current.type == StateType.success;
      },
      builder: (context, state, cubit) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TopBottomSheetWidget(),
            MText(
              text: context.tr.currency,
              color: context.colorScheme.onSurface,
              weight: FontWeight.w600,
              size: FoontSize.font21,
            ).addPadding(horizontal: 21.0, bottom: 16.0),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(Currencies.values.length, (index) {
                    final isSelected =
                        cubit.getCurrency == Currencies.values[index];
                    return OptionItemWidget(
                      isSelected: isSelected,
                      icon: Currencies.values[index] != Currencies.LOT
                          ? MSvg(
                              name: Currencies.values[index].name,
                              width: 24.0,
                              height: 24.0,
                            ).addPadding(end: 6.0)
                          : SizedBox(width: 24.0, height: 24.0),
                      onTap: () {
                        context.router.pop();
                        onCurrencyPick(Currencies.values[index]);
                      },
                      title: Currencies.values[index].name,
                    );
                  }),
                ),
              ),
            ),
          ],
        ).addPadding(bottom: 30.0);
      },
    );
  }
}

void showChooseCurrencyBottomSheet({
  required BuildContext context,
  required Function(Currencies currency) onCurrencyPick,
}) {
  showMBottomSheet(
    context: context,
    bottomSheet: ChooseCurrencyBottomSheet(onCurrencyPick: onCurrencyPick),
    noScrolling: true,
    removeTransparentBackground: true,
    backgorundColor: context.colorScheme.scrim,
  );
}
