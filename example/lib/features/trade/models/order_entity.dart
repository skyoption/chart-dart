import 'package:example/core/enums/position_sort.dart';
import 'package:example/features/trade/models/schema/order_model.dart';

class OrderEntity {
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

  OrderEntity({
    required this.id,
    required this.expirationDate,
    required this.symbol,
    required this.direction,
    required this.volume,
    required this.tp,
    required this.sl,
    required this.openPrice,
    required this.comment,
    required this.openTime,
    required this.createdAt,
  });

  OrderModel copyToModel() {
    return OrderModel(
      id: id,
      direction: direction,
      symbol: symbol,
      expirationDate: expirationDate,
      comment: comment,
      volume: volume,
      openPrice: openPrice,
      openTime: openTime,
      sl: sl,
      tp: tp,
      createdAt: createdAt,
    );
  }
}

extension OrderEntitySort on List<OrderEntity> {
  void sortByConfig(PositionSortConfig config) {
    sort((a, b) {
      final comparison = switch (config.criteria) {
        PositionSortCriteria.positionNumber => a.id.compareTo(b.id),
        PositionSortCriteria.openTime => a.createdAt.compareTo(b.createdAt),
        PositionSortCriteria.symbol => a.symbol.compareTo(b.symbol),
        PositionSortCriteria.profit => a.openPrice.compareTo(b.openPrice),
      };
      return config.isAscending ? comparison : -comparison;
    });
  }

  List<OrderEntity> filterBySymbol(String symbol) {
    if (symbol == "All") return this;
    return where((position) => position.symbol == symbol).toList();
  }
}
