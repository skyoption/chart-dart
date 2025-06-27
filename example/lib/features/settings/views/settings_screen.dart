import 'package:example/core/builder/flow_builder.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/enums/user_permissions.dart';
import 'package:example/core/framework/app_cubit.dart';
import 'package:example/features/auth/logic/connect_cubit.dart';
import 'package:example/features/auth/models/connected_account_info_entity.dart';
import 'package:example/features/auth/views/change_password_screen.dart';
import 'package:example/features/auth/views/login_screen.dart';
import 'package:example/features/main/views/widgets/trading_account_item_widget.dart';
import 'package:example/features/settings/views/logs_screen.dart';
import 'package:example/features/settings/views/switch_account_screen.dart';
import 'package:example/features/settings/views/trading_settings_screen.dart';
import 'package:example/features/settings/views/widgets/settings_item_widget.dart';

import 'bottom_sheets/language_bottom_sheet.dart';
import 'bottom_sheets/theme_bottom_sheet.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late ConnectCubit loginCubit = context.read<ConnectCubit>();
  late ConnectedAccountInfoEntity? accountInfo = loginCubit.accountInfo.value;

  @override
  Widget build(BuildContext context) {
    final height = context.height;
    final width = context.width;
    final hasPermission = accountInfo?.rights?.hasPermission(
      UserPermissions.changePassword,
    );
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(width, height * 0.06),
        child: Container(
          margin: const MPadding.set(horizontal: 10),
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: MText(
                  text: context.tr.settings,
                  size: FoontSize.font20,
                  color: context.colorScheme.scrim,
                  weight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
      body: MScroll(
        padding: const MPadding.set(bottom: 30.0),
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: loginCubit.accountInfo,
              builder: (context, value, child) {
                if (value == null) return SizedBox();
                accountInfo = value;
                return TradingAccountItemWidget(
                  accountInfo: value,
                  onDelete: () {},
                  onSwitch: () {},
                ).addPadding(bottom: 15);
              },
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: MBorderRadius.set(all: 10.0),
                color: context.colorScheme.primaryContainer,
                border: Border.all(
                  color: context.colorScheme.outline,
                ),
              ),
              padding: const MPadding.set(vertical: 5),
              margin: const MPadding.set(horizontal: 21.0, bottom: 20),
              child: Column(
                children: [
                  SettingsItemWidget(
                    title: context.tr.switchAccount,
                    iconName: Svgs.switchIcon,
                    iconSize: 23,
                    onTap: () {
                      context.pushNamed(SwitchAccountScreen.id);
                    },
                  ).addPadding(
                    horizontal: 5.0,
                  ),
                  Divider(color: context.colorScheme.outline),
                  SettingsItemWidget(
                    title: context.tr.addAccount,
                    iconName: Svgs.addAccountIcon,
                    iconSize: 23,
                    onTap: () {
                      context.pushNamed(LoginScreen.id);
                    },
                  ).addPadding(
                    horizontal: 5.0,
                  ),
                  if (hasPermission == true)
                    Divider(color: context.colorScheme.outline),
                  if (hasPermission == true)
                    SettingsItemWidget(
                      title: context.tr.changePassword,
                      iconName: Svgs.lock,
                      iconSize: 23,
                      onTap: () {
                        context.pushNamed(ChangePasswordScreen.id);
                      },
                    ).addPadding(horizontal: 5.0),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: MBorderRadius.set(all: 10.0),
                color: context.colorScheme.primaryContainer,
                border: Border.all(
                  color: context.colorScheme.outline,
                ),
              ),
              margin: const MPadding.set(horizontal: 21.0),
              child: Column(
                children: [
                  FlowBuilder<AppCubit>(
                    builder: (context, state, cubit) {
                      return SettingsItemWidget(
                        title: context.tr.changeTheme,
                        iconName: cubit.appThemeMode.icon,
                        iconSize: 23,
                        onTap: () {
                          showThemeBottomSheet(context: context);
                        },
                      ).addPadding(
                        horizontal: 5.0,
                      );
                    },
                  ),
                  Divider(color: context.colorScheme.outline),
                  SettingsItemWidget(
                    title: context.tr.language,
                    iconName: Svgs.languageIcon,
                    iconSize: 23,
                    onTap: () {
                      showLanguageBottomSheet(context: context);
                    },
                  ).addPadding(
                    horizontal: 5.0,
                  ),
                ],
              ).addPadding(vertical: 5),
            ).addPadding(bottom: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: MBorderRadius.set(all: 8.0),
                color: context.colorScheme.primaryContainer,
                border: Border.all(
                  color: context.colorScheme.outline,
                ),
              ),
              margin: const MPadding.set(horizontal: 21.0),
              child: SettingsItemWidget(
                title: context.tr.tradingSettings,
                iconName: Svgs.settingIcon,
                iconSize: 23,
                onTap: () {
                  context.push(const TradingSettingsScreen());
                },
              ).addPadding(
                horizontal: 5.0,
              ),
            ).addPadding(bottom: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: MBorderRadius.set(all: 8.0),
                color: context.colorScheme.primaryContainer,
                border: Border.all(
                  color: context.colorScheme.outline,
                ),
              ),
              margin: const MPadding.set(horizontal: 21.0),
              child: SettingsItemWidget(
                title: context.tr.logs,
                iconName: Svgs.documents,
                iconSize: 23,
                onTap: () {
                  context.push(const LogsScreen());
                },
              ).addPadding(
                horizontal: 5.0,
              ),
            ).addPadding(bottom: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: MBorderRadius.set(all: 8.0),
                color: context.colorScheme.primaryContainer,
                border: Border.all(
                  color: context.colorScheme.outline,
                ),
              ),
              margin: const MPadding.set(
                horizontal: 21.0,
              ),
              child: SettingsItemWidget(
                title: context.tr.logout,
                titleColor: context.colorScheme.error,
                suffixIconColor: context.colorScheme.error,
                iconName: Svgs.logoutIcon,
                onTap: () {
                  loginCubit.logout(
                    onLogout: () => context.pushNamedAndRemoveUntil(
                      LoginScreen.id,
                    ),
                  );
                },
              ).addPadding(horizontal: 5.0),
            ),
            MText(
              text: context.tr.version('3.2.1'),
              size: FoontSize.font16,
              color: context.colorScheme.onSurface,
              weight: FontWeight.w500,
            ).addPadding(vertical: 21.0),
          ],
        ),
      ),
    );
  }
}
