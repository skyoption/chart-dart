import 'package:example/core/consts/exports.dart';

@RoutePage()
class SignUpScreen extends StatefulWidget {
  final Function(String user, String password)? onAddNewAccount;

  const SignUpScreen({super.key, this.onAddNewAccount});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final height = context.height;
    final width = context.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(width, height * 0.08),
        child: SafeArea(
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Icon(
              Icons.arrow_back,
              color: context.colorScheme.scrim,
              size: 30.0,
            )
                .addAction(
                  padding: const MPadding.set(vertical: 21.0, end: 21.0),
                  onGesture: () => AutoRouterX(context).pop(),
                )
                .addPadding(horizontal: 21.0),
          ),
        ),
      ),
      body: MultiBlocProvider(
        providers: [],
        child: MScroll(
          padding: const MPadding.set(horizontal: 21.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MText(
                  text: context.tr.signUp,
                  size: FoontSize.font26,
                  weight: FontWeight.w600,
                  color: context.colorScheme.onSurface,
                  align: TextAlign.start,
                ).addPadding(bottom: 12.0),
                MText(
                  text: context.tr.pleaseEnterYourInfoToSignUp,
                  size: FoontSize.font22,
                ).addPadding(bottom: 30.0),
                MTextFiled(
                  title: context.tr.fullName,
                  hintText: context.tr.fullName,
                  titleColor: context.colorScheme.onSurface,
                  hintColor: context.colorScheme.onSurface,
                  contentPadding:
                      MPadding.set(horizontal: 21.0, vertical: 14.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: context.colorScheme.outline),
                  ),
                  textSize: FoontSize.font18,
                  keyboardType: TextInputType.text,
                  validator: (valid) {
                    return Validates.isHasData(
                      minLength: 5,
                      data: '12345',
                      errorMessage: context.tr.pleaseEnterData,
                    );
                  },
                ),
                MDropDown<String>(
                  title: context.tr.classification,
                  titleColor: context.colorScheme.onSurface,
                  hintColor: context.colorScheme.onSurface,
                  borderColor: context.colorScheme.outline,
                  iconColor: context.colorScheme.onSurface,
                  titleWeight: FontWeight.w500,
                  textSize: FoontSize.font18,
                  borderRadius: 8.0,
                  options: [],
                  inFill: false,
                  hint: context.tr.classification,
                  onChanged: (value) {},
                  itemTitle: (item) => item,
                ),
                MDropDown<String>(
                  title: context.tr.leverage,
                  titleWeight: FontWeight.w500,
                  textSize: FoontSize.font18,
                  titleColor: context.colorScheme.onSurface,
                  hintColor: context.colorScheme.onSurface,
                  borderColor: context.colorScheme.outline,
                  iconColor: context.colorScheme.onSurface,
                  borderRadius: 8.0,
                  options: const [],
                  inFill: false,
                  hint: context.tr.leverage,
                  selectedItem: (item) {
                    return MText(
                      text: context.tr.leverageRatio(item ?? ""),
                      size: FoontSize.font18,
                      weight: FontWeight.w400,
                    );
                  },
                  optionItem: (item) => MText(
                    text: context.tr.leverageRatio(item ?? ""),
                    size: FoontSize.font18,
                    weight: FontWeight.w400,
                  ),
                  onChanged: (value) {},
                  itemTitle: (item) => item,
                ),
                MDropDown<String>(
                  title: context.tr.currency,
                  titleColor: context.colorScheme.onSurface,
                  hintColor: context.colorScheme.onSurface,
                  borderColor: context.colorScheme.outline,
                  iconColor: context.colorScheme.onSurface,
                  titleWeight: FontWeight.w500,
                  textSize: FoontSize.font18,
                  borderRadius: 8.0,
                  options: [],
                  inFill: false,
                  hint: context.tr.currency,
                  onChanged: (value) {},
                  itemTitle: (item) => item,
                ),
                MDropDown<String>(
                  title: context.tr.swap,
                  titleColor: context.colorScheme.onSurface,
                  hintColor: context.colorScheme.onSurface,
                  borderColor: context.colorScheme.outline,
                  iconColor: context.colorScheme.onSurface,
                  titleWeight: FontWeight.w500,
                  textSize: FoontSize.font18,
                  borderRadius: 8.0,
                  options: [],
                  inFill: false,
                  hint: context.tr.swap,
                  onChanged: (value) {},
                  itemTitle: (item) => item,
                ).addPadding(bottom: 12.0),
                MPasswordWidget(
                  unActiveSize: 18.0,
                  activeSize: 24.0,
                  activeColor: context.colorScheme.onSurface,
                  unActiveColor: context.colorScheme.onSurface,
                  child: (icon, hide) {
                    return MTextFiled(
                      title: context.tr.mainPassword,
                      hintText: context.tr.mainPassword,
                      titleColor: context.colorScheme.onSurface,
                      keyboardType: TextInputType.visiblePassword,
                      contentPadding:
                          MPadding.set(horizontal: 21.0, vertical: 14.0),
                      hintColor: context.colorScheme.outline,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide:
                            BorderSide(color: context.colorScheme.outline),
                      ),
                      textSize: FoontSize.font18,
                      suffix: icon,
                      obscureText: hide,
                      validator: (valid) {
                        return Validation.isStrongPassword(
                          password: 'p',
                          errorMessage: context.tr.passwordValidationMessage,
                        );
                      },
                    ).addPadding(bottom: 12.0);
                  },
                ),
                MPasswordWidget(
                  unActiveSize: 18.0,
                  activeSize: 24.0,
                  activeColor: context.colorScheme.onSurface,
                  unActiveColor: context.colorScheme.onSurface,
                  child: (icon, hide) {
                    return MTextFiled(
                      title: context.tr.investorPassword,
                      hintText: context.tr.investorPassword,
                      titleColor: context.colorScheme.onSurface,
                      contentPadding:
                          MPadding.set(horizontal: 21.0, vertical: 14.0),
                      keyboardType: TextInputType.visiblePassword,
                      hintColor: context.colorScheme.outline,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide:
                            BorderSide(color: context.colorScheme.outline),
                      ),
                      textSize: FoontSize.font18,
                      suffix: icon,
                      obscureText: hide,
                      validator: (valid) {
                        return Validates.isConfirmPassword(
                          password: 'p',
                          confrimPassword: 'p',
                          errorMessage: context.tr.pleaseEnterInvestorPassword,
                        );
                      },
                    ).addPadding(bottom: 21.0);
                  },
                ),
                Align(
                  alignment: AlignmentDirectional.center,
                  child: MBouncingButton(
                    height: 62.0,
                    title: context.tr.signUp,
                    borderRadius: 12.0,
                    onTap: () {
                      if (widget.onAddNewAccount != null) {
                        AutoRouterX(context).pop();
                        widget.onAddNewAccount!('', '');
                      } else {
                        context.replaceRoute(AuthenticatedRoutes());
                      }
                    },
                  ).addPadding(top: height * 0.04, bottom: 30.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MText(
                      text: context.tr.alreadyHaveAccount,
                      size: FoontSize.font18,
                      weight: FontWeight.w400,
                      color: context.colorScheme.onSurface,
                    ).addPadding(end: 8.0),
                    MText(
                      text: context.tr.logIn,
                      size: FoontSize.font20,
                      weight: FontWeight.w500,
                      color: context.colorScheme.primary,
                    ).addAction(
                      onGesture: () {
                        context.navigateTo(
                          LoginRoute(
                            onAddNewAccount: widget.onAddNewAccount,
                          ),
                        );
                      },
                      padding: const MPadding.set(vertical: 12.0),
                    ),
                  ],
                ).addPadding(bottom: 40.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
