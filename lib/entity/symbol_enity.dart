import 'package:candle_chart/k_chart_widget.dart';
import 'package:isar_community/isar.dart';

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
