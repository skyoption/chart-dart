class TradePointEntity {
  int id;
  int time;
  double price;
  TradePointType type;
  bool isBuy;

  TradePointEntity({
    this.id = 0,
    required this.time,
    required this.price,
    required this.type,
    required this.isBuy,
  });
}

enum TradePointType {
  open,
  close,
}
