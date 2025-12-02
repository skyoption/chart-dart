import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:example/core/consts/constants.dart';
import 'package:example/core/framework/app_info.dart';
import 'package:example/features/auth/data/client-services/auth_client_services.dart';
import 'package:example/unauthored.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/router/app_router.dart';
import 'package:example/core/framework/app_prefs.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:location/location.dart';
import 'injectable.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async => await getIt.init();

@module
abstract class CoreModule {
  @preResolve
  @Injectable(order: -3)
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @Injectable(order: -2)
  AppPreferences get appPreferences =>
      AppPreferences(getIt<SharedPreferences>());

  @Singleton(order: -1)
  AppRouter get appRouter => AppRouter(appPreferences);
}

@module
abstract class InjectionModule {
  @injectable
  InternetConnection get internetConnectionChecker => InternetConnection();
  @injectable
  GlobalKey<NavigatorState> get nav => getIt<AppRouter>().navigatorKey;

  @injectable
  MainContext get mainContext => MainContext(nav: nav);
  @injectable
  Location get location => Location();

  @injectable
  StreamController<bool> get stream => StreamController<bool>.broadcast();

  @injectable
  PhoneValidator get phoneValidator => PhoneValidator(stream);

  @injectable
  Validate get validate => Validate();

  @injectable
  GlobalKey<FormState> get globalKey => GlobalKey<FormState>();

  @injectable
  String get text => '';

  @injectable
  bool get boolean => false;

  @injectable
  List<String> get strings => [];

  @injectable
  List<int> get ints => [];

  @injectable
  List<File> get files => [];

  @injectable
  List<MultipartFile> get multipartFiles => [];

  @injectable
  int get intNumber => 0;

  @injectable
  double get doubleNumber => 0.0;

  @injectable
  File get file => File('');

  @injectable
  MultipartFile get multipartFile => MultipartFile.fromString('');

  @injectable
  TextEditingController get textEditingController => TextEditingController();

  @injectable
  Dio get dio =>
      Dio(
          BaseOptions(
            baseUrl: Constants.URL,
            receiveTimeout: const Duration(milliseconds: Constants.API_TIMEOUT),
            sendTimeout: const Duration(milliseconds: Constants.API_TIMEOUT),
            validateStatus: (status) {
              if (status == 401 || status == 403) {
                getIt<Unauthorized>().onUnauthorized();
              }
              return status! <= 500;
            },
          ),
        )
        ..interceptors.add(
          LogInterceptor(
            requestBody: kDebugMode,
            responseBody: kDebugMode,
            logPrint: (object) {
              if (object is String && kDebugMode) {
                log(object);
              }
            },
          ),
        )
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, interceptor) async {
              options.headers = Headers.to();
              interceptor.next(options);
            },
            onError: (e, interceptor) async {},
          ),
        );

  @injectable
  AuthClientServices get authClientServices => AuthClientServices(dio);
}

class Headers {
  static final _pref = getIt<SharedPreferences>();

  static String lng() => _pref.getString(Constants.LANG) ?? 'en';

  static String get userToken {
    final token = _pref.getString(Constants.TOKENCACHED) ?? '';
    return token;
  }

  static Map<String, dynamic> to() {
    Map<String, dynamic> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Accept-Language': lng(),
      'OsType': Platform.isAndroid ? 'android' : 'ios',
      'OsSkyVersion': AppInfo.version,
    };
    if (userToken.isNotEmpty) {
      header['Authorization'] = userToken;
      kPrint(userToken);
    }
    return header;
  }
}
