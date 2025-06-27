import 'package:example/core/builder/flow_builder.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/features/symbols/logic/search_cubit.dart';
import 'package:example/features/symbols/logic/subscription_cubit.dart';
import 'package:example/features/symbols/models/schema/symbol_model.dart';
import 'package:example/features/symbols/views/widgets/currencies_item_widget.dart';
import 'package:example/injection/injectable.dart';

class AddQuoteWidget extends StatefulWidget {
  final SymbolModel item;
  final List<String> inPositionSymbols;

  const AddQuoteWidget({
    super.key,
    required this.item,
    required this.inPositionSymbols,
  });

  @override
  State<AddQuoteWidget> createState() => _AddQuoteWidgetState();
}

class _AddQuoteWidgetState extends State<AddQuoteWidget> {
  final cubit = getIt<SubscriptionCubit>();
  late final searchCubit = context.read<SearchCubit>();

  @override
  void initState() {
    cubit.setInitial(searchCubit.isFav(widget.item.name));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: context.colorScheme.outline,
          ),
          borderRadius: MBorderRadius.set(all: 8.0),
        ),
        margin: const MPadding.set(top: 12.0),
        padding: const MPadding.set(vertical: 12.0, horizontal: 14.0),
        child: Row(
          children: [
            if (!widget.inPositionSymbols.contains(widget.item.name))
              FlowBuilder<SubscriptionCubit>(
                builder: (context, state, cubit) {
                  return Icon(
                    cubit.isSubscribed ? Icons.delete : Icons.add,
                    size: 30.0,
                    color: cubit.isSubscribed
                        ? Colors.red
                        : context.colorScheme.scrim,
                  ).addAction(
                    onGesture: () {
                      cubit.subscription(widget.item.name);
                    },
                  );
                },
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CurrenciesItemWidget(
                        size: 21.0,
                        value: widget.item.copyToEntity(),
                      ),
                      MText(
                        text: widget.item.name,
                        color: context.colorScheme.scrim,
                        weight: FontWeight.w600,
                        size: FoontSize.font14,
                      ),
                    ],
                  ),
                  MText(
                    text: widget.item.description,
                    color: context.colorScheme.onSurface,
                    weight: FontWeight.w400,
                    size: FoontSize.font13,
                  ).addPadding(vertical: 5.0),
                ],
              ).addPadding(start: 12.0),
            ),
          ],
        ),
      ),
    );
  }
}
