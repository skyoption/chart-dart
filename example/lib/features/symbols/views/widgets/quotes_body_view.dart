import 'dart:async';

import 'package:example/core/consts/exports.dart';
import 'package:example/features/symbols/views/symbols_screen.dart';
import 'package:example/features/symbols/views/widgets/quotes_simple_widget.dart';
import 'package:example/features/symbols/views/widgets/quotes_table_widget.dart';
import 'package:example/features/symbols/views/widgets/vericial_quote_item_widget.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';

class QuotesBodyView extends StatefulWidget {
  final StreamController<QuotesWidgetLayoutType> layoutController;

  const QuotesBodyView({
    super.key,
    required this.layoutController,
  });

  @override
  State<QuotesBodyView> createState() => _QuotesBodyViewState();
}

class _QuotesBodyViewState extends State<QuotesBodyView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.layoutController.stream,
      builder: (context, snapShot) {
        if (snapShot.data == QuotesWidgetLayoutType.table) {
          return FlowBuilder<QuotesCubit>(
            builder: (context, state, cubit) {
              return QuotesTableWidget(
                items: cubit.symbols,
              );
            },
          );
        } else if (snapShot.data == QuotesWidgetLayoutType.simple) {
          return FlowBuilder<QuotesCubit>(
            builder: (context, state, cubit) {
              return MScroll(
                padding: const MPadding.set(horizontal: 21.0, bottom: 100.0),
                child: Column(
                  children: cubit.symbols.map((item) {
                    return QuotesSimpleWidget(
                      item: item,
                    );
                  }).toList(),
                ),
              );
            },
          );
        } else {
          return FlowBuilder<QuotesCubit>(
            builder: (context, state, cubit) {
              return MScroll(
                padding: const MPadding.set(horizontal: 21.0, bottom: 100.0),
                child: Column(
                  children: cubit.symbols.map((item) {
                    return VerticalQuoteWidget(
                      item: item,
                    );
                  }).toList(),
                ),
              );
            },
          );
        }
      },
    );
  }
}
