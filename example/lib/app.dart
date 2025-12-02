import 'package:candle_chart/l10n/chart_localizations.dart';
import 'package:example/core/theme/app_themes.dart';
import 'package:example/features/auth/views/logic/get_socket_servers_cubit.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/router/app_router.dart';
import 'package:example/injection/injectable.dart';
import 'package:example/l10n/app_localizations.dart';
import 'package:example/route_observer.dart';
import 'package:example/core/framework/app_cubit.dart';
import 'package:example/core/framework/fcm_notification.dart';
import 'package:example/core/framework/firebase_analytics_service.dart';
import 'package:example/core/framework/responsive.dart';
import 'package:example/features/chart/logic/chart_cubit.dart';
import 'package:example/features/main/logic/connect_cubit.dart';
import 'package:example/features/platform_settings/logic/platform_settings_cubit.dart';
import 'package:example/features/platform_settings/logic/trading_logs_cubit.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';
import 'package:example/features/trade/logic/open_position_cubit.dart';
import 'package:example/features/trade/logic/orders_cubit.dart';
import 'package:example/features/trade/logic/position_assets_lose_alert_cubit.dart';
import 'package:example/features/trade/logic/positions_cubit.dart';
import 'package:example/features/trade_history/logic/history_actions_cubit.dart';
import 'package:example/features/trade_history/logic/history_pending_cubit.dart';
import 'package:example/features/trade_history/logic/history_positions_cubit.dart';
import 'package:example/features/trade/logic/modify_position_cubit.dart';
import 'package:example/features/trade/logic/close_position_cubit.dart';
import 'package:example/features/trade/logic/modify_order_cubit.dart';
import 'main.dart';

class SkyTrading extends StatefulWidget {
  static late AppLocalizations tr;

  static late bool isDarkTheme;

  static BuildContext get context => rootContext.context;

  const SkyTrading({super.key});

  @override
  State<SkyTrading> createState() => _SkyTradingState();
}

class _SkyTradingState extends State<SkyTrading>
    with
        FCMNotificationClickMixin,
        FCMNotificationMixin,
        WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    notification.init();
    FlutterNativeSplash.remove();
    super.initState();
  }

  final appCubit = getIt<AppCubit>();
  final loginCubit = getIt<ConnectCubit>();
  final notification = getIt<FCMNotification>();
  final tradingSettingsCubit = getIt<PlatformSettingsCubit>();
  final quotesCubit = getIt<QuotesCubit>();
  final positionsCubit = getIt<PositionsCubit>();
  final historyPositionsCubit = getIt<HistoryPositionsCubit>();
  final historyActionsCubit = getIt<HistoryActionsCubit>();
  final historyPendingCubit = getIt<HistoryPendingCubit>();
  final ordersCubit = getIt<OrdersCubit>();
  final appLogCubit = getIt<TradingLogsCubit>();
  final chartCubit = getIt<ChartCubit>();
  final modifyPositionCubit = getIt<ModifyPositionCubit>();
  final closePositionCubit = getIt<ClosePositionCubit>();
  final modifyOrderCubit = getIt<ModifyOrderCubit>();
  final openPositionCubit = getIt<OpenPositionCubit>();
  final currencyChanged = getIt<CurrencyChanged>();
  final serversCubit = getIt<GetSocketServersCubit>();
  final positionAssetsLoseAlertCubit = getIt<PositionAssetsLoseAlertCubit>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: tradingSettingsCubit),
        BlocProvider.value(value: chartCubit),
        BlocProvider.value(value: appCubit),
        BlocProvider.value(value: loginCubit),
        BlocProvider.value(value: quotesCubit),
        BlocProvider.value(value: positionsCubit),
        BlocProvider.value(value: currencyChanged),
        BlocProvider.value(value: historyPositionsCubit),
        BlocProvider.value(value: openPositionCubit),
        BlocProvider.value(value: historyActionsCubit),
        BlocProvider.value(value: historyPendingCubit),
        BlocProvider.value(value: ordersCubit),
        BlocProvider.value(value: modifyPositionCubit),
        BlocProvider.value(value: closePositionCubit),
        BlocProvider.value(value: modifyOrderCubit),
        BlocProvider.value(value: positionAssetsLoseAlertCubit),
        BlocProvider.value(value: appLogCubit..getAllLogs()),
        BlocProvider.value(value: serversCubit..execute()),
      ],
      child: MResponsiveWrapper(
        child: FlowBuilder<AppCubit>(
          builder: (context, state, cubit) {
            SkyTrading.isDarkTheme = cubit.appThemeMode.isDarkTheme;
            return MaterialApp.router(
              theme: cubit.appThemeMode.data,
              key: rootContext.scaffoldKey,
              debugShowCheckedModeBanner: false,
              onGenerateTitle: (context) {
                SkyTrading.tr = AppLocalizations.of(context)!;
                return '';
              },
              routerConfig: getIt<AppRouter>().config(
                navigatorObservers: () => [
                  MyRouteObserver(),
                  AutoRouteObserver(),
                  getIt<FirebaseAnalyticsService>().appAnalyticsObserver(),
                ],
              ),
              builder: (context, child) {
                return MResponsiveWrapper.wrapper(
                  child: child!,
                  context: context,
                );
              },
              localizationsDelegates: const [
                ChartLocalizations.delegate,
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              locale: cubit.locale,
            );
          },
        ),
      ),
    );
  }

  @override
  void didChangePlatformBrightness() {
    appCubit.applyPlatformThemeMode();
    super.didChangePlatformBrightness();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void onClick(RemoteMessage message) {
    notification.onClick(message: message);
  }

  @override
  void onNotify(RemoteMessage message) {
    notification.onReceived(message: message);
  }
}
