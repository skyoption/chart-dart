// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i29;
import 'package:example/core/consts/exports.dart' as _i30;
import 'package:example/core/router/app_router.dart' as _i1;
import 'package:example/core/shared/time_filter_screen.dart' as _i25;
import 'package:example/core/shared/webview_screen.dart' as _i28;
import 'package:example/features/auth/views/change_password_screen.dart' as _i3;
import 'package:example/features/auth/views/login_screen.dart' as _i11;
import 'package:example/features/auth/views/sign_up_screen.dart' as _i19;
import 'package:example/features/boarding/views/boarding_screen.dart' as _i2;
import 'package:example/features/chart/views/chart_screen.dart' as _i4;
import 'package:example/features/main/views/main_screen.dart' as _i13;
import 'package:example/features/settings/views/logs_screen.dart' as _i12;
import 'package:example/features/settings/views/settings_screen.dart' as _i18;
import 'package:example/features/settings/views/switch_account_screen.dart'
    as _i21;
import 'package:example/features/settings/views/switch_new_account_screen.dart'
    as _i22;
import 'package:example/features/settings/views/trading_settings_screen.dart'
    as _i27;
import 'package:example/features/splash/views/spalsh_screen.dart' as _i20;
import 'package:example/features/symbols/models/symbol_entity.dart' as _i31;
import 'package:example/features/symbols/views/modify_symbols_screen.dart'
    as _i14;
import 'package:example/features/symbols/views/search_symbols_screen.dart'
    as _i16;
import 'package:example/features/symbols/views/symbol_details_screen.dart'
    as _i23;
import 'package:example/features/symbols/views/symbols_screen.dart' as _i24;
import 'package:example/features/trade/models/order_entity.dart' as _i33;
import 'package:example/features/trade/models/position_entity.dart' as _i32;
import 'package:example/features/trade/views/close_by_screen.dart' as _i5;
import 'package:example/features/trade/views/close_position_screen.dart' as _i6;
import 'package:example/features/trade/views/edit_order_screen.dart' as _i7;
import 'package:example/features/trade/views/edit_position_screen.dart' as _i8;
import 'package:example/features/trade/views/new_position_screen.dart' as _i15;
import 'package:example/features/trade/views/trade_screen.dart' as _i26;
import 'package:example/features/trade_history/models/filters.dart' as _i34;
import 'package:example/features/trade_history/views/filter_history_screen.dart'
    as _i9;
import 'package:example/features/trade_history/views/history_screen.dart'
    as _i10;
import 'package:example/features/trade_history/views/select_symbol_screen.dart'
    as _i17;

/// generated route for
/// [_i1.Authenticated]
class AuthenticatedRoutes extends _i29.PageRouteInfo<void> {
  const AuthenticatedRoutes({List<_i29.PageRouteInfo>? children})
    : super(AuthenticatedRoutes.name, initialChildren: children);

  static const String name = 'AuthenticatedRoutes';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return _i29.WrappedRoute(child: const _i1.Authenticated());
    },
  );
}

/// generated route for
/// [_i2.BoardingScreen]
class BoardingRoute extends _i29.PageRouteInfo<void> {
  const BoardingRoute({List<_i29.PageRouteInfo>? children})
    : super(BoardingRoute.name, initialChildren: children);

  static const String name = 'BoardingRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i2.BoardingScreen();
    },
  );
}

/// generated route for
/// [_i3.ChangePasswordScreen]
class ChangePasswordRoute extends _i29.PageRouteInfo<void> {
  const ChangePasswordRoute({List<_i29.PageRouteInfo>? children})
    : super(ChangePasswordRoute.name, initialChildren: children);

  static const String name = 'ChangePasswordRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i3.ChangePasswordScreen();
    },
  );
}

/// generated route for
/// [_i4.ChartScreen]
class ChartRoute extends _i29.PageRouteInfo<ChartRouteArgs> {
  ChartRoute({
    _i30.Key? key,
    required _i30.ValueNotifier<bool> isFullscreen,
    _i31.SymbolEntity? currentSymbol,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         ChartRoute.name,
         args: ChartRouteArgs(
           key: key,
           isFullscreen: isFullscreen,
           currentSymbol: currentSymbol,
         ),
         initialChildren: children,
       );

  static const String name = 'ChartRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChartRouteArgs>();
      return _i4.ChartScreen(
        key: args.key,
        isFullscreen: args.isFullscreen,
        currentSymbol: args.currentSymbol,
      );
    },
  );
}

class ChartRouteArgs {
  const ChartRouteArgs({
    this.key,
    required this.isFullscreen,
    this.currentSymbol,
  });

  final _i30.Key? key;

  final _i30.ValueNotifier<bool> isFullscreen;

  final _i31.SymbolEntity? currentSymbol;

  @override
  String toString() {
    return 'ChartRouteArgs{key: $key, isFullscreen: $isFullscreen, currentSymbol: $currentSymbol}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ChartRouteArgs) return false;
    return key == other.key &&
        isFullscreen == other.isFullscreen &&
        currentSymbol == other.currentSymbol;
  }

  @override
  int get hashCode =>
      key.hashCode ^ isFullscreen.hashCode ^ currentSymbol.hashCode;
}

/// generated route for
/// [_i5.CloseByScreen]
class CloseByRoute extends _i29.PageRouteInfo<void> {
  const CloseByRoute({List<_i29.PageRouteInfo>? children})
    : super(CloseByRoute.name, initialChildren: children);

  static const String name = 'CloseByRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i5.CloseByScreen();
    },
  );
}

/// generated route for
/// [_i6.ClosePositionScreen]
class ClosePositionRoute extends _i29.PageRouteInfo<ClosePositionRouteArgs> {
  ClosePositionRoute({
    _i30.Key? key,
    required _i32.PositionEntity position,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         ClosePositionRoute.name,
         args: ClosePositionRouteArgs(key: key, position: position),
         initialChildren: children,
       );

  static const String name = 'ClosePositionRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ClosePositionRouteArgs>();
      return _i6.ClosePositionScreen(key: args.key, position: args.position);
    },
  );
}

class ClosePositionRouteArgs {
  const ClosePositionRouteArgs({this.key, required this.position});

  final _i30.Key? key;

  final _i32.PositionEntity position;

  @override
  String toString() {
    return 'ClosePositionRouteArgs{key: $key, position: $position}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ClosePositionRouteArgs) return false;
    return key == other.key && position == other.position;
  }

  @override
  int get hashCode => key.hashCode ^ position.hashCode;
}

/// generated route for
/// [_i7.EditOrderScreen]
class EditOrderRoute extends _i29.PageRouteInfo<EditOrderRouteArgs> {
  EditOrderRoute({
    _i30.Key? key,
    required _i33.OrderEntity item,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         EditOrderRoute.name,
         args: EditOrderRouteArgs(key: key, item: item),
         initialChildren: children,
       );

  static const String name = 'EditOrderRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditOrderRouteArgs>();
      return _i7.EditOrderScreen(key: args.key, item: args.item);
    },
  );
}

class EditOrderRouteArgs {
  const EditOrderRouteArgs({this.key, required this.item});

  final _i30.Key? key;

  final _i33.OrderEntity item;

  @override
  String toString() {
    return 'EditOrderRouteArgs{key: $key, item: $item}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EditOrderRouteArgs) return false;
    return key == other.key && item == other.item;
  }

  @override
  int get hashCode => key.hashCode ^ item.hashCode;
}

/// generated route for
/// [_i8.EditPositionScreen]
class EditPositionRoute extends _i29.PageRouteInfo<EditPositionRouteArgs> {
  EditPositionRoute({
    _i30.Key? key,
    required _i32.PositionEntity position,
    Function? onSuccess,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         EditPositionRoute.name,
         args: EditPositionRouteArgs(
           key: key,
           position: position,
           onSuccess: onSuccess,
         ),
         initialChildren: children,
       );

  static const String name = 'EditPositionRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditPositionRouteArgs>();
      return _i8.EditPositionScreen(
        key: args.key,
        position: args.position,
        onSuccess: args.onSuccess,
      );
    },
  );
}

class EditPositionRouteArgs {
  const EditPositionRouteArgs({
    this.key,
    required this.position,
    this.onSuccess,
  });

  final _i30.Key? key;

  final _i32.PositionEntity position;

  final Function? onSuccess;

  @override
  String toString() {
    return 'EditPositionRouteArgs{key: $key, position: $position, onSuccess: $onSuccess}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EditPositionRouteArgs) return false;
    return key == other.key &&
        position == other.position &&
        onSuccess == other.onSuccess;
  }

  @override
  int get hashCode => key.hashCode ^ position.hashCode ^ onSuccess.hashCode;
}

/// generated route for
/// [_i9.FilterHistoryScreen]
class FilterHistoryRoute extends _i29.PageRouteInfo<FilterHistoryRouteArgs> {
  FilterHistoryRoute({
    _i30.Key? key,
    required dynamic Function(String, int, int) onPick,
    String? type,
    int? customFrom,
    int? customTo,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         FilterHistoryRoute.name,
         args: FilterHistoryRouteArgs(
           key: key,
           onPick: onPick,
           type: type,
           customFrom: customFrom,
           customTo: customTo,
         ),
         initialChildren: children,
       );

  static const String name = 'FilterHistoryRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FilterHistoryRouteArgs>();
      return _i9.FilterHistoryScreen(
        key: args.key,
        onPick: args.onPick,
        type: args.type,
        customFrom: args.customFrom,
        customTo: args.customTo,
      );
    },
  );
}

class FilterHistoryRouteArgs {
  const FilterHistoryRouteArgs({
    this.key,
    required this.onPick,
    this.type,
    this.customFrom,
    this.customTo,
  });

  final _i30.Key? key;

  final dynamic Function(String, int, int) onPick;

  final String? type;

  final int? customFrom;

  final int? customTo;

  @override
  String toString() {
    return 'FilterHistoryRouteArgs{key: $key, onPick: $onPick, type: $type, customFrom: $customFrom, customTo: $customTo}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! FilterHistoryRouteArgs) return false;
    return key == other.key &&
        type == other.type &&
        customFrom == other.customFrom &&
        customTo == other.customTo;
  }

  @override
  int get hashCode =>
      key.hashCode ^ type.hashCode ^ customFrom.hashCode ^ customTo.hashCode;
}

/// generated route for
/// [_i10.HistoryScreen]
class HistoryRoute extends _i29.PageRouteInfo<void> {
  const HistoryRoute({List<_i29.PageRouteInfo>? children})
    : super(HistoryRoute.name, initialChildren: children);

  static const String name = 'HistoryRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i10.HistoryScreen();
    },
  );
}

/// generated route for
/// [_i11.LoginScreen]
class LoginRoute extends _i29.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i30.Key? key,
    dynamic Function(String, String)? onAddNewAccount,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         LoginRoute.name,
         args: LoginRouteArgs(key: key, onAddNewAccount: onAddNewAccount),
         initialChildren: children,
       );

  static const String name = 'LoginRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginRouteArgs>(
        orElse: () => const LoginRouteArgs(),
      );
      return _i11.LoginScreen(
        key: args.key,
        onAddNewAccount: args.onAddNewAccount,
      );
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key, this.onAddNewAccount});

  final _i30.Key? key;

  final dynamic Function(String, String)? onAddNewAccount;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onAddNewAccount: $onAddNewAccount}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! LoginRouteArgs) return false;
    return key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
}

/// generated route for
/// [_i12.LogsScreen]
class LogsRoute extends _i29.PageRouteInfo<void> {
  const LogsRoute({List<_i29.PageRouteInfo>? children})
    : super(LogsRoute.name, initialChildren: children);

  static const String name = 'LogsRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i12.LogsScreen();
    },
  );
}

/// generated route for
/// [_i13.MainScreen]
class MainRoute extends _i29.PageRouteInfo<void> {
  const MainRoute({List<_i29.PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i13.MainScreen();
    },
  );
}

/// generated route for
/// [_i14.ModifySymbolsScreen]
class ModifySymbolsRoute extends _i29.PageRouteInfo<void> {
  const ModifySymbolsRoute({List<_i29.PageRouteInfo>? children})
    : super(ModifySymbolsRoute.name, initialChildren: children);

  static const String name = 'ModifySymbolsRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i14.ModifySymbolsScreen();
    },
  );
}

/// generated route for
/// [_i15.NewPositionScreen]
class NewPositionRoute extends _i29.PageRouteInfo<NewPositionRouteArgs> {
  NewPositionRoute({
    _i30.Key? key,
    String? item,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         NewPositionRoute.name,
         args: NewPositionRouteArgs(key: key, item: item),
         initialChildren: children,
       );

  static const String name = 'NewPositionRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NewPositionRouteArgs>(
        orElse: () => const NewPositionRouteArgs(),
      );
      return _i15.NewPositionScreen(key: args.key, item: args.item);
    },
  );
}

class NewPositionRouteArgs {
  const NewPositionRouteArgs({this.key, this.item});

  final _i30.Key? key;

  final String? item;

  @override
  String toString() {
    return 'NewPositionRouteArgs{key: $key, item: $item}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NewPositionRouteArgs) return false;
    return key == other.key && item == other.item;
  }

  @override
  int get hashCode => key.hashCode ^ item.hashCode;
}

/// generated route for
/// [_i16.SearchSymbolsScreen]
class SearchSymbolsRoute extends _i29.PageRouteInfo<void> {
  const SearchSymbolsRoute({List<_i29.PageRouteInfo>? children})
    : super(SearchSymbolsRoute.name, initialChildren: children);

  static const String name = 'SearchSymbolsRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i16.SearchSymbolsScreen();
    },
  );
}

/// generated route for
/// [_i17.SelectSymbolScreen]
class SelectSymbolRoute extends _i29.PageRouteInfo<void> {
  const SelectSymbolRoute({List<_i29.PageRouteInfo>? children})
    : super(SelectSymbolRoute.name, initialChildren: children);

  static const String name = 'SelectSymbolRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i17.SelectSymbolScreen();
    },
  );
}

/// generated route for
/// [_i18.SettingsScreen]
class SettingsRoute extends _i29.PageRouteInfo<void> {
  const SettingsRoute({List<_i29.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i18.SettingsScreen();
    },
  );
}

/// generated route for
/// [_i19.SignUpScreen]
class SignUpRoute extends _i29.PageRouteInfo<SignUpRouteArgs> {
  SignUpRoute({
    _i30.Key? key,
    dynamic Function(String, String)? onAddNewAccount,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         SignUpRoute.name,
         args: SignUpRouteArgs(key: key, onAddNewAccount: onAddNewAccount),
         initialChildren: children,
       );

  static const String name = 'SignUpRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SignUpRouteArgs>(
        orElse: () => const SignUpRouteArgs(),
      );
      return _i19.SignUpScreen(
        key: args.key,
        onAddNewAccount: args.onAddNewAccount,
      );
    },
  );
}

class SignUpRouteArgs {
  const SignUpRouteArgs({this.key, this.onAddNewAccount});

  final _i30.Key? key;

  final dynamic Function(String, String)? onAddNewAccount;

  @override
  String toString() {
    return 'SignUpRouteArgs{key: $key, onAddNewAccount: $onAddNewAccount}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SignUpRouteArgs) return false;
    return key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
}

/// generated route for
/// [_i20.SplashScreen]
class SplashRoute extends _i29.PageRouteInfo<void> {
  const SplashRoute({List<_i29.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i20.SplashScreen();
    },
  );
}

/// generated route for
/// [_i21.SwitchAccountScreen]
class SwitchAccountRoute extends _i29.PageRouteInfo<void> {
  const SwitchAccountRoute({List<_i29.PageRouteInfo>? children})
    : super(SwitchAccountRoute.name, initialChildren: children);

  static const String name = 'SwitchAccountRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i21.SwitchAccountScreen();
    },
  );
}

/// generated route for
/// [_i22.SwitchNewAccountScreen]
class SwitchNewAccountRoute
    extends _i29.PageRouteInfo<SwitchNewAccountRouteArgs> {
  SwitchNewAccountRoute({
    _i30.Key? key,
    dynamic Function(String, String, String)? onAddNewAccount,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         SwitchNewAccountRoute.name,
         args: SwitchNewAccountRouteArgs(
           key: key,
           onAddNewAccount: onAddNewAccount,
         ),
         initialChildren: children,
       );

  static const String name = 'SwitchNewAccountRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SwitchNewAccountRouteArgs>(
        orElse: () => const SwitchNewAccountRouteArgs(),
      );
      return _i22.SwitchNewAccountScreen(
        key: args.key,
        onAddNewAccount: args.onAddNewAccount,
      );
    },
  );
}

class SwitchNewAccountRouteArgs {
  const SwitchNewAccountRouteArgs({this.key, this.onAddNewAccount});

  final _i30.Key? key;

  final dynamic Function(String, String, String)? onAddNewAccount;

  @override
  String toString() {
    return 'SwitchNewAccountRouteArgs{key: $key, onAddNewAccount: $onAddNewAccount}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SwitchNewAccountRouteArgs) return false;
    return key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
}

/// generated route for
/// [_i23.SymbolDetailsScreen]
class SymbolDetailsRoute extends _i29.PageRouteInfo<SymbolDetailsRouteArgs> {
  SymbolDetailsRoute({
    _i30.Key? key,
    required _i31.SymbolEntity item,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         SymbolDetailsRoute.name,
         args: SymbolDetailsRouteArgs(key: key, item: item),
         initialChildren: children,
       );

  static const String name = 'SymbolDetailsRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SymbolDetailsRouteArgs>();
      return _i23.SymbolDetailsScreen(key: args.key, item: args.item);
    },
  );
}

class SymbolDetailsRouteArgs {
  const SymbolDetailsRouteArgs({this.key, required this.item});

  final _i30.Key? key;

  final _i31.SymbolEntity item;

  @override
  String toString() {
    return 'SymbolDetailsRouteArgs{key: $key, item: $item}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SymbolDetailsRouteArgs) return false;
    return key == other.key && item == other.item;
  }

  @override
  int get hashCode => key.hashCode ^ item.hashCode;
}

/// generated route for
/// [_i24.SymbolsScreen]
class SymbolsRoute extends _i29.PageRouteInfo<void> {
  const SymbolsRoute({List<_i29.PageRouteInfo>? children})
    : super(SymbolsRoute.name, initialChildren: children);

  static const String name = 'SymbolsRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i24.SymbolsScreen();
    },
  );
}

/// generated route for
/// [_i25.TimeFilterScreen]
class TimeFilterRoute extends _i29.PageRouteInfo<TimeFilterRouteArgs> {
  TimeFilterRoute({
    _i30.Key? key,
    _i34.TimeEntity? selectedTime,
    required dynamic Function(_i34.TimeEntity) onPickDate,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         TimeFilterRoute.name,
         args: TimeFilterRouteArgs(
           key: key,
           selectedTime: selectedTime,
           onPickDate: onPickDate,
         ),
         initialChildren: children,
       );

  static const String name = 'TimeFilterRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TimeFilterRouteArgs>();
      return _i25.TimeFilterScreen(
        key: args.key,
        selectedTime: args.selectedTime,
        onPickDate: args.onPickDate,
      );
    },
  );
}

class TimeFilterRouteArgs {
  const TimeFilterRouteArgs({
    this.key,
    this.selectedTime,
    required this.onPickDate,
  });

  final _i30.Key? key;

  final _i34.TimeEntity? selectedTime;

  final dynamic Function(_i34.TimeEntity) onPickDate;

  @override
  String toString() {
    return 'TimeFilterRouteArgs{key: $key, selectedTime: $selectedTime, onPickDate: $onPickDate}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TimeFilterRouteArgs) return false;
    return key == other.key && selectedTime == other.selectedTime;
  }

  @override
  int get hashCode => key.hashCode ^ selectedTime.hashCode;
}

/// generated route for
/// [_i26.TradeScreen]
class TradeRoute extends _i29.PageRouteInfo<void> {
  const TradeRoute({List<_i29.PageRouteInfo>? children})
    : super(TradeRoute.name, initialChildren: children);

  static const String name = 'TradeRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i26.TradeScreen();
    },
  );
}

/// generated route for
/// [_i27.TradingSettingsScreen]
class TradingSettingsRoute extends _i29.PageRouteInfo<void> {
  const TradingSettingsRoute({List<_i29.PageRouteInfo>? children})
    : super(TradingSettingsRoute.name, initialChildren: children);

  static const String name = 'TradingSettingsRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i27.TradingSettingsScreen();
    },
  );
}

/// generated route for
/// [_i1.UnAuthenticated]
class UnAuthenticatedRoutes extends _i29.PageRouteInfo<void> {
  const UnAuthenticatedRoutes({List<_i29.PageRouteInfo>? children})
    : super(UnAuthenticatedRoutes.name, initialChildren: children);

  static const String name = 'UnAuthenticatedRoutes';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i1.UnAuthenticated();
    },
  );
}

/// generated route for
/// [_i28.WebViewScreen]
class WebViewRoute extends _i29.PageRouteInfo<WebViewRouteArgs> {
  WebViewRoute({
    _i30.Key? key,
    required String url,
    required String title,
    required dynamic Function(String, _i30.BuildContext) onNavigationRequest,
    _i30.Widget? suffix,
    Function? onFinish,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         WebViewRoute.name,
         args: WebViewRouteArgs(
           key: key,
           url: url,
           title: title,
           onNavigationRequest: onNavigationRequest,
           suffix: suffix,
           onFinish: onFinish,
         ),
         initialChildren: children,
       );

  static const String name = 'WebViewRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WebViewRouteArgs>();
      return _i28.WebViewScreen(
        key: args.key,
        url: args.url,
        title: args.title,
        onNavigationRequest: args.onNavigationRequest,
        suffix: args.suffix,
        onFinish: args.onFinish,
      );
    },
  );
}

class WebViewRouteArgs {
  const WebViewRouteArgs({
    this.key,
    required this.url,
    required this.title,
    required this.onNavigationRequest,
    this.suffix,
    this.onFinish,
  });

  final _i30.Key? key;

  final String url;

  final String title;

  final dynamic Function(String, _i30.BuildContext) onNavigationRequest;

  final _i30.Widget? suffix;

  final Function? onFinish;

  @override
  String toString() {
    return 'WebViewRouteArgs{key: $key, url: $url, title: $title, onNavigationRequest: $onNavigationRequest, suffix: $suffix, onFinish: $onFinish}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! WebViewRouteArgs) return false;
    return key == other.key &&
        url == other.url &&
        title == other.title &&
        suffix == other.suffix &&
        onFinish == other.onFinish;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      url.hashCode ^
      title.hashCode ^
      suffix.hashCode ^
      onFinish.hashCode;
}
