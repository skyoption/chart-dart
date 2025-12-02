import 'package:example/core/consts/exports.dart';
import 'package:example/core/shared/row_value_item_widget.dart';
import 'package:example/features/trade_history/logic/history_actions_cubit.dart';

class ActionsProfitItemWidget extends StatelessWidget {
  const ActionsProfitItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final actionsCubit = context.read<HistoryActionsCubit>();
    return FlowBuilder<CurrencyChanged>(
        builder: (context, state, currencyCubit) {
      return Container(
        decoration: BoxDecoration(
          color: Coolors.primaryColor,
          image: const DecorationImage(
            image: AssetImage('assets/pngs/cover.png'),
          ),
        ),
        padding: const MPadding.set(horizontal: 21.0, vertical: 16.0),
        margin: const MPadding.set(bottom: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValueListenableBuilder<double>(
              valueListenable: actionsCubit.floating,
              builder: (context, value, child) {
                return RowValueItemWidget(
                  title: context.tr.netProfit,
                  subTitle:
                      "${value.currency2} (${currencyDisplayName(currencyCubit.getCurrency)})",
                  subTitleWeight: FontWeight.w400,
                  titleColor: context.colorScheme.onPrimary,
                  subTitleColor: context.colorScheme.onPrimary,
                ).addPadding(bottom: 4.0);
              },
            ),
            ValueListenableBuilder<double>(
              valueListenable: actionsCubit.commission,
              builder: (context, value, child) {
                return RowValueItemWidget(
                  title: context.tr.commission,
                  containerSize: 30.0,
                  titleColor: context.colorScheme.onPrimary,
                  subTitleColor: context.colorScheme.onPrimary,
                  subTitle:
                      "${value.currency2} (${currencyDisplayName(currencyCubit.getCurrency)})",
                  subTitleWeight: FontWeight.w400,
                );
              },
            ),
          ],
        ),
      );
    });
  }
}
