import 'package:example/core/consts/exports.dart';
import 'package:example/features/trade/views/widgets/position_item_widget.dart';
import 'package:example/features/trade/logic/positions_cubit.dart';

class ActivePositionsTab extends StatelessWidget {
  const ActivePositionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<PositionsCubit>(
      builder: (context, state, cubit) {
        return Column(
          children: cubit.positions.map((item) {
            return PositionItemWidget(item: item);
          }).toList(),
        );
      },
    );
  }
}
