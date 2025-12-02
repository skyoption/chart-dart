import 'package:example/core/consts/exports.dart';
import 'package:example/features/trade_history/views/widgets/custom_date_time_widget.dart';
import 'package:example/features/trade_history/views/widgets/filter_item_widget.dart';

@RoutePage()
class FilterHistoryScreen extends StatefulWidget {
  final Function(String type, int from, int to) onPick;
  final String? type;
  final int? customFrom;
  final int? customTo;
  static const id = 'FilterHistoryScreen';

  const FilterHistoryScreen({
    super.key,
    required this.onPick,
    this.type,
    this.customFrom,
    this.customTo,
  });

  @override
  State<FilterHistoryScreen> createState() => _FilterHistoryScreenState();
}

class _FilterHistoryScreenState extends State<FilterHistoryScreen> {
  DateTime? customFrom;
  DateTime? customTo;
  late String type;
  bool hasChanges = false;

  @override
  void initState() {
    type = widget.type ?? 'Last Week';
    customFrom = widget.customFrom?.toDateTime() ?? DateTime.now();
    customTo = widget.customTo?.toDateTime() ?? DateTime.now();
    super.initState();
  }

  late final List<FilterOption> filterOptions = [
    FilterOption(context.tr.today, 'Today', Duration(days: 0)),
    FilterOption(context.tr.lastWeek, 'Last Week', Duration(days: 7)),
    FilterOption(context.tr.lastMonth, 'Last Month', Duration(days: 30)),
    FilterOption(context.tr.last3Months, 'Last 3 Months', Duration(days: 90)),
    FilterOption(context.tr.last6Months, 'Last 6 Months', Duration(days: 180)),
    FilterOption(context.tr.lastYear, 'Last Year', Duration(days: 365)),
    FilterOption(context.tr.custom, 'Custom', null),
  ];

  void _onTypeSelected(String selectedType) {
    if (type == selectedType) return;

    setState(() {
      type = selectedType;
      hasChanges = true;
    });

    if (selectedType == 'Custom') {
      return;
    }

    final now = DateTime.now();
    DateTime from = now;
    DateTime to = now;
    final option = filterOptions.firstWhere((opt) => opt.value == selectedType);
    if (option.duration != null) {
      from = now.subtract(option.duration!);
    }

    _applyFilter(from, to);
  }

  void _onCustomDatePicked(DateTime? startDate, DateTime? endDate) {
    if (startDate == customFrom && endDate == customTo) return;

    setState(() {
      customFrom = startDate;
      customTo = endDate;
      hasChanges = true;
    });
  }

  void _applyFilter(DateTime from, DateTime to) {
    if (hasChanges) {
      widget.onPick(type, from.toStartTime, to.toEndTime);
      AutoRouterX(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = context.height;
    final width = context.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(width, height * 0.08),
        child: SafeArea(
          child: Row(
            children: [
              Icon(
                Icons.clear,
                color: context.colorScheme.onSurface,
                size: 30.0,
              ).addAction(
                padding: const MPadding.set(
                  vertical: 21.0,
                  end: 12.0,
                ),
                onGesture: () {
                  AutoRouterX(context).pop();
                },
              ),
              MText(
                text: context.tr.filterByDate,
                color: context.colorScheme.onSurface,
                weight: FontWeight.w400,
                size: FoontSize.font18,
              ),
            ],
          ).addPadding(horizontal: 21.0),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // MText(
                  //   text: 'Select Symbol',
                  //   size: FoontSize.font18,
                  //   color: MCoolors.highLight909090,
                  // ).addPadding(bottom: 12.0, top: 18.0, horizontal: 21.0),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     borderRadius: MBorderRadius.set(all: 6.0),
                  //     border: Border.all(color: MCoolors.highLight),
                  //   ),
                  //   margin: const MPadding.set(horizontal: 21.0),
                  //   padding: const MPadding.set(all: 18.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       MText(
                  //         text: 'All Symbols',
                  //         size: FoontSize.font20,
                  //         color: MCoolors.black,
                  //         weight: FontWeight.w500,
                  //       ),
                  //       const Icon(
                  //         Icons.arrow_forward_ios_rounded,
                  //         color: MCoolors.black,
                  //         size: 21.0,
                  //       )
                  //     ],
                  //   ),
                  // ).addAction(
                  //   onGesture: () {
                  //     context.push(const SelectSymbolScreen());
                  //   },
                  // ),
                  MText(
                    text: context.tr.selectDate,
                    size: FoontSize.font16,
                    color: context.colorScheme.onSurface,
                  ).addPadding(bottom: 12.0, top: 18.0, horizontal: 21.0),
                  ...filterOptions.map((option) => FilterItemWidget(
                        title: option.name,
                        check: type == option.name,
                        onTap: () => _onTypeSelected(option.value),
                      )),
                  if (type == 'Custom')
                    Column(
                      children: [
                        CustomDateTimeWidget(
                          initialFromDate: customFrom,
                          initialToDate: customTo,
                          onStartDate: (value) => _onCustomDatePicked(
                            value,
                            customTo,
                          ),
                          onEndDate: (value) => _onCustomDatePicked(
                            customFrom,
                            value,
                          ),
                        ).addPadding(bottom: 12.0),
                        MBouncingButton(
                          height: 50.0,
                          borderRadius: 8.0,
                          title: context.tr.apply,
                          color: context.colorScheme.primary,
                          onTap: () {
                            _applyFilter(customFrom!, customTo!);
                          },
                        ).addPadding(horizontal: 21.0),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TimeEntity {
  String type;
  int from;
  int to;

  TimeEntity({
    required this.type,
    required this.from,
    required this.to,
  });
}

class FilterOption {
  final String name;
  final String value;
  final Duration? duration;

  const FilterOption(
    this.name,
    this.value,
    this.duration,
  );
}
