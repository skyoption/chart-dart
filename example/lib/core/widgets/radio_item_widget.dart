import 'package:example/core/consts/exports.dart';

class RadioItemWidget extends StatelessWidget {
  final String title;
  final int index, groupIndex;
  final Widget? icon;
  final Function onTap;

  const RadioItemWidget({
    super.key,
    required this.title,
    required this.index,
    required this.groupIndex,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MDividerItemWidget(
          color: context.colorScheme.outline,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (icon != null) icon!,
                MText(
                  text: title,
                  size: FoontSize.font16,
                  weight: FontWeight.w500,
                  color: context.colorScheme.onSurface,
                ).addPadding(end: 12.0)
              ],
            ),
            Container(
              width: 21.0,
              height: 21.0,
              decoration: BoxDecoration(
                border: Border.all(color: context.colorScheme.primary),
                shape: BoxShape.circle,
              ),
              padding: const MPadding.set(all: 2.0),
              child: index == groupIndex
                  ? Container(
                      width: 19.0,
                      height: 19.0,
                      decoration: BoxDecoration(
                        color: context.colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                    )
                  : null,
            )
          ],
        ).addPadding(vertical: 2.0, horizontal: 21.0),
      ],
    ).addAction(
      onGesture: () => onTap(),
    );
  }
}
