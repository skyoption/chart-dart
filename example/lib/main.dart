import 'dart:async';

import 'package:candle_chart/k_chart_plus.dart';
import 'package:example/core/builder/flow_builder.dart';
import 'package:example/core/consts/currency.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/app_cubit.dart';
import 'package:example/core/framework/fcm_notification.dart';
import 'package:example/core/framework/responsive.dart';
import 'package:example/features/auth/logic/connect_cubit.dart';
import 'package:example/features/chart/logic/chart_cubit.dart';
import 'package:example/features/settings/logic/platform_settings_cubit.dart';
import 'package:example/features/settings/logic/trading_logs_cubit.dart';
import 'package:example/features/splash/views/spalsh_screen.dart';
import 'package:example/features/symbols/logic/quotes_cubit.dart';
import 'package:example/features/trade/logic/open_position_cubit.dart';
import 'package:example/features/trade/logic/orders_cubit.dart';
import 'package:example/features/trade/logic/positions_cubit.dart';
import 'package:example/features/trade_history/logic/history_actions_cubit.dart';
import 'package:example/features/trade_history/logic/history_pending_cubit.dart';
import 'package:example/features/trade_history/logic/history_positions_cubit.dart';
import 'package:example/l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'app_router.dart';
import 'core/framework/firebase_analytics_service.dart';
import 'injection/injectable.dart';

late MainContext rootContext;

Future<void> main() async {
  // runZonedGuarded<Future<void>>(() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  MWidgetsSetUp.settings(
    fontEn: Fonts.en,
    fontAr: Fonts.ar,
    primary: const Color(0xff43384D),
    secondPrimary: const Color(0xff9281A2),
  );
  await configureDependencies();
  await Firebase.initializeApp();
  rootContext = getIt<MainContext>();
  await KChart.openDB();
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  //  Bloc.observer = CubitObserver();
  runApp(const SkyTrading());
  // }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

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
  final openPositionCubit = getIt<OpenPositionCubit>();
  final currencyChanged = getIt<CurrencyChanged>();

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
        BlocProvider.value(value: appLogCubit..getAllLogs()),
      ],
      child: MResponsiveWrapper(
        child: FlowBuilder<AppCubit>(
          builder: (context, state, cubit) {
            SkyTrading.isDarkTheme = cubit.appThemeMode.isDarkTheme;
            return MaterialApp(
              theme: cubit.appThemeMode.data,
              key: rootContext.scaffoldKey,
              navigatorKey: rootContext.nav,
              debugShowCheckedModeBanner: false,
              onGenerateTitle: (context) {
                SkyTrading.tr = AppLocalizations.of(context)!;
                return '';
              },
              navigatorObservers: [
                getIt<FirebaseAnalyticsService>().appAnalyticsObserver()
              ],
              builder: (context, child) {
                return MResponsiveWrapper.wrapper(
                  child: child!,
                  context: context,
                );
              },
              onGenerateRoute: (RouteSettings settings) {
                return MaterialPageRoute(
                  builder: (context) {
                    return BouncingScrollWrapper.builder(
                      context,
                      AppRouter.generatedRoute(settings),
                    );
                  },
                );
              },
              initialRoute: getInitialRoute,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
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

  String get getInitialRoute {
    return SplashScreen.id;
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
