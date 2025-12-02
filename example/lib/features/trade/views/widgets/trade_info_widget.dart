import 'package:example/core/consts/exports.dart';
import 'package:example/features/trade/views/widgets/account_value_item_widget.dart';
import 'package:example/core/shared/row_value_item_widget.dart';
import 'package:example/features/trade/logic/position_assets_lose_alert_cubit.dart';
import 'package:example/features/trade/logic/positions_cubit.dart';

class TradeInfoWidget extends StatelessWidget {
  const TradeInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PositionsCubit>();
    return FlowBuilder<PositionAssetsLoseAlertCubit>(
      builder: (context, state, alertCubit) {
        bool hasAlert = state.type == StateType.success;
        return Container(
          decoration: BoxDecoration(
            color: hasAlert ? context.colorScheme.error : Colors.transparent,
            image: DecorationImage(
              image: AssetImage(Pngs.tradeAccountWidgetBackground),
              fit: BoxFit.fill,
            ),
          ),
          padding: const MPadding.set(horizontal: 15.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ValueListenableBuilder<double>(
                valueListenable: cubit.balance,
                builder: (context, value, child) {
                  return RowValueItemWidget(
                    title: context.tr.balance,
                    subTitle: value.currencyName2,
                    subTitleWeight: FontWeight.w600,
                    titleColor: context.colorScheme.onPrimary,
                    subTitleColor: context.colorScheme.onPrimary,
                  ).addPadding(bottom: 4.0);
                },
              ),
              ValueListenableBuilder<double>(
                valueListenable: cubit.credit,
                builder: (context, value, child) {
                  return RowValueItemWidget(
                    title: context.tr.credit,
                    subTitle: value.currencyName2,
                    subTitleWeight: FontWeight.w600,
                    titleColor: context.colorScheme.onPrimary,
                    subTitleColor: context.colorScheme.onPrimary,
                  ).addPadding(bottom: 4.0);
                },
              ),
              ValueListenableBuilder<double>(
                valueListenable: cubit.equity,
                builder: (context, value, child) {
                  return RowValueItemWidget(
                    title: context.tr.equity,
                    subTitle: value.currencyName2,
                    subTitleWeight: FontWeight.w600,
                    titleColor: context.colorScheme.onPrimary,
                    subTitleColor: context.colorScheme.onPrimary,
                  ).addPadding(bottom: 4.0);
                },
              ),
              ValueListenableBuilder<double>(
                valueListenable: cubit.margin,
                builder: (context, value, child) {
                  return RowValueItemWidget(
                    title: context.tr.margin,
                    subTitle: value.currencyName2,
                    subTitleWeight: FontWeight.w600,
                    titleColor: context.colorScheme.onPrimary,
                    subTitleColor: context.colorScheme.onPrimary,
                  ).addPadding(bottom: 4.0);
                },
              ),
              ValueListenableBuilder<double>(
                valueListenable: cubit.freeMargin,
                builder: (context, value, child) {
                  return RowValueItemWidget(
                    title: context.tr.freeMargin,
                    subTitle: value.currencyName2,
                    subTitleWeight: FontWeight.w600,
                    titleColor: context.colorScheme.onPrimary,
                    subTitleColor: context.colorScheme.onPrimary,
                  ).addPadding(bottom: 4.0);
                },
              ),
              ValueListenableBuilder<double>(
                valueListenable: cubit.marginLevel,
                builder: (context, value, child) {
                  if (value == 0) return const SizedBox();
                  return RowValueItemWidget(
                    title: context.tr.marginLevel,
                    titleColor: hasAlert
                        ? context.colorScheme.error
                        : context.colorScheme.onPrimary,
                    subTitleColor: hasAlert
                        ? context.colorScheme.error
                        : context.colorScheme.onPrimary,
                    subTitleWeight: FontWeight.w600,
                    subTitle: value.toStringAsFixed(2),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
