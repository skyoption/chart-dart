import 'package:flutter/material.dart';
import 'package:example/core/enums/position_sort.dart';
import 'package:example/features/symbols/models/schema/symbol_model.dart';
import 'package:example/features/trade/models/schema/position_model.dart';

class PositionEntity {
  int id;
  String groupSymbol;
  String direction;
  double volumeInit;
  double volumeCurrent;
  double openPrice;
  double tp;
  double sl;
  double floating;
  double margin;
  double commission;
  double swap;
  String comment;
  String openTime;

  PositionEntity({
    required this.id,
    required this.groupSymbol,
    required this.direction,
    required this.volumeInit,
    required this.volumeCurrent,
    required this.openPrice,
    required this.tp,
    required this.sl,
    required this.floating,
    required this.margin,
    required this.commission,
    required this.swap,
    required this.comment,
    required this.openTime,
  });

  late ValueNotifier<double> floatingChange = ValueNotifier(floating);

  PositionModel copyToModel() {
    return PositionModel(
      id: id,
      margin: margin,
      direction: direction,
      comment: comment,
      commission: commission,
      floating: floating,
      openPrice: openPrice,
      openTime: openTime,
      sl: sl,
      swap: swap,
      tp: tp,
      volumeCurrent: volumeCurrent,
      volumeInit: volumeInit,
      groupSymbol: groupSymbol,
    );
  }
}

extension OnPosition on PositionEntity {
  double? float(SymbolModel item) {
    double value = 0;
    if (direction == 'BUY') {
      value = (item.bid - openPrice) *
          item.contractSize *
          volumeCurrent *
          item.profitRatio;
    } else {
      value = (openPrice - item.ask) *
          item.contractSize *
          volumeCurrent *
          item.profitRatio;
    }
    if (value == 0) return null;
    return value;
  }

  //
  // distance * contractSize * currentVolume * profitRatio
  //
  // if buy :
  // distance = currency bid - openPrice
  // if sell:
  // distance  = openPrice - currentAsk
}

extension PositionSort on List<PositionEntity> {
  void sortByConfig(PositionSortConfig config) {
    sort((a, b) {
      final comparison = switch (config.criteria) {
        PositionSortCriteria.positionNumber => a.id.compareTo(b.id),
        PositionSortCriteria.openTime => a.openTime.compareTo(b.openTime),
        PositionSortCriteria.symbol => a.groupSymbol.compareTo(b.groupSymbol),
        PositionSortCriteria.profit => a.floating.compareTo(b.floating),
      };
      return config.isAscending ? comparison : -comparison;
    });
  }

  List<PositionEntity> filterBySymbol(String symbol) {
    if (symbol == "All") return this;
    return where((position) => position.groupSymbol == symbol).toList();
  }
}
