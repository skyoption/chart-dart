import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/functions.dart';
import 'package:example/features/platform_settings/logic/platform_settings_cubit.dart';
import 'package:example/features/platform_settings/logic/trading_logs_cubit.dart';
import 'package:example/injection/injectable.dart';

class LoggingPusher {
  static void success({
    required String message,
    required String logSuccessMessage,
    Color? color,
  }) {
    final cubit = SkyTrading.context.read<PlatformSettingsCubit>();
    showTradePositionNotification(
      platformSettings: cubit.settings,
      message: logSuccessMessage,
      color: color ?? getIt<AppColorScheme>().light.primary,
    );
    // getIt<TradingLogsCubit>().log(logSuccessMessage);
  }

  static void error({
    required String message,
    required String logErrorMessage,
    Color? color,
  }) {
    final cubit = SkyTrading.context.read<PlatformSettingsCubit>();
    showMessageNotification(
      platformSettings: cubit.settings,
      message: message,
      color: color ?? getIt<AppColorScheme>().light.error,
      isSuccess: false,
    );
    // getIt<TradingLogsCubit>().log(logErrorMessage);
  }
}
