import 'package:example/core/consts/exports.dart';
import 'package:example/core/shared/widget_direction.dart';

class SettingsItemWidget extends StatelessWidget {
  final String? headerTitle;
  final String? title;
  final String? icon;
  final Function? onTap;
  final String? suffixIcon;
  final Widget? child;
  final String? description;
  final Color? descriptionColor, titleColor, headerTitleColor;
  final Color? suffixIconColor, iconColor, backgroundColor;
  final double iconSize, suffixIconSize;
  final bool isCenter;
  final bool isDivideredIcon;
  final double? height;
  final TextDirection? titleTextDirection;
  final Widget? content;
  final bool disableDefaultIconColor;
  const SettingsItemWidget({
    super.key,
    this.title,
    this.headerTitle,
    this.icon,
    this.onTap,
    this.titleTextDirection,
    this.backgroundColor,
    this.child,
    this.suffixIcon,
    this.description,
    this.titleColor,
    this.headerTitleColor,
    this.descriptionColor,
    this.suffixIconSize = 19.0,
    this.iconSize = 21.0,
    this.isCenter = false,
    this.isDivideredIcon = false,
    this.suffixIconColor,
    this.iconColor,
    this.height = 50.0,
    this.content,
    this.disableDefaultIconColor = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (headerTitle != null)
          MText(
            text: headerTitle,
            direction: titleTextDirection,
            size: FoontSize.font17,
            color: headerTitleColor ?? context.colorScheme.onSurfaceVariant,
            weight: FontWeight.w400,
          ).addPadding(bottom: 8),
        Container(
          height: height,
          alignment: Alignment.center,
          padding: const MPadding.set(vertical: 10.0, horizontal: 20.0),
          margin: const MPadding.set(bottom: 12.0),
          decoration: BoxDecoration(
            color: backgroundColor ?? context.colorScheme.surfaceContainerLow,
            borderRadius: MBorderRadius.set(all: 8.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: isCenter
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (icon != null)
                    MSvg(
                      name: icon,
                      height: iconSize,
                      width: iconSize,
                      color: iconColor ??
                          (disableDefaultIconColor
                              ? null
                              : context.colorScheme.onSurfaceVariant),
                    ),
                  if (isDivideredIcon)
                    VerticalDivider(
                      color: context.colorScheme.outline,
                    ).addPadding(horizontal: 4.0)
                  else
                    SizedBox(width: 12.0),
                  Builder(
                    builder: (context) {
                      if (content != null) {
                        return content!.addPadding(start: 12.0);
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (title != null)
                            MText(
                              text: title,
                              direction: titleTextDirection,
                              size: FoontSize.font16,
                              color: titleColor ??
                                  context.colorScheme.onSurfaceVariant,
                              weight: FontWeight.w500,
                            ).addPadding(bottom: 2),
                          if (description != null)
                            MText(
                              text: description,
                              size: FoontSize.font12,
                              color: descriptionColor ??
                                  context.colorScheme.onSurfaceVariant,
                              weight: FontWeight.w400,
                            ),
                        ],
                      );
                    },
                  ),
                  if (child != null) child!.addPadding(start: 12.0),
                ],
              ),
              if (suffixIcon != null)
                WidgetDirection(
                  child: MSvg(
                    name: suffixIcon,
                    color:
                        suffixIconColor ?? context.colorScheme.onSurfaceVariant,
                    height: suffixIconSize,
                    width: suffixIconSize,
                  ),
                ).addPadding(start: 8.0),
            ],
          ),
        ).addAction(
          padding: const MPadding.set(horizontal: 5),
          onGesture: () {
            if (onTap != null) {
              onTap!();
            }
          },
        ),
      ],
    );
  }
}
