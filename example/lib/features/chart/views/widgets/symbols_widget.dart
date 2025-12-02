import 'package:example/core/consts/exports.dart';
import 'package:example/features/symbols/views/widgets/currencies_item_widget.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';

class SymbolsWidget extends StatefulWidget {
  final bool isTransparent;
  final double? size;
  final EdgeInsetsGeometry? margin;
  final bool showAll;
  final Function(String symbol) onChanged;

  const SymbolsWidget({
    super.key,
    this.isTransparent = true,
    this.size,
    this.margin,
    required this.onChanged,
    this.showAll = false,
  });

  @override
  State<SymbolsWidget> createState() => _SymbolsWidgetState();
}

class _SymbolsWidgetState extends State<SymbolsWidget> {
  @override
  Widget build(BuildContext context) {
    return FlowBuilder<QuotesCubit>(
      buildWhenState: (previous, current) {
        return previous.data is List<SymbolEntity> &&
            current.data is List<SymbolEntity> &&
            previous.data != current.data;
      },
      builder: (context, state, cubit) {
        final symbol = cubit.noFilterSymbols.isNotEmpty
            ? (cubit.currentSymbol.value ?? cubit.noFilterSymbols[0])
            : null;
        return SafeArea(
          left: !context.isLandscape,
          bottom: !context.isLandscape,
          right: !context.isLandscape,
          top: !context.isLandscape,
          child: MDropDown<SymbolEntity>(
            key: Key(DateTime.now().toIso8601String()),
            selectedItemColor: context.colorScheme.onSurface,
            textColor: context.colorScheme.onSurface,
            dropdownPadding: widget.margin ??
                const MPadding.set(
                  vertical: 6.0,
                  horizontal: 16.0,
                ),
            backgroundColor: !widget.isTransparent
                ? context.colorScheme.surfaceContainer
                : null,
            isExpanded: false,
            borderRadius: 12.0,
            iconSize: 25.0,
            iconColor: context.colorScheme.onSurface,
            onChanged: (value) {
              if (value != null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.read<QuotesCubit>().setCurrentSymbol(value);
                  widget.onChanged(value.symbol);
                });
              }
            },
            setInitial: symbol,
            itemTitle: (item) => item.symbol,
            options: cubit.noFilterSymbols,
            hintColor: context.colorScheme.onSurface,
            textSize: FoontSize.font18,
            prefix: (item) {
              if (item == null) return const SizedBox();
              return CurrenciesItemWidget(
                item: item.symbol,
                size: widget.size ?? 21.0,
              );
            },
          ),
        );
      },
    );
  }
}
