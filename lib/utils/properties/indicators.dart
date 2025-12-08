import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/entity/trade_entity.dart';
import 'package:candle_chart/k_chart_widget.dart';
import 'package:candle_chart/utils/indicator_utils.dart';
import 'package:candle_chart/utils/isar.dart';
import 'package:candle_chart/utils/kprint.dart';
import 'package:isar_community/isar.dart';

mixin Indicators {
  late String symbol;

  //For indicators
  List<IndicatorEntity> indicators = [];

  //For secondaryIndicators
  List<IndicatorEntity> _secondaryIndicators = [];

  List<KLineEntity> candles = [];

  int get maxWindowId {
    int id = 0;
    for (var item in _secondaryIndicators) {
      if (id < item.windowId) {
        id = item.windowId;
      }
    }
    return id;
  }

  int get newWindowId {
    return maxWindowId + 1;
  }

  Map<int, List<IndicatorEntity>> get secondaries {
    Map<int, List<IndicatorEntity>> items = {};
    for (var item in _secondaryIndicators) {
      items[item.windowId] = [...items[item.windowId] ?? [], item];
    }
    return items;
  }

  Future<void> loadIndicators() async {
    await _reset();
  }

  Future<void> _getIndicators() async {
    try {
      final res = await KChart.query.indicatorEntitys
          .filter()
          .isMainEqualTo(true)
          .findAll();
      indicators = res;
    } catch (e) {
      return kPrint(e.toString());
    }
  }

  Future<void> addIndicator(IndicatorEntity value) async {
    value.isMain = true;
    value.isSecondary = false;
    indicators.add(value);
    await KChart.write(query: (db) async {
      await db.indicatorEntitys.put(value);
    });
    await _reset();
  }

  Future<void> removeIndicator(int index) async {
    final id = indicators[index].id;
    indicators.removeAt(index);
    await KChart.write(query: (db) async {
      await db.indicatorEntitys.delete(id);
    });
    await _reset();
  }

  Future<void> updateIndicator(IndicatorEntity value) async {
    final index = indicators.indexWhere((e) => e.id == value.id);
    if (index != -1) {
      indicators[index] = value;
      await KChart.write(query: (db) async {
        await db.indicatorEntitys.put(value);
      });
      await _reset();
    }
  }

  Future<void> _getSecondaryIndicators() async {
    try {
      final res = await KChart.query.indicatorEntitys
          .filter()
          .isSecondaryEqualTo(true)
          .findAll();
      _secondaryIndicators = res;
    } catch (e) {
      return kPrint(e.toString());
    }
  }

  Future<void> addSecondaryIndicator(
      IndicatorEntity value, int? windowId) async {
    windowId ??= newWindowId;
    value.windowId = windowId;
    value.isMain = false;
    value.isSecondary = true;
    indicators.add(value);
    await KChart.write(query: (db) async {
      await db.indicatorEntitys.put(value);
    });
    await _reset();
  }

  Future<void> removeSecondaryWindow(int windowId) async {
    //when remove last secondary return trend indicators to get value from apply to close
    if (windowId != 0) {
      final items = secondaries[windowId] ?? [];
      if (items.length > 1) {
        if (indicators.isEmpty) {
          for (var item in items) {
            if (item.applyTo == ApplyTo.Last_Indicator ||
                item.applyTo == ApplyTo.First_Indicator) {
              updateSecondaryIndicator(item..applyTo = ApplyTo.Close);
            }
          }
        }
      }
      _secondaryIndicators.removeWhere((e) => e.windowId == windowId);
      await KChart.write(query: (db) async {
        await db.indicatorEntitys.deleteAll(items.map((e) => e.id).toList());
      });
      await _reset();
    }
  }

  Future<void> removeSecondaryIndicator(IndicatorEntity item) async {
    //when remove last secondary return trend indicators to get value from apply to close
    if (item.windowId != 0) {
      final items = secondaries[item.windowId] ?? [];
      if (items.length > 1) {
        final indicators =
            items.where((e) => isSecondary(e) && e.id != item.id).toList();
        if (indicators.isEmpty) {
          for (var item in items) {
            if (item.applyTo == ApplyTo.Last_Indicator ||
                item.applyTo == ApplyTo.First_Indicator) {
              updateSecondaryIndicator(item..applyTo = ApplyTo.Close);
            }
          }
        }
      }
    }
    _secondaryIndicators.removeWhere((e) => e.id == item.id);
    await KChart.write(query: (db) async {
      await db.indicatorEntitys.delete(item.id);
    });
    await _reset();
  }

  bool isSecondary(IndicatorEntity indicator) {
    return (indicator.type == IndicatorType.RSI ||
        indicator.type == IndicatorType.MACD ||
        indicator.type == IndicatorType.ATR ||
        indicator.type == IndicatorType.WPR ||
        indicator.type == IndicatorType.DEM ||
        indicator.type == IndicatorType.CCI ||
        indicator.type == IndicatorType.MFI ||
        indicator.type == IndicatorType.SO_EMA ||
        indicator.type == IndicatorType.SO_LINEAR ||
        indicator.type == IndicatorType.SO_SMA ||
        indicator.type == IndicatorType.SO_SMMA ||
        indicator.type == IndicatorType.MOM);
  }

  Future<void> updateSecondaryIndicator(IndicatorEntity value) async {
    final index = _secondaryIndicators.indexWhere((e) => e.id == value.id);
    if (index != -1) {
      _secondaryIndicators[index] = value;
      await KChart.write(query: (db) async {
        await db.indicatorEntitys.put(value);
      });
      await _reset();
    }
  }

  Future<void> _reset() async {
    await _getIndicators();
    await _getSecondaryIndicators();
    await IndicatorUtils.calculate(
      candles,
      indicators,
      secondaries,
    );
  }

  Future<void> updateIndicators(
    List<KLineEntity> candles, {
    List<TradeEntity> trades = const [],
  }) async {
    this.candles = candles;
    await IndicatorUtils.calculate(
      candles,
      indicators,
      secondaries,
    );
  }
}
