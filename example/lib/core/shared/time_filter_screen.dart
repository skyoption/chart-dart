import 'package:example/core/consts/exports.dart';
import 'package:example/core/shared/custom_date_time_widget.dart';
import 'package:example/core/shared/filter_item_widget.dart';
import 'package:example/core/shared/my_scaffold_widget.dart';
import 'package:example/features/trade_history/models/filters.dart';

@RoutePage()
class TimeFilterScreen extends StatefulWidget {
  final TimeEntity? selectedTime;
  final Function(TimeEntity selectedTime) onPickDate;

  const TimeFilterScreen({
    super.key,
    this.selectedTime,
    required this.onPickDate,
  });

  @override
  State<TimeFilterScreen> createState() => _TimeFilterScreenState();
}

class _TimeFilterScreenState extends State<TimeFilterScreen> {
  late TimeEntity pickedTime;
  bool hasChanges = false;
  int groupIndex = 0;

  @override
  void initState() {
    if (widget.selectedTime != null) {
      pickedTime = widget.selectedTime!;
      kPrint(pickedTime.type);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        groupIndex = filterOptions.indexWhere(
          (element) => element.type == pickedTime.type,
        );
        setState(() {});
      });
    } else {
      pickedTime = TimeEntity(
        from: DateTime.now().subtract(const Duration(days: 7)).toStartTime,
        to: DateTime.now().toEndTime,
        type: 'Last Week',
      );
      hasChanges = true;
    }
    super.initState();
  }

  late final List<FilterOption> filterOptions = [
    FilterOption(context.tr.today, const Duration(days: 0), 'Today'),
    FilterOption(context.tr.lastWeek, const Duration(days: 7), 'Last Week'),
    FilterOption(context.tr.lastMonth, const Duration(days: 30), 'Last Month'),
    FilterOption(
      context.tr.last3Months,
      const Duration(days: 90),
      'Last 3 Month',
    ),
    FilterOption(
      context.tr.last6Months,
      const Duration(days: 180),
      'Last 6 Month',
    ),
    FilterOption(context.tr.lastYear, const Duration(days: 365), 'Last Year'),
    FilterOption(context.tr.custom, null, 'Custom'),
  ];

  void _onTypeSelected(String selectedType) {
    if (pickedTime.type == selectedType) return;

    setState(() {
      pickedTime.type = selectedType;
      hasChanges = true;
    });

    if (selectedType == 'Custom') return;
    final now = DateTime.now();
    pickedTime.to = now.toEndTime;
    final option = filterOptions.firstWhere((opt) => opt.type == selectedType);
    if (option.duration != null) {
      pickedTime.from = now.subtract(option.duration!).toStartTime;
    }
  }

  void _onCustomDatePicked(int startDate, int endDate) {
    if (startDate == pickedTime.from && endDate == pickedTime.to) return;
    setState(() {
      pickedTime.from = startDate;
      pickedTime.to = endDate;
      hasChanges = true;
    });
  }

  void _applyFilter() {
    if (hasChanges) {
      widget.onPickDate(pickedTime);
      AutoRouterX(context).maybePop();
    }
  }

  void _resetFilter() {
    if (groupIndex != 0) {
      setState(() {
        pickedTime = TimeEntity(
          from: DateTime.now().toStartTime,
          to: DateTime.now().toEndTime,
          type: 'Today',
        );
        groupIndex = 0;
        hasChanges = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MScaffoldWidget(
      title: context.tr.filter,
      appbarSize: 60.0,
      child: MScroll(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...filterOptions.asMap().entries.map((item) {
              return FilterItemWidget(
                title: item.value.name,
                groupIndex: groupIndex,
                index: item.key,
                onTap: () {
                  groupIndex = item.key;
                  final type = item.value.type;
                  _onTypeSelected(type);
                  setState(() {});
                },
              );
            }),
            if (pickedTime.type == 'Custom')
              CustomDateTimeWidget(
                initialFromDate: pickedTime.from.toDateTime(),
                initialToDate: pickedTime.to.toDateTime(),
                onStartDate: (value) =>
                    _onCustomDatePicked(value.toStartTime, pickedTime.to),
                onEndDate: (value) =>
                    _onCustomDatePicked(pickedTime.from, value.toEndTime),
              ),
            MDividerItemWidget(color: context.colorScheme.outline),
            Row(
              children: [
                Expanded(
                  child: MBouncingButton(
                    onTap: _resetFilter,
                    title: context.tr.reset,
                    borderRadius: 10.0,
                    height: 50.0,
                    color: context.colorScheme.primary,
                    buttonType: ButtonType.outline,
                    textColor: context.colorScheme.primary,
                    textSize: FoontSize.font16,
                    weight: FontWeight.w500,
                  ).addPadding(vertical: 30.0, horizontal: 21.0),
                ),
                Expanded(
                  flex: 2,
                  child: MBouncingButton(
                    onTap: _applyFilter,
                    title: context.tr.apply,
                    borderRadius: 10.0,
                    height: 50.0,
                    textSize: FoontSize.font16,
                    weight: FontWeight.w500,
                    color: context.colorScheme.primary,
                  ).addPadding(vertical: 30.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
