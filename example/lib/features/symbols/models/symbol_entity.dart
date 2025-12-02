import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:example/features/symbols/models/market_schedule.dart';
import 'package:example/features/symbols/models/schema/symbol_model.dart';

class SymbolEntity {
  int id;
  String sector;
  String symbol;
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
  double askDifference;
  double bidDifference;
  int stopLevel;
  bool isFav;
  int index;
  String askColorHex;
  String bidColorHex;

  late ValueNotifier<int> dateTime = ValueNotifier(timestamp);
  late ValueNotifier<double> bidChange = ValueNotifier(bid);
  late ValueNotifier<double> askChange = ValueNotifier(ask);
  late ValueNotifier<Color> askColor = ValueNotifier(
    colorFromHex(askColorHex) ?? Colors.grey,
  );
  late ValueNotifier<Color> bidColor = ValueNotifier(
    colorFromHex(bidColorHex) ?? Colors.grey,
  );
  late ValueNotifier<bool> isFavChange = ValueNotifier(isFav);
  late ValueNotifier<double> spread = ValueNotifier((ask - bid) / tickSize);

  int get digits {
    if (tickSize == 0.00001) {
      return 5;
    } else if (tickSize == 0.0001) {
      return 4;
    } else if (tickSize == 0.001) {
      return 3;
    } else if (tickSize == 0.01) {
      return 2;
    } else if (tickSize == 0.1) {
      return 1;
    }
    return 1;
  }

  SymbolEntity({
    required this.id,
    required this.marginCurrency,
    required this.askColorHex,
    required this.bidColorHex,
    required this.profitCurrency,
    required this.description,
    required this.sector,
    required this.symbol,
    required this.leverage,
    required this.ask,
    required this.bid,
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

  SymbolModel copyToModel() {
    return SymbolModel(
      id: id,
      bidColorHex: bidColorHex,
      askColorHex: askColorHex,
      description: description,
      askDifference: askDifference,
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
      name: symbol,
      marginCurrency: marginCurrency,
      marginRatio: marginRatio,
      profitRatio: profitRatio,
      index: index,
    );
  }
}

extension SymbolEntityX on SymbolEntity {
  bool get isMarketClose {
    return MarketSchedule.isMarketClosed(
      sector: sector,
      symbol: symbol,
      time: DateTime.now().toUtc(),
    );
  }

  DateTime get symbolOpenTime {
    return MarketSchedule.getNextOpenTime(sector: sector, symbol: symbol);
  }
}

extension SymbolEntityExt on List<SymbolEntity> {
  List<SymbolEntity> get getOpenMarketSymbols {
    return where((symbol) => !symbol.isMarketClose).toList();
  }
}

final fakeSymbolEntity = SymbolEntity(
  id: 1,
  sector: "Forex",
  symbol: "EURUSD",
  leverage: 100,
  ask: 1.1050,
  bid: 1.1048,
  marginCurrency: "USD",
  description: "Euro vs US Dollar",
  profitCurrency: "USD",
  timestamp: DateTime.now().millisecondsSinceEpoch,
  groupSymbol: 1.0,
  contractSize: 100000.0,
  tickSize: 0.0001,
  profitRatio: 1.0,
  marginRatio: 1.0,
  swapLong: -0.5,
  swapShort: 0.3,
  commissionIn: 0.0,
  commissionOut: 0.0,
  volumeMin: 0.01,
  volumeMax: 100.0,
  volumeStep: 0.01,
  askDifference: 2,
  bidDifference: 2,
  stopLevel: 10,
  isFav: false,
  index: 1,
  askColorHex: "#00FF00",
  bidColorHex: "#FF0000",
);
