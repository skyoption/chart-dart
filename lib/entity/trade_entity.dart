class TradeEntity {
  int id;
  String openTime;
  double openPrice;
  String? closeTime;
  double? closePrice;
  bool isBuy;

  TradeEntity({
    this.id = 0,
    required this.openTime,
    required this.openPrice,
    this.closeTime,
    this.closePrice,
    this.isBuy = true,
  });
}

extension TradeEntityExtension on TradeEntity {
  int? get openTimeInMilliseconds {
    final dateTime = DateTime.tryParse(openTime);
    if (dateTime == null) return null;
    final timestamp = dateTime.millisecondsSinceEpoch;
    return timestamp ~/ 1000;
  }

  int? get closeTimeInMilliseconds {
    if (closeTime == null) return null;
    final dateTime = DateTime.tryParse(closeTime!);
    if (dateTime == null) return null;
    final timestamp = dateTime.millisecondsSinceEpoch;
    return timestamp ~/ 1000;
  }
}
