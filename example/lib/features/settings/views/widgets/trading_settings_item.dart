import 'package:example/core/consts/exports.dart';

class TradingSettingItemWidget extends StatefulWidget {
  final Function onAdd;
  final String icon, title, description;

  const TradingSettingItemWidget({
    super.key,
    required this.onAdd,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  State<TradingSettingItemWidget> createState() =>
      _TradingSettingItemWidgetState();
}

class _TradingSettingItemWidgetState extends State<TradingSettingItemWidget> {
  bool check = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  MSvg(
                    name: widget.icon,
                    width: 26.0,
                    height: 26.0,
                  ).addPadding(end: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MText(
                        text: widget.title,
                        color: Coolors.primaryColor,
                        weight: FontWeight.w400,
                        size: FoontSize.font18,
                      ),
                      MText(
                        text: widget.description,
                        color: AppColors.highLight909090,
                        size: FoontSize.font16,
                      ).addPadding(vertical: 5.0),
                    ],
                  ).addPadding(end: 21.0),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.secondColor, width: 1.2),
                shape: BoxShape.rectangle,
                borderRadius: MBorderRadius.set(all: 4.0),
              ),
              padding: const MPadding.set(all: 3.0),
              width: 25.0,
              height: 25.0,
              child: check
                  ? const Icon(
                      Icons.check,
                      color: AppColors.secondColor,
                      size: 18.0,
                    )
                  : null,
            )
          ],
        ),
        MDividerItemWidget(),
      ],
    ).addAction(
      onGesture: () {
        check = !check;
        setState(() {});
      },
    );
  }
}
