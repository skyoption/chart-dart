import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/entity/line_entity.dart';

mixin Indicators {
  late String symbol;

  //For indicators
  List<IndicatorEntity> get indicators {
    return properties['${symbol}_indicators'] ?? [];
  }

  //For properties
  late Map<String, dynamic> properties ;

  void addIndicator(IndicatorEntity value) {
    properties['${symbol}_indicators'] = indicators..add(value);
  }

  void removeIndicator(int index) {
    properties['${symbol}_indicators'] = indicators..removeAt(index);
  }

  void updateIndicator(int index, IndicatorEntity value) {
    indicators[index] = value;
    properties['${symbol}_indicators'] = indicators;
  }
}
