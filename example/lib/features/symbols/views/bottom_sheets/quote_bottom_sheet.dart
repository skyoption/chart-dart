import 'package:example/app_router.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/enums/user_permissions.dart';
import 'package:example/core/framework/mtoast.dart';
import 'package:example/features/auth/logic/connect_cubit.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';
import 'package:example/features/symbols/views/quote_details_screen.dart';
import 'package:example/features/symbols/views/widgets/bottom_sheet_item_widget.dart';
import 'package:example/features/symbols/views/widgets/currencies_item_widget.dart';
import 'package:example/features/trade/views/open_position_screen.dart';

class QuoteBottomSheet extends StatelessWidget {
  final SymbolEntity symbol;

  const QuoteBottomSheet({super.key, required this.symbol});

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<ConnectCubit>();
    return Column(
      children: [
        Row(
          children: [
            CurrenciesItemWidget(
              item: symbol.symbol,
              size: 31.0,
            ).addPadding(end: 4.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MText(
                            text: symbol.symbol,
                            color: context.colorScheme.scrim,
                            weight: FontWeight.w600,
                            size: FoontSize.font18,
                          ).addPadding(bottom: 3.0),
                          if (symbol.description.isNotEmpty)
                            MText(
                              text: symbol.description,
                              color: context.colorScheme.scrim,
                              size: FoontSize.font14,
                            ).addPadding(end: 8.0),
                        ],
                      ),
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: MSvg(
                          name: Svgs.fav,
                          height: 21.0,
                          width: 21.0,
                          color: symbol.isFav
                              ? AppColors.orange
                              : context.colorScheme.onSurface,
                        ).addPadding(end: 10),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ).addPadding(bottom: 40.0),
        if (loginCubit.accountInfo.value!.rights
            .hasPermission(UserPermissions.trade))
          BottomSheetItemWidget(
            icon: Svgs.trade,
            title: context.tr.trade,
            color: context.colorScheme.scrim,
            onTap: () {
              if (symbol.isMarketClose) {
                MToast.showError(message: context.tr.marketCurrentlyClosed);
              } else {
                context.push(
                  OpenPositionScreen(
                    item: symbol.symbol,
                  ),
                );
              }
            },
          ),
        BottomSheetItemWidget(
          icon: Svgs.chart,
          color: context.colorScheme.scrim,
          title: context.tr.chart,
          onTap: () {
            context.read<QuotesCubit>().currentSymbol.value = symbol;
            mainKey.currentState?.navToChart();
          },
        ),
        BottomSheetItemWidget(
          icon: Svgs.details,
          title: context.tr.details,
          onTap: () {
            context.push(QuoteDetailsScreen(symbol: symbol));
          },
        ),
        // BottomSheetItemWidget(
        //   icon: Svgs.statistics,
        //   title: 'Statistics',
        //   onTap: () {},
        // ),
        // QuoteBottomSheetItemWidget(
        //   color: Coolors.red,
        //   title: 'Delete',
        //   onTap: () {},
        // ),
      ],
    ).addPadding(bottom: 30.0, horizontal: 21.0);
  }
}

void showQuoteBottomSheet({
  required BuildContext context,
  required SymbolEntity symbol,
}) {
  showMBottomSheet(
    context: context,
    removeTransparentBackground: true,
    backgorundColor: context.colorScheme.primaryContainer,
    bottomSheet: QuoteBottomSheet(
      symbol: symbol,
    ),
  );
}
