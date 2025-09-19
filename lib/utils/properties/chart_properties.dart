import 'package:candle_chart/k_chart_widget.dart';
import 'package:candle_chart/utils/kprint.dart';
import 'package:candle_chart/utils/properties/indicators.dart';
import 'package:candle_chart/utils/properties/objects.dart';
import 'package:shared_preferences/shared_preferences.dart';
export 'package:candle_chart/k_chart_widget.dart';

late final ChartProperties chartProperties;

class ChartProperties with Indicators, Objects {
  String symbol = 'GBPUSD';
  CandleTimeFormat frame = CandleTimeFormat.M15;
  ChartProperties(this.sharedPreferences);
  final SharedPreferences sharedPreferences;
  //For properties
  Map<String, dynamic> properties = {};

  Future<void> updateDefaultSettings({
    required CandleTimeFormat frame,
    required String symbol,
  }) async {
    this.frame = frame;
    this.symbol = symbol;
    try {
      await sharedPreferences.setString('frame', frame.name);
      await sharedPreferences.setString('symbol', symbol);
      await loadObjects();
      await loadIndicators();
    } catch (e) {
      kPrint(e.toString());
    }
  }

  Future<void> getDefaultSettings({
    required Function(CandleTimeFormat frame, String symbol) onGetting,
  }) async {
    try {
      final res = await sharedPreferences.getString('frame') ?? 'M15';
      symbol = await sharedPreferences.getString('symbol') ?? 'GBPUSD';
      frame = CandleTimeFormat.values.firstWhere((e) => e.name == res);
      onGetting(frame, symbol);
    } catch (e) {
      kPrint(e.toString());
    }
  }

  Future<void> updateObjects() async {
    await loadObjects();
  }
}
