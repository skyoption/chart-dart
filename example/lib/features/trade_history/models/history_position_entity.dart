import 'package:example/core/enums/history_sort.dart';
import 'package:example/features/trade_history/models/history.dart';
import 'package:example/features/trade_history/models/schema/history_position_model.dart';

class HistoryPositionEntity implements History {
  @override
  int id;
  @override
  double amount;
  @override
  String date;
  String symbol;
  String direction;
  double volumeInit;
  double volumeCurrent;
  double openPrice;
  double tp;
  double sl;
  double margin;
  @override
  double commission;
  @override
  double swap;
  @override
  String comment;
  String openTime;
  double closePrice;
  @override
  String source;
  @override
  String isA;
  @override
  String type;

  HistoryPositionEntity({
    required this.id,
    required this.symbol,
    required this.type,
    required this.direction,
    required this.amount,
    required this.volumeInit,
    required this.date,
    required this.volumeCurrent,
    required this.openPrice,
    required this.tp,
    required this.closePrice,
    required this.sl,
    required this.margin,
    required this.commission,
    required this.swap,
    required this.comment,
    required this.openTime,
    required this.source,
    required this.isA,
  });

  HistoryPositionModel copyToM() {
    return HistoryPositionModel(
      id: id,
      margin: margin,
      direction: direction,
      closeTime: date,
      comment: comment,
      commission: commission,
      closePrice: closePrice,
      floating: amount,
      openPrice: openPrice,
      openTime: openTime,
      sl: sl,
      swap: swap,
      tp: tp,
      volumeCurrent: volumeCurrent,
      volumeInit: volumeInit,
      symbol: symbol,
    );
  }
}

extension HistorySort on List<History> {
  void sortByConfig(HistorySortConfig config) {
    sort((a, b) {
      final comparison = switch (config.criteria) {
        HistorySortCriteria.positionNumber => a.id.compareTo(b.id),
        HistorySortCriteria.date => a.date.compareTo(b.date),
        HistorySortCriteria.profit => a.amount.compareTo(b.amount),
      };
      return config.isAscending ? comparison : -comparison;
    });
  }
}

final fakeHistoryPosition = HistoryPositionEntity(
  id: 3,
  symbol: 'EURUSD',
  type: 'LIMIT',
  direction: 'BUY',
  amount: 500.0,
  volumeInit: 200.0,
  date: DateTime.now().toIso8601String(),
  volumeCurrent: 150.0,
  openPrice: 2800.75,
  tp: 2900.0,
  closePrice: 2850.0,
  sl: 2700.0,
  margin: 1000.0,
  commission: 5.75,
  swap: 1.50,
  comment: 'Long position',
  openTime: DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
  source: 'WEB',
  isA: 'TRADE',
);
