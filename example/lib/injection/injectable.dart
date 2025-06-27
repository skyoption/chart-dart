import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:example/core/consts/constants.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/accountBox.dart';
import 'package:example/core/framework/objectBox.dart';
import 'package:example/core/framework/socket/socket.dart';
import 'package:example/features/auth/data_source/connected_account_data_source.dart';
import 'package:example/unauthored.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'injectable.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  await getIt.init();
}

@module
abstract class InjectionModule {
  @singleton
  @preResolve
  Future<AccountBox> get accountBox => AccountBox().create();

  @singleton
  ObjectBox get objectBox => ObjectBox();

  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @singleton
  Sockeet get socket => Sockeet(
      accountBox: getIt<AccountBox>(),
      objectBox: getIt<ObjectBox>(),
      sharedPreferences: getIt<SharedPreferences>());
  @singleton
  ConnectedAccountDataSource get connectedAccountDataSource =>
      ConnectedAccountDataSourceImp(getIt<Sockeet>(), getIt<AccountBox>());

  @injectable
  InternetConnection get internetConnectionChecker => InternetConnection();

  @injectable
  GlobalKey<NavigatorState> get nav => GlobalKey<NavigatorState>();

  @injectable
  TextEditingController get textEditingController => TextEditingController();

  @injectable
  ScrollController get scrollController => ScrollController();

  @injectable
  StreamController<bool> get stream => StreamController<bool>.broadcast();

  @injectable
  PhoneValidator get phoneValidator => PhoneValidator(stream);

  @injectable
  MainContext get mainContext => MainContext(nav: nav);

  @injectable
  Validate get validate => Validate();

  @injectable
  GlobalKey<FormState> get globalKey => GlobalKey<FormState>();

  @injectable
  String get text => '';

  @injectable
  bool get boolean => true;

  @injectable
  List<String> get strings => [];

  @injectable
  int get intNumber => 0;

  @injectable
  double get doubleNumber => 0.0;

  @injectable
  File get file => File('');

  @injectable
  Dio get dio => Dio(
        BaseOptions(
          baseUrl: Constants.URL,
          receiveTimeout: const Duration(milliseconds: Constants.API_TIMEOUT),
          sendTimeout: const Duration(milliseconds: Constants.API_TIMEOUT),
          validateStatus: (status) {
            if (status == 403) {
              getIt<Unauthorized>().onUnauthorized();
            }
            return status! < 500;
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
}

class Headers {
  static final _pref = getIt<SharedPreferences>();

  static String get lng => _pref.getString(Constants.LANGUAGECASHED) ?? 'ar';

  static String get userCached => _pref.getString(Constants.USERCACHED) ?? '';

  static Map<String, dynamic> to() {
    Map<String, dynamic> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'language': lng,
      'os-type': Platform.isAndroid ? 'android' : 'ios',
    };
    // if (userCached.isNotEmpty) {
    //   final user = UserModel.fromJson(jsonDecode(userCached));
    //   if (user.token.isNotEmpty) {
    //     header['Authorization'] = 'Bearer ${user.token}';
    //   }
    // }
    return header;
  }
}
