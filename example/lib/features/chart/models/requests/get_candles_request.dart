class GetCandlesRequest {
  String symbol;
  String timeFrame;
  int offset;

  GetCandlesRequest({
    required this.symbol,
    required this.timeFrame,
    required this.offset,
  });

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'timeFrame': timeFrame,
      'offset': offset,
    };
  }
}
