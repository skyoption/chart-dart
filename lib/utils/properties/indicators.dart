import 'package:candle_chart/k_chart_widget.dart';
import 'package:candle_chart/utils/kprint.dart';
import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/entity/line_entity.dart';
import 'package:candle_chart/utils/isar.dart';
import 'package:isar/isar.dart';

mixin Indicators {
  late String symbol;

  //For indicators
  List<IndicatorEntity> indicators = [];

  //For secondaryIndicators
  List<IndicatorEntity> _secondaryIndicators = [];

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
    await _getIndicators();
    await _getSecondaryIndicators();
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

  void addIndicator(IndicatorEntity value) {
    value.isMain = true;
    value.isSecondary = false;
    indicators.add(value);
    KChart.write(query: (db) async {
      await db.indicatorEntitys.put(value);
    });
  }

  void removeIndicator(int index) {
    final id = indicators[index].id;
    indicators.removeAt(index);
    KChart.write(query: (db) async {
      await db.indicatorEntitys.delete(id);
    });
  }

  void updateIndicator(IndicatorEntity value) {
    final index = indicators.indexWhere((e) => e.id == value.id);
    if (index != -1) {
      indicators[index] = value;
      KChart.write(query: (db) async {
        await db.indicatorEntitys.put(value);
      });
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

  void addSecondaryIndicator(IndicatorEntity value, int? windowId) {
    windowId ??= newWindowId;
    value.windowId = windowId;
    value.isMain = false;
    value.isSecondary = true;
    indicators.add(value);
    KChart.write(query: (db) async {
      await db.indicatorEntitys.put(value);
    });
  }


  void removeSecondaryIndicator(IndicatorEntity item) {
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
    KChart.write(query: (db) async {
      await db.indicatorEntitys.delete(item.id);
    });
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



  void updateSecondaryIndicator(IndicatorEntity value) {
    final index = _secondaryIndicators.indexWhere((e) => e.id == value.id);
    if (index != -1) {
      _secondaryIndicators[index] = value;
      KChart.write(query: (db) async {
        await db.indicatorEntitys.put(value);
      });
    }
  }
}
