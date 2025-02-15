import 'package:candle_chart/entity/symbol_enity.dart';
import 'package:candle_chart/k_chart_widget.dart';
import 'package:candle_chart/utils/isar.dart';
import 'package:candle_chart/utils/kprint.dart';
import 'package:candle_chart/utils/properties/indicators.dart';
import 'package:candle_chart/utils/properties/objects.dart';
import 'package:isar/isar.dart';

final chartProperties = ChartProperties._set();

class ChartProperties with Indicators, Objects {
  String symbol = 'btcusdt';
  CandleTimeFormat frame = CandleTimeFormat.M15;

  //For properties
  Map<String, dynamic> properties = {};

  Future<void> updateDefaultSettings({
    required CandleTimeFormat frame,
    required String symbol,
  }) async {
    this.frame = frame;
    this.symbol = symbol;
    try {
      await KChart.write(query: (db) async {
        await db.symbols.put(
          Symbol(
            id: 0,
            frame: frame,
            symbol: symbol,
          ),
        );
      });
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
      final res = await KChart.query.symbols.filter().idEqualTo(0).findFirst();
      if (res != null) {
        frame = res.frame;
        symbol = res.symbol;
      }
      onGetting(frame, symbol);
    } catch (e) {
      kPrint(e.toString());
    }
  }

  Future<void> updateObjects() async {
    await loadObjects();
  }

  ChartProperties._set();
}
