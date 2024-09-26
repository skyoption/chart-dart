import 'dart:math';

import 'package:candle_chart/components/kprint.dart';
import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/indectors/ma_methods_screen.dart';
import 'package:candle_chart/k_chart_widget.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';

import '../entity/index.dart';

// import '../extends_futures/ema_indicator.dart';
class DataUtil {
  static calculate(
    List<KLineEntity> dataList, {
    int n = 20,
    k = 2,
  }) {
    // Group the indicators by type
    final SMA = chartProperties.indicators
        .where((e) => e.type == IndicatorType.SMA)
        .toList();
    final EMA = chartProperties.indicators
        .where((e) => e.type == IndicatorType.EMA)
        .toList();
    final LINEARMA = chartProperties.indicators
        .where((e) => e.type == IndicatorType.LINEARMA)
        .toList();
    final SMMA = chartProperties.indicators
        .where((e) => e.type == IndicatorType.SMMA)
        .toList();
    if (SMA.isNotEmpty) calcSMA(dataList, SMA);
    if (EMA.isNotEmpty) calcEMA(dataList, EMA);
    if (LINEARMA.isNotEmpty) calcLinearMa(dataList, LINEARMA);
    if (SMMA.isNotEmpty) calcSmoothedMa(dataList, SMMA);

    // Other indicators
    calcBOLL(dataList, n, k);
    calcVolumeMA(dataList);
    calcKDJ(dataList);
    calcMACD(dataList);
    calcRSI(dataList);
    calcWR(dataList);
    calcCCI(dataList);
  }

  static void calcSMA(
    List<KLineEntity> dataList,
    List<IndicatorEntity> indicators,
  ) {
    for (var indicator in indicators) {
      for (int i = indicator.period - 1; i < dataList.length; i++) {
        KLineEntity entity = dataList[i];
        if (i >= indicator.period - 1) {
          double sum = 0;
          for (int j = i; j > i - indicator.period; j--) {
            sum += dataList[j].close;
          }
          double smaValue = sum / indicator.period;
          entity.smaValues ??= List<IndicatorEntity>.filled(
              indicators.length, indicator.copy(value: 0));
          entity.smaValues![indicators.indexOf(indicator)].value = smaValue;
        } else {
          entity.smaValues ??= List<IndicatorEntity>.filled(
              indicators.length, indicator.copy(value: 0));
        }
      }
    }
  }

  static void calcLinearMa(
    List<KLineEntity> dataList,
    List<IndicatorEntity> indicators,
  ) {
    for (var indicator in indicators) {
      for (int i = indicator.period - 1; i < dataList.length; i++) {
        if (i >= indicator.period - 1) {
          double numerator = 0;
          double denominator = (indicator.period * (indicator.period + 1)) / 2;
          for (int j = 0; j < indicator.period; j++) {
            numerator += dataList[i - j].close * (indicator.period - j);
          }
          double lwmaValue = numerator / denominator;
          dataList[i].lwmaValues ??= List<IndicatorEntity>.filled(
              indicators.length, indicator.copy(value: 0));
          dataList[i].lwmaValues![indicators.indexOf(indicator)].value =
              lwmaValue;
        } else {
          dataList[i].lwmaValues ??= List<IndicatorEntity>.filled(
              indicators.length, indicator.copy(value: 0));
        }
      }
    }
  }

  static void calcEMA(
    List<KLineEntity> dataList,
    List<IndicatorEntity> indicators,
  ) {
    if (dataList.isEmpty) return;

    for (var indicator in indicators) {
      double? previousEma;
      for (int i = indicator.period - 1; i < dataList.length; i++) {
        KLineEntity entity = dataList[i];
        entity.emaValues ??= List<IndicatorEntity>.filled(
            indicators.length, indicator.copy(value: 0));

        if (i == 0) {
          // Initialize the first EMA value with the close price
          previousEma = entity.close;
        } else {
          double multiplier = 2 / (indicator.period + 1);
          previousEma = previousEma != null
              ? ((entity.close - previousEma) * multiplier + previousEma)
              : entity.close;
        }

        entity.emaValues![indicators.indexOf(indicator)].value = previousEma;
      }
    }
  }

  static void calcSmoothedMa(
    List<KLineEntity> dataList,
    List<IndicatorEntity> indicators,
  ) {
    for (var indicator in indicators) {
      double? previousSmma;

      // Loop through data starting from the period - 1
      for (int i = indicator.period - 1; i < dataList.length; i++) {
        KLineEntity entity = dataList[i];

        // Initialize smmaValues list if it's null
        entity.smmaValues ??= List<IndicatorEntity>.filled(
            indicators.length, indicator.copy(value: 0));

        if (i == indicator.period - 1) {
          // First SMMA value: Simple Moving Average (SMA)
          double sum = 0;
          for (int j = 0; j < indicator.period; j++) {
            sum += dataList[j].close;
          }
          previousSmma = sum / indicator.period;
          entity.smmaValues?[indicators.indexOf(indicator)].value =
              previousSmma;
        } else {
          // Subsequent SMMA values
          double currentClose = entity.close;
          previousSmma =
              ((previousSmma! * (indicator.period - 1)) + currentClose) /
                  indicator.period;

          // Set the current SMMA value in the list
          entity.smmaValues?[indicators.indexOf(indicator)].value =
              previousSmma;
        }
      }
    }
  }

  static void calcBOLL(List<KLineEntity> dataList, int n, int k) {
    _calcBOLLMA(n, dataList);
    for (int i = 0; i < dataList.length; i++) {
      KLineEntity entity = dataList[i];
      if (i >= n) {
        double md = 0;
        for (int j = i - n + 1; j <= i; j++) {
          double c = dataList[j].close;
          double m = entity.BOLLMA!;
          md += pow(c - m, 2);
        }
        md = sqrt(md / (n - 1));
        entity.mb = entity.BOLLMA!;
        entity.up = entity.mb! + k * md;
        entity.dn = entity.mb! - k * md;
      }
    }
  }

  static void _calcBOLLMA(int day, List<KLineEntity> dataList) {
    double ma = 0;
    for (int i = 0; i < dataList.length; i++) {
      KLineEntity entity = dataList[i];
      ma += entity.close;
      if (i == day - 1) {
        entity.BOLLMA = ma / day;
      } else if (i >= day) {
        ma -= dataList[i - day].close;
        entity.BOLLMA = ma / day;
      } else {
        entity.BOLLMA = null;
      }
    }
  }

  static void calcMACD(List<KLineEntity> dataList) {
    double ema12 = 0;
    double ema26 = 0;
    double dif = 0;
    double dea = 0;
    double macd = 0;

    for (int i = 0; i < dataList.length; i++) {
      KLineEntity entity = dataList[i];
      final closePrice = entity.close;
      if (i == 0) {
        ema12 = closePrice;
        ema26 = closePrice;
      } else {
        ema12 = ema12 * 11 / 13 + closePrice * 2 / 13;
        ema26 = ema26 * 25 / 27 + closePrice * 2 / 27;
      }
      dif = ema12 - ema26;
      dea = dea * 8 / 10 + dif * 2 / 10;
      macd = (dif - dea) * 2;
      entity.dif = dif;
      entity.dea = dea;
      entity.macd = macd;
    }
  }

  static void calcVolumeMA(List<KLineEntity> dataList) {
    double volumeMa5 = 0;
    double volumeMa10 = 0;

    for (int i = 0; i < dataList.length; i++) {
      KLineEntity entry = dataList[i];

      volumeMa5 += entry.vol;
      volumeMa10 += entry.vol;

      if (i == 4) {
        entry.MA5Volume = (volumeMa5 / 5);
      } else if (i > 4) {
        volumeMa5 -= dataList[i - 5].vol;
        entry.MA5Volume = volumeMa5 / 5;
      } else {
        entry.MA5Volume = 0;
      }

      if (i == 9) {
        entry.MA10Volume = volumeMa10 / 10;
      } else if (i > 9) {
        volumeMa10 -= dataList[i - 10].vol;
        entry.MA10Volume = volumeMa10 / 10;
      } else {
        entry.MA10Volume = 0;
      }
    }
  }

  static void calcRSI(List<KLineEntity> dataList) {
    double? rsi;
    double rsiABSEma = 0;
    double rsiMaxEma = 0;
    for (int i = 0; i < dataList.length; i++) {
      KLineEntity entity = dataList[i];
      final double closePrice = entity.close;
      if (i == 0) {
        rsi = 0;
        rsiABSEma = 0;
        rsiMaxEma = 0;
      } else {
        double rMax = max(0, closePrice - dataList[i - 1].close.toDouble());
        double rAbs = (closePrice - dataList[i - 1].close.toDouble()).abs();

        rsiMaxEma = (rMax + (14 - 1) * rsiMaxEma) / 14;
        rsiABSEma = (rAbs + (14 - 1) * rsiABSEma) / 14;
        rsi = (rsiMaxEma / rsiABSEma) * 100;
      }
      if (i < 13) rsi = null;
      if (rsi != null && rsi.isNaN) rsi = null;
      entity.rsi = rsi;
    }
  }

  static void calcKDJ(List<KLineEntity> dataList) {
    var preK = 50.0;
    var preD = 50.0;
    final tmp = dataList.first;
    tmp.k = preK;
    tmp.d = preD;
    tmp.j = 50.0;
    for (int i = 1; i < dataList.length; i++) {
      final entity = dataList[i];
      final n = max(0, i - 8);
      var low = entity.low;
      var high = entity.high;
      for (int j = n; j < i; j++) {
        final t = dataList[j];
        if (t.low < low) {
          low = t.low;
        }
        if (t.high > high) {
          high = t.high;
        }
      }
      final cur = entity.close;
      var rsv = (cur - low) * 100.0 / (high - low);
      rsv = rsv.isNaN ? 0 : rsv;
      final k = (2 * preK + rsv) / 3.0;
      final d = (2 * preD + k) / 3.0;
      final j = 3 * k - 2 * d;
      preK = k;
      preD = d;
      entity.k = k;
      entity.d = d;
      entity.j = j;
    }
  }

  static void calcWR(List<KLineEntity> dataList) {
    double r;
    for (int i = 0; i < dataList.length; i++) {
      KLineEntity entity = dataList[i];
      int startIndex = i - 14;
      if (startIndex < 0) {
        startIndex = 0;
      }
      double max14 = double.minPositive;
      double min14 = double.maxFinite;
      for (int index = startIndex; index <= i; index++) {
        max14 = max(max14, dataList[index].high);
        min14 = min(min14, dataList[index].low);
      }
      if (i < 13) {
        entity.r = -10;
      } else {
        r = -100 * (max14 - dataList[i].close) / (max14 - min14);
        if (r.isNaN) {
          entity.r = null;
        } else {
          entity.r = r;
        }
      }
    }
  }

  static void calcCCI(List<KLineEntity> dataList) {
    final size = dataList.length;
    final count = 14;
    for (int i = 0; i < size; i++) {
      final kline = dataList[i];
      final tp = (kline.high + kline.low + kline.close) / 3;
      final start = max(0, i - count + 1);
      var amount = 0.0;
      var len = 0;
      for (int n = start; n <= i; n++) {
        amount += (dataList[n].high + dataList[n].low + dataList[n].close) / 3;
        len++;
      }
      final ma = amount / len;
      amount = 0.0;
      for (int n = start; n <= i; n++) {
        amount +=
            (ma - (dataList[n].high + dataList[n].low + dataList[n].close) / 3)
                .abs();
      }
      final md = amount / len;
      kline.cci = ((tp - ma) / 0.015 / md);
      if (kline.cci!.isNaN) {
        kline.cci = 0.0;
      }
    }
  }

// static calcMA(List<KLineEntity> dataList, List<int> maDayList) {
//   List<double> ma = List<double>.filled(maDayList.length, 0);
//
//   if (dataList.isNotEmpty) {
//     for (int i = 0; i < dataList.length; i++) {
//       KLineEntity entity = dataList[i];
//       final closePrice = entity.close;
//       entity.maValues = List<double>.filled(maDayList.length, 0);
//
//       for (int j = 0; j < maDayList.length; j++) {
//         ma[j] += closePrice;
//         if (i == maDayList[j] - 1) {
//           entity.maValues?[j] = ma[j] / maDayList[j];
//         } else if (i >= maDayList[j]) {
//           ma[j] -= dataList[i - maDayList[j]].close;
//           entity.maValues?[j] = ma[j] / maDayList[j];
//         } else {
//           entity.maValues?[j] = 0;
//         }
//       }
//     }
//   }
// }
}
