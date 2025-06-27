class ModifyOrderRequest {
  final int id;
  double? sl;
  double? tp;
  double? price;
  double? volume;
  int? expiration;

  ModifyOrderRequest({
    required this.id,
    this.price,
    this.expiration,
    this.volume,
    this.sl,
    this.tp,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      if (expiration != null) 'expirationDate': expiration,
      if (volume != null) 'volume': volume,
      if (price != null) 'openPrice': price,
      if (tp != null) 'tp': tp,
      if (sl != null) 'sl': sl,
    };
  }
}
