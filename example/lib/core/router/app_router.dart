import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/app_prefs.dart';
import 'package:example/core/router/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  final AppPreferences appPreferences;

  AppRouter(this.appPreferences);

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        CustomRoute(
          page: SplashRoute.page,
          initial: true,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          duration: Duration(milliseconds: 300),
        ),
        AutoRoute(
          page: UnAuthenticatedRoutes.page,
          children: [
            CustomRoute(
              page: BoardingRoute.page,
              initial: appPreferences.isFirstStartUp,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              duration: Duration(milliseconds: 300),
            ),
            CustomRoute(
              page: LoginRoute.page,
              initial: !appPreferences.isFirstStartUp,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              duration: Duration(milliseconds: 300),
            ),
            CustomRoute(
              page: SignUpRoute.page,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              duration: Duration(milliseconds: 300),
            ),
          ],
        ),
        AutoRoute(
          page: AuthenticatedRoutes.page,
          children: [
            CustomRoute(
                page: MainRoute.page,
                initial: true,
                transitionsBuilder: TransitionsBuilders.fadeIn,
                duration: Duration(milliseconds: 300),
                children: [
                  CustomRoute(
                    page: SymbolsRoute.page,
                    maintainState: false,
                    transitionsBuilder: TransitionsBuilders.fadeIn,
                    duration: Duration(milliseconds: 300),
                  ),
                  CustomRoute(
                    page: ChartRoute.page,
                    // maintainState: false,
                    transitionsBuilder: TransitionsBuilders.fadeIn,
                    duration: Duration(milliseconds: 300),
                  ),
                  CustomRoute(
                    page: TradeRoute.page,
                    maintainState: false,
                    transitionsBuilder: TransitionsBuilders.fadeIn,
                    duration: Duration(milliseconds: 300),
                  ),
                  CustomRoute(
                    page: HistoryRoute.page,
                    maintainState: false,
                    transitionsBuilder: TransitionsBuilders.fadeIn,
                    duration: Duration(milliseconds: 300),
                  ),
                  CustomRoute(
                    page: SettingsRoute.page,
                    transitionsBuilder: TransitionsBuilders.fadeIn,
                    duration: Duration(milliseconds: 300),
                  ),
                ]),
            CustomRoute(
              page: LogsRoute.page,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              duration: Duration(milliseconds: 300),
            ),
            CustomRoute(
              page: FilterHistoryRoute.page,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              duration: Duration(milliseconds: 300),
            ),
            CustomRoute(
              page: ChangePasswordRoute.page,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              duration: Duration(milliseconds: 300),
            ),
            CustomRoute(
              page: SwitchAccountRoute.page,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              duration: Duration(milliseconds: 300),
            ),
            CustomRoute(
              page: ModifySymbolsRoute.page,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              duration: Duration(milliseconds: 300),
            ),
            CustomRoute(
              page: SymbolDetailsRoute.page,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              duration: Duration(milliseconds: 300),
            ),
            CustomRoute(
              page: SearchSymbolsRoute.page,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              duration: Duration(milliseconds: 300),
            ),
            CustomRoute(
              page: TradingSettingsRoute.page,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              duration: Duration(milliseconds: 300),
            ),
            CustomRoute(
              page: CloseByRoute.page,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              duration: Duration(milliseconds: 300),
            ),
            CustomRoute(
              page: ClosePositionRoute.page,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              duration: Duration(milliseconds: 300),
            ),
            CustomRoute(
              page: EditOrderRoute.page,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              duration: Duration(milliseconds: 300),
            ),
            CustomRoute(
              page: SwitchNewAccountRoute.page,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              duration: Duration(milliseconds: 300),
            ),
            CustomRoute(
              page: EditPositionRoute.page,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              duration: Duration(milliseconds: 300),
            ),
            CustomRoute(
              page: NewPositionRoute.page,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              duration: Duration(milliseconds: 300),
            ),
            CustomRoute(
              page: SelectSymbolRoute.page,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              duration: Duration(milliseconds: 300),
            ),
          ],
        ),
      ];
}

@RoutePage(name: "UnAuthenticatedRoutes")
class UnAuthenticated extends AutoRouter {
  const UnAuthenticated({super.key});
}

@RoutePage(name: "AuthenticatedRoutes")
class Authenticated extends AutoRouter implements AutoRouteWrapper {
  const Authenticated({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }
}
