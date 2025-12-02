import 'package:example/core/consts/exports.dart';
import 'package:example/features/symbols/views/widgets/bottom_sheet_item_widget.dart';
import 'package:example/features/trade/views/widgets/close_by_item_widget.dart';

class HistoryBottomSheet extends StatelessWidget {
  const HistoryBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            width: 100.0,
            height: 6.0,
            decoration: BoxDecoration(
              color: Coolors.highlight2,
              borderRadius: MBorderRadius.set(all: 12.0),
            ),
          ),
        ).addPadding(bottom: 21.0),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Coolors.highlight2),
            borderRadius: MBorderRadius.set(all: 12.0),
          ),
          padding: const MPadding.set(vertical: 12.0),
          margin: const MPadding.set(bottom: 30.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        MSvg(
                          name: 'positions/${convert('buy')}-position-icon',
                          height: 45.0,
                          width: 45.0,
                        ).addPadding(end: 12.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MText(
                                text: context.tr.currency,
                                weight: FontWeight.w600,
                                size: FoontSize.font18,
                              ).addPadding(bottom: 4.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MText(
                                    text: context.tr.currency,
                                    color: Coolors.grey,
                                    size: FoontSize.font18,
                                  ),
                                  MText(
                                    text: '2',
                                    color: 2 == 0
                                        ? Coolors.black
                                        : 2 > 0
                                            ? const Color(0xff00A774)
                                            : Coolors.red,
                                    size: FoontSize.font15,
                                    weight: FontWeight.w500,
                                  ).addPadding(bottom: 4.0),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ).addPadding(horizontal: 12.0),
              const MDividerItemWidget(padding: MPadding.set(vertical: 18.0)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            MText(
                              text: context.tr.stopLossShort,
                              size: FoontSize.font16,
                              color: Coolors.grey,
                            ),
                            MText(
                              text: 2 > 0 ? 2.toString() : '-',
                              size: FoontSize.font16,
                              color: Coolors.grey,
                            ).addPadding(start: 16.0)
                          ],
                        ).addPadding(bottom: 4.0),
                        Row(
                          children: [
                            MText(
                              text: context.tr.takeProfitShort,
                              size: FoontSize.font16,
                              color: Coolors.grey,
                            ),
                            MText(
                              text: 2 > 0 ? 2.toString() : '-',
                              size: FoontSize.font16,
                              color: Coolors.grey,
                            ).addPadding(start: 16.0)
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            MText(
                              text: context.tr.commission,
                              size: FoontSize.font16,
                              color: Coolors.grey,
                            ),
                            MText(
                              text: 2.toString(),
                              size: FoontSize.font14,
                              color: Coolors.grey,
                            ).addPadding(start: 12.0)
                          ],
                        ).addPadding(bottom: 4.0),
                        Row(
                          children: [
                            MText(
                              text: context.tr.swap,
                              size: FoontSize.font16,
                              color: Coolors.red,
                            ),
                            MText(
                              text: 2 > 0 ? 2.toString() : '-',
                              size: FoontSize.font14,
                              color: Coolors.red,
                            ).addPadding(start: 12.0)
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MText(
                              text: '23.0988',
                              size: FoontSize.font15,
                              color: Coolors.grey,
                            ),
                            const Padding(
                              padding: MPadding.set(horizontal: 8.0),
                              child: Icon(
                                Icons.arrow_forward,
                                color: Coolors.grey,
                                size: 18.0,
                              ),
                            ),
                            MText(
                              text: '23.0988',
                              size: FoontSize.font15,
                              color: Coolors.grey,
                            ),
                          ],
                        ).addPadding(bottom: 4.0),
                        MText(
                          text: '#123',
                          size: FoontSize.font16,
                          color: Coolors.red,
                        ),
                      ],
                    ),
                  ),
                ],
              ).addPadding(horizontal: 12.0, bottom: 4.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MText(
                        text: context.tr.openDate,
                        size: FoontSize.font13,
                        color: Coolors.grey,
                      ),
                      MText(
                        text: DateTime.now().toIso8601String().toLastTime,
                        size: FoontSize.font13,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MText(
                        text: context.tr.closeDate,
                        size: FoontSize.font13,
                        color: Coolors.grey,
                      ),
                      MText(
                        text: DateTime.now().toIso8601String().toLastTime,
                        size: FoontSize.font13,
                      ),
                    ],
                  ),
                ],
              ).addPadding(horizontal: 12.0)
            ],
          ),
        ),
        BottomSheetItemWidget(
          title: context.tr.trade,
          onTap: () {},
        ),
        BottomSheetItemWidget(
          title: context.tr.chart,
          onTap: () {
            context.navigateTo(
              ChartRoute(
                isFullscreen: ValueNotifier(false),
              ),
            );
          },
        ),
      ],
    ).addPadding(bottom: 30.0, horizontal: 21.0);
  }
}

void showHistoryBottomSheet({
  required BuildContext context,
}) {
  showMBottomSheet(
    context: context,
    removeTransparentBackground: true,
    backgorundColor: context.colorScheme.scrim,
    bottomSheet: HistoryBottomSheet(),
  );
}
