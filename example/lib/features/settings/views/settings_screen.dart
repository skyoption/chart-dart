import 'package:example/core/consts/constants.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/consts/tool_tips_config.dart';
import 'package:example/core/theme/app_themes.dart';
import 'package:example/features/main/views/widgets/trading_account_item_widget.dart';
import 'package:example/features/settings/views/widgets/settings_item_widget.dart';
import 'package:example/core/enums/user_permissions.dart';
import 'package:example/core/framework/app_cubit.dart';
import 'package:example/core/router/app_router.gr.dart';
import 'package:example/core/shared/guide_tooltip_scaffold.dart';
import 'package:example/core/shared/guide_tooltip_widget.dart';
import 'package:example/features/main/logic/connect_cubit.dart';
import 'package:example/features/main/models/connected_account_info_entity.dart';

import 'bottom_sheets/language_bottom_sheet.dart';
import 'bottom_sheets/theme_bottom_sheet.dart';

@RoutePage()
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
    return GuideTooltipScaffold(
      preferenceKey: Constants.SETTINGS_ONBOARDING_COMPLETED,
      child: Scaffold(
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
                    color: context.colorScheme.onSurface,
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
                  return GuideTooltipWidget(
                    config: SettingsTooltip.tradingAccount.config,
                    child: TradingAccountItemWidget(
                      accountInfo: value,
                      isDefault: true,
                      onDelete: () {},
                      onSwitch: () {},
                    ).addPadding(bottom: 15),
                  );
                },
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: MBorderRadius.set(all: 10.0),
                  color: context.colorScheme.surfaceContainerLow,
                  border: Border.all(
                    color: context.colorScheme.outline,
                  ),
                ),
                padding: const MPadding.set(vertical: 5),
                margin: const MPadding.set(horizontal: 21.0, bottom: 20),
                child: Column(
                  children: [
                    GuideTooltipWidget(
                      config: SettingsTooltip.switchAccount.config,
                      child: SettingsItemWidget(
                        title: context.tr.switchAccount,
                        iconName: Svgs.switchIcon,
                        iconSize: 23,
                        onTap: () {
                          context.navigateTo(SwitchAccountRoute());
                        },
                      ).addPadding(
                        horizontal: 5.0,
                      ),
                    ),
                    // Divider(color: context.colorScheme.outline),
                    // GuideTooltipWidget(
                    //   config: SettingsTooltip.addAccount.config,
                    //   child: SettingsItemWidget(
                    //     title: context.tr.addAccount,
                    //     iconName: Svgs.addAccountIcon,
                    //     iconSize: 23,
                    //     onTap: () {
                    //       context.navigateTo(
                    //           UnAuthenticatedRoutes(children: [LoginRoute()]));
                    //     },
                    //   ).addPadding(
                    //     horizontal: 5.0,
                    //   ),
                    // ),
                    if (hasPermission == true)
                      Divider(color: context.colorScheme.outline),
                    if (hasPermission == true)
                      GuideTooltipWidget(
                        config: SettingsTooltip.changePassword.config,
                        child: SettingsItemWidget(
                          title: context.tr.changePassword,
                          iconName: Svgs.lock,
                          iconSize: 23,
                          onTap: () {
                            context.navigateTo(ChangePasswordRoute());
                          },
                        ).addPadding(horizontal: 5.0),
                      ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: MBorderRadius.set(all: 10.0),
                  color: context.colorScheme.surfaceContainerLow,
                  border: Border.all(
                    color: context.colorScheme.outline,
                  ),
                ),
                margin: const MPadding.set(horizontal: 21.0),
                child: Column(
                  children: [
                    FlowBuilder<AppCubit>(
                      builder: (context, state, cubit) {
                        return GuideTooltipWidget(
                          config: SettingsTooltip.changeTheme.config,
                          child: SettingsItemWidget(
                            title: context.tr.changeTheme,
                            iconName: cubit.appThemeMode.icon,
                            iconSize: 23,
                            onTap: () {
                              showThemeBottomSheet(context: context);
                            },
                          ).addPadding(
                            horizontal: 5.0,
                          ),
                        );
                      },
                    ),
                    Divider(color: context.colorScheme.outline),
                    GuideTooltipWidget(
                      config: SettingsTooltip.language.config,
                      child: SettingsItemWidget(
                        title: context.tr.language,
                        iconName: Svgs.languageIcon,
                        iconSize: 23,
                        onTap: () {
                          showLanguageBottomSheet(context: context);
                        },
                      ).addPadding(
                        horizontal: 5.0,
                      ),
                    ),
                  ],
                ).addPadding(vertical: 5),
              ).addPadding(bottom: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: MBorderRadius.set(all: 8.0),
                  color: context.colorScheme.surfaceContainerLow,
                  border: Border.all(
                    color: context.colorScheme.outline,
                  ),
                ),
                margin: const MPadding.set(horizontal: 21.0),
                child: GuideTooltipWidget(
                  config: SettingsTooltip.tradingSettings.config,
                  child: SettingsItemWidget(
                    title: context.tr.tradingSettings,
                    iconName: Svgs.settingIcon,
                    iconSize: 23,
                    onTap: () {
                      context.navigateTo(const TradingSettingsRoute());
                    },
                  ).addPadding(
                    horizontal: 5.0,
                  ),
                ),
              ).addPadding(bottom: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: MBorderRadius.set(all: 8.0),
                  color: context.colorScheme.surfaceContainerLow,
                  border: Border.all(
                    color: context.colorScheme.outline,
                  ),
                ),
                margin: const MPadding.set(horizontal: 21.0),
                child: GuideTooltipWidget(
                  config: SettingsTooltip.logs.config,
                  child: SettingsItemWidget(
                    title: context.tr.logs,
                    iconName: Svgs.documents,
                    iconSize: 23,
                    onTap: () {
                      context.navigateTo(const LogsRoute());
                    },
                  ).addPadding(
                    horizontal: 5.0,
                  ),
                ),
              ).addPadding(bottom: 20),
              // Container(
              //   decoration: BoxDecoration(
              //     borderRadius: MBorderRadius.set(all: 8.0),
              //     color: context.colorScheme.surfaceContainerLow,
              //     border: Border.all(
              //       color: context.colorScheme.outline,
              //     ),
              //   ),
              //   margin: const MPadding.set(horizontal: 21.0),
              //   child: GuideTooltipWidget(
              //     config: SettingsTooltip.tickets.config,
              //     child: SettingsItemWidget(
              //       title: context.tr.tickets,
              //       iconName: Svgs.contactUs,
              //       iconSize: 23,
              //       onTap: () {
              //         context.navigateTo(const TicketsRoute());
              //       },
              //     ).addPadding(
              //       horizontal: 5.0,
              //     ),
              //   ),
              // ).addPadding(bottom: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: MBorderRadius.set(all: 8.0),
                  color: context.colorScheme.surfaceContainerLow,
                  border: Border.all(
                    color: context.colorScheme.outline,
                  ),
                ),
                margin: const MPadding.set(
                  horizontal: 21.0,
                ),
                child: GuideTooltipWidget(
                  config: SettingsTooltip.logout.config,
                  child: SettingsItemWidget(
                    title: context.tr.logout,
                    titleColor: context.colorScheme.error,
                    suffixIconColor: context.colorScheme.error,
                    iconName: Svgs.logoutIcon,
                    onTap: () {
                      loginCubit.logout(onLogout: () {});
                      loginCubit.clear();
                      context.replaceRoute(
                        UnAuthenticatedRoutes(children: [LoginRoute()]),
                      );
                    },
                  ).addPadding(horizontal: 5.0),
                ),
              ),
              MText(
                text: context.tr.version('3.2.1'),
                size: FoontSize.font16,
                color: context.colorScheme.onSurface,
                weight: FontWeight.w500,
              ).addPadding(top: 21.0, bottom: 100.0),
            ],
          ),
        ),
      ),
    );
  }
}
