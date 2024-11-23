import 'package:candle_chart/utils/kprint.dart';
import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/entity/symbol_enity.dart';
import 'package:candle_chart/utils/date_util.dart';
import 'package:candle_chart/utils/isar.dart';
import 'package:candle_chart/utils/properties/indicators.dart';
import 'package:candle_chart/utils/properties/objects.dart';
import 'package:isar/isar.dart';

final chartProperties = ChartProperties._set();

class ChartProperties with Indicators, Objects {
  String symbol = 'btcusdt';
  CandleTimeFormat frame = CandleTimeFormat.H4;

  //For properties
  Map<String, dynamic> properties = {};

  List<KLineEntity> candles = [];

  KLineEntity? get firstCandle {
    if (candles.isNotEmpty) {
      return candles[0];
    }
    return null;
  }

  KLineEntity? get lastCandle {
    if (candles.isNotEmpty) {
      return candles[candles.length - 1];
    }
    return null;
  }

  void setCurrentSymbol(String value) {
    symbol = value;
    _updateSymbol();
  }

  Future<void> setTimeframe(CandleTimeFormat value) async {
    frame = value;
    await _updateSymbol();
  }

  Future<void> _updateSymbol() async {
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
    } catch (e) {
      kPrint(e.toString());
    }
  }

  Future<void> _loadSymbol() async {
    try {
      final res = await KChart.query.symbols.filter().idEqualTo(0).findFirst();
      if (res != null) {
        frame = res.frame;
        symbol = res.symbol;
      }
      await loadObjects();
    } catch (e) {
      kPrint(e.toString());
    }
  }

  Future<void> loadCandles({
    Function(
      CandleTimeFormat frame,
      String symbol,
      List<KLineEntity> candles,
      KLineEntity? firstCandle,
      KLineEntity? lastCandle,
    )? onLoaded,
  }) async {
    try {
      await _loadSymbol();
      final res = await KChart.query.kLineEntitys
          .filter()
          .symbolEqualTo(symbol)
          .frameEqualTo(frame)
          .findAll();
      candles = res;
    } catch (e) {
      kPrint(e.toString());
    }
    if (onLoaded != null) {
      onLoaded(
        frame,
        symbol,
        candles,
        firstCandle,
        lastCandle,
      );
    }
  }

  Future<void> setCandles(List<KLineEntity> values) async {
    try {
      for (int i = 0; i < values.length; i++) {
        values[i].symbol = symbol;
        values[i].frame = frame;
      }
      KChart.write(query: (db) async {
        await db.kLineEntitys.putAll(values);
      });
    } catch (e) {
      kPrint(e.toString());
    }
  }

  ChartProperties._set();
}
