class GetHistoryRequest {
  final int from;

  final int to;

  GetHistoryRequest({
    required this.from,
    required this.to,
  });

  Map<String, dynamic> toJson() {
    return {
      'from': from,
      'to': to,
    };
  }
}
