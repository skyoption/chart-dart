import '../../../../../../../core/consts/exports.dart';

class SettingsItemWidget extends StatelessWidget {
  final String title;
  final String? iconName;
  final Function? onTap;
  final String? suffixIcon;
  final String? description;
  final Color? descriptionColor;
  final Color? suffixIconColor;
  final Color? titleColor;
  final double iconSize;

  const SettingsItemWidget({
    super.key,
    required this.title,
    this.iconName,
    this.onTap,
    this.suffixIcon,
    this.description,
    this.titleColor,
    this.descriptionColor,
    this.iconSize = 20.0,
    this.suffixIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (iconName != null)
                  Container(
                    width: iconSize + 20,
                    padding: const MPadding.set(all: 8.0),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: MSvg(
                      name: iconName,
                      height: iconSize,
                      width: iconSize,
                      color: suffixIconColor ?? context.colorScheme.onSurface,
                    ),
                  ),
                Column(
                  children: [
                    MText(
                      text: title,
                      size: FoontSize.font17,
                      color: titleColor ?? context.colorScheme.onSurface,
                      weight: FontWeight.w500,
                    ).addPadding(bottom: 2.0),
                    if (description != null)
                      MText(
                        text: description,
                        size: FoontSize.font12,
                        color:
                            descriptionColor ?? context.colorScheme.onSurface,
                        weight: FontWeight.w400,
                      )
                  ],
                )
              ],
            ),
            Icon(
              Icons.navigate_next,
              size: 34,
              color: context.colorScheme.onSurface,
            ),
          ],
        ).addPadding(horizontal: 5),
      ],
    ).addAction(
      padding: const MPadding.set(vertical: 10.0),
      onGesture: () {
        if (onTap != null) {
          onTap!();
        }
      },
    );
  }
}
