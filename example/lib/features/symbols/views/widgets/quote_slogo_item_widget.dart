import 'package:example/core/consts/exports.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';
import 'package:example/features/trade/logic/positions_cubit.dart';

class QuoteSlogoItemWidget extends StatelessWidget {
  final double? height;
  final SymbolEntity item;

  const QuoteSlogoItemWidget({
    super.key,
    this.height,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final height = context.height;
    final floating =
        context.read<PositionsCubit>().floatingSymbols[item.symbol];
    if (floating == null) return const SizedBox();
    return ValueListenableBuilder<double>(
      valueListenable: floating,
      builder: (context, value, child) {
        if (value == 0) return const SizedBox(width: 4.0);
        return Container(
          height: this.height ?? height * 0.08,
          width: 4.0,
          margin: const MPadding.set(start: 0.2),
          decoration: BoxDecoration(
            color: value < 0
                ? Colors.red
                : value > 0
                    ? Colors.green
                    : Colors.grey,
            borderRadius: MBorderRadius.set(end: 16.0),
          ),
        );
      },
    );
  }
}
