import 'dart:io';

import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/entity/object_entity.dart';
import 'package:candle_chart/entity/symbol_enity.dart';
import 'package:candle_chart/utils/kprint.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class KChart {
  static Isar? isar;

  static Future<void> openDB() async {
    final baseUrl = await getCachePath();
    isar = await Isar.open(
      [
        ObjectEntitySchema,
        IndicatorEntitySchema,
        SymbolSchema,
      ],
      name: 'candle-chart-v2',
      directory: baseUrl,
    );
  }

  static Future<void> write({required Function(Isar db) query}) async {
    return await isar!.writeTxn(() async {
      await query(isar!); // insert & update & delete
    });
  }

  static Isar get query {
    return isar!; // get & queries & filters
  }

  static Future<String> getCachePath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationCacheDirectory();
      } else {
        directory = await getTemporaryDirectory();
      }
    } catch (err) {
      kPrint(err.toString());
    }
    return directory?.path ?? '/';
  }
}
