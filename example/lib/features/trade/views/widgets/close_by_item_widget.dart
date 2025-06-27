import 'package:example/core/consts/exports.dart';

class CloseByItemWidget extends StatelessWidget {
  final bool selected;
  final Function onTap;

  const CloseByItemWidget({
    super.key,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: selected ? Coolors.blue : Coolors.highlight2,
          width: selected ? 2.0 : 1.0,
        ),
        borderRadius: MBorderRadius.set(all: 12.0),
      ),
      padding: const MPadding.set(vertical: 12.0, horizontal: 21.0),
      margin: const MPadding.set(bottom: 12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  MSvg(
                    name: 'positions/${convert('buy')}-position-icon',
                    height: 45.0,
                    width: 45.0,
                  ).addPadding(end: 12.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          MText(
                            text: context.tr.symbol,
                            weight: FontWeight.w600,
                            size: FoontSize.font18,
                          ),
                          MText(
                            text: '32',
                            size: FoontSize.font16,
                            color: Coolors.black,
                          ).addPadding(start: 10.0),
                        ],
                      ).addPadding(bottom: 4.0),
                      Row(
                        children: [
                          MText(
                            text: 23.766.toString(),
                            size: FoontSize.font14,
                            color: Coolors.grey,
                          ),
                          const Padding(
                            padding: MPadding.set(horizontal: 8.0),
                            child: Icon(
                              Icons.arrow_forward,
                              color: Coolors.grey,
                              size: 18.0,
                            ),
                          ),
                          MText(
                            text: '23.6545',
                            size: FoontSize.font14,
                            color: Coolors.grey,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  MText(
                    text: '2',
                    color: 2 == 0
                        ? Coolors.black
                        : 2 > 0
                            ? const Color(0xff00A774)
                            : Coolors.red,
                    size: FoontSize.font16,
                    weight: FontWeight.w500,
                  ).addPadding(bottom: 4.0),
                  MText(
                    text: DateTime.now().toIso8601String().toLastTime,
                    size: FoontSize.font14,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ).addAction(onGesture: onTap);
  }
}

String convert(text) {
  final exp = RegExp('(?<=[a-z])[A-Z]');
  return text.replaceAllMapped(exp, (m) => '-${m.group(0)}').toLowerCase();
}
