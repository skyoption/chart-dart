import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/functions.dart';
import 'package:example/features/auth/logic/connect_cubit.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';
import 'package:example/features/trade/views/widgets/trade_item_details_item_widget.dart';

class OpenPositionInfoWidget extends StatelessWidget {
  final SymbolEntity symbol;
  final ValueNotifier<double> volume;
  final ValueNotifier<double> price;

  const OpenPositionInfoWidget({
    super.key,
    required this.symbol,
    required this.volume,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ConnectCubit>();
    final leverage = getLeverage(
      symbol.leverage,
      cubit.accountInfo.value!.leverage,
    );

    return Column(
      children: [
        TradeItemDetailsItemWidget(
          title: context.tr.leverage,
          value: '1:$leverage',
        ),
        ValueListenableBuilder(
          valueListenable: volume,
          builder: (context, volume, child) {
            return Column(
              children: [
                TradeItemDetailsItemWidget(
                  title: context.tr.pointValue(symbol.tickSize),
                  value: getPointValue(volume: volume, symbol: symbol)
                      .toStringAsFixed(4),
                ),
                // Depend on volume value
                ValueListenableBuilder(
                  valueListenable: price,
                  builder: (context, price, child) {
                    return TradeItemDetailsItemWidget(
                      title: context.tr.tradeMargin,
                      value: getTradeMargin(
                        volume: volume,
                        price: price,
                        accountLeverage: cubit.accountInfo.value!.leverage,
                        symbol: symbol,
                      ).toStringAsFixed(2),
                    );
                  },
                ),
              ],
            );
          },
        ),
        TradeItemDetailsItemWidget(
          title: context.tr.availableMargin,
          value: cubit.accountInfo.value!.marginFree.toTwoDecimal,
        ),
      ],
    ).addPadding(horizontal: 21.0);
  }
}
