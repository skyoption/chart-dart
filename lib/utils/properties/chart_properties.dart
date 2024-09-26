import 'package:candle_chart/utils/properties/indicators.dart';
import 'package:candle_chart/utils/properties/line_price_object.dart';
import 'package:candle_chart/utils/properties/trend_line_object.dart';

final chartProperties = ChartProperties._set();

class ChartProperties with Indicators, LinePriceObject, TrendLineObject {
  String symbol = 'USD';

  //For properties
  Map<String, dynamic> properties = {};

  void setCurrentSymbol(String value) => symbol = value;

  ChartProperties._set();
}
