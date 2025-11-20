import 'package:candle_chart/k_chart_widget.dart';
import 'package:candle_chart/utils/kprint.dart';
import 'package:candle_chart/utils/properties/indicators.dart';
import 'package:candle_chart/utils/properties/objects.dart';
import 'package:isar_community/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';
export 'package:candle_chart/k_chart_widget.dart';
import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/utils/isar.dart';

late final ChartProperties chartProperties;

class ChartProperties with Indicators, Objects {
  String symbol = 'GBPUSD';
  CandleTimeFormat frame = CandleTimeFormat.M15;
  ChartProperties(this.sharedPreferences);
  final SharedPreferences sharedPreferences;
  //For properties
  Map<String, dynamic> properties = {};

  List<KLineEntity> lineCandles = [];

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
    required Function(
      CandleTimeFormat frame,
      String symbol,
      List<KLineEntity> candles,
    ) onGetting,
  }) async {
    try {
      final res = await sharedPreferences.getString('frame') ?? 'M15';
      symbol = await sharedPreferences.getString('symbol') ?? 'GBPUSD';
      frame = CandleTimeFormat.values.firstWhere((e) => e.name == res);
      await loadCandles();
      onGetting(frame, symbol, lineCandles);
    } catch (e) {
      kPrint(e.toString());
    }
  }

  Future<void> updateObjects() async {
    await loadObjects();
  }

  Future<void> loadCandles() async {
    try {
      final res = await KChart.query.kLineEntitys
          .filter()
          .symbolEqualTo(symbol)
          .frameEqualTo(frame)
          .findAll();
      lineCandles = res;
    } catch (e) {
      kPrint(e.toString());
    }
  }

  Future<void> getCandlesBySymbol(String symbol) async {
    try {
      final res = await KChart.query.kLineEntitys
          .filter()
          .symbolEqualTo(symbol)
          .frameEqualTo(frame)
          .findAll();
      lineCandles = res;
    } catch (e) {
      kPrint(e.toString());
    }
  }

  Future<void> addCandles(List<KLineEntity> values) async {
    for (var item in values) {
      item.symbol = symbol;
      item.frame = frame;
    }
    lineCandles = values;
    await KChart.write(query: (db) async {
      await db.kLineEntitys.putAll(values);
    });
    loadCandles();
  }

  Future<void> clearChart() async {
    lineCandles.clear();
    await KChart.write(query: (db) async {
      await db.kLineEntitys.clear();
    });
  }
}
