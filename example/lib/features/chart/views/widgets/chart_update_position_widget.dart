import 'package:candle_chart/entity/line_entity.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/features/chart/views/widgets/chart_widget.dart';
import 'package:example/core/framework/functions.dart';
import 'package:example/core/framework/mtoast.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';
import 'package:example/features/trade/logic/close_position_cubit.dart';
import 'package:example/features/trade/logic/modify_position_cubit.dart';
import 'package:example/features/trade/logic/positions_cubit.dart';
import 'package:example/features/trade/models/position_entity.dart';

class ChartUpdatePositionWidget extends StatefulWidget {
  final Function(PositionEntity item) onFinish;
  final Function(PositionEntity item) onUpdateSlAndTp,
      onCancel,
      initialPosition;
  final Function(PositionEntity item, bool value) onSl, onTp;
  final ValueNotifier<LineEntity> positionLine;
  final ValueNotifier<double> updatedValue;

  const ChartUpdatePositionWidget({
    super.key,
    required this.onCancel,
    required this.onFinish,
    required this.positionLine,
    required this.updatedValue,
    required this.onSl,
    required this.onTp,
    required this.onUpdateSlAndTp,
    required this.initialPosition,
  });

  @override
  State<ChartUpdatePositionWidget> createState() =>
      _ChartUpdatePositionWidgetState();
}

class _ChartUpdatePositionWidgetState extends State<ChartUpdatePositionWidget> {
  late final closePosition = context.read<ClosePositionCubit>();
  late final modifyPositionCubit = context.read<ModifyPositionCubit>();
  late final positionCubit = context.read<PositionsCubit>();
  late final quotesCubit = context.read<QuotesCubit>();

  late PositionType orderType;
  late UpdatePosition type;
  PositionEntity? position;
  SymbolEntity? symbol;

  void execute() {
    if (type == UpdatePosition.Price) {
      closePosition.closePosition(
        profit: position!.floatingChange.value.signFixed(symbol!.digits),
        symbol: symbol!.symbol,
        ticketNumber: position!.id,
        volume: position!.volumeCurrent,
        sl: position!.sl,
        tp: position!.tp,
      );
    } else if (type == UpdatePosition.TP) {
      modifyPositionCubit.modifyPosition(
        requestSymbol: symbol!.symbol,
        id: position!.id,
        sl: position!.sl,
        type: position!.direction,
        tp: widget.updatedValue.value,
      );
    } else if (type == UpdatePosition.SL) {
      modifyPositionCubit.modifyPosition(
        requestSymbol: symbol!.symbol,
        id: position!.id,
        type: position!.direction,
        sl: widget.updatedValue.value,
        tp: position!.tp,
      );
    }
  }

  bool init = false;
  final sl = ValueNotifier<bool>(false);
  final tp = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<LineEntity>(
      valueListenable: widget.positionLine,
      builder: (context, line, child) {
        type = line.positionType;
        position = positionCubit.getPosition(line.positionId);
        if (position != null) {
          symbol = quotesCubit.getSymbol(position!.groupSymbol);
          orderType = getPositionTypeByDirection(position!.direction);
          if (!init) {
            widget.initialPosition(position!);
            sl.value = position!.sl != 0;
            tp.value = position!.tp != 0;
            init = true;
          }
        }
        if (position == null || symbol == null) {
          return const SizedBox.shrink();
        }
        return Container(
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainer,
            borderRadius: MBorderRadius.set(all: 10.0),
          ),
          padding: const MPadding.set(vertical: 6.0),
          margin: const MPadding.set(horizontal: 21.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.close,
                size: 25.0,
                color: context.colorScheme.onSurface,
              ).addAction(
                onTap: () => widget.onCancel(position!),
                padding: const MPadding.set(horizontal: 12.0),
              ),
              // if (!sl.value &&
              //     !tp.value &&
              //     positionLine.positionType != UpdatePosition.Price)
              //   Row(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       if (positionLine.positionType == UpdatePosition.SL)
              //         MBouncingButton(
              //           width: 70,
              //           color: context.colorScheme.error,
              //           textColor: Colors.white,
              //           height: 30,
              //           bouncing: false,
              //           borderRadius: 8,
              //           textSize: FoontSize.font16,
              //           title: "SL",
              //         ),
              //       if (positionLine.positionType == UpdatePosition.TP)
              //         MBouncingButton(
              //           width: 70,
              //           bouncing: false,
              //           color: context.colorScheme.primary,
              //           textColor: Colors.white,
              //           height: 30,
              //           borderRadius: 8,
              //           textSize: FoontSize.font16,
              //           title: "TP",
              //         ),
              //       MBouncingButton(
              //         width: 70,
              //         color: context.colorScheme.surfaceBright,
              //         textColor: Colors.white,
              //         height: 30,
              //         borderRadius: 8,
              //         icon: Svgs.correctIcon,
              //         textSize: FoontSize.font16,
              //         onTap: () {
              //           if (symbol!.isMarketClose) {
              //             MToast.showError(
              //               message: context.tr.marketCurrentlyClosed,
              //             );
              //           } else {
              //             execute();
              //           }
              //           widget.onFinish();
              //         },
              //       ),
              //     ],
              //   )
              // else
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    spacing: 6.0,
                    children: [
                      MBouncingButton(
                        width: 140,
                        color: context.colorScheme.error,
                        height: 30.0,
                        borderRadius: 8,
                        bouncing: false,
                        textSize: FoontSize.font15,
                        title: context.tr.closePosition,
                        onTap: () {
                          if (symbol!.isMarketClose) {
                            MToast.showError(
                              message: context.tr.marketCurrentlyClosed,
                            );
                          } else {
                            execute();
                          }
                          widget.onFinish(position!);
                        },
                      ),
                      ValueListenableBuilder(
                        valueListenable: sl,
                        builder: (context, value, child) {
                          return MBouncingButton(
                            width: 70,
                            color: value
                                ? context.colorScheme.error
                                : context.colorScheme.outlineVariant,
                            textColor: value
                                ? Colors.white
                                : context.colorScheme.onSurfaceVariant,
                            height: 32.0,
                            bouncing: false,
                            borderRadius: 8,
                            buttonType:
                                value ? ButtonType.filled : ButtonType.outline,
                            textSize: FoontSize.font16,
                            title: "SL",
                            onTap: () {
                              sl.value = !sl.value;
                              widget.onSl(position!, sl.value);
                            },
                          );
                        },
                      ),
                      ValueListenableBuilder(
                        valueListenable: tp,
                        builder: (context, value, child) {
                          return MBouncingButton(
                            width: 70,
                            bouncing: false,
                            color: value
                                ? context.colorScheme.primary
                                : context.colorScheme.outlineVariant,
                            textColor: value
                                ? Colors.white
                                : context.colorScheme.onSurfaceVariant,
                            height: 32.0,
                            borderRadius: 8,
                            buttonType:
                                value ? ButtonType.filled : ButtonType.outline,
                            textSize: FoontSize.font16,
                            title: "TP",
                            onTap: () {
                              tp.value = !tp.value;
                              widget.onTp(position!, tp.value);
                            },
                          );
                        },
                      ),
                      MSvg(
                        name: Svgs.correctIcon,
                        width: 21.0,
                        color: context.colorScheme.onSurface,
                        height: 21.0,
                      ).addAction(
                        padding: const MPadding.set(horizontal: 12.0),
                        onGesture: () {
                          if (symbol!.isMarketClose) {
                            MToast.showError(
                              message: context.tr.marketCurrentlyClosed,
                            );
                          } else {
                            widget.onUpdateSlAndTp(position!);
                          }
                        },
                      ),
                    ],
                  ).addPadding(vertical: 4.0),
                ],
              ).addPadding(horizontal: 12.0),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    sl.dispose();
    tp.dispose();
    super.dispose();
  }
}
