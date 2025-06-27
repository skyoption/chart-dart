import 'package:example/core/consts/exports.dart';
import 'package:example/features/trade/views/widgets/account_value_item_widget.dart';

class ProfitItemWidget extends StatelessWidget {
  const ProfitItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Coolors.primaryColor,
        borderRadius: MBorderRadius.set(all: 12.0),
        image: const DecorationImage(
          image: AssetImage('assets/pngs/cover.png'),
        ),
      ),
      padding: const MPadding.set(horizontal: 21.0, vertical: 21.0),
      margin: const MPadding.set(bottom: 30.0, horizontal: 21.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MText(
            text: context.tr.profit,
            color: Coolors.white,
            size: FoontSize.font21,
          ).addPadding(bottom: 4.0),
          MText(
            text: 2.toStringAsFixed(2),
            size: FoontSize.font24,
            color: Coolors.white,
            weight: FontWeight.w600,
          ),
          Padding(
            padding: const MPadding.set(bottom: 18.0, top: 6.0),
            child: Divider(color: Coolors.grey.withValues(alpha: 0.4)),
          ),
          Row(
            children: [
              Expanded(
                  child: AccountValueItemWidget(
                title: context.tr.deposit,
                containerSize: 30.0,
                axisAlignment: MainAxisAlignment.start,
                subTitle: 2.toStringAsFixed(2),
                fontSize: FoontSize.font15,
              )),
              Expanded(
                child: AccountValueItemWidget(
                  title: context.tr.commission,
                  containerSize: 30.0,
                  subTitle: 2.toStringAsFixed(2),
                  fontSize: FoontSize.font15,
                ),
              ),
              Expanded(
                  child: AccountValueItemWidget(
                title: context.tr.totalBalance,
                containerSize: 30.0,
                axisAlignment: MainAxisAlignment.end,
                subTitle: 2.toStringAsFixed(2),
                fontSize: FoontSize.font15,
              )),
            ],
          )
        ],
      ),
    ).addAction(
      onGesture: () {},
    );
  }
}
