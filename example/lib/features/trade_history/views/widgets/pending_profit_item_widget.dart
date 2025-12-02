import 'package:example/core/consts/exports.dart';
import 'package:example/features/symbols/views/widgets/quote_details_item_widget.dart';
import 'package:example/features/trade_history/logic/history_pending_cubit.dart';

class PendingProfitItemWidget extends StatelessWidget {
  const PendingProfitItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HistoryPendingCubit>();
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
          ValueListenableBuilder<int>(
            valueListenable: cubit.filled,
            builder: (context, value, child) {
              return QuoteDetailsItemWidget(
                hideDivider: true,
                valueColor: context.colorScheme.onPrimary,
                titleColor: context.colorScheme.onPrimary,
                title: context.tr.filled,
                value: '$value',
              ).addPadding(bottom: 6.0);
            },
          ),
          ValueListenableBuilder<int>(
            valueListenable: cubit.canceled,
            builder: (context, value, child) {
              return QuoteDetailsItemWidget(
                hideDivider: true,
                valueColor: context.colorScheme.onPrimary,
                titleColor: context.colorScheme.onPrimary,
                title: context.tr.canceled,
                value: '$value',
              ).addPadding(bottom: 6.0);
            },
          ),
          ValueListenableBuilder<int>(
            valueListenable: cubit.total,
            builder: (context, value, child) {
              return QuoteDetailsItemWidget(
                hideDivider: true,
                valueColor: context.colorScheme.onPrimary,
                titleColor: context.colorScheme.onPrimary,
                title: context.tr.total,
                value: '$value',
              ).addPadding(bottom: 6.0);
            },
          ),
        ],
      ),
    );
  }
}
