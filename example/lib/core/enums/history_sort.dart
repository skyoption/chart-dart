import 'package:example/main.dart';

enum HistorySortCriteria {
  date,
  positionNumber,
  profit;

  String get displayName {
    switch (this) {
      case HistorySortCriteria.date:
        return SkyTrading.tr.historyDate;
      case HistorySortCriteria.positionNumber:
        return SkyTrading.tr.historyPositionNumber;
      case HistorySortCriteria.profit:
        return SkyTrading.tr.historyProfit;
    }
  }
}

class HistorySortConfig {
  final HistorySortCriteria criteria;
  final bool isAscending;

  const HistorySortConfig({
    required this.criteria,
    required this.isAscending,
  });
}
