import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/entity/object_entity.dart';
import 'package:candle_chart/k_chart_widget.dart';
import 'package:candle_chart/utils/isar.dart';
import 'package:candle_chart/utils/kprint.dart';
import 'package:isar_community/isar.dart';

mixin Objects {
  late String symbol;
  late CandleTimeFormat frame;

  List<ObjectEntity> get objects {
    return [
      ...horizontalLines,
      ...tPAndSLLines,
      ...verticalLines,
      ...trendLines,
      ...rectangles,
      ...fibonaccis,
      ...fibonacciTimeZones,
      ...fibonacciFans,
      ...fibonacciArcs,
      ...fibonacciChannels,
    ];
  }

  ObjectEntity? cursor;
  List<ObjectEntity> horizontalLines = [];
  List<ObjectEntity> tPAndSLLines = [];
  List<ObjectEntity> verticalLines = [];
  List<ObjectEntity> trendLines = [];
  List<ObjectEntity> rectangles = [];
  List<ObjectEntity> fibonaccis = [];
  List<ObjectEntity> fibonacciTimeZones = [];
  List<ObjectEntity> fibonacciFans = [];
  List<ObjectEntity> fibonacciArcs = [];
  List<ObjectEntity> fibonacciChannels = [];
  ObjectEntity? lastItem;

  Future<void> loadObjects(String symbol) async {
    this.symbol = symbol;
    await _getObjects(symbol);
  }

  ObjectEntity setCopy(ObjectEntity item) {
    if (lastItem != null) {
      item.style = lastItem!.style;
      item.color = lastItem!.color;
      item.height = lastItem!.height;
      item.isFill = lastItem!.isFill;
      item.drawAsBackground = lastItem!.drawAsBackground;
    }
    return item;
  }

  Future<void> addVerticalLine(
    ObjectEntity value,
    List<KLineEntity> data,
  ) async {
    lastItem = value;
    value.symbol = symbol;
    value.frame = frame;
    value.type = ObjectType.Vertical;
    value.currentEditIndex = verticalLines.length;
    value = setCopy(value);
    verticalLines.add(value);
    KChart.write(query: (db) async {
      await db.objectEntitys.put(value);
    });
    _getObjects(symbol);
  }

  Future<void> addTrendLine(ObjectEntity value) async {
    lastItem = value;
    value.type = ObjectType.Trend;
    value.frame = frame;
    value.currentEditIndex = trendLines.length;
    value = setCopy(value);
    value.symbol = symbol;
    trendLines.add(value);
    KChart.write(query: (db) async {
      await db.objectEntitys.put(value);
    });
  }

  Future<void> addFibonacci(ObjectEntity value) async {
    lastItem = value;
    value.type = ObjectType.Fibonacci;
    value.frame = frame;
    value.currentEditIndex = fibonaccis.length;
    value = setCopy(value);
    value.symbol = symbol;
    fibonaccis.add(value);
    KChart.write(query: (db) async {
      await db.objectEntitys.put(value);
    });
  }

  Future<void> addFibonacciTimeZone(ObjectEntity value) async {
    lastItem = value;
    value.type = ObjectType.FibonacciTimeZones;
    value.frame = frame;
    value.currentEditIndex = fibonacciTimeZones.length;
    value = setCopy(value);
    value.symbol = symbol;
    fibonacciTimeZones.add(value);
    KChart.write(query: (db) async {
      await db.objectEntitys.put(value);
    });
  }

  Future<void> addFibonacciFan(ObjectEntity value) async {
    lastItem = value;
    value.type = ObjectType.FibonacciFan;
    value.frame = frame;
    value.currentEditIndex = fibonacciFans.length;
    value = setCopy(value);
    value.symbol = symbol;
    fibonacciFans.add(value);
    KChart.write(query: (db) async {
      await db.objectEntitys.put(value);
    });
  }

  Future<void> addFibonacciArcs(ObjectEntity value) async {
    lastItem = value;
    value.type = ObjectType.FibonacciArcs;
    value.frame = frame;
    value.currentEditIndex = fibonacciArcs.length;
    value = setCopy(value);
    value.symbol = symbol;
    fibonacciArcs.add(value);
    KChart.write(query: (db) async {
      await db.objectEntitys.put(value);
    });
  }

  Future<void> addFibonacciChannel(ObjectEntity value) async {
    lastItem = value;
    value.type = ObjectType.FibonacciChannel;
    value.frame = frame;
    value.currentEditIndex = fibonacciChannels.length;
    value = setCopy(value);
    value.symbol = symbol;
    fibonacciChannels.add(value);
    KChart.write(query: (db) async {
      await db.objectEntitys.put(value);
    });
  }

  Future<void> addHorizontalLine(ObjectEntity value) async {
    lastItem = value;
    value.type = ObjectType.Horizontal;
    value.frame = frame;
    value.currentEditIndex = horizontalLines.length;
    value = setCopy(value);
    value.symbol = symbol;
    horizontalLines.add(value);
    KChart.write(query: (db) async {
      await db.objectEntitys.put(value);
    });
  }

  Future<void> addTPAndSLLine(ObjectEntity value) async {
    value.symbol = symbol;
    value.frame = frame;
    value.currentEditIndex = tPAndSLLines.length;
    tPAndSLLines.add(value);
  }

  Future<void> addRectangle(ObjectEntity value) async {
    lastItem = value;
    value.type = ObjectType.Rectangle;
    value.frame = frame;
    value.currentEditIndex = rectangles.length;
    value = setCopy(value);
    value.symbol = symbol;
    rectangles.add(value);
    KChart.write(query: (db) async {
      await db.objectEntitys.put(value);
    });
  }

  Future<void> removeVerticalLine(int id) async {
    final index = verticalLines.indexWhere((e) => e.id == id);
    if (index != -1) {
      verticalLines.removeAt(index);
      KChart.write(query: (db) async {
        await db.objectEntitys.delete(id);
      });
    }
  }

  Future<void> removeTrendLine(int id) async {
    final index = trendLines.indexWhere((e) => e.id == id);
    if (index != -1) {
      trendLines.removeAt(index);
      KChart.write(query: (db) async {
        await db.objectEntitys.delete(id);
      });
    }
  }

  Future<void> removeFibonacci(int id) async {
    final index = fibonaccis.indexWhere((e) => e.id == id);
    if (index != -1) {
      fibonaccis.removeAt(index);
      KChart.write(query: (db) async {
        await db.objectEntitys.delete(id);
      });
    }
  }

  Future<void> removeFibonacciTimeZone(int id) async {
    final index = fibonacciTimeZones.indexWhere((e) => e.id == id);
    if (index != -1) {
      fibonacciTimeZones.removeAt(index);
      KChart.write(query: (db) async {
        await db.objectEntitys.delete(id);
      });
    }
  }

  Future<void> removeFibonacciFan(int id) async {
    final index = fibonacciFans.indexWhere((e) => e.id == id);
    if (index != -1) {
      fibonacciFans.removeAt(index);
      KChart.write(query: (db) async {
        await db.objectEntitys.delete(id);
      });
    }
  }

  Future<void> removeFibonacciArcs(int id) async {
    final index = fibonacciArcs.indexWhere((e) => e.id == id);
    if (index != -1) {
      fibonacciArcs.removeAt(index);
      KChart.write(query: (db) async {
        await db.objectEntitys.delete(id);
      });
    }
  }

  Future<void> removeFibonacciChannel(int id) async {
    final index = fibonacciChannels.indexWhere((e) => e.id == id);
    if (index != -1) {
      fibonacciChannels.removeAt(index);
      KChart.write(query: (db) async {
        await db.objectEntitys.delete(id);
      });
    }
  }

  Future<void> removeHorizontalLine(int id) async {
    final index = horizontalLines.indexWhere((e) => e.id == id);
    if (index != -1) {
      horizontalLines.removeAt(index);
      KChart.write(query: (db) async {
        await db.objectEntitys.delete(id);
      });
    }
  }

  Future<void> removeRectangle(int id) async {
    final index = rectangles.indexWhere((e) => e.id == id);
    if (index != -1) {
      rectangles.removeAt(index);
      KChart.write(query: (db) async {
        await db.objectEntitys.delete(id);
      });
    }
  }

  Future<void> removePosition(int id) async {
    final index = tPAndSLLines.indexWhere((e) => e.id == id);
    if (index != -1) {
      tPAndSLLines.removeAt(index);
    }
  }

  Future<void> updateVerticalLine(ObjectEntity value) async {
    final index = verticalLines.indexWhere((e) => e.id == value.id);
    if (index != -1) {
      verticalLines[index] = value;
      KChart.write(query: (db) async {
        await db.objectEntitys.put(value);
      });
    }
  }

  Future<void> updateTrendLine(ObjectEntity value) async {
    final index = trendLines.indexWhere((e) => e.id == value.id);
    if (index != -1) {
      trendLines[index] = value;
      KChart.write(query: (db) async {
        await db.objectEntitys.put(value);
      });
    }
  }

  Future<void> updateFibonacci(ObjectEntity value) async {
    final index = fibonaccis.indexWhere((e) => e.id == value.id);
    if (index != -1) {
      fibonaccis[index] = value;
      KChart.write(query: (db) async {
        await db.objectEntitys.put(value);
      });
    }
  }

  Future<void> updateFibonacciTimeZone(ObjectEntity value) async {
    final index = fibonacciTimeZones.indexWhere((e) => e.id == value.id);
    if (index != -1) {
      fibonacciTimeZones[index] = value;
      KChart.write(query: (db) async {
        await db.objectEntitys.put(value);
      });
    }
  }

  Future<void> updateFibonacciFan(ObjectEntity value) async {
    final index = fibonacciFans.indexWhere((e) => e.id == value.id);
    if (index != -1) {
      fibonacciFans[index] = value;
      KChart.write(query: (db) async {
        await db.objectEntitys.put(value);
      });
    }
  }

  Future<void> updateFibonacciArcs(ObjectEntity value) async {
    final index = fibonacciArcs.indexWhere((e) => e.id == value.id);
    if (index != -1) {
      fibonacciArcs[index] = value;
      KChart.write(query: (db) async {
        await db.objectEntitys.put(value);
      });
    }
  }

  Future<void> updateFibonacciChannel(ObjectEntity value) async {
    final index = fibonacciChannels.indexWhere((e) => e.id == value.id);
    if (index != -1) {
      fibonacciChannels[index] = value;
      KChart.write(query: (db) async {
        await db.objectEntitys.put(value);
      });
    }
  }

  Future<void> updateHorizontalLine(ObjectEntity value) async {
    final index = horizontalLines.indexWhere((e) => e.id == value.id);
    if (index != -1) {
      horizontalLines[index] = value;
      KChart.write(query: (db) async {
        await db.objectEntitys.put(value);
      });
    }
  }

  Future<void> updatePositionLine(ObjectEntity value) async {
    final index = tPAndSLLines.indexWhere((e) => e.id == value.id);
    if (index != -1) {
      tPAndSLLines[index] = value;
    }
  }

  Future<void> disUpdatePositionLine(ObjectEntity value) async {
    final index = tPAndSLLines.indexWhere((e) => e.id == value.id);
    if (index != -1) {
      tPAndSLLines[index] = value;
      tPAndSLLines[index].currentEditIndex = -1;
    }
  }

  Future<void> updateRectangle(ObjectEntity value) async {
    final index = rectangles.indexWhere((e) => e.id == value.id);
    if (index != -1) {
      rectangles[index] = value;
      KChart.write(query: (db) async {
        await db.objectEntitys.put(value);
      });
    }
  }

  Future<void> updateObject(ObjectEntity value) async {
    int index = trendLines.indexWhere((e) => e.id == value.id);
    if (index != -1) {
      trendLines[index] = value;
    } else if (index == -1) {
      index = horizontalLines.indexWhere((e) => e.id == value.id);
      if (index != -1) horizontalLines[index] = value;
    } else if (index == -1) {
      index = tPAndSLLines.indexWhere((e) => e.id == value.id);
      if (index != -1) tPAndSLLines[index] = value;
    } else if (index == -1) {
      index = verticalLines.indexWhere((e) => e.id == value.id);
      if (index != -1) verticalLines[index] = value;
    } else if (index == -1) {
      index = rectangles.indexWhere((e) => e.id == value.id);
      if (index != -1) rectangles[index] = value;
    }
    if (index != -1) {
      KChart.write(query: (db) async {
        await db.objectEntitys.put(value);
      });
    }
  }

  Future<void> _getObjects(String symbol) async {
    try {
      final objects = await KChart.query.objectEntitys
          .filter()
          .symbolEqualTo(symbol)
          .findAll();
      rectangles.clear();
      trendLines.clear();
      verticalLines.clear();
      horizontalLines.clear();
      fibonaccis.clear();
      fibonacciTimeZones.clear();
      fibonacciFans.clear();
      fibonacciArcs.clear();
      fibonacciChannels.clear();
      for (var item in objects) {
        if (item.type == ObjectType.Rectangle) {
          rectangles.add(item);
        } else if (item.type == ObjectType.Fibonacci) {
          fibonaccis.add(item);
        } else if (item.type == ObjectType.FibonacciTimeZones) {
          fibonacciTimeZones.add(item);
        } else if (item.type == ObjectType.FibonacciFan) {
          fibonacciFans.add(item);
        } else if (item.type == ObjectType.FibonacciArcs) {
          fibonacciArcs.add(item);
        } else if (item.type == ObjectType.FibonacciChannel) {
          fibonacciChannels.add(item);
        } else if (item.type == ObjectType.Trend) {
          trendLines.add(item);
        } else if (item.type == ObjectType.Horizontal) {
          horizontalLines.add(item);
        } else if (item.type == ObjectType.Vertical) {
          verticalLines.add(item);
        }
      }
    } catch (e) {
      return kPrint(e.toString());
    }
  }
}
