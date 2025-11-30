class TradeEntity {
  int id;
  int openTime;
  double openPrice;
  int? closeTime;
  double? closePrice;

  TradeEntity({
    this.id = 0,
    required this.openTime,
    required this.openPrice,
    this.closeTime,
    this.closePrice,
  });
}
