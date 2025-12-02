import 'package:example/core/consts/exports.dart';
import 'package:example/features/trade/views/widgets/order_item_widget.dart';
import 'package:example/features/trade/logic/orders_cubit.dart';

class PendingPositionsTab extends StatelessWidget {
  const PendingPositionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<OrdersCubit>(
      builder: (context, state, cubit) {
        return Column(
          children: cubit.orders.map((item) {
            return OrderItemWidget(item: item);
          }).toList(),
        );
      },
    );
  }
}
