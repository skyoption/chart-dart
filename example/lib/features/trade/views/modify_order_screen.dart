import 'package:example/core/builder/flow_builder.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/functions.dart';
import 'package:example/features/auth/logic/connect_cubit.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';
import 'package:example/features/symbols/views/widgets/currencies_item_widget.dart';
import 'package:example/features/trade/logic/modify_order_cubit.dart';
import 'package:example/features/trade/models/order_entity.dart';
import 'package:example/features/trade/views/open_position_screen.dart';
import 'package:example/features/trade/views/widgets/position_expiration_type_widget.dart';
import 'package:example/features/trade/views/widgets/take_profit_widget.dart';
import 'package:example/features/trade/views/widgets/trade_price_item_widget.dart';
import 'package:example/features/trade/views/widgets/trade_textfiled_item_widget.dart';
import 'package:example/injection/injectable.dart';

import 'widgets/stop_loss_widget.dart';

class ModifyOrderScreen extends StatefulWidget {
  static const id = 'ModifyOrderScreen';
  final OrderEntity item;

  const ModifyOrderScreen({
    super.key,
    required this.item,
  });

  @override
  State<ModifyOrderScreen> createState() => _ModifyOrderScreenState();
}

class _ModifyOrderScreenState extends State<ModifyOrderScreen> {
  late PositionType orderType =
      getPositionTypeByOrderType(widget.item.direction);
  final price = ValueNotifier<double>(0);
  final formKey = GlobalKey<FormState>();
  final volume = ValueNotifier<double>(0);

  late final loginCubit = context.read<ConnectCubit>();
  late double sl = widget.item.sl.toTwoDecimalNum;
  late double tp = widget.item.tp.toTwoDecimalNum;
  int expiration = 0;

  @override
  void dispose() {
    price.dispose();
    volume.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QuotesCubit>();
    final symbol = cubit.getSymbol(widget.item.symbol);
    final height = context.height;
    final width = context.width;
    volume.value = widget.item.volume;
    price.value = widget.item.openPrice;
    if (symbol == null) return const SizedBox();
    return BlocProvider(
      create: (context) => getIt<ModifyOrderCubit>(),
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
                  text: context.tr.modifyOrder,
                  color: context.colorScheme.scrim,
                  weight: FontWeight.w600,
                  size: FoontSize.font18,
                ),
              ],
            ).addPadding(top: 21.0, horizontal: 21.0),
          ),
        ),
        body: SingleChildScrollView(
          padding: const MPadding.set(horizontal: 21.0, bottom: 30.0),
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CurrenciesItemWidget(item: symbol.symbol),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MText(
                          text: symbol.symbol.toUpperCase(),
                          color: context.colorScheme.scrim,
                          weight: FontWeight.w600,
                          size: FoontSize.font16,
                        ),
                        if (symbol.description.isNotEmpty)
                          MText(
                            text: symbol.description,
                            color: context.colorScheme.outline,
                            weight: FontWeight.w300,
                            size: FoontSize.font14,
                          ),
                      ],
                    ),
                  ],
                ).addPadding(bottom: 21.0, top: 16.0),
                TradePriceItemWidget(
                  symbol: symbol,
                ),
                TradeTextFiledItemWidget(
                  title: context.tr.price,
                  max: widget.item.openPrice,
                  step: 1,
                  onChange: (value) {
                    price.value = double.tryParse(value) ?? 0.0;
                  },
                  validator: (messageError) {
                    if (price.value > widget.item.openPrice ||
                        price.value == 0) {
                      return context.tr.invalid;
                    }
                    return null;
                  },
                ).addPadding(top: 30.0),
                StopLossWidget(
                  type: orderType,
                  price: sl,
                  onChange: (value) {
                    sl = value;
                  },
                ),
                TakeProfitWidget(
                  type: orderType,
                  price: tp,
                  onChange: (value) {
                    tp = value;
                  },
                ),
                PositionExpirationTypeWidget(
                  onTap: (value) {
                    expiration = value;
                  },
                ),
                MDividerItemWidget(
                  color: context.colorScheme.outline,
                  padding: const MPadding.set(vertical: 21.0),
                ),
                FlowBuilder<ModifyOrderCubit>(
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
                            size: FoontSize.font14,
                          ).addPadding(top: 12.0),
                        ValueListenableBuilder(
                          valueListenable: loginCubit.socketState,
                          builder: (context, socketState, child) {
                            return MBouncingButton(
                              height: 50.0,
                              borderRadius: 8.0,
                              title: context.tr.modify,
                              color: socketState.connectionColor(
                                context.colorScheme.primary,
                                context.colorScheme.error,
                              ),
                              onTap: socketState.isDisconnected
                                  ? null
                                  : () {
                                      if (formKey.currentState!.validate()) {
                                        cubit.modifyOrder(
                                          id: widget.item.id,
                                          price: _getUpdatedValue(price.value,
                                              widget.item.openPrice),
                                          volume: _getUpdatedValue(
                                            volume.value,
                                            widget.item.volume,
                                          ),
                                          sl: _getUpdatedValue(
                                            sl,
                                            widget.item.sl.toTwoDecimalNum,
                                          ),
                                          tp: _getUpdatedValue(
                                            tp,
                                            widget.item.tp.toTwoDecimalNum,
                                          ),
                                          expiration:
                                              _getUpdatedValue(expiration, 0),
                                        );
                                      }
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

T? _getUpdatedValue<T>(T newValue, T oldValue) {
  return newValue != oldValue ? newValue : null;
}
