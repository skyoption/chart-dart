import 'package:candle_chart/entity/k_line_entity.dart';

enum CandleTimeFormat { M1, M5, M15, M30, H1, H4, D1, W1, MN }

class CandleAggregator {
  List<KLineEntity> aggregateCandles(
      List<KLineEntity> data, CandleTimeFormat format) {
    int interval = _getInterval(format); // get the aggregation interval
    List<KLineEntity> aggregatedData = [];

    for (int i = 0; i < data.length; i += interval) {
      // Aggregate the required number of candles
      int endIndex =
          (i + interval) > data.length ? data.length : (i + interval);
      List<KLineEntity> batch = data.sublist(i, endIndex);

      KLineEntity aggregatedCandle = _aggregateBatch(batch);
      aggregatedData.add(aggregatedCandle);
    }

    return aggregatedData;
  }

  // Get the number of candles to aggregate based on the CandleTimeFormat
  int _getInterval(CandleTimeFormat format) {
    switch (format) {
      case CandleTimeFormat.M1:
        return 1;
      case CandleTimeFormat.M5:
        return 5;
      case CandleTimeFormat.M15:
        return 15;
      case CandleTimeFormat.M30:
        return 30;
      case CandleTimeFormat.H1:
        return 60;
      case CandleTimeFormat.H4:
        return 240;
      case CandleTimeFormat.D1:
        return 1440;
      case CandleTimeFormat.W1:
        return 1440 * 7;
      case CandleTimeFormat.MN:
        return 43200;
      default:
        return 1;
    }
  }

  // Aggregate a batch of candles into a single KLineEntity
  KLineEntity _aggregateBatch(List<KLineEntity> batch) {
    if (batch.isEmpty)
      return KLineEntity.fromCustom(
          open: 0, close: 0, high: 0, low: 0, vol: 0, time: 0);

    double open = batch.first.open;
    double close = batch.last.close;
    double high = batch.map((e) => e.high).reduce((a, b) => a > b ? a : b);
    double low = batch.map((e) => e.low).reduce((a, b) => a < b ? a : b);
    double vol = batch.map((e) => e.vol).reduce((a, b) => a + b);
    double? amount = batch.map((e) => e.amount ?? 0).reduce((a, b) => a + b);
    int? time = batch.first.time;

    return KLineEntity.fromCustom(
      open: open,
      close: close,
      high: high,
      low: low,
      vol: vol,
      amount: amount,
      time: time ?? 0,
    );
  }
}
