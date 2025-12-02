import 'package:example/core/consts/exports.dart';
import 'package:example/core/shared/select_date_item_widget.dart';

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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectDateItemWidget(
          title: context.tr.from,
          initialDate: widget.initialFromDate,
          onDate: widget.onStartDate,
        ),
        SelectDateItemWidget(
          title: context.tr.to,
          initialDate: widget.initialToDate,
          onDate: widget.onEndDate,
        ),
      ],
    );
  }
}
