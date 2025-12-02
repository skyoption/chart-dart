import 'package:example/core/consts/exports.dart';
import 'package:example/features/symbols/views/widgets/quotes_table_header.dart';
import 'package:example/features/symbols/views/widgets/quotes_values_table.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';

class QuotesTableWidget extends StatefulWidget {
  final List<SymbolEntity> items;

  const QuotesTableWidget({super.key, required this.items});

  @override
  State<QuotesTableWidget> createState() => _QuotesTableWidgetState();
}

class _QuotesTableWidgetState extends State<QuotesTableWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: MPadding.set(bottom: 7),
          child: QuotesTableHeader(),
        ),
        Expanded(
          child: MScroll(
            child: QuotesValuesTable(
              items: widget.items,
            ),
          ),
        ),
      ],
    ).addPadding(horizontal: 21.0, bottom: 100.0);
  }
}
