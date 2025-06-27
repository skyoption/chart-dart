import 'package:example/core/builder/flow_builder.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/functions.dart';
import 'package:example/features/auth/logic/connect_cubit.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';
import 'package:example/features/symbols/views/widgets/currencies_item_widget.dart';
import 'package:example/features/trade/logic/modify_position_cubit.dart';
import 'package:example/features/trade/models/position_entity.dart';
import 'package:example/features/trade/views/open_position_screen.dart';
import 'package:example/features/trade/views/widgets/stop_loss_widget.dart';
import 'package:example/features/trade/views/widgets/take_profit_widget.dart';
import 'package:example/features/trade/views/widgets/trade_price_item_widget.dart';
import 'package:example/injection/injectable.dart';

class ModifyPositionScreen extends StatefulWidget {
  static const id = 'ModifyPositionScreen';
  final PositionEntity position;

  const ModifyPositionScreen({
    super.key,
    required this.position,
  });

  @override
  State<ModifyPositionScreen> createState() => _ModifyPositionScreenState();
}

class _ModifyPositionScreenState extends State<ModifyPositionScreen> {
  late PositionType orderType =
      getPositionTypeByDirection(widget.position.direction);
  final formKey = GlobalKey<FormState>();
  late double sl = widget.position.sl;
  late double tp = widget.position.tp;

  late final loginCubit = context.read<ConnectCubit>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QuotesCubit>();
    final symbol = cubit.getSymbol(widget.position.groupSymbol);
    final height = context.height;
    final width = context.width;
    if (symbol == null) return const SizedBox();
    return BlocProvider(
      create: (context) => getIt<ModifyPositionCubit>(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(width, height * 0.06),
          child: SafeArea(
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back,
                  color: context.colorScheme.scrim,
                  size: 30.0,
                ).addAction(
                  padding: const MPadding.set(end: 12.0),
                  onGesture: () {
                    context.pop();
                  },
                ),
                MText(
                  text: context.tr.modifyPosition,
                  color: context.colorScheme.scrim,
                  weight: FontWeight.w600,
                  size: FoontSize.font18,
                ),
              ],
            ).addPadding(top: 21.0, horizontal: 21.0),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const MPadding.set(horizontal: 21.0, bottom: 30.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CurrenciesItemWidget(
                      item: symbol.symbol,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MText(
                          text: symbol.symbol.toUpperCase(),
                          color: context.colorScheme.scrim,
                          weight: FontWeight.w600,
                          size: FoontSize.font16,
                        ),
                        MText(
                          text:
                              "${widget.position.direction} ${widget.position.volumeCurrent} ${context.tr.at("")}${widget.position.openPrice}",
                          color: context.colorScheme.onSurface,
                          weight: FontWeight.w300,
                          size: FoontSize.font14,
                        ),
                      ],
                    ),
                  ],
                ).addPadding(bottom: 21.0, top: 16.0),
                TradePriceItemWidget(
                  symbol: symbol,
                ).addPadding(bottom: 30.0),
                StopLossWidget(
                  type: orderType,
                  init: sl,
                  price: widget.position.openPrice,
                  onChange: (value) {
                    sl = value;
                  },
                ),
                TakeProfitWidget(
                  type: orderType,
                  init: tp,
                  price: widget.position.openPrice,
                  onChange: (value) {
                    tp = value;
                  },
                ),
                MDividerItemWidget(
                  color: context.colorScheme.outline,
                  padding: const MPadding.set(vertical: 21.0),
                ),
                FlowBuilder<ModifyPositionCubit>(
                  onSuccess: (state, cubit) {
                    context.pop();
                  },
                  builder: (context, state, cubit) {
                    return Column(
                      children: [
                        if (cubit.error.isNotEmpty)
                          MText(
                            text: cubit.error,
                            color: AppColors.red,
                          ).addPadding(top: 21),
                        ValueListenableBuilder(
                          valueListenable: loginCubit.socketState,
                          builder: (context, socketState, child) {
                            return MBouncingButton(
                              bouncing: false,
                              height: 50.0,
                              borderRadius: 8.0,
                              color: socketState.connectionColor(
                                context.colorScheme.primary,
                                context.colorScheme.error,
                              ),
                              title: context.tr.modify,
                              textSize: FoontSize.font18,
                              onTap: socketState.isDisconnected
                                  ? null
                                  : () {
                                      cubit.modifyPosition(
                                        id: widget.position.id,
                                        sl: sl,
                                        tp: tp,
                                      );
                                    },
                            ).addPadding(top: 12.0);
                          },
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
