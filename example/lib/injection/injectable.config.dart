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
import 'package:example/core/base/safe_request_handler.dart' as _i209;
import 'package:example/core/consts/currency.dart' as _i108;
import 'package:example/core/consts/exports.dart' as _i710;
import 'package:example/core/framework/accountBox.dart' as _i104;
import 'package:example/core/framework/app_cubit.dart' as _i783;
import 'package:example/core/framework/app_prefs.dart' as _i767;
import 'package:example/core/framework/fcm_notification.dart' as _i409;
import 'package:example/core/framework/filepath.dart' as _i447;
import 'package:example/core/framework/firebase_analytics_service.dart'
    as _i189;
import 'package:example/core/framework/network.dart' as _i125;
import 'package:example/core/framework/objectBox.dart' as _i918;
import 'package:example/core/framework/socket/socket.dart' as _i810;
import 'package:example/features/auth/data_source/connected_account_data_source.dart'
    as _i519;
import 'package:example/features/auth/logic/connect_cubit.dart' as _i844;
import 'package:example/features/boarding/logic/boarding_cubit.dart' as _i86;
import 'package:example/features/chart/data_source/chart_data_source.dart'
    as _i374;
import 'package:example/features/chart/logic/chart_cubit.dart' as _i466;
import 'package:example/features/main/logic/bottom_nav_cubit.dart' as _i356;
import 'package:example/features/main/logic/main_cubit.dart' as _i542;
import 'package:example/features/settings/data_sources/logs_data_source.dart'
    as _i419;
import 'package:example/features/settings/logic/accounts_cubit.dart' as _i60;
import 'package:example/features/settings/logic/platform_settings_cubit.dart'
    as _i778;
import 'package:example/features/settings/logic/trading_logs_cubit.dart'
    as _i1073;
import 'package:example/features/symbols/data_source/quotes_data_source.dart'
    as _i707;
import 'package:example/features/symbols/data_source/search_data_source.dart'
    as _i189;
import 'package:example/features/symbols/logic/quotes_cubit.dart' as _i243;
import 'package:example/features/symbols/logic/search_cubit.dart' as _i1039;
import 'package:example/features/symbols/logic/subscription_cubit.dart'
    as _i749;
import 'package:example/features/trade/data_sources/orders_data_source.dart'
    as _i889;
import 'package:example/features/trade/data_sources/positions_data_source.dart'
    as _i254;
import 'package:example/features/trade/logic/close_all_pending_cubit.dart'
    as _i74;
import 'package:example/features/trade/logic/close_all_positions_cubit.dart'
    as _i941;
import 'package:example/features/trade/logic/close_position_cubit.dart'
    as _i243;
import 'package:example/features/trade/logic/delete_order_cubit.dart' as _i1013;
import 'package:example/features/trade/logic/modify_order_cubit.dart' as _i544;
import 'package:example/features/trade/logic/modify_position_cubit.dart'
    as _i71;
import 'package:example/features/trade/logic/open_order_cubit.dart' as _i342;
import 'package:example/features/trade/logic/open_position_cubit.dart' as _i544;
import 'package:example/features/trade/logic/orders_cubit.dart' as _i67;
import 'package:example/features/trade/logic/positions_cubit.dart' as _i996;
import 'package:example/features/trade_history/data_sources/history_data_source.dart'
    as _i641;
import 'package:example/features/trade_history/logic/history_actions_cubit.dart'
    as _i214;
import 'package:example/features/trade_history/logic/history_pending_cubit.dart'
    as _i89;
import 'package:example/features/trade_history/logic/history_positions_cubit.dart'
    as _i1012;
import 'package:example/injection/injectable.dart' as _i593;
import 'package:example/unauthored.dart' as _i1062;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i161;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectionModule = _$InjectionModule();
    gh.factory<_i447.FilePath>(() => _i447.FilePath());
    gh.factory<_i189.FirebaseAnalyticsService>(
        () => _i189.FirebaseAnalyticsService());
    gh.factory<_i86.BoardingCubit>(() => _i86.BoardingCubit());
    gh.factory<_i356.BottomNavCubit>(() => _i356.BottomNavCubit());
    gh.factory<_i542.MainCubit>(() => _i542.MainCubit());
    await gh.factoryAsync<_i710.SharedPreferences>(
      () => injectionModule.prefs,
      preResolve: true,
    );
    gh.factory<_i161.InternetConnection>(
        () => injectionModule.internetConnectionChecker);
    gh.factory<_i710.GlobalKey<_i710.NavigatorState>>(
        () => injectionModule.nav);
    gh.factory<_i710.TextEditingController>(
        () => injectionModule.textEditingController);
    gh.factory<_i710.ScrollController>(() => injectionModule.scrollController);
    gh.factory<_i687.StreamController<bool>>(() => injectionModule.stream);
    gh.factory<_i710.PhoneValidator>(() => injectionModule.phoneValidator);
    gh.factory<_i710.MainContext>(() => injectionModule.mainContext);
    gh.factory<_i710.Validate>(() => injectionModule.validate);
    gh.factory<_i710.GlobalKey<_i710.FormState>>(
        () => injectionModule.globalKey);
    gh.factory<String>(() => injectionModule.text);
    gh.factory<bool>(() => injectionModule.boolean);
    gh.factory<List<String>>(() => injectionModule.strings);
    gh.factory<int>(() => injectionModule.intNumber);
    gh.factory<double>(() => injectionModule.doubleNumber);
    gh.factory<_i497.File>(() => injectionModule.file);
    gh.factory<_i361.Dio>(() => injectionModule.dio);
    await gh.singletonAsync<_i104.AccountBox>(
      () => injectionModule.accountBox,
      preResolve: true,
    );
    gh.singleton<_i918.ObjectBox>(() => injectionModule.objectBox);
    gh.singleton<_i810.Sockeet>(() => injectionModule.socket);
    gh.singleton<_i519.ConnectedAccountDataSource>(
        () => injectionModule.connectedAccountDataSource);
    gh.factory<_i889.OrdersDataSource>(() => _i889.OrdersDataSourceImp(
          gh<_i810.Sockeet>(),
          gh<_i918.ObjectBox>(),
        ));
    gh.factory<_i1062.Unauthorized>(() => _i1062.UnauthorizedImp());
    gh.lazySingleton<_i374.ChartDataSource>(() => _i374.QuotesDataSourceImp(
          gh<_i810.Sockeet>(),
          gh<_i918.ObjectBox>(),
        ));
    gh.factory<_i254.PositionsDataSource>(() => _i254.PositionsDataSourceImp(
          gh<_i810.Sockeet>(),
          gh<_i918.ObjectBox>(),
          gh<_i104.AccountBox>(),
        ));
    gh.factory<_i941.CloseAllPositionsCubit>(
        () => _i941.CloseAllPositionsCubit(gh<_i254.PositionsDataSource>()));
    gh.factory<_i707.QuotesDataSource>(() => _i707.QuotesDataSourceImp(
          gh<_i810.Sockeet>(),
          gh<_i918.ObjectBox>(),
        ));
    gh.factory<_i641.HistoryDataSource>(() => _i641.HistoryDataSourceImp(
          gh<_i810.Sockeet>(),
          gh<_i918.ObjectBox>(),
        ));
    gh.lazySingleton<_i409.FCMNotification>(() => _i409.FCMNotificationImpl());
    gh.factory<_i189.SearchDataSource>(() => _i189.SearchDataSourceImp(
          gh<_i810.Sockeet>(),
          gh<_i918.ObjectBox>(),
        ));
    gh.factory<_i419.LogsDataSource>(
        () => _i419.LogsDataSourceImpl(gh<_i104.AccountBox>()));
    gh.lazySingleton<_i466.ChartCubit>(
        () => _i466.ChartCubit(gh<_i374.ChartDataSource>()));
    gh.factory<_i74.CloseAllPendingCubit>(
        () => _i74.CloseAllPendingCubit(gh<_i889.OrdersDataSource>()));
    gh.factory<_i67.OrdersCubit>(
        () => _i67.OrdersCubit(gh<_i889.OrdersDataSource>()));
    gh.factory<_i1039.SearchCubit>(
        () => _i1039.SearchCubit(gh<_i189.SearchDataSource>()));
    gh.factory<_i749.SubscriptionCubit>(
        () => _i749.SubscriptionCubit(gh<_i189.SearchDataSource>()));
    gh.singleton<_i844.ConnectCubit>(() => _i844.ConnectCubit(
          gh<_i710.GlobalKey<_i710.FormState>>(),
          gh<_i710.TextEditingController>(),
          gh<_i710.TextEditingController>(),
          gh<_i519.ConnectedAccountDataSource>(),
        ));
    gh.factory<_i60.AccountsCubit>(
        () => _i60.AccountsCubit(gh<_i519.ConnectedAccountDataSource>()));
    gh.factory<_i108.Currency>(
        () => _i108.CurrencyImp(gh<_i710.SharedPreferences>()));
    gh.factory<_i125.NetworkInfo>(
        () => _i125.NetworkInfoImpl(gh<_i161.InternetConnection>()));
    gh.factory<_i767.AppPreferences>(
        () => _i767.AppPreferences(gh<_i710.SharedPreferences>()));
    gh.singleton<_i783.AppCubit>(
        () => _i783.AppCubit(gh<_i767.AppPreferences>()));
    gh.singleton<_i778.PlatformSettingsCubit>(
        () => _i778.PlatformSettingsCubit(gh<_i767.AppPreferences>()));
    gh.singleton<_i1073.TradingLogsCubit>(
        () => _i1073.TradingLogsCubit(gh<_i419.LogsDataSource>()));
    gh.factory<_i1013.DeleteOrderCubit>(() => _i1013.DeleteOrderCubit(
          gh<_i889.OrdersDataSource>(),
          gh<_i778.PlatformSettingsCubit>(),
        ));
    gh.factory<_i544.ModifyOrderCubit>(() => _i544.ModifyOrderCubit(
          gh<_i889.OrdersDataSource>(),
          gh<_i778.PlatformSettingsCubit>(),
        ));
    gh.factory<_i342.OpenOrderCubit>(() => _i342.OpenOrderCubit(
          gh<_i889.OrdersDataSource>(),
          gh<_i778.PlatformSettingsCubit>(),
        ));
    gh.factory<_i214.HistoryActionsCubit>(
        () => _i214.HistoryActionsCubit(gh<_i641.HistoryDataSource>()));
    gh.factory<_i89.HistoryPendingCubit>(
        () => _i89.HistoryPendingCubit(gh<_i641.HistoryDataSource>()));
    gh.factory<_i1012.HistoryPositionsCubit>(
        () => _i1012.HistoryPositionsCubit(gh<_i641.HistoryDataSource>()));
    gh.singleton<_i243.QuotesCubit>(() => _i243.QuotesCubit(
          gh<_i707.QuotesDataSource>(),
          gh<_i374.ChartDataSource>(),
          gh<_i466.ChartCubit>(),
        ));
    gh.factory<_i209.SafeApi>(() => _i209.SafeApi(gh<_i125.NetworkInfo>()));
    gh.factory<_i996.PositionsCubit>(() => _i996.PositionsCubit(
          gh<_i254.PositionsDataSource>(),
          gh<_i844.ConnectCubit>(),
          gh<_i519.ConnectedAccountDataSource>(),
        ));
    gh.factory<_i108.CurrencyChanged>(
        () => _i108.CurrencyChanged(gh<_i108.Currency>()));
    gh.factory<_i243.ClosePositionCubit>(() => _i243.ClosePositionCubit(
          gh<_i254.PositionsDataSource>(),
          gh<_i778.PlatformSettingsCubit>(),
        ));
    gh.factory<_i71.ModifyPositionCubit>(() => _i71.ModifyPositionCubit(
          gh<_i254.PositionsDataSource>(),
          gh<_i778.PlatformSettingsCubit>(),
        ));
    gh.factory<_i544.OpenPositionCubit>(() => _i544.OpenPositionCubit(
          gh<_i254.PositionsDataSource>(),
          gh<_i778.PlatformSettingsCubit>(),
        ));
    return this;
  }
}

class _$InjectionModule extends _i593.InjectionModule {}
