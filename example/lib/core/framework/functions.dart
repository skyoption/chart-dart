import 'package:example/core/consts/countries.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/app_prefs.dart';
import 'package:example/core/framework/audio_player.dart' hide Player;
import 'package:example/core/framework/mtoast.dart';
import 'package:example/core/framework/vibiration.dart';
import 'package:example/features/platform_settings/models/platform_settings_model.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';
import 'package:example/injection/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

enum PositionType { bid, ask, none }

int getLeverage(int symbolLeverage, int accountLeverage) {
  if (symbolLeverage == 0) return accountLeverage;
  return (accountLeverage < symbolLeverage) ? accountLeverage : symbolLeverage;
}

double getPointValue({required double volume, required SymbolEntity symbol}) {
  final result =
      volume * symbol.tickSize * symbol.contractSize * symbol.profitRatio;
  return result;
}

String errorMessage(
  BuildContext context,
  String value, {
  bool isMax = false,
  String title = '',
}) {
  final currency = context.read<CurrencyChanged>().getCurrency;
  return '${context.tr.fieldInvalid(title.isEmpty ? context.tr.volume : title)} ${isMax ? context.tr.maxAmount : context.tr.minAmount} $value '
          .toLowerCase() +
      currency.name;
}

double truncateToFixedDecimal(double number, int fixed) {
  return double.parse(number.toStringAsFixed(fixed));
}

double truncateToDecimalPlaces(
  double number,
  int decimalPlaces, {
  bool round = false,
  int maxDecimalPlaces = 3,
}) {
  if (decimalPlaces < 0) return number;

  final effectiveDecimalPlaces =
      decimalPlaces > maxDecimalPlaces ? maxDecimalPlaces : decimalPlaces;

  final numAsString = number.toStringAsFixed(effectiveDecimalPlaces).split('.');
  if (numAsString.length == 1) return number;

  if (decimalPlaces == 0) return double.parse(numAsString[0]);

  if (round) {
    return double.parse(number.toStringAsFixed(effectiveDecimalPlaces));
  }
  final truncatedString =
      '${numAsString[0]}.${numAsString.length > 1 ? numAsString[1].length > effectiveDecimalPlaces ? numAsString[1].substring(0, effectiveDecimalPlaces) : numAsString[1] : '0'}';

  return double.parse(truncatedString);
}

double getTradeMargin({
  required double volume,
  required SymbolEntity symbol,
  required double price,
  required int accountLeverage,
}) {
  final value = getIt<CurrencyChanged>().getCurrency;
  if (value != Currencies.LOT) {
    return volume;
  }

  final currentPrice = symbol.symbol.startsWith("USD") ? 1 : price;

  int leverage = getLeverage(symbol.leverage, accountLeverage);
  double marginRequirement =
      volume * symbol.contractSize * symbol.marginRatio * currentPrice;
  double margin = marginRequirement / leverage;
  return double.parse(margin.toString()).toTwoDecimalNum;
}

double convertLotMargin({
  required double data,
  required SymbolEntity symbol,
  required double price,
  required int accountLeverage,
}) {
  int leverage = getLeverage(symbol.leverage, accountLeverage);

  double margin = (data * symbol.contractSize * symbol.marginRatio) / leverage;

  return margin;
}

double convertLotVolumeToPrice({
  required double data,
  required SymbolEntity symbol,
  required double price,
  required int accountLeverage,
}) {
  if (accountLeverage == 0) return 0;
  ;
  final value = getIt<CurrencyChanged>().getCurrency;
  if (value == Currencies.LOT) {
    return data;
  }
  int leverage = getLeverage(symbol.leverage, accountLeverage);

  double margin =
      (data * symbol.contractSize * symbol.marginRatio * price) / leverage;

  if (value == Currencies.AED) {
    margin = margin * aedDuller;
  } else if (value == Currencies.SAR) {
    margin = margin * sarDuller;
  }
  return truncateToDecimalPlaces(margin, 2, round: true);
}

double convertPriceToLot({
  required double value,
  required SymbolEntity symbol,
  required double price,
  required int accountLeverage,
}) {
  final currency = getIt<CurrencyChanged>().getCurrency;
  if (currency == Currencies.LOT) {
    return value;
  }

  int leverage = getLeverage(symbol.leverage, accountLeverage);
  double volume =
      (value * leverage) / (symbol.contractSize * symbol.marginRatio * price);

  if (currency == Currencies.AED) {
    volume = volume / aedDuller;
  } else if (currency == Currencies.SAR) {
    volume = volume / sarDuller;
  }

  return truncateToDecimalPlaces(volume, 2);
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

String? getCountryNameByCode(String countryCode) {
  kPrint(countryCode);
  final country = Countries.allCountries.firstWhere(
    (element) => element["code"] == countryCode,
    orElse: () => {},
  );
  return country.isNotEmpty ? country["name"] : countryCode;
}

String? getCountryCodeByDialCode(String dialCode) {
  final country = Countries.allCountries.firstWhere(
    (element) => element["dial_code"] == dialCode,
    orElse: () => {},
  );
  return country.isNotEmpty ? country["code"] : null;
}

String? getCountryCodeByName(String countryName) {
  final country = Countries.allCountries.firstWhere(
    (element) =>
        (element["name"]?.toLowerCase() ?? "") == countryName.toLowerCase(),
    orElse: () => {},
  );
  return country.isNotEmpty ? country["code"] : null;
}

String? getCountryCodeByNumber(String phoneNumber) {
  final dialCode = Countries.allCountries.firstWhere(
    (element) => phoneNumber.startsWith(element["dial_code"] ?? ""),
    orElse: () => {},
  );
  return dialCode.isNotEmpty ? dialCode["code"] : null;
}

Future<void> showMessageNotification({
  required PlatformSettingsModel platformSettings,
  required Color color,
  required String message,
  required bool isSuccess,
}) async {
  if (platformSettings.tradePositionNotification) {
    if (message.isNotEmpty) {
      MToast.showTradeStatus(
        message: message,
        color: color,
        onBuild: (controller) {
          if (platformSettings.tradePositionNotificationVibration) {
            Vibrate.run();
            if (controller.controller.isDismissed) {
              Vibrate.cancel();
            }
          }
        },
      );
    } else {
      if (platformSettings.tradePositionNotificationVibration) {
        Vibrate.run();
        Future.delayed(const Duration(milliseconds: 300), () {
          Vibrate.cancel();
        });
      }
    }
    if (platformSettings.tradePositionNotificationSound) {
      if (isSuccess) {
        await Player.success();
      } else {
        await Player.failure();
      }
    }
  }
}

void showTradePositionNotification({
  required PlatformSettingsModel platformSettings,
  required Color color,
  required String message,
}) {
  if (platformSettings.tradePositionNotification) {
    if (platformSettings.tradePositionNotificationSound) Player.success();
    if (message.isNotEmpty) {
      MToast.showTradeStatus(
        message: message,
        color: color,
        onBuild: (controller) {
          if (platformSettings.tradePositionNotificationVibration) {
            Vibrate.run();
            if (controller.controller.isDismissed) {
              Vibrate.cancel();
            }
          }
        },
      );
    } else {
      if (platformSettings.tradePositionNotificationVibration) {
        Vibrate.run();
        Future.delayed(const Duration(milliseconds: 300), () {
          Vibrate.cancel();
        });
      }
    }
  } else {
    if (platformSettings.tradePositionNotificationSound) Player.success();
    if (platformSettings.tradePositionNotificationVibration) {
      Vibrate.run(duration: const Duration(milliseconds: 300));
    }
  }
}

void showTradeOrderNotification({
  required PlatformSettingsModel platformSettings,
  required Color color,
  required String message,
}) {
  if (platformSettings.tradeOrderNotification) {
    if (platformSettings.tradeOrderNotificationSound) Player.success();
    MToast.showTradeStatus(
      message: message,
      color: color,
      onBuild: (controller) {
        if (platformSettings.tradeOrderNotificationVibration) {
          Vibrate.run();
          if (controller.controller.isDismissed) {
            Vibrate.cancel();
          }
        }
      },
    );
  } else {
    if (platformSettings.tradeOrderNotificationSound) Player.success();
    if (platformSettings.tradeOrderNotificationVibration) {
      Vibrate.run(duration: const Duration(milliseconds: 300));
    }
  }
}

double getTextWidth(String text, double fontSize) {
  final textPainter = TextPainter(
    text: TextSpan(
      text: text,
      style: TextStyle(fontSize: fontSize),
    ),
    textDirection: TextDirection.ltr,
  )..layout();
  return textPainter.size.width * 1.3;
}

String formatLikesCount(int count) {
  if (count >= 1000000) return '${(count / 1000000).toStringAsFixed(1)}M';
  if (count >= 1000) return '${(count / 1000).toStringAsFixed(1)}k';
  return count.toString();
}

Future<void> openUrl(String url) async {
  final uri = Uri.tryParse(url);
  if (uri != null && await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    debugPrint('Could not launch $url');
  }
}

// 1. Price → Money
double priceToMoney({
  required double entryPrice,
  required double targetPrice,
  required double profitRatio,
  required int decimalPlaces,
  required double volume,
  required double contractSize,
}) {
  final pipDifference = targetPrice - entryPrice;
  final result = pipDifference * profitRatio * volume * contractSize;
  return double.parse(result.toStringAsFixed(decimalPlaces));
}

// 2. Money → Price
double moneyToPrice({
  required double entryPrice,
  required double money,
  required double profitRatio,
  required int decimalPlaces,
  required double volume,
  required double contractSize,
  required bool isBuyTarget,
}) {
  money = isBuyTarget ? money : -money;
  final result = (entryPrice + money / (profitRatio * volume * contractSize));

  return double.parse(result.toStringAsFixed(decimalPlaces));
}

// 3. Price → Pips
double priceToPips({
  required double entryPrice,
  required double targetPrice,
  required double pipSize,
  required bool isBuyTarget,
  required int decimalPlaces,
}) {
  final result = isBuyTarget
      ? (targetPrice - entryPrice) / pipSize
      : (entryPrice - targetPrice) / pipSize;
  return double.parse(result.toStringAsFixed(decimalPlaces));
}

// 4. Pips → Price
double pipsToPrice({
  required double entryPrice,
  required double pips,
  required double pipSize,
  required bool isBuyTarget,
  required int decimalPlaces,
}) {
  final result = isBuyTarget
      ? entryPrice + (pips * pipSize)
      : entryPrice - (pips * pipSize);
  return double.parse(result.toStringAsFixed(decimalPlaces));
}

// 5. Money → Pips
double moneyToPips({
  required double money,
  required double lotSize,
  required double contractSize,
  required bool isBuyTarget,
  required int decimalPlaces,
  required double profitRatio,
  required double tickSize,
}) {
  final pipValue = lotSize * contractSize * profitRatio * tickSize * 10;
  final pips = money / pipValue;
  final result = isBuyTarget ? pips : -pips;
  return double.parse(result.toStringAsFixed(decimalPlaces));
}

// 6. Pips → Money
double pipsToMoney({
  required double pips,
  required double lotSize,
  required double contractSize,
  required int decimalPlaces,
  required double profitRatio,
  required double tickSize,
}) {
  final pipValue = lotSize * contractSize * profitRatio;
  final result = pips * tickSize * pipValue * 10;
  kPrint(pips.toString());
  return double.parse(result.toStringAsFixed(decimalPlaces));
}
