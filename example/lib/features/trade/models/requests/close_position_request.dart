//direction (BUY, SELL)
class ClosePositionRequest {
  final int id;
  final double volume;
  final double sl;
  final double tp;

  ClosePositionRequest({
    required this.id,
    required this.volume,
    required this.sl,
    required this.tp,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'volume': volume,
      'sl': sl,
      'tp': tp,
    };
  }
}
