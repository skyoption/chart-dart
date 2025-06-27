import 'package:objectbox/objectbox.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';

@Entity()
class SymbolModel {
  @Id(assignable: true)
  int id;
  String sector;
  String name;
  int leverage;
  double ask;
  double bid;
  String marginCurrency;
  String description;
  String profitCurrency;
  int timestamp;
  double groupSymbol;
  double contractSize;
  double tickSize;
  double profitRatio;
  double marginRatio;
  double swapLong;
  double swapShort;
  double commissionIn;
  double commissionOut;
  double volumeMin;
  double volumeMax;
  double volumeStep;
  int askDifference;
  int bidDifference;
  int stopLevel;
  bool isFav;
  @Index()
  int index;
  String askColorHex;
  String bidColorHex;

  SymbolModel({
    required this.id,
    required this.marginCurrency,
    required this.profitCurrency,
    required this.description,
    required this.sector,
    required this.name,
    required this.leverage,
    required this.ask,
    required this.bid,
    required this.askColorHex,
    required this.bidColorHex,
    required this.timestamp,
    required this.groupSymbol,
    required this.contractSize,
    required this.tickSize,
    required this.profitRatio,
    required this.marginRatio,
    required this.swapLong,
    required this.swapShort,
    required this.commissionIn,
    required this.commissionOut,
    required this.volumeMin,
    required this.volumeMax,
    required this.volumeStep,
    required this.askDifference,
    required this.bidDifference,
    required this.stopLevel,
    required this.isFav,
    required this.index,
  });

  factory SymbolModel.fromJson(Map<String, dynamic> json) {
    return SymbolModel(
      id: json['symbol'] == null ? 0 : stringToInt(json['symbol'] as String),
      marginCurrency: json['marginCurrency'] as String? ?? '',
      profitCurrency: json['profitCurrency'] as String? ?? '',
      description: json['description'] as String? ?? '',
      sector: json['sector'] as String? ?? '',
      name: json['symbol'] as String? ?? '',
      leverage: (json['leverage'] as num?)?.toInt() ?? 0,
      ask: (json['ask'] as num?)?.toDouble() ?? 0,
      bid: (json['bid'] as num?)?.toDouble() ?? 0,
      bidColorHex: '',
      askColorHex: '',
      index: 0,
      timestamp: (json['timestamp'] as num?)?.toInt() ?? 0,
      groupSymbol: (json['groupSymbol'] as num?)?.toDouble() ?? 0,
      contractSize: (json['contractSize'] as num?)?.toDouble() ?? 0,
      tickSize: (json['tickSize'] as num?)?.toDouble() ?? 0,
      profitRatio: (json['profitRatio'] as num?)?.toDouble() ?? 0,
      marginRatio: (json['marginRatio'] as num?)?.toDouble() ?? 0,
      swapLong: (json['swapLong'] as num?)?.toDouble() ?? 0,
      swapShort: (json['swapShort'] as num?)?.toDouble() ?? 0,
      commissionIn: (json['commissionIn'] as num?)?.toDouble() ?? 0,
      commissionOut: (json['commissionOut'] as num?)?.toDouble() ?? 0,
      volumeMin: (json['volumeMin'] as num?)?.toDouble() ?? 0,
      volumeMax: (json['volumeMax'] as num?)?.toDouble() ?? 0,
      volumeStep: (json['volumeStep'] as num?)?.toDouble() ?? 0,
      askDifference: (json['askDifference'] as num?)?.toInt() ?? 0,
      bidDifference: (json['bidDifference'] as num?)?.toInt() ?? 0,
      stopLevel: (json['stopLevel'] as num?)?.toInt() ?? 0,
      isFav: json['isFav'] as bool? ?? false,
    );
  }
}

extension OnModel on SymbolModel {
  SymbolEntity copyToEntity() {
    return SymbolEntity(
      id: id,
      description: description,
      askDifference: askDifference,
      bidColorHex: bidColorHex,
      askColorHex: askColorHex,
      sector: sector,
      bidDifference: bidDifference,
      commissionIn: commissionIn,
      commissionOut: commissionOut,
      contractSize: contractSize,
      tickSize: tickSize,
      isFav: isFav,
      bid: bid,
      swapShort: swapShort,
      timestamp: timestamp,
      volumeMax: volumeMax,
      swapLong: swapLong,
      volumeMin: volumeMin,
      volumeStep: volumeStep,
      stopLevel: stopLevel,
      groupSymbol: groupSymbol,
      profitCurrency: profitCurrency,
      leverage: leverage,
      ask: ask,
      symbol: name,
      marginCurrency: marginCurrency,
      marginRatio: marginRatio,
      profitRatio: profitRatio,
      index: index,
    );
  }
}

int charToInt(String char) {
  if (char.isEmpty) {
    throw ArgumentError("Input must be a single alphabetic character.");
  }
  return char.toLowerCase().codeUnitAt(0) - 'a'.codeUnitAt(0) + 1;
}

int stringToInt(String input) {
  if (input.length == 1) {
    return charToInt(input.replaceAll(' ', ''));
  }
  final buffer = StringBuffer();
  for (var char in input.replaceAll(' ', '').split('')) {
    buffer.write(charToInt(char));
  }
  return int.parse(buffer.toString().replaceAll('-', ''));
}

extension SymbolModelX on SymbolModel {
  bool get isMarketClose {
    if (sector != "Crypto") {
      final gmt2 = DateTime.now().toUtc().add(const Duration(hours: 2));

      return gmt2.weekday == DateTime.saturday ||
          gmt2.weekday == DateTime.sunday;
    } else {
      return false;
    }
  }
}
