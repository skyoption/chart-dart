import 'package:example/core/consts/exports.dart';
import 'package:example/features/auth/views/widget/password_item_widget.dart';
import 'package:example/features/trade/views/widgets/cupertino_custom_sliding_segmented_control.dart';

@RoutePage()
class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final height = context.height;
    final width = context.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(width, height * 0.08),
        child: SafeArea(
          child: Row(
            children: [
              Icon(
                Icons.arrow_back,
                color: context.colorScheme.onSurface,
                size: 32.0,
              ).addAction(
                padding: const MPadding.set(vertical: 21.0, end: 12.0),
                onGesture: () => AutoRouterX(context).pop(),
              ),
              MText(
                text: context.tr.changePassword,
                color: context.colorScheme.onSurface,
                weight: FontWeight.w600,
                size: FoontSize.font18,
              ),
            ],
          ).addPadding(horizontal: 21.0),
        ),
      ),
      body: MScroll(
        padding: const MPadding.set(horizontal: 21.0, top: 21.0),
        child: Form(
          child: Column(
            children: [
              CupertinoCustomSlidingSegmentedControl(
                fontSize: FoontSize.font16,
                padding: const MPadding.set(all: 6.0),
                options: [
                  context.tr.mainPassword,
                  context.tr.spectatePassword,
                ],
                onChange: (value) {},
              ).addPadding(top: 5.0, bottom: 30.0),
              MPasswordWidget(
                unActiveSize: 18.0,
                activeSize: 24.0,
                activeColor: context.colorScheme.onSurface,
                unActiveColor: context.colorScheme.onSurface,
                child: (icon, hide) {
                  return MTextFiled(
                    title: context.tr.masterPassword,
                    hintText: context.tr.enterPassword,
                    hintColor: context.colorScheme.onSurface,
                    titleColor: context.colorScheme.onSurface,
                    textColor: context.colorScheme.onSurface,
                    contentPadding:
                        MPadding.set(horizontal: 21.0, vertical: 14.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: context.colorScheme.outline,
                      ),
                    ),
                    titleSize: FoontSize.font18,
                    textSize: FoontSize.font18,
                    hintSize: FoontSize.font16,
                    suffix: icon,
                    obscureText: hide,
                    keyboardType: TextInputType.visiblePassword,
                  ).addPadding(bottom: 12.0);
                },
              ),
              PasswordItemWidget(
                title: context.tr.enterNewPassword,
                onChanged: (value) {},
              ),
              MPasswordWidget(
                unActiveSize: 18.0,
                activeSize: 24.0,
                activeColor: context.colorScheme.onSurface,
                unActiveColor: context.colorScheme.onSurface,
                child: (icon, hide) {
                  return MTextFiled(
                    title: context.tr.confirmNewPassword,
                    titleSize: FoontSize.font18,
                    contentPadding:
                        MPadding.set(horizontal: 21.0, vertical: 14.0),
                    hintText: context.tr.enterPassword,
                    titleColor: context.colorScheme.scrim,
                    hintColor: context.colorScheme.onSurface,
                    textColor: context.colorScheme.scrim,
                    textSize: FoontSize.font18,
                    hintSize: FoontSize.font16,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: context.colorScheme.outline,
                      ),
                    ),
                    suffix: icon,
                    obscureText: hide,
                    keyboardType: TextInputType.visiblePassword,
                  ).addPadding(bottom: 12.0);
                },
              ),
              Align(
                alignment: AlignmentDirectional.center,
                child: MBouncingButton(
                  height: 55.0,
                  title: context.tr.submit,
                  borderRadius: 8.0,
                  onTap: () {
                    AutoRouterX(context).pop();
                  },
                ).addPadding(top: height * 0.04, bottom: 30.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
