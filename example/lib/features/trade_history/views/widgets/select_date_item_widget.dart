import 'package:example/core/consts/exports.dart';
import 'package:example/features/trade_history/views/bottom_sheets/date_time_bottom_sheet.dart';

class SelectDateItemWidget extends StatefulWidget {
  final String title;
  final DateTime? initialDate;

  final Function(DateTime value) onDate;
  const SelectDateItemWidget({
    super.key,
    required this.title,
    required this.onDate,
    this.initialDate,
  });

  @override
  State<SelectDateItemWidget> createState() => _SelectDateItemWidgetState();
}

class _SelectDateItemWidgetState extends State<SelectDateItemWidget> {
  late DateTime date;
  @override
  void initState() {
    date = widget.initialDate ?? DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MText(
          text: widget.title,
          color: context.colorScheme.onSurface,
          size: FoontSize.font16,
          weight: FontWeight.w400,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: context.colorScheme.primary, width: 2),
            borderRadius: MBorderRadius.set(all: 12.0),
          ),
          padding: const MPadding.set(all: 10.0),
          child: MText(
            text: date.yearMonthDay,
            weight: FontWeight.w400,
            color: context.colorScheme.onSurface,
            size: FoontSize.font14,
          ),
        ).addAction(
          onGesture: () {
            showDateTimeBottomSheet(
              context: context,
              initialDate: widget.initialDate,
              onDate: (value) {
                date = value;
                widget.onDate(date);
                setState(() {});
              },
            );
          },
        ),
      ],
    ).addPadding(horizontal: 21.0);
  }
}
