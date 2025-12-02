import 'package:example/app.dart';

enum HistorySortCriteria {
  date,
  positionNumber,

  profit;

  String get displayName {
    switch (this) {
      case HistorySortCriteria.date:
        return SkyTrading.tr.date;
      case HistorySortCriteria.positionNumber:
        return SkyTrading.tr.positionNumber;
      case HistorySortCriteria.profit:
        return SkyTrading.tr.profit;
    }
  }
}

class HistorySortConfig {
  final HistorySortCriteria criteria;
  final bool isAscending;

  const HistorySortConfig({required this.criteria, required this.isAscending});
}
