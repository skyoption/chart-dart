import 'package:example/core/consts/exports.dart';
import 'package:example/features/symbols/views/widgets/quote_details_item_widget.dart';
import 'package:example/features/trade_history/logic/history_actions_cubit.dart';

class ActionsProfitItemWidget extends StatelessWidget {
  const ActionsProfitItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final actionsCubit = context.read<HistoryActionsCubit>();
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
            valueListenable: actionsCubit.commission,
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
