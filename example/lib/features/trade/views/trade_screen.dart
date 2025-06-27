import 'package:example/core/builder/flow_builder.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/enums/position_sort.dart';
import 'package:example/features/trade/logic/orders_cubit.dart';
import 'package:example/features/trade/logic/positions_cubit.dart';
import 'package:example/features/trade/views/bottom_sheets/active_trade_action_sheet.dart';
import 'package:example/features/trade/views/bottom_sheets/pending_trade_action_sheet.dart';
import 'package:example/features/trade/views/open_position_screen.dart';
import 'package:example/features/trade/views/widgets/cupertino_custom_sliding_segmented_control.dart';
import 'package:example/features/trade/views/widgets/order_item_widget.dart';
import 'package:example/features/trade/views/widgets/position_item_widget.dart';
import 'package:example/features/trade/views/widgets/trade_info_widget.dart';

import 'bottom_sheets/trade_bottom_sheet.dart';

class TradeScreen extends StatefulWidget {
  const TradeScreen({super.key});

  @override
  State<TradeScreen> createState() => _TradeScreenState();
}

class _TradeScreenState extends State<TradeScreen> {
  ValueNotifier<int> index = ValueNotifier<int>(0);

  late final List cubits = [
    context.read<PositionsCubit>(),
    context.read<OrdersCubit>(),
  ];

  PositionSortConfig getCurrentSort() {
    return cubits[index.value].currentSort;
  }

  void sort(PositionSortConfig onSortSelection) {
    cubits[index.value].sortData(onSortSelection);
  }

  @override
  Widget build(BuildContext context) {
    final height = context.height;
    final width = context.width;
    final positionsCubit = context.read<PositionsCubit>();
    final ordersCubit = context.read<OrdersCubit>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(width, height * 0.06),
        child: Container(
          margin: const MPadding.set(horizontal: 10),
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional.center,
                child: ValueListenableBuilder<double>(
                  valueListenable: positionsCubit.floating,
                  builder: (context, value, child) {
                    return MText(
                      text: context.tr.usdAmount(value > 0
                          ? "+${value.toStringAsFixed(2)}"
                          : value.toStringAsFixed(2)),
                      color: value == 0
                          ? Colors.grey
                          : value > 0
                              ? Coolors.green
                              : Coolors.red,
                      weight: FontWeight.w600,
                      size: FoontSize.font21,
                    ).addPadding(end: 30.0);
                  },
                ),
              ),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: MText(
                  text: context.tr.trade,
                  size: FoontSize.font18,
                  color: context.colorScheme.scrim,
                  weight: FontWeight.w600,
                ),
              ),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MSvg(
                      name: Svgs.sort,
                      height: 21.0,
                      width: 21.0,
                      color: context.colorScheme.scrim,
                    ).addAction(
                      onGesture: () {
                        showTradeBottomSheet(
                          context: context,
                          hideOptions: index.value == 1
                              ? [PositionSortCriteria.profit]
                              : null,
                          currentSort: index.value == 0
                              ? positionsCubit.currentSort
                              : ordersCubit.currentSort,
                          onSortSelection: (value) {
                            if (index.value == 0) {
                              positionsCubit.sort(value);
                            } else {
                              ordersCubit.sort(value);
                            }
                          },
                        );
                      },
                      padding: const MPadding.set(horizontal: 8),
                    ),
                    MSvg(
                      name: Svgs.receiptIcon,
                      color: context.colorScheme.scrim,
                      height: 24.0,
                      width: 24.0,
                    ).addAction(
                      onGesture: () {
                        context.push(const OpenPositionScreen());
                      },
                      padding: const MPadding.set(start: 10),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: index,
        builder: (context, value, child) {
          return FlowBuilder<PositionsCubit>(
            builder: (context, state, positionsCubit) {
              return FlowBuilder<OrdersCubit>(
                builder: (context, state, ordersCubit) {
                  return CustomScrollView(
                    slivers: [
                      const SliverToBoxAdapter(child: TradeInfoWidget()),
                      SliverAppBar(
                        pinned: true,
                        floating: false,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CupertinoCustomSlidingSegmentedControl(
                              options: [
                                context.tr.positions,
                                context.tr.pending
                              ],
                              onChange: (value) {
                                index.value = value;
                              },
                            ),
                            Icon(
                              Icons.more_horiz_outlined,
                              color: context.colorScheme.scrim,
                              size: 35.0,
                            ).addAction(
                              onGesture: () {
                                if (index.value == 0) {
                                  showActiveTradeActionsBottomSheet(
                                    context: context,
                                  );
                                } else {
                                  showPendingTradeActionsBottomSheet(
                                    context: context,
                                  );
                                }
                              },
                            )
                          ],
                        ).addPadding(vertical: 5.0),
                      ),
                      if (value == 0)
                        SliverList.builder(
                          itemCount: positionsCubit.positions.length,
                          itemBuilder: (context, index) {
                            final item = positionsCubit.positions[index];
                            return PositionItemWidget(item: item);
                          },
                        ),
                      if (value == 1)
                        SliverList.builder(
                          itemCount: ordersCubit.orders.length,
                          itemBuilder: (context, index) {
                            final item = ordersCubit.orders[index];
                            return OrderItemWidget(item: item);
                          },
                        ),
                    ],
                  ).addPadding(bottom: 80.0);
                },
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    index.dispose();
    super.dispose();
  }
}
