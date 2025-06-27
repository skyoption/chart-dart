import 'package:example/core/enums/history_sort.dart';
import 'package:example/features/trade_history/models/schema/history_pending_model.dart';

class HistoryPendingEntity {
  int id;
  String symbol;
  String direction;
  String expirationDate;
  double volume;
  double openPrice;
  double tp;
  double sl;
  String comment;
  String createdAt;
  String openTime;
  int type;
  String closedAt;
  String reason;

  HistoryPendingEntity({
    required this.id,
    required this.expirationDate,
    required this.symbol,
    required this.closedAt,
    required this.reason,
    required this.direction,
    required this.volume,
    required this.type,
    required this.tp,
    required this.sl,
    required this.openPrice,
    required this.comment,
    required this.openTime,
    required this.createdAt,
  });

  HistoryPendingModel copyToModel() {
    return HistoryPendingModel(
      id: id,
      direction: direction,
      symbol: symbol,
      reason: reason,
      closedAt: closedAt,
      expirationDate: expirationDate,
      comment: comment,
      volume: volume,
      openPrice: openPrice,
      type: type,
      openTime: openTime,
      sl: sl,
      tp: tp,
      createdAt: createdAt,
    );
  }
}

extension HistoryPendingSort on List<HistoryPendingEntity> {
  void sortByConfig(HistorySortConfig config) {
    sort((a, b) {
      final comparison = switch (config.criteria) {
        HistorySortCriteria.positionNumber => a.id.compareTo(b.id),
        HistorySortCriteria.date => a.createdAt.compareTo(b.createdAt),
        HistorySortCriteria.profit => a.id.compareTo(b.id),
      };
      return config.isAscending ? comparison : -comparison;
    });
  }
}
