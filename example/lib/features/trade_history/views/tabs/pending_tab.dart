import 'package:example/core/consts/exports.dart';
import 'package:example/features/trade_history/views/widgets/history_pending_item_widget.dart';
import 'package:example/features/trade_history/views/widgets/pending_profit_item_widget.dart';
import 'package:example/features/trade_history/logic/history_pending_cubit.dart';

class PendingTab extends StatelessWidget {
  const PendingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<HistoryPendingCubit>(
      builder: (context, state, cubit) {
        return ListView.builder(
          padding: const MPadding.set(bottom: 90.0),
          itemCount: cubit.pending.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return const PendingProfitItemWidget();
            }
            final item = cubit.pending[index - 1];
            return HistoryPendingItemWidget(item: item);
          },
        );
      },
    );
  }
}
