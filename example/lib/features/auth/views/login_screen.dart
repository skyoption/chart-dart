import 'package:example/core/builder/flow_builder.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/features/auth/logic/connect_cubit.dart';
import 'package:example/features/chart/views/chart_screen.dart';
import 'package:example/features/main/views/main_screen.dart';

class LoginScreen extends StatefulWidget {
  final Function(String user, String password)? onAddNewAccount;
  static const id = 'LoginScreen';

  const LoginScreen({
    super.key,
    this.onAddNewAccount,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final cubit = context.read<ConnectCubit>();

  @override
  void initState() {
    if (widget.onAddNewAccount == null) cubit.hasLoggedOut = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const MAssetImage(
            name: Pngs.login,
            width: double.infinity,
            height: 400.0,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: AlignmentDirectional.topStart,
            child: MText(
              text: context.tr.login,
              size: FoontSize.font32,
              weight: FontWeight.w600,
              align: TextAlign.start,
              color: AppColors.white,
            ).addPadding(horizontal: 32.0, vertical: 80.0),
          ),
          SafeArea(
            child: Container(
              height: context.height,
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: MBorderRadius.set(top: 50.0),
              ),
              margin: const MPadding.set(top: 160.0),
              child: MScroll(
                padding: const MPadding.set(horizontal: 21.0),
                child: Form(
                  key: cubit.loginFormKey,
                  child: Column(
                    children: [
                      MSvg(
                        name: context.isDarkTheme ? Svgs.logoDark : Svgs.logo,
                        width: 35.0,
                        height: 35.0,
                      ).addPadding(bottom: 30.0, top: 35.0),
                      MText(
                        text: context.tr.loginWelcomeMessage,
                        size: FoontSize.font17,
                        weight: FontWeight.w400,
                        color: context.colorScheme.scrim,
                      ).addPadding(bottom: 30.0),
                      // TradeDropdownItemWidget<String>(
                      //   height: 65.0,
                      //   width: context.width * 0.919,
                      //   searchTitle: 'Search by Name Server',
                      //   options: const [
                      //     'Live 1',
                      //     'Live 2',
                      //     'Live 3',
                      //     'Live 4',
                      //     'Live 5',
                      //     'Demo 1',
                      //     'Demo 2',
                      //   ],
                      //   isOutline: false,
                      //   onTap: (item) {},
                      //   onName: (item) => item,
                      // ).addPadding(bottom: 6.0),
                      MTextFiled(
                        hintText: context.tr.accountNumber,
                        hintColor: context.colorScheme.onSurface,
                        controller: cubit.number,
                        textColor: context.colorScheme.scrim,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: context.colorScheme.surfaceContainer,
                        textSize: FoontSize.font18,
                        hintSize: FoontSize.font16,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: false,
                          signed: false,
                        ),
                        contentPadding:
                            MPadding.set(horizontal: 21.0, vertical: 14.0),
                        validator: (valid) {
                          return Validates.isHasData(
                            minLength: 4,
                            data: cubit.number.text,
                            errorMessage: context.tr.pleaseEnterAccountNumber,
                          );
                        },
                      ).addPadding(bottom: 21.0),
                      MPasswordWidget(
                        unActiveSize: 18.0,
                        activeSize: 24.0,
                        activeColor: context.colorScheme.scrim,
                        unActiveColor: context.colorScheme.scrim,
                        child: (icon, hide) {
                          return MTextFiled(
                            hintText: context.tr.password,
                            controller: cubit.password,
                            textSize: FoontSize.font18,
                            hintSize: FoontSize.font16,
                            keyboardType: TextInputType.text,
                            contentPadding:
                                MPadding.set(horizontal: 21.0, vertical: 14.0),
                            hintColor: context.colorScheme.onSurface,
                            textColor: context.colorScheme.scrim,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: context.colorScheme.surfaceContainer,
                            validator: (valid) {
                              return Validates.isHasData(
                                minLength: 5,
                                data: cubit.password.text,
                                errorMessage: context.tr.pleaseEnterPassword,
                              );
                            },
                            suffix: icon,
                            obscureText: hide,
                          ).addPadding(bottom: 21.0);
                        },
                      ),
                      Align(
                        alignment: AlignmentDirectional.center,
                        child: FlowBuilder<ConnectCubit>(
                          onSuccess: (state, cubit) {
                            cubit.number.clear();
                            cubit.password.clear();
                            context.pushNamedAndRemoveUntil(MainScreen.id);
                          },
                          builder: (context, state, cubit) {
                            return MBouncingButton(
                              width: double.infinity,
                              color: AppColors.primary,
                              height: 55.0,
                              title: context.tr.login,
                              borderRadius: 8.0,
                              onTap: () {
                                if (widget.onAddNewAccount != null) {
                                  context.pop();
                                  widget.onAddNewAccount!(
                                    cubit.number.text,
                                    cubit.password.text,
                                  );
                                } else {
                                  cubit.execute(
                                    onConnected: () {
                                      key.currentState?.clearSLOrTPOrPosition();
                                    },
                                  );
                                }
                                // context.pushNamedAndRemoveUntil(MainScreen.id);
                              },
                            ).addPadding(top: 21.0, bottom: 30.0);
                          },
                        ),
                      ),
                      // MTitleDividerItemWidget(
                      //   textColor: context.colorScheme.scrim,
                      //   title: 'Or Login with',
                      //   color: context.colorScheme.outline,
                      // ),
                      // MBouncingButton(
                      //   width: double.infinity,
                      //   color: context.colorScheme.onSurface,
                      //   buttonType: ButtonType.outline,
                      //   height: 65.0,
                      //   weight: FontWeight.w600,
                      //   textSize: FoontSize.font18,
                      //   icon: Svgs.google,
                      //   iconSize: 35.0,
                      //   textColor: context.colorScheme.scrim,
                      //   title: 'Login With Google',
                      //   borderRadius: 12.0,
                      //   onTap: () {},
                      // ).addPadding(top: 30.0, bottom: 16.0),
                      // MBouncingButton(
                      //   width: double.infinity,
                      //   color: context.colorScheme.onSurface,
                      //   buttonType: ButtonType.outline,
                      //   height: 65.0,
                      //   weight: FontWeight.w600,
                      //   textSize: FoontSize.font18,
                      //   icon:
                      //       context.isDarkTheme ? Svgs.appleWhite : Svgs.apple,
                      //   iconSize: 35.0,
                      //   textColor: context.colorScheme.scrim,
                      //   title: 'Login With Apple',
                      //   borderRadius: 12.0,
                      //   onTap: () {},
                      // ).addPadding(bottom: 30.0),
                      // MText(
                      //   text: context.tr.openNewAccount,
                      //   size: FoontSize.font16,
                      //   weight: FontWeight.w400,
                      //   color: context.colorScheme.scrim,
                      //   decoration: TextDecoration.underline,
                      // ).addAction(
                      //   onGesture: () {
                      //     context.push(
                      //       WebViewScreen(
                      //         url: Constants.SIGNUPURL,
                      //         title: context.tr.createAccount,
                      //         onNavigationRequest: (url, context) {
                      //           kPrint(url);
                      //         },
                      //       ),
                      //     );
                      //   },
                      //   padding: const MPadding.set(vertical: 12.0),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// MDropDown<String>(
//   title: 'Select Server',
//   titleColor: Coolors.black,
//   titleWeight: FontWeight.w500,
//   borderColor: Coolors.highlight2,
//   iconColor: Coolors.black,
//   textSize: FoontSize.font18,
//   borderRadius: 8.0,
//   options: const [
//     'Sky Option - Live',
//     'Sky Option - Demo',
//   ],
//   inFill: false,
//   hint: 'Sky Option - 01',
//   hintColor: Coolors.highlight2,
//   onChanged: (value) {},
//   itemTitle: (item) => item,
// ),
