// ignore_for_file: depend_on_referenced_packages

import 'package:intl/intl.dart';
import 'package:example/core/consts/exports.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateTimeBottomSheet extends StatefulWidget {
  final Function(DateTime date) onDate;
  final DateTime? initialDate;

  const DateTimeBottomSheet({
    super.key,
    required this.onDate,
    this.initialDate,
  });

  @override
  State<DateTimeBottomSheet> createState() => _DateTimeBottomSheetState();
}

class _DateTimeBottomSheetState extends State<DateTimeBottomSheet> {
  DateRangePickerController controller = DateRangePickerController();

  final format = DateFormat("MMMM");

  late List<ItemEntity> months = List.generate(12, (index) {
    final item = index + 1;
    return ItemEntity(
      name: format.format(DateTime(2000, item)),
      value: item,
    );
  });

  List<ItemEntity> years = List.generate(30, (index) {
    final item = 2000 + index;
    return ItemEntity(name: item.toString(), value: item);
  });

  late ItemEntity month =
      months[(widget.initialDate?.month ?? DateTime.now().month) - 1];
  late ItemEntity year = years.firstWhere(
    (item) => item.value == (widget.initialDate?.year ?? DateTime.now().year),
    orElse: () => years[0],
  );

  @override
  void initState() {
    super.initState();
    controller.selectedDate = widget.initialDate ?? DateTime.now();
    controller.displayDate = widget.initialDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    kPrint(widget.initialDate);
    final width = context.width;
    return SizedBox(
      height: 475.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 20.0,
                  color: context.colorScheme.onSurface,
                ).addAction(
                  padding: const MPadding.set(all: 14.0),
                  onTap: () => controller.backward?.call(),
                ),
              ),
              Row(
                children: [
                  Container(
                    width: width * 0.25,
                    decoration: BoxDecoration(
                      color: context.colorScheme.surface,
                      borderRadius: MBorderRadius.set(all: 8.0),
                    ),
                    margin: const MPadding.set(end: 12.0),
                    padding: const MPadding.set(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: MDropDown<ItemEntity>(
                      key: ValueKey(month.value),
                      titleSize: FoontSize.font16,
                      textSize: FoontSize.font22,
                      textWeight: FontWeight.w400,
                      setInitial: month,
                      options: months,
                      iconColor: context.colorScheme.onSurface,
                      selectedItemColor: context.colorScheme.onSurface,
                      dropdownColor: context.colorScheme.surface,
                      textColor: context.colorScheme.onSurface,
                      titlePadding: const MPadding.set(bottom: 5.0),
                      dropdownPadding: const MPadding.set(end: 6.0),
                      onChanged: (value) {
                        month = value!;
                        _updateDatePicker();
                      },
                      itemTitle: (item) => item.name.substring(0, 3),
                    ),
                  ),
                  Container(
                    width: width * 0.25,
                    decoration: BoxDecoration(
                      color: context.colorScheme.surface,
                      borderRadius: MBorderRadius.set(all: 8.0),
                    ),
                    padding: const MPadding.set(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: MDropDown<ItemEntity>(
                      key: ValueKey(year.value),
                      titleSize: FoontSize.font16,
                      textSize: FoontSize.font22,
                      textWeight: FontWeight.w400,
                      setInitial: year,
                      options: years,
                      iconColor: context.colorScheme.onSurface,
                      selectedItemColor: context.colorScheme.onSurface,
                      dropdownColor: context.colorScheme.surface,
                      textColor: context.colorScheme.onSurface,
                      titlePadding: const MPadding.set(bottom: 5.0),
                      dropdownPadding: const MPadding.set(end: 6.0),
                      onChanged: (value) {
                        year = value!;
                        _updateDatePicker();
                      },
                      itemTitle: (item) => item.name,
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: context.colorScheme.onSurface,
                  size: 20.0,
                ).addAction(
                  padding: const MPadding.set(all: 14.0),
                  onTap: () => controller.forward?.call(),
                ),
              )
            ],
          ).addPadding(bottom: 16.0),
          SfDateRangePicker(
            headerHeight: 0.0,
            controller: controller,
            backgroundColor: context.colorScheme.surface,
            initialDisplayDate: widget.initialDate ?? DateTime.now(),
            initialSelectedDate: widget.initialDate ?? DateTime.now(),
            monthViewSettings: const DateRangePickerMonthViewSettings(
              viewHeaderHeight: 50.0,
              viewHeaderStyle: DateRangePickerViewHeaderStyle(
                textStyle: TextStyle(fontSize: FoontSize.font18),
              ),
            ),
            rangeSelectionColor: Coolors.highlight,
            startRangeSelectionColor: context.colorScheme.primary,
            endRangeSelectionColor: context.colorScheme.primary,
            todayHighlightColor: context.colorScheme.primary,
            selectionColor: context.colorScheme.primary,
            yearCellStyle: const DateRangePickerYearCellStyle(
              textStyle: TextStyle(fontSize: FoontSize.font20),
              leadingDatesTextStyle: TextStyle(fontSize: FoontSize.font18),
              todayTextStyle: TextStyle(fontSize: FoontSize.font18),
              disabledDatesTextStyle: TextStyle(fontSize: FoontSize.font18),
            ),
            selectionShape: DateRangePickerSelectionShape.rectangle,
            monthCellStyle: const DateRangePickerMonthCellStyle(
              disabledDatesTextStyle: TextStyle(fontSize: FoontSize.font18),
              weekendTextStyle: TextStyle(fontSize: FoontSize.font18),
              trailingDatesTextStyle: TextStyle(fontSize: FoontSize.font18),
              leadingDatesTextStyle: TextStyle(fontSize: FoontSize.font18),
              textStyle: TextStyle(fontSize: FoontSize.font18),
              blackoutDateTextStyle: TextStyle(fontSize: FoontSize.font18),
              todayTextStyle: TextStyle(fontSize: FoontSize.font18),
              specialDatesTextStyle: TextStyle(fontSize: FoontSize.font18),
            ),
            selectionRadius: 6.0,
            viewSpacing: 12.0,
            headerStyle: const DateRangePickerHeaderStyle(
              textStyle: TextStyle(fontSize: FoontSize.font18),
            ),
            selectionTextStyle: const TextStyle(fontSize: FoontSize.font18),
            rangeTextStyle: const TextStyle(fontSize: FoontSize.font18),
            selectionMode: DateRangePickerSelectionMode.single,
            initialSelectedRange: PickerDateRange(
              DateTime.now().subtract(const Duration(days: 4)),
              DateTime.now().add(const Duration(days: 3)),
            ),
            onSubmit: (p0) {},
            onSelectionChanged: (dateRange) {
              if (dateRange.value != null) {
                final selectedDate = dateRange.value!;
                setState(() {
                  month = months[selectedDate.month - 1];
                  year = years
                      .firstWhere((item) => item.value == selectedDate.year);
                });
              }
            },
          ).addPadding(bottom: 12),
          MBouncingButton(
            height: 50.0,
            width: 120.0,
            title: context.tr.save,
            color: context.colorScheme.primary,
            borderRadius: 12.0,
            onTap: () {
              final selectedDate = controller.selectedDate;
              if (selectedDate != null) {
                final newDate = DateTime(
                  year.value,
                  month.value,
                  selectedDate.day,
                  selectedDate.hour,
                  selectedDate.minute,
                  selectedDate.second,
                );
                widget.onDate(newDate);
              }
              context.router.pop();
            },
          ),
        ],
      ).addPadding(bottom: 30.0, horizontal: 21.0),
    );
  }

  void _updateDatePicker() {
    DateTime newSelectedDate =
        DateTime(year.value, month.value, controller.selectedDate?.day ?? 1);
    if (newSelectedDate.month != month.value) {
      newSelectedDate = DateTime(year.value, month.value, 1);
    }
    controller.selectedDate = newSelectedDate;
    controller.displayDate = newSelectedDate;
  }
}

void showDateTimeBottomSheet({
  required BuildContext context,
  required Function(DateTime date) onDate,
  DateTime? initialDate,
}) {
  showMBottomSheet(
    context: context,
    noScrolling: true,
    backgorundColor: context.colorScheme.scrim,
    removeTransparentBackground: true,
    bottomSheet: DateTimeBottomSheet(
      onDate: onDate,
      initialDate: initialDate,
    ),
  );
}

class ItemEntity {
  final String name;
  dynamic value;

  ItemEntity({
    required this.name,
    required this.value,
  });
}
