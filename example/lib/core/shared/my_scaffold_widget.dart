import 'package:auto_route/auto_route.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/shared/top_icon_button_widget.dart';
import 'package:example/injection/injectable.dart';

class MScaffoldWidget extends StatefulWidget {
  final Widget child;
  final Widget? appbarChild;
  final Widget? action;
  final String? title;
  final double appbarSize;
  final Color? backgroundColor,
      notificationBorderColor,
      notificationBackgroundColor;
  final void Function()? onBackPress;
  final bool showNotificationIcon;
  final bool enableBackButton;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  const MScaffoldWidget({
    super.key,
    required this.child,
    this.title,
    required this.appbarSize,
    this.appbarChild,
    this.action,
    this.backgroundColor,
    this.notificationBorderColor,
    this.notificationBackgroundColor,
    this.onBackPress,
    this.showNotificationIcon = false,
    this.enableBackButton = true,
    this.floatingActionButton,
    this.floatingActionButtonLocation =
        FloatingActionButtonLocation.startDocked,
  });

  @override
  State<MScaffoldWidget> createState() => _MScaffoldWidgetState();
}

class _MScaffoldWidgetState extends State<MScaffoldWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor ?? context.colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          (context.isLandscape ? 20.0 : 0) + widget.appbarSize,
        ),
        child: Container(
          color: widget.backgroundColor ?? context.colorScheme.surface,
          alignment: Alignment.center,
          padding: const MPadding.set(horizontal: 21.0),
          child: SafeArea(
            left: !context.isLandscape,
            right: !context.isLandscape,
            minimum: context.isLandscape
                ? EdgeInsets.only(left: 12.0, top: 12.0, right: 12.0)
                : EdgeInsets.zero,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (widget.enableBackButton)
                          Icon(
                            Icons.arrow_back,
                            size: 26.0,
                            color: context.colorScheme.onSurface,
                          ).addAction(
                            onGesture: widget.onBackPress ??
                                AutoRouterX(context).router.maybePop,
                          ),
                        MText(
                          text: widget.title,
                          size: FoontSize.font18,
                          weight: FontWeight.w600,
                          color: context.colorScheme.onSurface,
                        ).addPadding(start: 12.0),
                      ],
                    ),
                    if (widget.action != null) widget.action!,
                    if (widget.showNotificationIcon)
                      TopIconButtonWidget(
                        icon: Svgs.notifications,
                        borderColor: widget.notificationBorderColor,
                        backgroundColor: widget.notificationBackgroundColor,
                        onTap: () {
                          // getIt<Env>().openNotification();
                        },
                      ),
                  ],
                ).addPadding(vertical: 10.0),
                if (widget.appbarChild != null)
                  widget.appbarChild!.addPadding(horizontal: 6.0),
              ],
            ),
          ),
        ),
      ),
      body: widget.child,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
    );
  }
}
