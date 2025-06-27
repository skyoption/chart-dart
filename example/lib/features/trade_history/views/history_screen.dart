import 'package:example/core/consts/exports.dart';
import 'package:example/core/enums/history_sort.dart';
import 'package:example/features/trade/views/widgets/cupertino_custom_sliding_segmented_control.dart';
import 'package:example/features/trade_history/logic/history_actions_cubit.dart';
import 'package:example/features/trade_history/logic/history_pending_cubit.dart';
import 'package:example/features/trade_history/logic/history_positions_cubit.dart';
import 'package:example/features/trade_history/views/tabs/actions_tab.dart';
import 'package:example/features/trade_history/views/tabs/pending_tab.dart';
import 'package:example/features/trade_history/views/tabs/positions_tab.dart';

import 'bottom_sheets/history_sort_bottom_sheet.dart';
import 'filter_history_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late final controller = TabController(length: 3, vsync: this);
  late final List<dynamic> cubits = [
    context.read<HistoryPositionsCubit>(),
    context.read<HistoryPendingCubit>(),
    context.read<HistoryActionsCubit>(),
  ];

  late final List<String> tabs = [
    context.tr.positions,
    context.tr.pending,
    context.tr.actions,
  ];

  dynamic get currentCubit => cubits[controller.index];

  HistorySortConfig getCurrentSort() => currentCubit.currentSort;

  void sort(HistorySortConfig onSortSelection) {
    currentCubit.sortData(onSortSelection);
  }

  void onFilterPicked(String type, int from, int to) {
    currentCubit.getAll(type: type, from: from, to: to);
  }

  String? getType() => currentCubit.selectedTimeFilter;

  int? getFromTime() => currentCubit.customFromTime;

  int? getToTime() => currentCubit.customToTime;

  @override
  void initState() {
    context.read<HistoryPositionsCubit>().getAll();
    context.read<HistoryPendingCubit>().getAll();
    context.read<HistoryActionsCubit>().getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = context.height;
    final width = context.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(width, height * 0.1),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MSvg(
                name: Svgs.sort,
                height: 21.0,
                width: 21.0,
                color: context.colorScheme.scrim,
              ).addAction(
                onGesture: () {
                  showHistorySortBottomSheet(
                    context: context,
                    hideOptions: controller.index == 2
                        ? [HistorySortCriteria.date]
                        : null,
                    currentSort: getCurrentSort(),
                    onSortSelection: sort,
                  );
                },
                padding: const MPadding.set(vertical: 21.0),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CupertinoCustomSlidingSegmentedControl(
                      options: tabs,
                      onChange: (value) {
                        controller.animateTo(value);
                      },
                    ),
                  ],
                ),
              ),
              MSvg(
                name: Svgs.filter,
                height: 21.0,
                width: 21.0,
                color: context.colorScheme.scrim,
              ).addAction(
                onGesture: () {
                  context.push(
                    FilterHistoryScreen(
                      onPick: onFilterPicked,
                      type: getType(),
                      customFrom: getFromTime(),
                      customTo: getToTime(),
                    ),
                  );
                },
                padding: const MPadding.set(vertical: 21.0),
              ),
            ],
          ).addPadding(horizontal: 21.0),
        ),
      ),
      body: TabBarView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          PositionsTab(),
          PendingTab(),
          ActionsTab(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
