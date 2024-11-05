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

  void addIndicator(IndicatorEntity value) {
    value.isMain = true;
    value.isSecondary = false;
    indicators.add(value);
    KChart.write(query: (db) async {
      await db.indicatorEntitys.put(value);
    });
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

  void removeIndicator(int index) {
    final id = indicators[index].id;
    indicators.removeAt(index);
    KChart.write(query: (db) async {
      await db.indicatorEntitys.delete(id);
    });
  }

  void removeSecondaryIndicator(IndicatorEntity item) {
    _secondaryIndicators.removeWhere((e) => e.id == item.id);
    KChart.write(query: (db) async {
      await db.indicatorEntitys.delete(item.id);
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
