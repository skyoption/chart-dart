import 'package:candle_chart/entity/line_entity.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/functions.dart';
import 'package:example/core/framework/mtoast.dart';
import 'package:example/features/chart/views/widgets/chart_widget.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';
import 'package:example/features/trade/logic/close_position_cubit.dart';
import 'package:example/features/trade/logic/modify_position_cubit.dart';
import 'package:example/features/trade/logic/positions_cubit.dart';
import 'package:example/features/trade/models/position_entity.dart';
import 'package:example/features/trade/views/open_position_screen.dart';

class ChartUpdatePositionWidget extends StatefulWidget {
  final VoidCallback onFinish, onCancel;
  final ValueNotifier<LineEntity> positionLine;
  final ValueNotifier<double> updatedValue;

  const ChartUpdatePositionWidget({
    super.key,
    required this.onCancel,
    required this.onFinish,
    required this.positionLine,
    required this.updatedValue,
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
        type: position!.direction,
        requestSymbol: symbol!.symbol,
        id: position!.id,
        sl: position!.sl,
        tp: widget.updatedValue.value,
      );
    } else if (type == UpdatePosition.SL) {
      modifyPositionCubit.modifyPosition(
        type: position!.direction,
        requestSymbol: symbol!.symbol,
        id: position!.id,
        sl: widget.updatedValue.value,
        tp: position!.tp,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<LineEntity>(
      valueListenable: widget.positionLine,
      builder: (context, positionLine, child) {
        type = positionLine.positionType;
        position = positionCubit.getPosition(positionLine.positionId);
        if (position != null) {
          symbol = quotesCubit.getSymbol(position!.groupSymbol);
          orderType = getPositionTypeByDirection(position!.direction);
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
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.close,
                    size: 25.0,
                    color: context.colorScheme.onSurface,
                  ).addAction(
                    onTap: widget.onCancel,
                    padding: const MPadding.set(horizontal: 12.0),
                  ),
                  if (positionLine.positionType == UpdatePosition.SL)
                    MBouncingButton(
                      width: 70,
                      color: context.colorScheme.error,
                      textColor: Colors.white,
                      height: 30,
                      bouncing: false,
                      borderRadius: 8,
                      textSize: FoontSize.font16,
                      title: "SL",
                    ),
                  if (positionLine.positionType == UpdatePosition.TP)
                    MBouncingButton(
                      width: 70,
                      bouncing: false,
                      color: context.colorScheme.primary,
                      textColor: Colors.white,
                      height: 30,
                      borderRadius: 8,
                      textSize: FoontSize.font16,
                      title: "TP",
                    ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (positionLine.positionType == UpdatePosition.Price)
                    MBouncingButton(
                      width: 140,
                      color: context.colorScheme.error,
                      height: 32.0,
                      borderRadius: 8,
                      bouncing: false,
                      textSize: FoontSize.font16,
                      title: context.tr.closePosition,
                      onTap: () {
                        if (symbol!.isMarketClose) {
                          MToast.showError(
                            message: context.tr.marketCurrentlyClosed,
                          );
                        } else {
                          execute();
                        }
                        widget.onFinish();
                      },
                    ).addPadding(vertical: 4.0),
                  if (positionLine.positionType != UpdatePosition.Price)
                    MBouncingButton(
                      width: 70,
                      color: context.colorScheme.surfaceBright,
                      textColor: Colors.white,
                      height: 30,
                      borderRadius: 8,
                      icon: Svgs.correctIcon,
                      textSize: FoontSize.font16,
                      onTap: () {
                        if (symbol!.isMarketClose) {
                          MToast.showError(
                            message: context.tr.marketCurrentlyClosed,
                          );
                        } else {
                          execute();
                        }
                        widget.onFinish();
                      },
                    ),
                ],
              ).addPadding(horizontal: 12.0),
            ],
          ),
        );
      },
    );
  }
}
