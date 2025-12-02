import 'dart:async';

import 'package:candle_chart/k_chart_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/accountBox.dart';
import 'package:example/core/framework/app_info.dart';
import 'package:example/core/framework/orientation_helper.dart';
import 'injection/injectable.dart';

late MainContext rootContext;

Future<void> main() async {
  // runZonedGuarded<Future<void>>(() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await OrientationHelper.lockToPortrait();

  MWidgetsSetUp.settings(
    fontEn: Fonts.en,
    fontAr: Fonts.ar,
    primary: const Color(0xff43384D),
    secondPrimary: const Color(0xff9281A2),
  );
  await configureDependencies();
  await AppInfo.init();
  await Firebase.initializeApp();
  rootContext = getIt<MainContext>();
  await getIt<AccountBox>().create();
  await KChart.openDB();
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  //  Bloc.observer = CubitObserver();
  runApp(const SkyTrading());
  // }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}
