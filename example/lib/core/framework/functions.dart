import 'dart:ui';

import 'package:example/core/framework/mtoast.dart';
import 'package:example/core/framework/sky_audio_player.dart';
import 'package:example/core/framework/vibiration.dart';
import 'package:example/features/settings/models/platform_settings_model.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';
import 'package:example/features/trade/views/open_position_screen.dart';

int getLeverage(int symbolLeverage, int accountLeverage) {
  if (symbolLeverage == 0) return accountLeverage;
  return (accountLeverage < symbolLeverage) ? accountLeverage : symbolLeverage;
}

double getPointValue({
  required double volume,
  required SymbolEntity symbol,
}) {
  final result =
      volume * symbol.tickSize * symbol.contractSize * symbol.profitRatio;
  return result;
}

double getTradeMargin({
  required double volume,
  required SymbolEntity symbol,
  required double price,
  required int accountLeverage,
}) {
  int leverage = getLeverage(symbol.leverage, accountLeverage);
  double marginRequirement =
      volume * symbol.contractSize * symbol.marginRatio * price;
  return marginRequirement / leverage;
}

PositionType getPositionTypeByDirection(String direction) {
  if (direction == "SELL") return PositionType.bid;
  if (direction == "BUY") return PositionType.ask;
  return PositionType.none;
}

PositionType getPositionTypeByOrderType(String type) {
  if (type == 'BUY_STOP' || type == 'SELL_LIMIT') return PositionType.ask;
  if (type == 'SELL_STOP' || type == 'BUY_LIMIT') return PositionType.bid;
  return PositionType.none;
}

void showTradeNotification({
  required PlatformSettingsModel platformSettings,
  required Color color,
  required String message,
}) {
  if (platformSettings.tradeNotification) {
    if (platformSettings.tradeNotificationSound) Player.success();
    MToast.showTradeStatus(
      message: message,
      color: color,
      onBuild: (controller) {
        if (platformSettings.tradeNotificationVibration) {
          Vibrate.run();
          if (controller.controller.isDismissed) {
            Vibrate.cancel();
          }
        }
      },
    );
  } else {
    if (platformSettings.tradeNotificationSound) Player.success();
    if (platformSettings.tradeNotificationVibration) {
      Vibrate.run();
      Future.delayed(const Duration(milliseconds: 300), () {
        Vibrate.cancel();
      });
    }
  }
}
