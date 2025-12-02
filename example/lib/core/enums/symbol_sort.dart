import 'package:example/app.dart';

enum SymbolSortCriteria {
  sortByName,
  activeTrades;

  String get displayName {
    switch (this) {
      case SymbolSortCriteria.sortByName:
        return SkyTrading.tr.name;
      case SymbolSortCriteria.activeTrades:
        return SkyTrading.tr.activeTrades;
    }
  }

  bool get canToggle {
    switch (this) {
      case SymbolSortCriteria.sortByName:
        return true;
      case SymbolSortCriteria.activeTrades:
        return false;
    }
  }

  bool get defaultAscending {
    switch (this) {
      case SymbolSortCriteria.sortByName:
        return true;
      case SymbolSortCriteria.activeTrades:
        return false;
    }
  }
}

class SymbolSortConfig {
  final SymbolSortCriteria criteria;
  final bool isAscending;
  final bool hideToggleIcon;
  const SymbolSortConfig({
    required this.criteria,
    required this.isAscending,
    this.hideToggleIcon = false,
  });
}
