import 'package:example/main.dart';

enum PositionSortCriteria {
  positionNumber,
  openTime,
  symbol,
  profit;

  String get displayName {
    final tr = SkyTrading.tr;
    switch (this) {
      case PositionSortCriteria.positionNumber:
        return tr.positionNumber;
      case PositionSortCriteria.openTime:
        return tr.openTime;
      case PositionSortCriteria.symbol:
        return tr.symbol;
      case PositionSortCriteria.profit:
        return tr.profit;
    }
  }
}

class PositionSortConfig {
  final PositionSortCriteria criteria;
  final bool isAscending;

  const PositionSortConfig({
    required this.criteria,
    required this.isAscending,
  });
}
