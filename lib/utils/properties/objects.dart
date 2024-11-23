import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/entity/object_entity.dart';
import 'package:candle_chart/utils/date_util.dart';
import 'package:candle_chart/utils/isar.dart';
import 'package:candle_chart/utils/kprint.dart';
import 'package:isar/isar.dart';

mixin Objects {
  late String symbol;
  late CandleTimeFormat frame;

  List<ObjectEntity> objects = [];
  List<ObjectEntity> horizontalLines = [];
  List<ObjectEntity> verticalLines = [];
  List<ObjectEntity> trendLines = [];
  List<ObjectEntity> rectangles = [];

  Future<void> loadObjects() async {
    await _getObjects();
    await _getVerticalLines();
    await _getHorizontalLines();
    await _getTrendLines();
    await _getRectanglesLines();
  }

  void addVerticalLine(
    ObjectEntity value,
    List<KLineEntity> data,
  ) {
    value.symbol = symbol;
    value.frame = frame;
    value.type = ObjectType.Vertical;
    value.currentEditIndex = verticalLines.length;
    verticalLines.add(value);
    KChart.write(query: (db) async {
      await db.objectEntitys.put(value);
      _getObjects();
    });
  }

  void addTrendLine(ObjectEntity value) {
    value.symbol = symbol;
    value.type = ObjectType.Trend;
    value.frame = frame;
    value.currentEditIndex = trendLines.length;
    trendLines.add(value);
    KChart.write(query: (db) async {
      await db.objectEntitys.put(value);
      _getObjects();
    });
  }

  void addHorizontalLine(ObjectEntity value) {
    value.symbol = symbol;
    value.type = ObjectType.Horizontal;
    value.frame = frame;
    value.currentEditIndex = horizontalLines.length;
    horizontalLines.add(value);
    KChart.write(query: (db) async {
      await db.objectEntitys.put(value);
      _getObjects();
    });
  }

  void addRectangle(ObjectEntity value) {
    value.symbol = symbol;
    value.type = ObjectType.Rectangle;
    value.frame = frame;
    value.currentEditIndex = rectangles.length;
    rectangles.add(value);
    KChart.write(query: (db) async {
      await db.objectEntitys.put(value);
      _getObjects();
    });
  }

  Future<void> removeVerticalLine(int id) async {
    final index = verticalLines.indexWhere((e) => e.id == id);
    verticalLines.removeAt(index);
    await KChart.write(query: (db) async {
      await db.objectEntitys.delete(id);
    });
    await _getObjects();
  }

  Future<void> removeTrendLine(int id) async {
    final index = trendLines.indexWhere((e) => e.id == id);
    trendLines.removeAt(index);
    await KChart.write(query: (db) async {
      await db.objectEntitys.delete(id);
    });
    await _getObjects();
  }

  Future<void> removeHorizontalLine(int id) async {
    final index = horizontalLines.indexWhere((e) => e.id == id);
    horizontalLines.removeAt(index);
    await KChart.write(query: (db) async {
      await db.objectEntitys.delete(id);
    });
    await _getObjects();
  }

  Future<void> removeRectangle(int id) async {
    final index = rectangles.indexWhere((e) => e.id == id);
    rectangles.removeAt(index);
    await KChart.write(query: (db) async {
      await db.objectEntitys.delete(id);
    });
    await _getObjects();
  }

  Future<void> updateVerticalLine(ObjectEntity value) async {
    final index = verticalLines.indexWhere((e) => e.id == value.id);
    if (index != -1) {
      verticalLines[index] = value;
      await KChart.write(query: (db) async {
        await db.objectEntitys.put(value);
      });
      await _getObjects();
    }
  }

  Future<void> updateTrendLine(ObjectEntity value) async {
    final index = trendLines.indexWhere((e) => e.id == value.id);
    if (index != -1) {
      trendLines[index] = value;
      await KChart.write(query: (db) async {
        await db.objectEntitys.put(value);
        _getObjects();
      });
    }
  }

  Future<void> updateHorizontalLine(ObjectEntity value) async {
    final index = horizontalLines.indexWhere((e) => e.id == value.id);
    if (index != -1) {
      horizontalLines[index] = value;
      await KChart.write(query: (db) async {
        await db.objectEntitys.put(value);
      });
    }
  }

  Future<void> updateRectangle(ObjectEntity value) async {
    final index = rectangles.indexWhere((e) => e.id == value.id);
    if (index != -1) {
      rectangles[index] = value;
      await KChart.write(query: (db) async {
        await db.objectEntitys.put(value);
        _getObjects();
      });
    }
  }

  Future<void> _getVerticalLines() async {
    try {
      final res = await KChart.query.objectEntitys
          .filter()
          .typeEqualTo(ObjectType.Vertical)
          .symbolEqualTo(symbol)
          .findAll();
      verticalLines = res;
    } catch (e) {
      return kPrint(e.toString());
    }
  }

  Future<void> _getHorizontalLines() async {
    try {
      final res = await KChart.query.objectEntitys
          .filter()
          .typeEqualTo(ObjectType.Horizontal)
          .symbolEqualTo(symbol)
          .findAll();
      horizontalLines = res;
    } catch (e) {
      return kPrint(e.toString());
    }
  }

  Future<void> _getTrendLines() async {
    try {
      final res = await KChart.query.objectEntitys
          .filter()
          .typeEqualTo(ObjectType.Trend)
          .symbolEqualTo(symbol)
          .findAll();
      trendLines = res;
    } catch (e) {
      return kPrint(e.toString());
    }
  }

  Future<void> _getRectanglesLines() async {
    try {
      final res = await KChart.query.objectEntitys
          .filter()
          .typeEqualTo(ObjectType.Rectangle)
          .symbolEqualTo(symbol)
          .findAll();
      rectangles = res;
    } catch (e) {
      return kPrint(e.toString());
    }
  }

  Future<void> _getObjects() async {
    try {
      final res = await KChart.query.objectEntitys
          .filter()
          .symbolEqualTo(symbol)
          .findAll();
      objects = res;
    } catch (e) {
      return kPrint(e.toString());
    }
  }
}
