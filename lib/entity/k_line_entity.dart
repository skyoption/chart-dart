import 'package:candle_chart/k_chart_widget.dart';
import 'package:isar/isar.dart';

import '../entity/k_entity.dart';

class KLineEntity extends KEntity {
  Id id = Isar.autoIncrement;
  double open = 0;
  double high = 0;
  double low = 0;
  double close = 0;
  double vol = 0;
  int time = 0;
  String symbol = '';
  CandleTimeFormat frame = CandleTimeFormat.H4;

  KLineEntity({
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.vol,
    this.frame = CandleTimeFormat.H4,
  });

  KLineEntity.fromCustom({
    required this.open,
    required this.close,
    required this.symbol,
    required this.time,
    required this.high,
    required this.low,
    required this.vol,
  });

  KLineEntity.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol']?.toString() ?? "";
    open = json['open']?.toDouble() ?? 0;
    high = json['high']?.toDouble() ?? 0;
    low = json['low']?.toDouble() ?? 0;
    close = json['close']?.toDouble() ?? 0;
    vol = json['vol']?.toDouble() ?? 0;
    time = json['time']?.toInt() ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['open'] = this.open;
    data['close'] = this.close;
    data['high'] = this.high;
    data['low'] = this.low;
    data['vol'] = this.vol;
    data['symbol'] = this.symbol;
    return data;
  }

  @override
  String toString() {
    return 'MarketModel{open: $open, high: $high, low: $low, close: $close, vol: $vol, time: $time, symbol: $symbol}';
  }
}
