import 'package:example/core/consts/exports.dart';
import 'package:example/features/trade_history/views/widgets/select_date_item_widget.dart';

class CustomDateTimeWidget extends StatefulWidget {
  final Function(DateTime value) onStartDate, onEndDate;
  final DateTime? initialFromDate;
  final DateTime? initialToDate;
  const CustomDateTimeWidget({
    super.key,
    required this.onStartDate,
    required this.onEndDate,
    this.initialFromDate,
    this.initialToDate,
  });

  @override
  State<CustomDateTimeWidget> createState() => _CustomDateTimeWidgetState();
}

class _CustomDateTimeWidgetState extends State<CustomDateTimeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: context.colorScheme.outline),
        borderRadius: MBorderRadius.set(all: 8.0),
      ),
      padding: const MPadding.set(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectDateItemWidget(
            title: context.tr.startDate,
            onDate: widget.onStartDate,
            initialDate: widget.initialFromDate,
          ),
          MDividerItemWidget(
            color: context.colorScheme.outline,
            padding: const MPadding.set(vertical: 12.0),
          ),
          SelectDateItemWidget(
            title: context.tr.endDate,
            onDate: widget.onEndDate,
            initialDate: widget.initialToDate,
          ),
        ],
      ),
    ).addPadding(horizontal: 21.0, vertical: 12.0);
  }
}
