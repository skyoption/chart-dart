import 'package:isar_community/isar.dart';

import '../entity/k_entity.dart';

class KLineEntity extends KEntity {
  Id id = Isar.autoIncrement;
  double open = 0;
  double high = 0;
  double low = 0;
  double close = 0;
  double vol = 0;
  int time = 0;

  KLineEntity({
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.vol,
    required this.time,
  });

  KLineEntity.fromString(String data) {
    final values = data.split(',');
    this.time = int.tryParse(values[0]) ?? 0;
    this.open = double.tryParse(values[1]) ?? 0;
    this.high = double.tryParse(values[2]) ?? 0;
    this.low = double.tryParse(values[3]) ?? 0;
    this.close = double.tryParse(values[4]) ?? 0;
    this.vol = double.tryParse(values[5]) ?? 0;
  }

  KLineEntity.fromJson(Map<String, dynamic> json) {
    open = json['open']?.toDouble() ?? 0;
    high = json['high']?.toDouble() ?? 0;
    low = json['low']?.toDouble() ?? 0;
    close = json['close']?.toDouble() ?? 0;
    vol = json['vol']?.toDouble() ?? 0;
    int? tempTime = json['time']?.toInt();
    if (tempTime == null) {
      tempTime = json['id']?.toInt() ?? 0;
      tempTime = tempTime! * 1000;
    }
    time = tempTime;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['open'] = this.open;
    data['close'] = this.close;
    data['high'] = this.high;
    data['low'] = this.low;
    data['vol'] = this.vol;
    return data;
  }

  @override
  String toString() {
    return 'MarketModel{open: $open, high: $high, low: $low, close: $close, vol: $vol, time: $time}';
  }
}
