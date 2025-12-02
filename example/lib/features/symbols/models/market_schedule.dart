/// Market schedule configuration and logic for different sectors
class MarketSchedule {
  /// Checks if a market is currently closed based on sector and symbol
  static bool isMarketClosed({
    required String sector,
    required String symbol,
    required DateTime time,
  }) {
    final sectorLower = sector.toLowerCase();
    final symbolUpper = symbol.toUpperCase();

    // Crypto is always open
    if (sectorLower == "crypto") {
      return false;
    }

    final weekday = time.weekday;
    final hour = time.hour;
    final minute = time.minute;

    // Special case: Gold has daily closure between 22:00-23:00 UTC
    if (sectorLower == "metal" && symbolUpper == "XAUUSD") {
      if (weekday == DateTime.saturday || weekday == DateTime.sunday) {
        return true;
      }
      return (hour == 22) || (hour == 23 && minute == 0);
    }

    // Forex (all types) closes Friday 22:00 UTC and reopens Sunday 22:00 UTC
    if (_isForexSector(sectorLower)) {
      if (weekday == DateTime.friday && hour >= 22) return true;
      if (weekday == DateTime.saturday) return true;
      if (weekday == DateTime.sunday && hour < 22) return true;
      return false;
    }

    // Stocks close Friday 20:00 UTC and reopen Monday 13:30 UTC
    if (_isStocksSector(sectorLower)) {
      if (weekday == DateTime.friday &&
          (hour > 20 || (hour == 20 && minute > 0))) {
        return true;
      }
      if (weekday == DateTime.saturday || weekday == DateTime.sunday) {
        return true;
      }
      if (weekday == DateTime.monday &&
          (hour < 13 || (hour == 13 && minute < 30))) {
        return true;
      }
      return false;
    }

    // Indices close Friday 20:00 UTC and reopen Monday 13:30 UTC
    if (_isIndicesSector(sectorLower)) {
      if (weekday == DateTime.friday &&
          (hour > 20 || (hour == 20 && minute > 0))) {
        return true;
      }
      if (weekday == DateTime.saturday || weekday == DateTime.sunday) {
        return true;
      }
      if (weekday == DateTime.monday &&
          (hour < 13 || (hour == 13 && minute < 30))) {
        return true;
      }
      return false;
    }

    // Commodities close Friday 20:00 UTC and reopen Monday 08:00 UTC
    if (_isCommoditiesSector(sectorLower)) {
      if (weekday == DateTime.friday &&
          (hour > 20 || (hour == 20 && minute > 0))) {
        return true;
      }
      if (weekday == DateTime.saturday || weekday == DateTime.sunday) {
        return true;
      }
      if (weekday == DateTime.monday && hour < 8) {
        return true;
      }
      return false;
    }

    // Other metals - similar to gold
    if (sectorLower == "metal") {
      if (weekday == DateTime.saturday || weekday == DateTime.sunday) {
        return true;
      }
      return (hour == 22) || (hour == 23 && minute == 0);
    }

    // Default: Closed on weekends
    return weekday == DateTime.saturday || weekday == DateTime.sunday;
  }

  /// Gets the next market open time for a sector and symbol
  static DateTime getNextOpenTime({
    required String sector,
    required String symbol,
  }) {
    final sectorLower = sector.toLowerCase();
    final symbolUpper = symbol.toUpperCase();

    // Crypto is always open
    if (sectorLower == "crypto") {
      return DateTime.now().toUtc();
    }

    // Gold (XAUUSD) has special daily closure
    if (sectorLower == "metal" && symbolUpper == "XAUUSD") {
      return _getGoldOpenTime();
    }

    // Forex (all types) opens Sunday 22:00 UTC
    if (_isForexSector(sectorLower)) {
      return _getForexOpenTime();
    }

    // Indices open Monday 13:30 UTC
    if (_isIndicesSector(sectorLower)) {
      return _getIndicesOpenTime();
    }

    // Stocks open Monday 13:30 UTC
    if (_isStocksSector(sectorLower)) {
      return _getStocksOpenTime();
    }

    // Other metals - same as gold
    if (sectorLower == "metal") {
      return _getGoldOpenTime();
    }

    // Commodities open Monday 08:00 UTC
    if (_isCommoditiesSector(sectorLower)) {
      return _getCommoditiesOpenTime();
    }

    // Default: Monday 00:00 UTC
    return _getOtherSymbolsOpenTime();
  }

  // Helper methods to check sector types
  static bool _isForexSector(String sectorLower) {
    return sectorLower == "forex" ||
        sectorLower == "forex majors" ||
        sectorLower == "forexmajor" ||
        sectorLower == "forex minors" ||
        sectorLower == "forexminor";
  }

  static bool _isStocksSector(String sectorLower) {
    return sectorLower == "equities" ||
        sectorLower == "stock" ||
        sectorLower == "stocks";
  }

  static bool _isIndicesSector(String sectorLower) {
    return sectorLower == "indices" ||
        sectorLower == "indexes" ||
        sectorLower == "index";
  }

  static bool _isCommoditiesSector(String sectorLower) {
    return sectorLower == "commodities" || sectorLower == "commodity";
  }

  // Market open time getters
  static DateTime _getGoldOpenTime() {
    final now = DateTime.now().toUtc();
    final todayAt2301 = DateTime.utc(now.year, now.month, now.day, 23, 1, 0);
    if (now.isBefore(todayAt2301)) {
      return todayAt2301;
    } else {
      return DateTime.utc(now.year, now.month, now.day + 1, 23, 1, 0);
    }
  }

  static DateTime _getForexOpenTime() {
    final now = DateTime.now().toUtc();
    final currentWeekday = now.weekday;

    if (currentWeekday == DateTime.sunday) {
      final todayAt2200 = DateTime.utc(now.year, now.month, now.day, 22, 0, 0);
      if (now.isBefore(todayAt2200)) {
        return todayAt2200;
      }
    }

    final daysUntilSunday = (DateTime.sunday - currentWeekday) % 7;
    final nextSunday = now.add(
      Duration(days: daysUntilSunday == 0 ? 7 : daysUntilSunday),
    );
    return DateTime.utc(
      nextSunday.year,
      nextSunday.month,
      nextSunday.day,
      22,
      0,
      0,
    );
  }

  static DateTime _getStocksOpenTime() {
    return _getNextMondayAt(13, 30);
  }

  static DateTime _getIndicesOpenTime() {
    return _getNextMondayAt(13, 30);
  }

  static DateTime _getCommoditiesOpenTime() {
    return _getNextMondayAt(8, 0);
  }

  static DateTime _getOtherSymbolsOpenTime() {
    return _getNextMondayAt(0, 0);
  }

  static DateTime _getNextMondayAt(int hour, int minute) {
    final now = DateTime.now().toUtc();
    final daysUntilMonday = (DateTime.monday - now.weekday) % 7;
    final nextMonday = now.add(
      Duration(days: daysUntilMonday == 0 ? 7 : daysUntilMonday),
    );
    return DateTime.utc(
      nextMonday.year,
      nextMonday.month,
      nextMonday.day,
      hour,
      minute,
      0,
    );
  }
}
