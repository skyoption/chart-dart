import 'package:example/app.dart';

enum PositionSortCriteria {
  positionNumber,
  openTime,
  symbol,
  profit;

  String get displayName {
    switch (this) {
      case PositionSortCriteria.positionNumber:
        return SkyTrading.tr.positionNumber;
      case PositionSortCriteria.openTime:
        return SkyTrading.tr.openTime;
      case PositionSortCriteria.symbol:
        return SkyTrading.tr.symbol;
      case PositionSortCriteria.profit:
        return SkyTrading.tr.profit;
    }
  }
}

class PositionSortConfig {
  final PositionSortCriteria criteria;
  final bool isAscending;

  const PositionSortConfig({required this.criteria, required this.isAscending});
}
