import 'package:example/app.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:example/core/consts/constants.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/functions.dart';
import 'package:example/features/main/models/account_credential.dart';
import 'package:example/injection/injectable.dart';

enum Currencies { LOT, USD, AED, SAR }

const aedDuller = 3.67;
const sarDuller = 3.75;
const currencyKey = 'Currency';

extension CurrencyConverter on num {
  String get currencyName2 => _currencyName(2);
  String currencyName2For(login) => _currencyName(2, login: login);

  String get currencyName6 => _currencyName(6);

  String get currency2 => _currency(2);

  String get currency6 => _currency(6);

  double toCurrencyAsFixed(int num) => double.parse(_currency(num));

  String _currency(int num) {
    final value = getIt<CurrencyChanged>().getCurrency;
    if (value == Currencies.AED) {
      return aed(num);
    } else if (value == Currencies.LOT) {
      return lot(num);
    } else if (value == Currencies.SAR) {
      return sar(num);
    } else if (value == Currencies.USD) {
      return usd(num);
    }
    return '0';
  }

  String _currencyName(int num, {String? login}) {
    final value = login == null
        ? getIt<CurrencyChanged>().getCurrency
        : getIt<CurrencyChanged>().getCurrencyFor(login);
    if (value == Currencies.AED) {
      return "${aed(num)} ${SkyTrading.tr.aed}";
    } else if (value == Currencies.LOT) {
      return "${lot(num)} ${SkyTrading.tr.usd}";
    } else if (value == Currencies.SAR) {
      return "${sar(num)} ${SkyTrading.tr.sar}";
    } else if (value == Currencies.USD) {
      return "${usd(num)} ${SkyTrading.tr.usd}";
    }
    return '0';
  }

  String usd(int num) =>
      truncateToDecimalPlaces(this.toDouble(), num).toStringAsFixed(num);

  String lot(int num) =>
      truncateToDecimalPlaces(this.toDouble(), num).toStringAsFixed(num);

  String sar(int num) {
    return truncateToDecimalPlaces(this * sarDuller, num).toStringAsFixed(num);
  }

  String aed(int num) {
    return truncateToDecimalPlaces(this * aedDuller, num).toStringAsFixed(num);
  }
}

abstract class Currency {
  Future<void> setCurrency(Currencies type);

  Future<void> init();
  Currencies get getCurrency;
  Currencies getCurrencyFor(String login);
}

String currencyName(Currencies value) {
  if (value == Currencies.AED) {
    return SkyTrading.tr.aed;
  } else if (value == Currencies.LOT) {
    return SkyTrading.tr.lot;
  } else if (value == Currencies.SAR) {
    return SkyTrading.tr.sar;
  } else if (value == Currencies.USD) {
    return SkyTrading.tr.usd;
  }
  return '';
}

String currencyDisplayName(Currencies value) {
  if (value == Currencies.AED) {
    return SkyTrading.tr.aed;
  } else if (value == Currencies.SAR) {
    return SkyTrading.tr.sar;
  } else if (value == Currencies.USD) {
    return SkyTrading.tr.usd;
  }
  return SkyTrading.tr.usd;
}

@LazySingleton(as: Currency)
class CurrencyImp implements Currency {
  final SharedPreferences sharedPreferences;
  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
      resetOnError: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
      synchronizable: true,
    ),
  );

  CurrencyImp(this.sharedPreferences);

  AccountCredential? account;

  @override
  Future<void> init() async {
    final results = await _storage.read(key: Constants.USERCACHED);
    account = AccountCredential.fromJson(jsonDecode(results!));
    kPrint("ACCOUNT: ${account?.id}");
  }

  @override
  Currencies get getCurrency {
    if (account != null) {
      final index = sharedPreferences.getInt('${account?.id}-Currency') ?? 1;
      return Currencies.values[index];
    }
    return Currencies.values[1];
  }

  @override
  Future<void> setCurrency(Currencies type) async {
    final results = await _storage.read(key: Constants.USERCACHED);
    if (results != null) {
      account = AccountCredential.fromJson(jsonDecode(results));
      await sharedPreferences.setInt('${account?.id}-Currency', type.index);
    }
  }

  @override
  Currencies getCurrencyFor(String login) {
    final index = sharedPreferences.getInt('$login-Currency') ?? 1;
    return Currencies.values[index];
  }
}

@lazySingleton
class CurrencyChanged extends Cubit<FlowState> {
  final Currency _currency;

  CurrencyChanged(this._currency) : super(FlowState());

  Future<void> change(Currencies? type) async {
    if (type != null && getCurrency != type) {
      emit(state.copyWith(type: StateType.none));
      await _currency.setCurrency(type);
      emit(state.copyWith(type: StateType.success, data: Data.secure));
    }
  }

  Future<void> init() async {
    await _currency.init();
  }

  Currencies get getCurrency {
    return _currency.getCurrency;
  }

  Currencies getCurrencyFor(login) {
    return _currency.getCurrencyFor(login);
  }

  Future<void> refresh(login) async {
    final currentCurrency = getCurrencyFor(login);

    if (currentCurrency != getCurrency) {
      emit(state.copyWith(type: StateType.none));
      await _currency.setCurrency(currentCurrency);
      emit(state.copyWith(type: StateType.success, data: Data.secure));
    }
  }
}
