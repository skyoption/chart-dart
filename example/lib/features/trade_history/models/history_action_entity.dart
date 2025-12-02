import 'package:example/core/enums/history_sort.dart';

import 'schema/history_actions_model.dart';

class HistoryActionEntity {
  int id;
  int account;
  String symbol;
  String source;
  String type;
  double volume;
  double price;
  double profit;
  double commission;
  String createdAt;
  String direction;
  int tradeId;

  HistoryActionEntity({
    required this.id,
    required this.createdAt,
    required this.profit,
    required this.commission,
    required this.price,
    required this.volume,
    required this.direction,
    required this.type,
    required this.source,
    required this.symbol,
    required this.account,
    required this.tradeId,
  });

  HistoryActionModel copyToModel() {
    return HistoryActionModel(
      id: id,
      type: type,
      price: price,
      createdAt: createdAt,
      source: source,
      volume: volume,
      commission: commission,
      account: account,
      direction: direction,
      profit: profit,
      symbol: symbol,
      tradeId: tradeId,
    );
  }
}

extension HistorySort on List<HistoryActionEntity> {
  void sortByConfig(HistorySortConfig config) {
    sort((a, b) {
      final comparison = switch (config.criteria) {
        HistorySortCriteria.positionNumber => a.id.compareTo(b.id),
        HistorySortCriteria.date => a.createdAt.compareTo(b.createdAt),
        HistorySortCriteria.profit => a.profit.compareTo(b.profit),
      };
      return config.isAscending ? comparison : -comparison;
    });
  }
}

extension HistoryAction on HistoryActionEntity {
  bool get isPositionClosed => type == 'CLOSE';
}

final fakeHistoryAction = HistoryActionEntity(
  id: 1,
  account: 123,
  symbol: 'EURUSD',
  source: 'APP',
  type: 'MARKET',
  volume: 50.0,
  price: 150.75,
  profit: 20.50,
  commission: 1.25,
  createdAt: DateTime.now().toIso8601String(),
  direction: 'BUY',
  tradeId: 12345,
);
