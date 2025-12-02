import 'package:example/core/consts/exports.dart';
import 'package:example/core/shared/row_value_item_widget.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';
import 'package:example/features/trade/models/position_entity.dart';

class PositionDetailsWidget extends StatelessWidget {
  final SymbolEntity symbol;
  final PositionEntity position;
  const PositionDetailsWidget({
    super.key,
    required this.symbol,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainer,
        borderRadius: MBorderRadius.set(all: 12.0),
      ),
      padding: const MPadding.set(vertical: 12.0, horizontal: 16.0),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RowValueItemWidget(
            title: context.tr.id,
            subTitle: position.id,
            subTitleWeight: FontWeight.w400,
            titleColor: context.colorScheme.onSurface,
            subTitleColor: context.colorScheme.onSurface,
          ).addPadding(bottom: 4.0),
          RowValueItemWidget(
            title: context.tr.positionDirection,
            subTitle: position.direction.toLowerCase() == "sell"
                ? context.tr.sell
                : context.tr.buy,
            subTitleWeight: FontWeight.w400,
            titleColor: context.colorScheme.onSurface,
            subTitleColor: context.colorScheme.onSurface,
          ).addPadding(bottom: 4.0),
          // RowValueItemWidget(
          //   title: context.tr.leverage,
          //   subTitle: '1:$leverage',
          //   subTitleWeight: FontWeight.w400,
          //   titleColor: context.colorScheme.onSurface,
          //   subTitleColor: context.colorScheme.onSurface,
          // ).addPadding(bottom: 4.0),
          Column(
            children: [
              RowValueItemWidget(
                title: context.tr.volume,
                subTitle: position.volumeCurrent,
                subTitleWeight: FontWeight.w400,
                titleColor: context.colorScheme.onSurface,
                subTitleColor: context.colorScheme.onSurface,
              ).addPadding(bottom: 4.0),
              // RowValueItemWidget(
              //   title: '${context.tr.pointValue} (${symbol.tickSize})',
              //   subTitle: getPointValue(
              //           volume: position.volumeCurrent, symbol: symbol)
              //       .toStringAsFixed(4),
              //   subTitleWeight: FontWeight.w400,
              //   titleColor: context.colorScheme.onSurface,
              //   subTitleColor: context.colorScheme.onSurface,
              // ).addPadding(bottom: 4.0),
              // RowValueItemWidget(
              //   title: context.tr.tradeMargin,
              //   subTitle: getTradeMargin(
              //     volume: position.volumeCurrent,
              //     price: position.openPrice,
              //     accountLeverage: cubit.account.value!.leverage,
              //     symbol: symbol,
              //   ).toStringAsFixed(2),
              //   subTitleWeight: FontWeight.w400,
              //   titleColor: context.colorScheme.onSurface,
              //   subTitleColor: context.colorScheme.onSurface,
              // ).addPadding(bottom: 4.0),
            ],
          ),
          // RowValueItemWidget(
          //   title: context.tr.availableMargin,
          //   subTitle: cubit.account.value!.marginFree.toTwoDecimal,
          //   subTitleWeight: FontWeight.w400,
          //   titleColor: context.colorScheme.onSurface,
          //   subTitleColor: context.colorScheme.onSurface,
          // ),
        ],
      ),
    ).addPadding(bottom: 21.0, top: 8.0);
  }
}
