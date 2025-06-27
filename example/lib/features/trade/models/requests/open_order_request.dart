class OpenOrderRequest {
  final String direction;
  final String symbol;
  final int expirationDate;
  final double price;
  final double volume;
  final double sl;
  final double tp;

  OpenOrderRequest({
    required this.direction,
    required this.price,
    required this.symbol,
    required this.expirationDate,
    required this.volume,
    required this.sl,
    required this.tp,
  });

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'direction': direction,
      'expirationDate': expirationDate,
      'volume': volume,
      'openPrice': price,
      'sl': sl,
      'tp': tp,
      'comment': "",
    };
  }
}
