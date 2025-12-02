import 'package:example/core/consts/exports.dart';
import 'package:example/core/shared/bottom_sheets/date_time_bottom_sheet.dart';

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
  DateTime date = DateTime.now();

  @override
  void initState() {
    if (widget.initialDate != null) {
      date = widget.initialDate!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MText(
          text: widget.title,
          weight: FontWeight.w400,
          size: FoontSize.font14,
          color: context.colorScheme.onSurface,
        ).addPadding(bottom: 6.0),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: context.colorScheme.outline),
            borderRadius: MBorderRadius.set(all: 12.0),
          ),
          padding: const MPadding.set(all: 10.0),
          child: MText(
            text: date.yearMonthDay,
            weight: FontWeight.w400,
            size: FoontSize.font14,
            color: context.colorScheme.onSurface,
          ),
        ).addAction(
          onGesture: () {
            showDateTimeBottomSheet(
              context: context,
              initialDate: widget.initialDate,
              onDate: (value) {
                date = value;
                widget.onDate(value);
                setState(() {});
              },
            );
          },
        ),
      ],
    ).addPadding(horizontal: 21.0);
  }
}
