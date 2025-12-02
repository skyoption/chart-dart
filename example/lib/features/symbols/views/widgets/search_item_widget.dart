import 'package:example/core/consts/exports.dart';
import 'package:example/features/symbols/views/widgets/currencies_item_widget.dart';
import 'package:example/injection/injectable.dart';
import 'package:example/features/symbols/logic/search_cubit.dart';
import 'package:example/features/symbols/logic/subscription_cubit.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';
import 'package:example/features/symbols/models/schema/symbol_model.dart';
import 'package:example/features/trade/logic/positions_cubit.dart';

class SearchItemWidget extends StatefulWidget {
  final SymbolModel item;

  const SearchItemWidget({super.key, required this.item});

  @override
  State<SearchItemWidget> createState() => _SearchItemWidgetState();
}

class _SearchItemWidgetState extends State<SearchItemWidget> {
  final cubit = getIt<SubscriptionCubit>();
  late final searchCubit = context.read<SearchCubit>();
  late final quotesCubit = context.read<QuotesCubit>();
  late final positionsCubit = context.read<PositionsCubit>();

  @override
  void initState() {
    final symbols = quotesCubit.symbols.map((e) => e.symbol).toList();
    cubit.setInitial(symbols.contains(widget.item.name));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final symbols = positionsCubit.symbols;
    return BlocProvider(
      create: (context) => cubit,
      child: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.surfaceContainer,
          borderRadius: MBorderRadius.set(all: 10.0),
        ),
        padding: const MPadding.set(vertical: 12.0, horizontal: 12.0),
        margin: const MPadding.set(bottom: 12.0),
        child: Row(
          children: [
            if (!symbols.contains(widget.item.name))
              FlowBuilder<SubscriptionCubit>(
                builder: (context, state, cubit) {
                  return Icon(
                    cubit.isSubscribed ? Icons.delete : Icons.add,
                    size: 26.0,
                    color: cubit.isSubscribed
                        ? Colors.red
                        : context.colorScheme.onSurface,
                  ).addAction(
                    onGesture: () {
                      cubit.subscription(widget.item.name);
                    },
                  );
                },
              ),
            Row(
              children: [
                CurrenciesItemWidget(
                  size: 21.0,
                  item: widget.item.name,
                ),
                MText(
                  text: widget.item.name,
                  weight: FontWeight.w600,
                  size: FoontSize.font14,
                  color: context.colorScheme.onSurface,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
