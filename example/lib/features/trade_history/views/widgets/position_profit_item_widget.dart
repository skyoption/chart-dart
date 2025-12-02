import 'package:example/core/consts/exports.dart';
import 'package:example/core/shared/row_value_item_widget.dart';
import 'package:example/features/trade_history/logic/history_positions_cubit.dart';

class PositionProfitItemWidget extends StatelessWidget {
  const PositionProfitItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final historyPositions = context.read<HistoryPositionsCubit>();
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
        margin: const MPadding.set(bottom: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValueListenableBuilder<double>(
              valueListenable: historyPositions.floating,
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
              valueListenable: historyPositions.totalWinAmount,
              builder: (context, winAmount, child) {
                return ValueListenableBuilder<int>(
                  valueListenable: historyPositions.totalWinCount,
                  builder: (context, winCount, child) {
                    return RowValueItemWidget(
                      title: "${context.tr.winPositions} ($winCount)",
                      subTitle:
                          "${winAmount.currency2} (${currencyDisplayName(currencyCubit.getCurrency)})",
                      subTitleWeight: FontWeight.w400,
                      titleColor: context.colorScheme.onPrimary,
                      subTitleColor: context.colorScheme.onPrimary,
                    ).addPadding(bottom: 4.0);
                  },
                );
              },
            ),
            ValueListenableBuilder<double>(
              valueListenable: historyPositions.totalLoseAmount,
              builder: (context, loseAmount, child) {
                return ValueListenableBuilder<int>(
                  valueListenable: historyPositions.totalLoseCount,
                  builder: (context, loseCount, child) {
                    return RowValueItemWidget(
                      title: "${context.tr.losePositions} ($loseCount)",
                      subTitle:
                          "${loseAmount.currency2} (${currencyDisplayName(currencyCubit.getCurrency)})",
                      subTitleWeight: FontWeight.w400,
                      titleColor: context.colorScheme.onPrimary,
                      subTitleColor: context.colorScheme.onPrimary,
                    ).addPadding(bottom: 4.0);
                  },
                );
              },
            ),
            ValueListenableBuilder<double>(
              valueListenable: historyPositions.deposit,
              builder: (context, value, child) {
                return RowValueItemWidget(
                  title: context.tr.deposit,
                  subTitle:
                      "${value.currency2} (${currencyDisplayName(currencyCubit.getCurrency)})",
                  subTitleWeight: FontWeight.w400,
                  titleColor: context.colorScheme.onPrimary,
                  subTitleColor: context.colorScheme.onPrimary,
                ).addPadding(bottom: 4.0);
              },
            ),
            ValueListenableBuilder<double>(
              valueListenable: historyPositions.withdrawal,
              builder: (context, value, child) {
                return RowValueItemWidget(
                  title: context.tr.withdrawal,
                  subTitle:
                      "${value.currency2} (${currencyDisplayName(currencyCubit.getCurrency)})",
                  subTitleWeight: FontWeight.w400,
                  titleColor: context.colorScheme.onPrimary,
                  subTitleColor: context.colorScheme.onPrimary,
                ).addPadding(bottom: 4.0);
              },
            ),
            ValueListenableBuilder<double>(
              valueListenable: historyPositions.swap,
              builder: (context, value, child) {
                return RowValueItemWidget(
                  title: context.tr.swap,
                  subTitle:
                      "${value.currency2} (${currencyDisplayName(currencyCubit.getCurrency)})",
                  subTitleWeight: FontWeight.w400,
                  titleColor: context.colorScheme.onPrimary,
                  subTitleColor: context.colorScheme.onPrimary,
                ).addPadding(bottom: 4.0);
              },
            ),
            ValueListenableBuilder<double>(
              valueListenable: historyPositions.commission,
              builder: (context, value, child) {
                return RowValueItemWidget(
                  title: context.tr.commission,
                  subTitle:
                      "${value.currency2} (${currencyDisplayName(currencyCubit.getCurrency)})",
                  subTitleWeight: FontWeight.w400,
                  titleColor: context.colorScheme.onPrimary,
                  subTitleColor: context.colorScheme.onPrimary,
                );
              },
            ),
          ],
        ),
      );
    });
  }
}
