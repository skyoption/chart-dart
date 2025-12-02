import 'package:candle_chart/k_chart_widget.dart';

class GetCandlesRequest {
  String symbol;
  CandleTimeFormat timeFrame;
  int offset;

  GetCandlesRequest({
    required this.symbol,
    required this.timeFrame,
    required this.offset,
  });

  Map<String, dynamic> toJson() {
    return {'symbol': symbol, 'timeFrame': timeFrame.name, 'offset': offset};
  }
}
