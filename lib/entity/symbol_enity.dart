import 'package:candle_chart/utils/date_util.dart';
import 'package:isar/isar.dart';

part 'symbol_enity.g.dart';

@collection
class Symbol {
  Id id = Isar.autoIncrement;
  String symbol = 'USD';

  @enumerated
  CandleTimeFormat frame = CandleTimeFormat.H4;

  Symbol({
    this.frame = CandleTimeFormat.H4,
    this.symbol = 'USD',
    this.id = Isar.autoIncrement,
  });
}
