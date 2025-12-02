import 'package:example/core/consts/exports.dart';
import 'package:example/features/trade_history/views/widgets/actions_profit_item_widget.dart';
import 'package:example/features/trade_history/views/widgets/history_action_item_widget.dart';
import 'package:example/features/trade_history/logic/history_actions_cubit.dart';

class ActionsTab extends StatelessWidget {
  const ActionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<HistoryActionsCubit>(
      builder: (context, state, cubit) {
        return ListView.builder(
          padding: const MPadding.set(bottom: 90.0),
          itemCount: cubit.actions.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return const ActionsProfitItemWidget();
            }
            final item = cubit.actions[index - 1];
            return HistoryActionItemWidget(item: item);
          },
        );
      },
    );
  }
}
