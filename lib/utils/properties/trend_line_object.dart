import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/entity/line_entity.dart';
import 'package:candle_chart/renderer/chart_painter.dart';
import 'package:candle_chart/utils/properties/indicators.dart';

mixin TrendLineObject {
  late String symbol;

  //For price lines
  List<TrendLine> get trendLines {
    return properties['${symbol}_trend_lines'] ?? [];
  }

  //For properties
  late Map<String, dynamic> properties ;

  void addTrendLine(TrendLine value) {
    properties['${symbol}_trend_lines'] = trendLines..add(value);
  }

  void removeTrendLine(int index) {
    properties['${symbol}_trend_lines'] = trendLines..removeAt(index);
  }

  void updateTrendLine(int index, TrendLine value) {
    trendLines[index] = value;
    properties['${symbol}_trend_lines'] = trendLines;
  }
}
