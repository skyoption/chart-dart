import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/entity/line_entity.dart';
import 'package:candle_chart/utils/isar.dart';
import 'package:candle_chart/utils/kprint.dart';
import 'package:candle_chart/utils/properties/indicators.dart';
import 'package:isar/isar.dart';

mixin LinePriceObject {
  late String symbol;

  //For price lines
  List<LineEntity> horizontalLines = [];
  List<LineEntity> verticalLines = [];

  Future<void> loadObjects() async {
    await _getVerticalLines();
    await _getHorizontalLines();
  }

  void addVerticalLine(
    LineEntity value,
    List<KLineEntity> data,
  ) {
    value.symbol = symbol;
    value.type = LineType.vertical;
    // value.dx1 = value.dx2;
    verticalLines.add(value);
    KChart.write(query: (db) async {
      await db.lineEntitys.put(value);
    });
  }

  void removeVerticalLine(int index) {
    final id = verticalLines[index].id;
    verticalLines.removeAt(index);
    KChart.write(query: (db) async {
      await db.lineEntitys.delete(id);
    });
  }

  Future<void> updateVerticalLine(LineEntity value) async {
    final index = verticalLines.indexWhere((e) => e.id == value.id);
    if (index != -1) {
      value.dx1 = value.dx2;
      verticalLines[index] = value;
      await KChart.write(query: (db) async {
        await db.lineEntitys.put(value);
      });
    }
  }

  void addHorizontalLine(LineEntity value) {
    value.symbol = symbol;
    value.type = LineType.horizontal;
    horizontalLines.add(value);
    KChart.write(query: (db) async {
      await db.lineEntitys.put(value);
    });
  }

  void removeHorizontalLine(int index) {
    final id = horizontalLines[index].id;
    horizontalLines.removeAt(index);
    KChart.write(query: (db) async {
      await db.lineEntitys.delete(id);
    });
  }

  Future<void> updateHorizontalLine(LineEntity value) async {
    final index = horizontalLines.indexWhere((e) => e.id == value.id);
    if (index != -1) {
      horizontalLines[index] = value;
      await KChart.write(query: (db) async {
        await db.lineEntitys.put(value);
      });
    }
  }

  Future<void> _getVerticalLines() async {
    try {
      final res = await KChart.query.lineEntitys
          .filter()
          .typeEqualTo(LineType.vertical)
          .symbolEqualTo(symbol)
          .findAll();
      verticalLines = res;
    } catch (e) {
      return kPrint(e.toString());
    }
  }

  Future<void> _getHorizontalLines() async {
    try {
      final res = await KChart.query.lineEntitys
          .filter()
          .typeEqualTo(LineType.horizontal)
          .symbolEqualTo(symbol)
          .findAll();
      horizontalLines = res;
    } catch (e) {
      return kPrint(e.toString());
    }
  }
}
