import 'dart:math';

import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/k_chart_widget.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';

class IndicatorUtils {
  static calculate(List<KLineEntity> data) {
    List<IndicatorEntity> SMA_MA = [],
        EMA_MA = [],
        Linear_MA = [],
        Smoothed_MA = [],
        SMA_ENVELOPS = [],
        EMA_ENVELOPS = [],
        LINEAR_ENVELOPS = [],
        SMMA_ENVELOPS = [],
        BOLL = [],
        PARABOLIC = [];

    /// Group the indicators by type
    for (var indicator in chartProperties.indicators) {
      if (indicator.type == IndicatorType.SMA_MA) {
        SMA_MA.add(indicator);
      } else if (indicator.type == IndicatorType.EMA_MA) {
        EMA_MA.add(indicator);
      } else if (indicator.type == IndicatorType.LINEAR_MA) {
        Linear_MA.add(indicator);
      } else if (indicator.type == IndicatorType.SMMA_MA) {
        Smoothed_MA.add(indicator);
      } else if (indicator.type == IndicatorType.SMA_ENVELOPS) {
        SMA_ENVELOPS.add(indicator);
      } else if (indicator.type == IndicatorType.EMA_ENVELOPS) {
        EMA_ENVELOPS.add(indicator);
      } else if (indicator.type == IndicatorType.LINEAR_ENVELOPS) {
        LINEAR_ENVELOPS.add(indicator);
      } else if (indicator.type == IndicatorType.SMMA_ENVELOPS) {
        SMMA_ENVELOPS.add(indicator);
      } else if (indicator.type == IndicatorType.BOLL) {
        BOLL.add(indicator);
      } else if (indicator.type == IndicatorType.PARABOLIC) {
        PARABOLIC.add(indicator);
      }
    }

    if (SMA_MA.isNotEmpty) calc_SMA_MA(data, SMA_MA);
    if (EMA_MA.isNotEmpty) calc_EMA_MA(data, EMA_MA);
    if (Linear_MA.isNotEmpty) calc_Linear_MA(data, Linear_MA);
    if (Smoothed_MA.isNotEmpty) calc_Smoothed_MA(data, Smoothed_MA);
    if (SMA_ENVELOPS.isNotEmpty) calc_SMA_Envelops(data, SMA_ENVELOPS);
    if (EMA_ENVELOPS.isNotEmpty) calc_EMA_Envelops(data, EMA_ENVELOPS);
    if (LINEAR_ENVELOPS.isNotEmpty) calc_Linear_Envelops(data, LINEAR_ENVELOPS);
    if (SMMA_ENVELOPS.isNotEmpty) calc_Smoothed_Envelops(data, SMMA_ENVELOPS);
    if (BOLL.isNotEmpty) calc_BOLL(data, BOLL);
    if (PARABOLIC.isNotEmpty) calc_Parabolic_SAR(data, PARABOLIC);

    /// calc the volume indicator
    calcVolumeMA(data);

    /// Other indicators
    calcKDJ(data);
    calcMACD(data);
    calcRSI(data);
    calcWR(data);
    calcCCI(data);
  }

  static void calc_SMA_MA(
    List<KLineEntity> dataList,
    List<IndicatorEntity> indicators,
  ) {
    for (var indicator in indicators) {
      for (int i = indicator.period; i < dataList.length; i++) {
        KLineEntity entity = dataList[i];
        entity.smaMaValues = null;
        if (i >= indicator.period - 1) {
          double sum = 0;
          for (int j = i; j > i - indicator.period; j--) {
            sum += _currentPriceValue(indicator, dataList[j]);
          }
          double smaValue = sum / indicator.period;
          entity.smaMaValues ??= List<IndicatorEntity>.filled(
              indicators.length, indicator.copy(value: 0));

          entity.smaMaValues![indicators.indexOf(indicator)].value = smaValue;
        } else {
          entity.smaMaValues ??= List<IndicatorEntity>.filled(
              indicators.length, indicator.copy(value: 0));
        }
      }
    }
  }

  static void calc_Linear_MA(
    List<KLineEntity> dataList,
    List<IndicatorEntity> indicators,
  ) {
    for (var indicator in indicators) {
      for (int i = indicator.period - 1; i < dataList.length; i++) {
        KLineEntity entity = dataList[i];
        entity.lwmaMaValues = null;
        if (i >= indicator.period - 1) {
          double numerator = 0;
          double denominator = (indicator.period * (indicator.period + 1)) / 2;
          for (int j = 0; j < indicator.period; j++) {
            numerator += _currentPriceValue(indicator, dataList[i - j]) *
                (indicator.period - j);
          }
          double lwmaValue = numerator / denominator;
          entity.lwmaMaValues ??= List<IndicatorEntity>.filled(
              indicators.length, indicator.copy(value: 0));

          entity.lwmaMaValues![indicators.indexOf(indicator)].value = lwmaValue;
        } else {
          entity.lwmaMaValues ??= List<IndicatorEntity>.filled(
              indicators.length, indicator.copy(value: 0));
        }
      }
    }
  }

  static void calc_EMA_MA(
    List<KLineEntity> dataList,
    List<IndicatorEntity> indicators,
  ) {
    if (dataList.isEmpty) return;

    for (var indicator in indicators) {
      double? previousEma;
      for (int i = indicator.period; i < dataList.length; i++) {
        KLineEntity entity = dataList[i];
        entity.emaMaValues = null;
        entity.emaMaValues ??= List<IndicatorEntity>.filled(
            indicators.length, indicator.copy(value: 0));

        if (i == 0) {
          // Initialize the first EMA value with the close price
          previousEma = _currentPriceValue(indicator, entity);
        } else {
          double multiplier = 2 / (indicator.period + 1);
          previousEma = previousEma != null
              ? ((_currentPriceValue(indicator, entity) - previousEma) *
                      multiplier +
                  previousEma)
              : _currentPriceValue(indicator, entity);
        }

        entity.emaMaValues![indicators.indexOf(indicator)].value = previousEma;
      }
    }
  }

  static void calc_Smoothed_MA(
    List<KLineEntity> dataList,
    List<IndicatorEntity> indicators,
  ) {
    for (var indicator in indicators) {
      double? previousSmma;

      // Loop through data starting from the period - 1
      for (int i = indicator.period - 1; i < dataList.length; i++) {
        KLineEntity entity = dataList[i];
        entity.smmaMaValues = null;
        // Initialize smmaValues list if it's null
        entity.smmaMaValues ??= List<IndicatorEntity>.filled(
            indicators.length, indicator.copy(value: 0));

        if (i == indicator.period - 1) {
          // First SMMA value: Simple Moving Average (SMA)
          double sum = 0;
          for (int j = 0; j < indicator.period; j++) {
            sum += _currentPriceValue(indicator, dataList[j]);
          }
          previousSmma = sum / indicator.period;
          entity.smmaMaValues?[indicators.indexOf(indicator)].value =
              previousSmma;
        } else {
          // Subsequent SMMA values
          double currentClose = _currentPriceValue(indicator, entity);
          previousSmma =
              ((previousSmma! * (indicator.period - 1)) + currentClose) /
                  indicator.period;

          // Set the current SMMA value in the list
          entity.smmaMaValues?[indicators.indexOf(indicator)].value =
              previousSmma;
        }
      }
    }
  }

  static void calc_BOLL(
    List<KLineEntity> dataList,
    List<IndicatorEntity> indicators,
  ) {
    for (var indicator in indicators) {
      // Calculate the moving average (Middle Band)
      List<double> movingAverage = _calcBOLLMA(dataList, indicator);

      // Loop over data and calculate the Upper and Lower bands
      for (int i = 0; i < dataList.length; i++) {
        KLineEntity entity = dataList[i];
        entity.bollValues = null;
        // Initialize smmaValues list if it's null
        entity.bollValues ??= List<IndicatorEntity>.filled(
            indicators.length, indicator.copy(value: 0));
        if (i >= indicator.period - 1) {
          double sumOfSquares = 0;

          // Calculate the standard deviation for this window
          for (int j = i - indicator.period + 1; j <= i; j++) {
            double currentPrice = _currentPriceValue(indicator, dataList[j]);
            sumOfSquares += pow(currentPrice - movingAverage[i], 2);
          }

          double standardDeviation = sqrt(sumOfSquares / indicator.period);

          // Calculate Bollinger Bands
          entity.bollValues![indicators.indexOf(indicator)].value =
              movingAverage[i]; // Middle Band (SMA)
          entity.bollValues![indicators.indexOf(indicator)].up =
              entity.bollValues![indicators.indexOf(indicator)].value +
                  (standardDeviation * indicator.deviations!); // Upper Band
          entity.bollValues![indicators.indexOf(indicator)].dn =
              entity.bollValues![indicators.indexOf(indicator)].value -
                  (standardDeviation * indicator.deviations!); // Lower Band
        } else {
          // For the early data points, set bands to null (or zero if needed)
          entity.bollValues?[indicators.indexOf(indicator)].value = 0;
          entity.bollValues?[indicators.indexOf(indicator)].up = null;
          entity.bollValues?[indicators.indexOf(indicator)].dn = null;
        }
      }
    }
  }

  static List<double> _calcBOLLMA(
    List<KLineEntity> dataList,
    IndicatorEntity indicator,
  ) {
    List<double> movingAverage = List.filled(dataList.length, 0);
    double sum = 0;

    // Calculate the simple moving average (SMA)
    for (int i = 0; i < dataList.length; i++) {
      double currentPrice = _currentPriceValue(indicator, dataList[i]);
      sum += currentPrice;

      if (i >= indicator.period - 1) {
        movingAverage[i] = sum / indicator.period;
        sum -=
            _currentPriceValue(indicator, dataList[i - indicator.period + 1]);
      } else {
        movingAverage[i] = 0; // For the first few data points
      }
    }

    return movingAverage;
  }

  static void calc_Parabolic_SAR(
    List<KLineEntity> dataList,
    List<IndicatorEntity> indicators,
  ) {
    if (dataList.isEmpty) return;

    for (var indicator in indicators) {
      // Initialize variables
      bool uptrend = true; // Start assuming an uptrend (you can modify this)
      double sar = dataList.first.low; // Initial SAR value
      double af = indicator.steps!; // Initial acceleration factor (AF)
      double extremePoint = dataList.first.high; // Initial extreme point (EP)

      for (int i = 1; i < dataList.length; i++) {
        KLineEntity entity = dataList[i];

        entity.parabolicValues = null;
        // Initialize smmaValues list if it's null
        entity.parabolicValues ??= List<IndicatorEntity>.filled(
            indicators.length, indicator.copy(value: 0));
        // Update the SAR value
        sar = sar + af * (extremePoint - sar);

        if (uptrend) {
          // In an uptrend, SAR can't exceed the low of the current or previous bar
          sar = min(sar, dataList[i - 1].low);
          sar = min(sar, entity.low);

          // If price falls below the SAR, trend reverses to downtrend
          if (entity.low < sar) {
            uptrend = false;
            sar = extremePoint; // Reset SAR to the extreme point
            extremePoint =
                entity.low; // Set the extreme point for the downtrend
            af = indicator.steps!; // Reset AF
          } else {
            // Update extreme point if a new high is reached
            if (entity.high > extremePoint) {
              extremePoint = entity.high;
              af = min(af + indicator.steps!,
                  indicator.maximum!); // Increase AF but not beyond the maximum
            }
          }
        } else {
          // In a downtrend, SAR can't fall below the high of the current or previous bar
          sar = max(sar, dataList[i - 1].high);
          sar = max(sar, entity.high);

          // If price rises above the SAR, trend reverses to uptrend
          if (entity.high > sar) {
            uptrend = true;
            sar = extremePoint; // Reset SAR to the extreme point
            extremePoint = entity.high; // Set the extreme point for the uptrend
            af = indicator.steps!; // Reset AF
          } else {
            // Update extreme point if a new low is reached
            if (entity.low < extremePoint) {
              extremePoint = entity.low;
              af = min(af + indicator.steps!,
                  indicator.maximum!); // Increase AF but not beyond the maximum
            }
          }
        }

        // Assign the SAR value to the current candle
        entity.parabolicValues?[indicators.indexOf(indicator)].value = sar;
      }
    }
  }

  static void calc_SMA_Envelops(
    List<KLineEntity> dataList,
    List<IndicatorEntity> indicators,
  ) {
    for (var indicator in indicators) {
      for (int i = indicator.period - 1; i < dataList.length; i++) {
        KLineEntity entity = dataList[i];
        entity.smaEnvelopsValues = null;

        if (i >= indicator.period - 1) {
          double sum = 0;
          for (int j = i; j > i - indicator.period; j--) {
            sum += _currentPriceValue(indicator, dataList[j]);
          }
          double smaValue = sum / indicator.period;
          double upperEnvelope = smaValue * (1 + indicator.deviations! / 100);
          double lowerEnvelope = smaValue * (1 - indicator.deviations! / 100);

          entity.smaEnvelopsValues ??= List<IndicatorEntity>.filled(
              indicators.length, indicator.copy(value: 0));
          entity.smaEnvelopsValues![indicators.indexOf(indicator)].value =
              smaValue;
          entity.smaEnvelopsValues![indicators.indexOf(indicator)].up =
              upperEnvelope;
          entity.smaEnvelopsValues![indicators.indexOf(indicator)].dn =
              lowerEnvelope;
        } else {
          entity.smaEnvelopsValues ??= List<IndicatorEntity>.filled(
              indicators.length, indicator.copy(value: 0));
        }
      }
    }
  }

  static void calc_EMA_Envelops(
    List<KLineEntity> dataList,
    List<IndicatorEntity> indicators,
  ) {
    if (dataList.isEmpty) return;

    for (var indicator in indicators) {
      double? previousEma;
      for (int i = indicator.period; i < dataList.length; i++) {
        KLineEntity entity = dataList[i];
        entity.emaEnvelopsValues = null;
        entity.emaEnvelopsValues ??= List<IndicatorEntity>.filled(
            indicators.length, indicator.copy(value: 0));

        if (i == 0) {
          previousEma = _currentPriceValue(indicator, entity);
        } else {
          double multiplier = 2 / (indicator.period + 1);
          previousEma = previousEma != null
              ? ((_currentPriceValue(indicator, entity) - previousEma) *
                      multiplier +
                  previousEma)
              : _currentPriceValue(indicator, entity);
        }

        double upperEnvelope = previousEma * (1 + indicator.deviations! / 100);
        double lowerEnvelope = previousEma * (1 - indicator.deviations! / 100);

        entity.emaEnvelopsValues![indicators.indexOf(indicator)].value =
            previousEma;
        entity.emaEnvelopsValues![indicators.indexOf(indicator)].up =
            upperEnvelope;
        entity.emaEnvelopsValues![indicators.indexOf(indicator)].dn =
            lowerEnvelope;
      }
    }
  }

  static void calc_Linear_Envelops(
    List<KLineEntity> dataList,
    List<IndicatorEntity> indicators,
  ) {
    for (var indicator in indicators) {
      for (int i = indicator.period - 1; i < dataList.length; i++) {
        KLineEntity entity = dataList[i];
        entity.lwmaEnvelopsValues = null;

        if (i >= indicator.period - 1) {
          double numerator = 0;
          double denominator = (indicator.period * (indicator.period + 1)) / 2;
          for (int j = 0; j < indicator.period; j++) {
            numerator += _currentPriceValue(indicator, dataList[i - j]) *
                (indicator.period - j);
          }
          double lwmaValue = numerator / denominator;
          double upperEnvelope = lwmaValue * (1 + indicator.deviations! / 100);
          double lowerEnvelope = lwmaValue * (1 - indicator.deviations! / 100);

          entity.lwmaEnvelopsValues ??= List<IndicatorEntity>.filled(
              indicators.length, indicator.copy(value: 0));
          entity.lwmaEnvelopsValues![indicators.indexOf(indicator)].value =
              lwmaValue;
          entity.lwmaEnvelopsValues![indicators.indexOf(indicator)].up =
              upperEnvelope;
          entity.lwmaEnvelopsValues![indicators.indexOf(indicator)].dn =
              lowerEnvelope;
        } else {
          entity.lwmaEnvelopsValues ??= List<IndicatorEntity>.filled(
              indicators.length, indicator.copy(value: 0));
        }
      }
    }
  }

  static void calc_Smoothed_Envelops(
    List<KLineEntity> dataList,
    List<IndicatorEntity> indicators,
  ) {
    for (var indicator in indicators) {
      double? previousSmma;

      for (int i = indicator.period - 1; i < dataList.length; i++) {
        KLineEntity entity = dataList[i];
        entity.smmaEnvelopsValues = null;
        entity.smmaEnvelopsValues ??= List<IndicatorEntity>.filled(
            indicators.length, indicator.copy(value: 0));

        if (i == indicator.period - 1) {
          double sum = 0;
          for (int j = 0; j < indicator.period; j++) {
            sum += _currentPriceValue(indicator, dataList[j]);
          }
          previousSmma = sum / indicator.period;
          entity.smmaEnvelopsValues?[indicators.indexOf(indicator)].value =
              previousSmma;
        } else {
          double currentClose = _currentPriceValue(indicator, entity);
          previousSmma =
              ((previousSmma! * (indicator.period - 1)) + currentClose) /
                  indicator.period;

          entity.smmaEnvelopsValues?[indicators.indexOf(indicator)].value =
              previousSmma;
        }

        double upperEnvelope = previousSmma * (1 + indicator.deviations! / 100);
        double lowerEnvelope = previousSmma * (1 - indicator.deviations! / 100);

        entity.smmaEnvelopsValues![indicators.indexOf(indicator)].up =
            upperEnvelope;
        entity.smmaEnvelopsValues![indicators.indexOf(indicator)].dn =
            lowerEnvelope;
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

  static double _currentPriceValue(
    IndicatorEntity indicator,
    KLineEntity point,
  ) {
    if (indicator.applyTo == ApplyTo.Open) {
      return point.open;
    } else if (indicator.applyTo == ApplyTo.Low) {
      return point.low;
    } else if (indicator.applyTo == ApplyTo.High) {
      return point.high;
    } else if (indicator.applyTo == ApplyTo.Median_Price_HL$2) {
      return (point.high + point.low) / 2;
    } else if (indicator.applyTo == ApplyTo.Middle_Price_OC$2) {
      return (point.open + point.close) / 2;
    } else if (indicator.applyTo == ApplyTo.Typical_Price_HLC$3) {
      return (point.high + point.low + point.close) / 3;
    } else if (indicator.applyTo == ApplyTo.Weighted_Close_HLCC$4) {
      return (point.high + point.low + (point.close * 2)) / 4;
    } else {
      return point.close;
    }
  }
}
