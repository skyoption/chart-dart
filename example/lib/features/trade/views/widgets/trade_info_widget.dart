import 'package:example/core/consts/exports.dart';
import 'package:example/features/trade/logic/positions_cubit.dart';
import 'package:example/features/trade/views/widgets/account_value_item_widget.dart';

class TradeInfoWidget extends StatelessWidget {
  const TradeInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PositionsCubit>();
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Pngs.tradeAccountWidgetBackground),
          fit: BoxFit.fill,
        ),
      ),
      padding: const MPadding.set(horizontal: 15.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder<double>(
            valueListenable: cubit.balance,
            builder: (context, value, child) {
              return AccountValueItemWidget(
                title: context.tr.balance,
                subTitle: value.toStringAsFixed(2),
                subTitleWeight: FontWeight.w600,
              ).addPadding(bottom: 4.0);
            },
          ),
          ValueListenableBuilder<double>(
            valueListenable: cubit.credit,
            builder: (context, value, child) {
              return AccountValueItemWidget(
                title: context.tr.credit,
                subTitle: value.toStringAsFixed(2),
                subTitleWeight: FontWeight.w600,
              ).addPadding(bottom: 4.0);
            },
          ),
          ValueListenableBuilder<double>(
            valueListenable: cubit.equity,
            builder: (context, value, child) {
              return AccountValueItemWidget(
                title: context.tr.equity,
                subTitle: value.toStringAsFixed(2),
                subTitleWeight: FontWeight.w600,
              ).addPadding(bottom: 4.0);
            },
          ),
          ValueListenableBuilder<double>(
            valueListenable: cubit.margin,
            builder: (context, value, child) {
              return AccountValueItemWidget(
                title: context.tr.margin,
                containerSize: 30.0,
                axisAlignment: MainAxisAlignment.start,
                subTitle: value.toStringAsFixed(2),
              ).addPadding(bottom: 4.0);
            },
          ),
          ValueListenableBuilder<double>(
            valueListenable: cubit.freeMargin,
            builder: (context, value, child) {
              return AccountValueItemWidget(
                title: context.tr.freeMargin,
                containerSize: 30.0,
                subTitle: value.toStringAsFixed(2),
              ).addPadding(bottom: 4.0);
            },
          ),
          ValueListenableBuilder<double>(
            valueListenable: cubit.marginLevel,
            builder: (context, value, child) {
              if (value == 0) return const SizedBox();
              return AccountValueItemWidget(
                title: context.tr.marginLevel,
                containerSize: 30.0,
                axisAlignment: MainAxisAlignment.end,
                subTitle: value.toStringAsFixed(2),
              );
            },
          ),
        ],
      ),
    );
  }
}
