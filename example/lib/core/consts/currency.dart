import 'dart:math';

import 'package:example/injection/injectable.dart';

import 'exports.dart';

enum Currencies { LOT, USD, AED, SAR }

const aedDuller = 3.75;
const sarDuller = 3.67;
const currencyKey = 'Currency';

extension CurrencyConverter on num {
  String get currencyName2 => _currencyName(2);

  String get currencyName6 => _currencyName(6);

  String get currency2 => _currency(2);

  String get currency6 => _currency(6);

  double toCurrencyAsFixed(int num) => double.parse(_currency(num));

  String _currency(int num) {
    final value = getIt<Currency>().getCurrency;
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

  String _currencyName(int num) {
    final value = getIt<Currency>().getCurrency;
    if (value == Currencies.AED) {
      return "${aed(num)} AED";
    } else if (value == Currencies.LOT) {
      return "${lot(num)} USD";
    } else if (value == Currencies.SAR) {
      return "${sar(num)} SAR";
    } else if (value == Currencies.USD) {
      return "${usd(num)} USD";
    }
    return '0';
  }

  String usd(int num) => toStringAsFixed(num);

  String lot(int num) => toStringAsFixed(num);

  String sar(int num) {
    return (this * sarDuller).toStringAsFixed(num);
  }

  String aed(int num) {
    return (this * aedDuller).toStringAsFixed(num);
  }
}

abstract class Currency {
  Future<void> setCurrency(Currencies type);

  Currencies get getCurrency;
}

@Injectable(as: Currency)
class CurrencyImp implements Currency {
  final SharedPreferences sharedPreferences;

  CurrencyImp(this.sharedPreferences);

  @override
  Currencies get getCurrency {
    final index = sharedPreferences.getInt(currencyKey) ?? 0;
    return Currencies.values[index];
  }

  @override
  Future<void> setCurrency(Currencies type) async {
    await sharedPreferences.setInt(currencyKey, type.index);
  }
}

@injectable
class CurrencyChanged extends Cubit<FlowState> {
  final Currency _currency;

  CurrencyChanged(this._currency) : super(FlowState());

  int get randomInt => Random().nextInt(1000);

  Future<void> change(Currencies? type) async {
    if (type != null) {
      await _currency.setCurrency(type);
      emit(state.copyWith(data: randomInt));
    }
  }

  Currencies get getCurrency {
    return _currency.getCurrency;
  }
}
