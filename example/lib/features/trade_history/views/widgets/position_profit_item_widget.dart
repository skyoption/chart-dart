import 'package:example/core/consts/exports.dart';
import 'package:example/features/symbols/views/widgets/quote_details_item_widget.dart';
import 'package:example/features/trade_history/logic/history_positions_cubit.dart';

class PositionProfitItemWidget extends StatelessWidget {
  const PositionProfitItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HistoryPositionsCubit>();
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
            valueListenable: cubit.floating,
            builder: (context, value, child) {
              return QuoteDetailsItemWidget(
                hideDivider: true,
                valueColor: AppColors.white,
                titleColor: AppColors.white,
                title: context.tr.profit,
                value: value.toTwoDecimal,
              ).addPadding(bottom: 6.0);
            },
          ),
          ValueListenableBuilder<double>(
            valueListenable: cubit.deposit,
            builder: (context, value, child) {
              return QuoteDetailsItemWidget(
                hideDivider: true,
                valueColor: AppColors.white,
                titleColor: AppColors.white,
                title: context.tr.deposit,
                value: value.toTwoDecimal,
              ).addPadding(bottom: 6.0);
            },
          ),
          ValueListenableBuilder<double>(
            valueListenable: cubit.withdrawal,
            builder: (context, value, child) {
              return QuoteDetailsItemWidget(
                hideDivider: true,
                valueColor: AppColors.white,
                titleColor: AppColors.white,
                title: context.tr.withdrawal,
                value: value.toTwoDecimal,
              ).addPadding(bottom: 6.0);
            },
          ),
          ValueListenableBuilder<double>(
            valueListenable: cubit.swap,
            builder: (context, value, child) {
              return QuoteDetailsItemWidget(
                hideDivider: true,
                valueColor: AppColors.white,
                titleColor: AppColors.white,
                title: context.tr.swap,
                value: value.toTwoDecimal,
              ).addPadding(bottom: 6.0);
            },
          ),
          ValueListenableBuilder<double>(
            valueListenable: cubit.commission,
            builder: (context, value, child) {
              return QuoteDetailsItemWidget(
                hideDivider: true,
                valueColor: AppColors.white,
                titleColor: AppColors.white,
                title: context.tr.commission,
                value: value.toTwoDecimal,
              );
            },
          ),
        ],
      ),
    );
  }
}
