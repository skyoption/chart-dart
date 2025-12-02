import 'package:example/core/consts/exports.dart';
import 'package:example/features/symbols/views/widgets/currencies_item_widget.dart';
import 'package:example/features/trade/views/widgets/currency_ask_bid_widget.dart';
import 'package:example/features/trade/views/widgets/stop_loss_widget.dart';
import 'package:example/features/trade/views/widgets/take_profit_widget.dart';
import 'package:example/core/framework/functions.dart';
import 'package:example/core/shared/my_scaffold_widget.dart';
import 'package:example/features/main/logic/connect_cubit.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';
import 'package:example/features/trade/logic/modify_position_cubit.dart';
import 'package:example/features/trade/models/position_entity.dart';

@RoutePage()
class EditPositionScreen extends StatefulWidget {
  final PositionEntity position;
  final Function? onSuccess;

  const EditPositionScreen({super.key, required this.position, this.onSuccess});

  @override
  State<EditPositionScreen> createState() => _EditPositionScreenState();
}

class _EditPositionScreenState extends State<EditPositionScreen> {
  late PositionType orderType = getPositionTypeByDirection(
    widget.position.direction,
  );

  final formKey = GlobalKey<FormState>();
  late double sl = widget.position.sl;
  late double tp = widget.position.tp;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QuotesCubit>();
    final connectCubit = context.read<ConnectCubit>();
    final symbol = cubit.getSymbol(widget.position.groupSymbol);
    if (symbol == null) return const SizedBox();

    return MScaffoldWidget(
      title: context.tr.modifyPosition,
      appbarSize: 72.0,
      child: MScroll(
        padding: const MPadding.set(horizontal: 21.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: const MPadding.set(vertical: 12.0, horizontal: 20.0),
                margin: const MPadding.set(bottom: 21.0),
                decoration: BoxDecoration(
                  color: context.colorScheme.surfaceContainerLow,
                  borderRadius: MBorderRadius.set(all: 8.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CurrenciesItemWidget(item: symbol.symbol, size: 25.0),
                        MText(
                          text: symbol.symbol.toUpperCase(),
                          weight: FontWeight.w300,
                          size: FoontSize.font18,
                          color: context.colorScheme.onSurface,
                        ),
                      ],
                    ),
                    MText(
                      text:
                          "${widget.position.direction} ${widget.position.volumeCurrent} ${context.tr.at(widget.position.openPrice)}",
                      color: widget.position.direction == 'SELL'
                          ? Colors.red
                          : Colors.green,
                      size: FoontSize.font16,
                      weight: FontWeight.w400,
                    ).addPadding(start: 10.0),
                  ],
                ),
              ),

              /// ask/bid
              Padding(
                padding: const MPadding.set(bottom: 21.0),
                child: CurrencyAskBidWidget(
                  item: symbol,
                  textSize: FoontSize.font16,
                  largeTextSize: FoontSize.font18,
                ),
              ),

              /// TP + dropdown
              TakeProfitWidget(
                symbol: symbol,
                volume: widget.position.volumeCurrent,
                entryPrice: widget.position.openPrice,
                type: orderType,
                init: tp,
                digits: symbol.digits,
                onChange: (value) {
                  tp = value;
                },
              ),

              const SizedBox(height: 16.0),

              /// SL + dropdown
              StopLossWidget(
                symbol: symbol,
                volume: widget.position.volumeCurrent,
                type: orderType,
                init: sl,
                digits: symbol.digits,
                entryPrice: widget.position.openPrice,
                onChange: (value) {
                  sl = value;
                },
              ),

              /// Button
              FlowBuilder<ModifyPositionCubit>(
                onSuccess: (state, cubit) {
                  context.router.maybePop();
                  widget.onSuccess?.call();
                },
                builder: (context, state, cubit) {
                  return Column(
                    children: [
                      if (cubit.error.isNotEmpty)
                        MText(
                          text: cubit.error,
                          color: Colors.red,
                          size: FoontSize.font16,
                        ).addPadding(top: 21),
                      ValueListenableBuilder(
                        valueListenable: connectCubit.socketState,
                        builder: (context, socketState, child) {
                          return ValueListenableBuilder(
                            valueListenable: connectCubit.hasTradePermission,
                            builder: (context, hasTradePermission, child) {
                              return MBouncingButton(
                                bouncing: false,
                                width: context.width,
                                borderRadius: 8.0,
                                height: 50.0,
                                color: socketState.isDisconnected ||
                                        !hasTradePermission
                                    ? context.colorScheme.onSurfaceDisabled
                                    : context.colorScheme.primary,
                                title: context.tr.modify.toUpperCase(),
                                textSize: FoontSize.font18,
                                onTap: socketState.isDisconnected ||
                                        !hasTradePermission
                                    ? null
                                    : () {
                                        cubit.modifyPosition(
                                          type: widget.position.direction,
                                          requestSymbol:
                                              widget.position.groupSymbol,
                                          id: widget.position.id,
                                          sl: sl,
                                          tp: tp,
                                        );
                                      },
                              ).addPadding(top: 12.0);
                            },
                          );
                        },
                      ),
                    ],
                  );
                },
              ).addPadding(top: 50.0),
            ],
          ),
        ),
      ),
    );
  }
}
