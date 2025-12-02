// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;
import 'dart:io' as _i497;

import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i161;
import 'package:location/location.dart' as _i645;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../core/base/safe_request_handler.dart' as _i591;
import '../core/consts/currency.dart' as _i196;
import '../core/consts/exports.dart' as _i975;
import '../core/framework/accountBox.dart' as _i752;
import '../core/framework/app_cubit.dart' as _i251;
import '../core/framework/app_prefs.dart' as _i280;
import '../core/framework/download.dart' as _i403;
import '../core/framework/fcm_notification.dart' as _i303;
import '../core/framework/firebase_analytics_service.dart' as _i431;
import '../core/framework/network.dart' as _i620;
import '../core/framework/objectBox.dart' as _i890;
import '../core/framework/premissions.dart' as _i493;
import '../core/framework/sharing.dart' as _i147;
import '../core/framework/socket/socket.dart' as _i149;
import '../core/router/app_router.dart' as _i877;
import '../features/auth/data/client-services/auth_client_services.dart'
    as _i96;
import '../features/auth/data/data-sources/auth_remote_data_source.dart'
    as _i518;
import '../features/auth/data/data-sources/auth_remote_data_source_impl.dart'
    as _i489;
import '../features/auth/data/repository/auth_repository_impl.dart' as _i920;
import '../features/auth/domain/repositories/auth_repository.dart' as _i869;
import '../features/auth/domain/use-cases/get_socket_servers_use_case.dart'
    as _i708;
import '../features/auth/views/logic/get_socket_servers_cubit.dart' as _i92;
import '../features/boarding/logic/boarding_cubit.dart' as _i976;
import '../features/chart/data_source/chart_data_source.dart' as _i450;
import '../features/chart/logic/chart_cubit.dart' as _i540;
import '../features/main/data_source/connected_account_data_source.dart'
    as _i443;
import '../features/main/logic/connect_cubit.dart' as _i311;
import '../features/platform_settings/data_sources/logs_data_source.dart'
    as _i919;
import '../features/platform_settings/logic/accounts_cubit.dart' as _i312;
import '../features/platform_settings/logic/platform_settings_cubit.dart'
    as _i757;
import '../features/platform_settings/logic/trading_logs_cubit.dart' as _i248;
import '../features/symbols/data_source/quotes_data_source.dart' as _i796;
import '../features/symbols/data_source/search_data_source.dart' as _i1003;
import '../features/symbols/logic/quotes_cubit.dart' as _i215;
import '../features/symbols/logic/search_cubit.dart' as _i642;
import '../features/symbols/logic/subscription_cubit.dart' as _i115;
import '../features/trade/data_sources/orders_data_source.dart' as _i803;
import '../features/trade/data_sources/positions_data_source.dart' as _i658;
import '../features/trade/logic/close_all_pending_cubit.dart' as _i919;
import '../features/trade/logic/close_all_positions_cubit.dart' as _i119;
import '../features/trade/logic/close_position_cubit.dart' as _i447;
import '../features/trade/logic/delete_order_cubit.dart' as _i990;
import '../features/trade/logic/modify_order_cubit.dart' as _i949;
import '../features/trade/logic/modify_position_cubit.dart' as _i600;
import '../features/trade/logic/open_order_cubit.dart' as _i517;
import '../features/trade/logic/open_position_cubit.dart' as _i735;
import '../features/trade/logic/orders_cubit.dart' as _i182;
import '../features/trade/logic/position_assets_lose_alert_cubit.dart' as _i809;
import '../features/trade/logic/positions_cubit.dart' as _i329;
import '../features/trade_history/data_sources/history_data_source.dart'
    as _i508;
import '../features/trade_history/logic/history_actions_cubit.dart' as _i86;
import '../features/trade_history/logic/history_pending_cubit.dart' as _i1004;
import '../features/trade_history/logic/history_positions_cubit.dart' as _i848;
import '../unauthored.dart' as _i1052;
import 'injectable.dart' as _i1027;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final coreModule = _$CoreModule();
    final injectionModule = _$InjectionModule();
    await gh.factoryAsync<_i975.SharedPreferences>(
      () => coreModule.prefs,
      preResolve: true,
    );
    gh.factory<_i280.AppPreferences>(() => coreModule.appPreferences);
    gh.singleton<_i877.AppRouter>(() => coreModule.appRouter);
    gh.factory<_i431.FirebaseAnalyticsService>(
      () => _i431.FirebaseAnalyticsService(),
    );
    gh.factory<_i147.Sharing>(() => _i147.Sharing());
    gh.factory<_i161.InternetConnection>(
      () => injectionModule.internetConnectionChecker,
    );
    gh.factory<_i975.GlobalKey<_i975.NavigatorState>>(
      () => injectionModule.nav,
    );
    gh.factory<_i975.MainContext>(() => injectionModule.mainContext);
    gh.factory<_i645.Location>(() => injectionModule.location);
    gh.factory<_i687.StreamController<bool>>(() => injectionModule.stream);
    gh.factory<_i975.PhoneValidator>(() => injectionModule.phoneValidator);
    gh.factory<_i975.Validate>(() => injectionModule.validate);
    gh.factory<_i975.GlobalKey<_i975.FormState>>(
      () => injectionModule.globalKey,
    );
    gh.factory<String>(() => injectionModule.text);
    gh.factory<bool>(() => injectionModule.boolean);
    gh.factory<List<String>>(() => injectionModule.strings);
    gh.factory<List<int>>(() => injectionModule.ints);
    gh.factory<List<_i497.File>>(() => injectionModule.files);
    gh.factory<List<_i361.MultipartFile>>(() => injectionModule.multipartFiles);
    gh.factory<int>(() => injectionModule.intNumber);
    gh.factory<double>(() => injectionModule.doubleNumber);
    gh.factory<_i497.File>(() => injectionModule.file);
    gh.factory<_i361.MultipartFile>(() => injectionModule.multipartFile);
    gh.factory<_i975.TextEditingController>(
      () => injectionModule.textEditingController,
    );
    gh.factory<_i361.Dio>(() => injectionModule.dio);
    gh.factory<_i96.AuthClientServices>(
      () => injectionModule.authClientServices,
    );
    gh.singleton<_i752.AccountBox>(() => _i752.AccountBox());
    gh.singleton<_i890.ObjectBox>(() => _i890.ObjectBox());
    gh.factory<_i1052.Unauthorized>(() => _i1052.UnauthorizedImp());
    gh.singleton<_i251.AppCubit>(
      () => _i251.AppCubit(gh<_i280.AppPreferences>()),
    );
    gh.singleton<_i757.PlatformSettingsCubit>(
      () => _i757.PlatformSettingsCubit(gh<_i280.AppPreferences>()),
    );
    gh.lazySingleton<_i149.Sockeet>(
      () => _i149.Sockeet(
        accountBox: gh<_i752.AccountBox>(),
        objectBox: gh<_i890.ObjectBox>(),
        sharedPreferences: gh<_i460.SharedPreferences>(),
      ),
    );
    gh.factory<_i658.PositionsDataSource>(
      () => _i658.PositionsDataSourceImp(
        gh<_i149.Sockeet>(),
        gh<_i890.ObjectBox>(),
        gh<_i752.AccountBox>(),
      ),
    );
    gh.factory<_i119.CloseAllPositionsCubit>(
      () => _i119.CloseAllPositionsCubit(gh<_i658.PositionsDataSource>()),
    );
    gh.factory<_i796.QuotesDataSource>(
      () =>
          _i796.QuotesDataSourceImp(gh<_i149.Sockeet>(), gh<_i890.ObjectBox>()),
    );
    gh.factory<_i508.HistoryDataSource>(
      () => _i508.HistoryDataSourceImp(
        gh<_i149.Sockeet>(),
        gh<_i890.ObjectBox>(),
      ),
    );
    gh.lazySingleton<_i303.FCMNotification>(() => _i303.FCMNotificationImpl());
    gh.factory<_i1003.SearchDataSource>(
      () => _i1003.SearchDataSourceImp(
        gh<_i149.Sockeet>(),
        gh<_i890.ObjectBox>(),
      ),
    );
    gh.lazySingleton<_i493.Permissions>(
      () => _i493.PermissionsInfo(location: gh<_i645.Location>()),
    );
    gh.singleton<_i809.PositionAssetsLoseAlertCubit>(
      () => _i809.PositionAssetsLoseAlertCubit(gh<_i658.PositionsDataSource>()),
    );
    gh.factory<_i642.SearchCubit>(
      () => _i642.SearchCubit(gh<_i1003.SearchDataSource>()),
    );
    gh.factory<_i115.SubscriptionCubit>(
      () => _i115.SubscriptionCubit(gh<_i1003.SearchDataSource>()),
    );
    gh.factory<_i447.ClosePositionCubit>(
      () => _i447.ClosePositionCubit(
        gh<_i658.PositionsDataSource>(),
        gh<_i757.PlatformSettingsCubit>(),
      ),
    );
    gh.factory<_i600.ModifyPositionCubit>(
      () => _i600.ModifyPositionCubit(
        gh<_i658.PositionsDataSource>(),
        gh<_i757.PlatformSettingsCubit>(),
      ),
    );
    gh.factory<_i735.OpenPositionCubit>(
      () => _i735.OpenPositionCubit(
        gh<_i658.PositionsDataSource>(),
        gh<_i757.PlatformSettingsCubit>(),
      ),
    );
    gh.factory<_i443.ConnectedAccountDataSource>(
      () => _i443.ConnectedAccountDataSourceImp(
        gh<_i149.Sockeet>(),
        gh<_i752.AccountBox>(),
      ),
    );
    gh.lazySingleton<_i196.Currency>(
      () => _i196.CurrencyImp(gh<_i975.SharedPreferences>()),
    );
    gh.factory<_i919.LogsDataSource>(
      () => _i919.LogsDataSourceImpl(gh<_i752.AccountBox>()),
    );
    gh.factory<_i976.BoardingCubit>(
      () => _i976.BoardingCubit(
        gh<_i280.AppPreferences>(),
        gh<_i877.AppRouter>(),
      ),
    );
    gh.factory<_i620.NetworkInfo>(
      () => _i620.NetworkInfoImpl(gh<_i161.InternetConnection>()),
    );
    gh.singleton<_i248.TradingLogsCubit>(
      () => _i248.TradingLogsCubit(gh<_i919.LogsDataSource>()),
    );
    gh.factory<_i803.OrdersDataSource>(
      () =>
          _i803.OrdersDataSourceImp(gh<_i149.Sockeet>(), gh<_i890.ObjectBox>()),
    );
    gh.lazySingleton<_i450.ChartDataSource>(
      () =>
          _i450.QuotesDataSourceImp(gh<_i149.Sockeet>(), gh<_i890.ObjectBox>()),
    );
    gh.factory<_i403.Download>(
      () => _i403.Download(permissions: gh<_i493.Permissions>()),
    );
    gh.singleton<_i311.ConnectCubit>(
      () => _i311.ConnectCubit(
        gh<_i443.ConnectedAccountDataSource>(),
        gh<_i975.TextEditingController>(),
        password: gh<_i975.TextEditingController>(),
        loginFormKey: gh<_i975.GlobalKey<_i975.FormState>>(),
      ),
    );
    gh.lazySingleton<_i196.CurrencyChanged>(
      () => _i196.CurrencyChanged(gh<_i196.Currency>()),
    );
    gh.factory<_i86.HistoryActionsCubit>(
      () => _i86.HistoryActionsCubit(gh<_i508.HistoryDataSource>()),
    );
    gh.factory<_i1004.HistoryPendingCubit>(
      () => _i1004.HistoryPendingCubit(gh<_i508.HistoryDataSource>()),
    );
    gh.factory<_i848.HistoryPositionsCubit>(
      () => _i848.HistoryPositionsCubit(gh<_i508.HistoryDataSource>()),
    );
    gh.factory<_i591.SafeApi>(() => _i591.SafeApi(gh<_i620.NetworkInfo>()));
    gh.factory<_i990.DeleteOrderCubit>(
      () => _i990.DeleteOrderCubit(
        gh<_i803.OrdersDataSource>(),
        gh<_i757.PlatformSettingsCubit>(),
      ),
    );
    gh.factory<_i949.ModifyOrderCubit>(
      () => _i949.ModifyOrderCubit(
        gh<_i803.OrdersDataSource>(),
        gh<_i757.PlatformSettingsCubit>(),
      ),
    );
    gh.factory<_i517.OpenOrderCubit>(
      () => _i517.OpenOrderCubit(
        gh<_i803.OrdersDataSource>(),
        gh<_i757.PlatformSettingsCubit>(),
      ),
    );
    gh.factory<_i312.AccountsCubit>(
      () => _i312.AccountsCubit(gh<_i443.ConnectedAccountDataSource>()),
    );
    gh.lazySingleton<_i540.ChartCubit>(
      () => _i540.ChartCubit(gh<_i450.ChartDataSource>()),
    );
    gh.factory<_i919.CloseAllPendingCubit>(
      () => _i919.CloseAllPendingCubit(gh<_i803.OrdersDataSource>()),
    );
    gh.factory<_i182.OrdersCubit>(
      () => _i182.OrdersCubit(gh<_i803.OrdersDataSource>()),
    );
    gh.factory<_i518.AuthRemoteDataSource>(
      () => _i489.AuthRemoteDataSourceImplement(
        gh<_i96.AuthClientServices>(),
        gh<_i591.SafeApi>(),
      ),
    );
    gh.factory<_i869.AuthRepository>(
      () => _i920.AuthRepositoryImplement(gh<_i518.AuthRemoteDataSource>()),
    );
    gh.factory<_i708.GetSocketServersUseCase>(
      () => _i708.GetSocketServersUseCase(gh<_i869.AuthRepository>()),
    );
    gh.singleton<_i215.QuotesCubit>(
      () => _i215.QuotesCubit(
        gh<_i796.QuotesDataSource>(),
        gh<_i450.ChartDataSource>(),
        gh<_i540.ChartCubit>(),
      ),
    );
    gh.factory<_i92.GetSocketServersCubit>(
      () => _i92.GetSocketServersCubit(gh<_i708.GetSocketServersUseCase>()),
    );
    gh.factory<_i329.PositionsCubit>(
      () => _i329.PositionsCubit(
        gh<_i658.PositionsDataSource>(),
        gh<_i443.ConnectedAccountDataSource>(),
        gh<_i215.QuotesCubit>(),
        gh<_i311.ConnectCubit>(),
        gh<_i809.PositionAssetsLoseAlertCubit>(),
      ),
    );
    return this;
  }
}

class _$CoreModule extends _i1027.CoreModule {}

class _$InjectionModule extends _i1027.InjectionModule {}
