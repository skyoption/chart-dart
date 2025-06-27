import 'package:example/core/builder/flow_builder.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/features/trade_history/logic/history_positions_cubit.dart';
import 'package:example/features/trade_history/views/widgets/account_found_item_widget.dart';
import 'package:example/features/trade_history/views/widgets/history_position_item_widget.dart';
import 'package:example/features/trade_history/views/widgets/position_profit_item_widget.dart';

class PositionsTab extends StatelessWidget {
  const PositionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<HistoryPositionsCubit>(
      builder: (context, state, cubit) {
        return ListView.builder(
          padding: const MPadding.set(bottom: 90.0),
          itemCount: cubit.positions.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return const PositionProfitItemWidget();
            }
            final item = cubit.positions[index - 1];
            if (item.isA == 'found') {
              return AccountFoundItemWidget(item: item);
            }
            return HistoryPositionItemWidget(item: item);
          },
        );
      },
    );
  }
}
