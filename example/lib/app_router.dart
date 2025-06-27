import 'package:example/features/auth/views/change_password_screen.dart';
import 'package:example/features/auth/views/login_screen.dart';
import 'package:example/features/auth/views/sign_up_screen.dart';
import 'package:example/features/boarding/views/boarding_screen.dart';
import 'package:example/features/main/views/main_screen.dart';
import 'package:example/features/settings/views/logs_screen.dart';
import 'package:example/features/settings/views/trading_settings_screen.dart';
import 'package:example/features/splash/views/spalsh_screen.dart';
import 'package:example/features/trade/views/close_by_screen.dart';
import 'package:example/features/trade_history/views/filter_history_screen.dart';

import 'core/consts/exports.dart';
import 'features/settings/views/switch_account_screen.dart';

final mainKey = GlobalKey<MainScreenState>();

class AppRouter {
  static Widget generatedRoute(RouteSettings settings) {
    dynamic arguments = settings.arguments;
    switch (settings.name) {
      case SplashScreen.id:
        return const SplashScreen();
      case BoardingScreen.id:
        return const BoardingScreen();
      case FilterHistoryScreen.id:
        return FilterHistoryScreen(onPick: arguments);
      case LoginScreen.id:
        return const LoginScreen();
      case SignUpScreen.id:
        return const SignUpScreen();
      case MainScreen.id:
        return MainScreen(key: mainKey);
      case CloseByScreen.id:
        return const CloseByScreen();
      case SwitchAccountScreen.id:
        return const SwitchAccountScreen();
      case ChangePasswordScreen.id:
        return const ChangePasswordScreen();
      case TradingSettingsScreen.id:
        return const TradingSettingsScreen();
      case LogsScreen.id:
        return const LogsScreen();
      default:
        return const Center(
          child: Text("Page Not Found"),
        );
    }
  }
}
