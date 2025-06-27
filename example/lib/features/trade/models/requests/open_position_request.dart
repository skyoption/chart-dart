//direction (BUY, SELL)
class OpenPositionRequest {
  final String symbol;
  final String direction;
  final double volume;
  final double sl;
  final double tp;

  OpenPositionRequest({
    required this.symbol,
    required this.direction,
    required this.volume,
    required this.sl,
    required this.tp,
  });

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'direction': direction,
      'volume': volume,
      'sl': sl,
      'tp': tp,
    };
  }
}
