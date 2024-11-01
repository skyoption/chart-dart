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
  List<IndicatorEntity> secondaryIndicators = [];

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
      secondaryIndicators = res;
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

  void addSecondaryIndicator(IndicatorEntity value) {
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

  void removeSecondaryIndicator(int index) {
    final id = secondaryIndicators[index].id;
    secondaryIndicators.removeAt(index);
    KChart.write(query: (db) async {
      await db.indicatorEntitys.delete(id);
    });
  }

  void updateIndicator(int index, IndicatorEntity value) {
    indicators[index] = value;
    KChart.write(query: (db) async {
      await db.indicatorEntitys.put(value);
    });
  }

  void updateSecondaryIndicator(int index, IndicatorEntity value) {
    secondaryIndicators[index] = value;
    KChart.write(query: (db) async {
      await db.indicatorEntitys.put(value);
    });
  }
}
