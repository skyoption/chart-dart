import 'package:example/app.dart';

import 'exports.dart';

class PickOption<T> {
  final T value;
  final String label;

  const PickOption(this.value, this.label);
}

enum PriceOptions { Price, Money, Pips }

final List<PickOption<PriceOptions>> pickOptions = [
  PickOption(PriceOptions.Price, "Price"),
  PickOption(PriceOptions.Money, "Money"),
  PickOption(PriceOptions.Pips, "Pips"),
];

// ****************************************************** Account Types ********************************************************

final List<PickOption<String>> accountTypes = [
  PickOption('individual', SkyTrading.tr.individual),
  PickOption('corporate', SkyTrading.tr.corporate),
];

// ****************************************************** Chart Line Size ********************************************************

final List<PickOption<double>> chartLineSizes = [
  const PickOption(1, "1x"),
  const PickOption(2, "2x"),
  const PickOption(3, "3x"),
  const PickOption(4, "4x"),
  const PickOption(5, "5x"),
];
