import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/entity/line_entity.dart';
import 'package:candle_chart/utils/properties/indicators.dart';

mixin LinePriceObject {
  late String symbol;

  //For price lines
  List<LineEntity> get linesPrice {
    return properties['${symbol}_lines_price'] ?? [];
  }

  //For properties
  late Map<String, dynamic> properties ;

  void addLinePrice(LineEntity value) {
    properties['${symbol}_lines_price'] = linesPrice..add(value);
  }

  void removeLinePrice(int index) {
    properties['${symbol}_lines_price'] = linesPrice..removeAt(index);
  }

  void updateLinePrice(int index, LineEntity value) {
    linesPrice[index] = value;
    properties['${symbol}_lines_price'] = linesPrice;
  }
}
