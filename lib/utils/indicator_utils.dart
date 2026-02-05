import 'dart:math';

import 'package:candle_chart/entity/candle_indicator_entity.dart';
import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/renderer/rects/secondary_rect.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';

class IndicatorUtils {
  static calculate(List<KLineEntity> data, List<IndicatorEntity> indicators,
      Map<int, List<IndicatorEntity>> secondaries) async {
    List<IndicatorEntity> MA_SMA = [],
        MA_EMA = [],
        MA_LINEAR = [],
        MA_Smoothed = [],
        ENVELOPS_SMA = [],
        ENVELOPS_EMA = [],
        ENVELOPS_LINEAR = [],
        ENVELOPS_SMMA = [],
        BOLL = [],
        ICHIMOKU = [],
        PARABOLIC = [],
        RSI = [],
        MACD = [],
        ATR = [],
        CCI = [],
        DEM = [],
        MOM = [],
        SO = [],
        WPR = [],
        MFI = [];

    /// reset candles
    // _resetCandles(data);

    /// Group the indicators by type
    for (var indicator in indicators) {
      if (indicator.type == IndicatorType.MA_SMA) {
        MA_SMA.add(indicator);
      } else if (indicator.type == IndicatorType.MA_EMA) {
        MA_EMA.add(indicator);
      } else if (indicator.type == IndicatorType.MA_LINEAR) {
        MA_LINEAR.add(indicator);
      } else if (indicator.type == IndicatorType.MA_SMMA) {
        MA_Smoothed.add(indicator);
      } else if (indicator.type == IndicatorType.ENVELOPS_SMA) {
        ENVELOPS_SMA.add(indicator);
      } else if (indicator.type == IndicatorType.ENVELOPS_EMA) {
        ENVELOPS_EMA.add(indicator);
      } else if (indicator.type == IndicatorType.ENVELOPS_LINEAR) {
        ENVELOPS_LINEAR.add(indicator);
      } else if (indicator.type == IndicatorType.ENVELOPS_SMMA) {
        ENVELOPS_SMMA.add(indicator);
      } else if (indicator.type == IndicatorType.BOLL) {
        BOLL.add(indicator);
      } else if (indicator.type == IndicatorType.PARABOLIC) {
        PARABOLIC.add(indicator);
      } else if (indicator.type == IndicatorType.ICHIMOKU) {
        ICHIMOKU.add(indicator);
      }
    }

    for (var item in secondaries.entries) {
      for (var indicator in item.value) {
        if (indicator.type == IndicatorType.RSI) {
          RSI.add(indicator);
        } else if (indicator.type == IndicatorType.MACD) {
          MACD.add(indicator);
        } else if (indicator.type == IndicatorType.ATR) {
          ATR.add(indicator);
        } else if (indicator.type == IndicatorType.CCI) {
          CCI.add(indicator);
        } else if (indicator.type == IndicatorType.DEM) {
          DEM.add(indicator);
        } else if (indicator.type == IndicatorType.MOM) {
          MOM.add(indicator);
        } else if (indicator.type == IndicatorType.SO_LINEAR ||
            indicator.type == IndicatorType.SO_SMA ||
            indicator.type == IndicatorType.SO_EMA ||
            indicator.type == IndicatorType.SO_SMMA) {
          SO.add(indicator);
        } else if (indicator.type == IndicatorType.WPR) {
          WPR.add(indicator);
        } else if (indicator.type == IndicatorType.MFI) {
          MFI.add(indicator);
        } else if (indicator.type == IndicatorType.MA_SMA) {
          MA_SMA.add(indicator);
        } else if (indicator.type == IndicatorType.MA_EMA) {
          MA_EMA.add(indicator);
        } else if (indicator.type == IndicatorType.MA_LINEAR) {
          MA_LINEAR.add(indicator);
        } else if (indicator.type == IndicatorType.MA_SMMA) {
          MA_Smoothed.add(indicator);
        } else if (indicator.type == IndicatorType.ENVELOPS_SMA) {
          ENVELOPS_SMA.add(indicator);
        } else if (indicator.type == IndicatorType.ENVELOPS_EMA) {
          ENVELOPS_EMA.add(indicator);
        } else if (indicator.type == IndicatorType.ENVELOPS_LINEAR) {
          ENVELOPS_LINEAR.add(indicator);
        } else if (indicator.type == IndicatorType.ENVELOPS_SMMA) {
          ENVELOPS_SMMA.add(indicator);
        } else if (indicator.type == IndicatorType.BOLL) {
          BOLL.add(indicator);
        } else if (indicator.type == IndicatorType.PARABOLIC) {
          PARABOLIC.add(indicator);
        } else if (indicator.type == IndicatorType.ICHIMOKU) {
          ICHIMOKU.add(indicator);
        }
      }
    }

    if (RSI.isNotEmpty) calcRSI(data, RSI);
    if (MACD.isNotEmpty) calcMACD(data, MACD);
    if (ATR.isNotEmpty) calcATR(data, ATR);
    if (CCI.isNotEmpty) calcCCI(data, CCI);
    if (DEM.isNotEmpty) calcDeMarker(data, DEM);
    if (MOM.isNotEmpty) calcMomentum(data, MOM);
    if (SO.isNotEmpty) calcStochasticOscillator(data, SO);
    if (WPR.isNotEmpty) calcWilliamsPercentRange(data, WPR);
    if (MFI.isNotEmpty) calcMoneyFlowIndex(data, MFI);
    await Future.delayed(Duration(milliseconds: 150));
    if (MA_SMA.isNotEmpty) calc_SMA_MA(data, MA_SMA);
    if (MA_EMA.isNotEmpty) calc_EMA_MA(data, MA_EMA);
    if (MA_LINEAR.isNotEmpty) calc_Linear_MA(data, MA_LINEAR);
    if (MA_Smoothed.isNotEmpty) calc_Smoothed_MA(data, MA_Smoothed);
    if (ENVELOPS_SMA.isNotEmpty) calc_SMA_Envelops(data, ENVELOPS_SMA);
    if (ENVELOPS_EMA.isNotEmpty) calc_EMA_Envelops(data, ENVELOPS_EMA);
    if (ENVELOPS_LINEAR.isNotEmpty) calc_Linear_Envelops(data, ENVELOPS_LINEAR);
    if (ENVELOPS_SMMA.isNotEmpty) calc_Smoothed_Envelops(data, ENVELOPS_SMMA);
    if (BOLL.isNotEmpty) calc_BOLL(data, BOLL);
    if (PARABOLIC.isNotEmpty) calc_Parabolic_SAR(data, PARABOLIC);
    if (ICHIMOKU.isNotEmpty) calc_Ichimoku(data, ICHIMOKU);
    // if (trades.isNotEmpty) calc_Trade_Positions(data, trades);

    /// calc the volume indicator
    calcVolumeMA(data);
  }

  // static void _resetCandles(List<KLineEntity> data) {
  //   for (int k = 0; k < data.length; k++) {
  //     ///MA
  //     data[k].maEmaValues = null;
  //     data[k].maSmaValues = null;
  //     data[k].maLwmaValues = null;
  //     data[k].maSmmaValues = null;

  //     ///Envelops
  //     data[k].envelopsEmaValues = null;
  //     data[k].envelopsSmaValues = null;
  //     data[k].envelopsLwmaValues = null;
  //     data[k].envelopsSmmaValues = null;

  //     data[k].bollValues = null;
  //     data[k].parabolicValues = null;
  //     data[k].ichimokuValues = null;
  //     data[k].rsiValues = null;
  //     data[k].macdValues = null;
  //     data[k].macdSignalValues = null;
  //     data[k].cciValues = null;
  //     data[k].atrValues = null;
  //     data[k].deMarkerValues = null;
  //     data[k].momentumValues = null;
  //     data[k].wprValues = null;
  //     data[k].mfiValues = null;
  //     data[k].stochasticValues = null;
  //   }
  // }

  static void calc_SMA_MA(
    List<KLineEntity> dataList,
    List<IndicatorEntity> indicators,
  ) {
    for (int k = 0; k < indicators.length; k++) {
      final indicator = indicators[k];
      double sum = 0;
      for (int i = 0; i < dataList.length; i++) {
        KLineEntity entity = dataList[i];
        double price = _currentPriceValue(indicator, entity);
        sum += price;
        if (i >= indicator.period) {
          sum -= _currentPriceValue(indicator, dataList[i - indicator.period]);
        }

        entity.maSmaValues ??= List<CandleIndicatorEntity>.filled(
            indicators.length, indicator.copyToCandle(value: 0));

        if (i >= indicator.period - 1) {
          double smaValue = sum / indicator.period;
          entity.maSmaValues = _addNewIndicator(
            entity.maSmaValues,
            indicator,
            k,
          );
          entity.maSmaValues![k] = indicator.copyToCandle(value: smaValue);
        } else {
          // ensure initial padding if needed or just leave as is (usually 0 or null)
          // The usage pattern suggests we might need to initialize the list even if value is invalid?
          // Existing code did: entity.maSmaValues ??= ... value: 0
          // effectively filling with 0 until period is reached.
          entity.maSmaValues = _addNewIndicator(
            entity.maSmaValues,
            indicator,
            k,
          );
          entity.maSmaValues![k] = indicator.copyToCandle(value: 0);
        }
      }
    }
  }

  static void calc_Linear_MA(
    List<KLineEntity> dataList,
    List<IndicatorEntity> indicators,
  ) {
    for (int k = 0; k < indicators.length; k++) {
      final indicator = indicators[k];
      double sum = 0; // Regular sum (SMA part)
      double numerator = 0; // Weighted numerator
      double denominator = (indicator.period * (indicator.period + 1)) / 2;

      for (int i = 0; i < dataList.length; i++) {
        KLineEntity entity = dataList[i];

        entity.maLwmaValues ??= List<CandleIndicatorEntity>.filled(
            indicators.length, indicator.copyToCandle(value: 0));

        if (i < indicator.period - 1) {
          entity.maLwmaValues =
              _addNewIndicator(entity.maLwmaValues, indicator, k);
          entity.maLwmaValues![k] = indicator.copyToCandle(value: 0);
          continue;
        }

        if (i == indicator.period - 1) {
          sum = 0;
          numerator = 0;
          for (int j = 0; j < indicator.period; j++) {
            double val = _currentPriceValue(indicator, dataList[i - j]);
            sum += val;
            numerator += val * (indicator.period - j);
          }
        } else {
          // Recurrence for i >= period
          double price = _currentPriceValue(indicator, entity);
          double prevSum = sum;
          double valOut =
              _currentPriceValue(indicator, dataList[i - indicator.period]);

          numerator = numerator + (price * indicator.period) - prevSum;
          sum = sum + price - valOut;
        }

        double lwmaValue = numerator / denominator;
        entity.maLwmaValues = _addNewIndicator(
          entity.maLwmaValues,
          indicator,
          k,
        );
        entity.maLwmaValues![k] = indicator.copyToCandle(value: lwmaValue);
      }
    }
  }

  static void calc_EMA_MA(
    List<KLineEntity> dataList,
    List<IndicatorEntity> indicators,
  ) {
    if (dataList.isEmpty) return;

    for (int k = 0; k < indicators.length; k++) {
      final indicator = indicators[k];
      double? previousEma;
      for (int i = indicator.period - 1; i < dataList.length; i++) {
        KLineEntity entity = dataList[i];
        entity.maEmaValues ??= List<CandleIndicatorEntity>.filled(
            indicators.length, indicator.copyToCandle(value: 0));

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
        entity.maEmaValues = _addNewIndicator(
          entity.maEmaValues,
          indicator,
          k,
        );
        entity.maEmaValues![k] = indicator.copyToCandle(value: previousEma);
      }
    }
  }

  static void calc_Smoothed_MA(
    List<KLineEntity> dataList,
    List<IndicatorEntity> indicators,
  ) {
    for (int k = 0; k < indicators.length; k++) {
      final indicator = indicators[k];
      double? previousSmma;

      // Loop through data starting from the period - 1
      for (int i = indicator.period - 1; i < dataList.length; i++) {
        KLineEntity entity = dataList[i];
        entity.maSmmaValues ??= List<CandleIndicatorEntity>.filled(
            indicators.length, indicator.copyToCandle(value: 0));

        if (i == indicator.period - 1) {
          // First SMMA value: Simple Moving Average (SMA)
          double sum = 0;
          for (int j = 0; j < indicator.period; j++) {
            sum += _currentPriceValue(indicator, dataList[j]);
          }
          previousSmma = sum / indicator.period;
          entity.maSmmaValues = _addNewIndicator(
            entity.maSmmaValues,
            indicator,
            k,
          );
          entity.maSmmaValues![k] = indicator.copyToCandle(value: previousSmma);
        } else {
          // Subsequent SMMA values
          double currentClose = _currentPriceValue(indicator, entity);
          previousSmma =
              ((previousSmma! * (indicator.period - 1)) + currentClose) /
                  indicator.period;

          entity.maSmmaValues = _addNewIndicator(
            entity.maSmmaValues,
            indicator,
            k,
          );
          // Set the current SMMA value in the list
          entity.maSmmaValues![k] = indicator.copyToCandle(value: previousSmma);
        }
      }
    }
  }

  static void calc_BOLL(
    List<KLineEntity> dataList,
    List<IndicatorEntity> indicators,
  ) {
    if (dataList.isEmpty) return;

    for (int k = 0; k < indicators.length; k++) {
      final indicator = indicators[k];

      // We calculate SMA and SMA of Squares incrementally
      double sum = 0;
      double sumSq = 0;

      for (int i = 0; i < dataList.length; i++) {
        KLineEntity entity = dataList[i];
        double price = _currentPriceValue(indicator, entity);

        sum += price;
        sumSq += price * price;

        if (i >= indicator.period) {
          double outPrice =
              _currentPriceValue(indicator, dataList[i - indicator.period]);
          sum -= outPrice;
          sumSq -= outPrice * outPrice;
        }

        entity.bollValues ??= List<CandleIndicatorEntity>.filled(
            indicators.length, indicator.copyToCandle(value: 0));

        if (i >= indicator.period - 1) {
          double mean = sum / indicator.period;
          // Variance = (SumSq - (Sum^2)/N) / N
          // Standard Deviation = sqrt(Variance)

          double variance =
              (sumSq - (sum * sum / indicator.period)) / indicator.period;
          if (variance < 0) variance = 0; // Precision safety
          double standardDeviation = sqrt(variance);

          // Calculate Bollinger Bands
          final value = mean; // Middle Band is SMA
          final up =
              value + (standardDeviation * indicator.deviations!); // Upper Band
          final dn =
              value - (standardDeviation * indicator.deviations!); // Lower Band

          entity.bollValues![k] = indicator.copyToCandle(
            value: value,
            up: up,
            dn: dn,
          );
        } else {
          entity.bollValues?[k] = indicator.copyToCandle(
            value: 0,
            up: null,
            dn: null,
          );
        }
      }
    }
  }

  static void calc_Parabolic_SAR(
    List<KLineEntity> dataList,
    List<IndicatorEntity> indicators,
  ) {
    if (dataList.isEmpty) return;

    // Loop through each indicator
    for (int k = 0; k < indicators.length; k++) {
      final indicator = indicators[k];
      // Initialize trend-related variables
      bool uptrend =
          true; // Start by assuming an uptrend (this could be made more dynamic)
      double sar =
          dataList.first.low; // Initial SAR value, set to first bar's low
      double af = indicator.steps ?? 0.02; // Initial acceleration factor (AF)
      double extremePoint =
          dataList.first.high; // Set initial extreme point (EP) to first high

      // Loop through all data points
      for (int i = 1; i < dataList.length; i++) {
        KLineEntity entity = dataList[i];

        // Ensure each entity has space to store the parabolic SAR values
        entity.parabolicValues ??= List<CandleIndicatorEntity>.filled(
            indicators.length, indicator.copyToCandle(value: 0));

        // Update the SAR value using the formula
        sar = sar + af * (extremePoint - sar);

        if (uptrend) {
          // In an uptrend, SAR is placed below the candle (so, limit SAR below the lows)
          sar = min(sar, dataList[i - 1].low);
          sar = min(sar, entity.low);

          // Check for a trend reversal (price drops below SAR)
          if (entity.low < sar) {
            // Trend reversal to downtrend
            uptrend = false;
            sar = extremePoint; // Reset SAR to extreme point
            extremePoint =
                entity.low; // Set new extreme point (low for downtrend)
            af = indicator.steps ?? 0.02; // Reset acceleration factor
          } else {
            // Update extreme point if a new high is reached during the uptrend
            if (entity.high > extremePoint) {
              extremePoint = entity.high;
              sar = extremePoint; // Reset SAR to extreme point
              af =
                  min(af + (indicator.steps ?? 0.02), indicator.maximum ?? 0.2);
            }
          }
        } else {
          // In a downtrend, SAR is placed above the candle (so, limit SAR above the highs)
          sar = max(sar, dataList[i - 1].high);
          sar = max(sar, entity.high);

          // Check for a trend reversal (price rises above SAR)
          if (entity.high > sar) {
            // Trend reversal to uptrend
            uptrend = true;
            sar = extremePoint; // Reset SAR to extreme point
            extremePoint =
                entity.high; // Set new extreme point (high for uptrend)
            af = indicator.steps ?? 0.02; // Reset acceleration factor
          } else {
            // Update extreme point if a new low is reached during the downtrend
            if (entity.low < extremePoint) {
              extremePoint = entity.low;
              sar = extremePoint; // Reset SAR to extreme point
              af =
                  min(af + (indicator.steps ?? 0.02), indicator.maximum ?? 0.2);
            }
          }
        }
        entity.parabolicValues = _addNewIndicator(
          entity.parabolicValues,
          indicator,
          k,
        );
        entity.parabolicValues?[k] = indicator.copyToCandle(value: sar);
      }
    }
  }

  static void calc_SMA_Envelops(
    List<KLineEntity> dataList,
    List<IndicatorEntity> indicators,
  ) {
    for (int k = 0; k < indicators.length; k++) {
      final indicator = indicators[k];
      double sum = 0;

      for (int i = 0; i < dataList.length; i++) {
        KLineEntity entity = dataList[i];
        double price = _currentPriceValue(indicator, entity);
        sum += price;

        if (i >= indicator.period) {
          sum -= _currentPriceValue(indicator, dataList[i - indicator.period]);
        }

        entity.envelopsSmaValues ??= List<CandleIndicatorEntity>.filled(
            indicators.length, indicator.copyToCandle(value: 0));

        if (i >= indicator.period - 1) {
          double smaValue = sum / indicator.period;
          double upperEnvelope = smaValue * (1 + indicator.deviations! / 100);
          double lowerEnvelope = smaValue * (1 - indicator.deviations! / 100);

          entity.envelopsSmaValues = _addNewIndicator(
            entity.envelopsSmaValues,
            indicator,
            k,
          );

          entity.envelopsSmaValues?[k] = indicator.copyToCandle(
            value: smaValue,
            up: upperEnvelope,
            dn: lowerEnvelope,
          );
        } else {
          entity.envelopsSmaValues = _addNewIndicator(
            entity.envelopsSmaValues,
            indicator,
            k,
          );
          entity.envelopsSmaValues?[k] = indicator.copyToCandle(
            value: 0.0, // Or handle appropriately
            up: 0.0,
            dn: 0.0,
          );
        }
      }
    }
  }

  static void calc_EMA_Envelops(
    List<KLineEntity> dataList,
    List<IndicatorEntity> indicators,
  ) {
    if (dataList.isEmpty) return;

    for (int k = 0; k < indicators.length; k++) {
      final indicator = indicators[k];
      double? previousEma;
      for (int i = indicator.period; i < dataList.length; i++) {
        KLineEntity entity = dataList[i];
        entity.envelopsEmaValues ??= List<CandleIndicatorEntity>.filled(
            indicators.length, indicator.copyToCandle(value: 0));

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
        entity.envelopsEmaValues = _addNewIndicator(
          entity.envelopsEmaValues,
          indicator,
          k,
        );

        entity.envelopsEmaValues?[k] = indicator.copyToCandle(
          value: previousEma,
          up: upperEnvelope,
          dn: lowerEnvelope,
        );
      }
    }
  }

  static void calc_Linear_Envelops(
    List<KLineEntity> dataList,
    List<IndicatorEntity> indicators,
  ) {
    for (int k = 0; k < indicators.length; k++) {
      final indicator = indicators[k];
      double sum = 0; // SMA sum
      double numerator = 0; // Weighted sum
      double denominator = (indicator.period * (indicator.period + 1)) / 2;

      for (int i = 0; i < dataList.length; i++) {
        KLineEntity entity = dataList[i];

        entity.envelopsLwmaValues ??= List<CandleIndicatorEntity>.filled(
            indicators.length, indicator.copyToCandle(value: 0));

        if (i < indicator.period - 1) {
          entity.envelopsLwmaValues =
              _addNewIndicator(entity.envelopsLwmaValues, indicator, k);
          entity.envelopsLwmaValues?[k] = indicator.copyToCandle(value: 0);
          continue;
        }

        if (i == indicator.period - 1) {
          sum = 0;
          numerator = 0;
          for (int j = 0; j < indicator.period; j++) {
            double val = _currentPriceValue(indicator, dataList[i - j]);
            sum += val;
            numerator += val * (indicator.period - j);
          }
        } else {
          // i >= period recurrence
          double price = _currentPriceValue(indicator, entity);
          double prevSum = sum;
          double valOut =
              _currentPriceValue(indicator, dataList[i - indicator.period]);

          numerator = numerator + (price * indicator.period) - prevSum;
          sum = sum + price - valOut;
        }

        double lwmaValue = numerator / denominator;
        double upperEnvelope = lwmaValue * (1 + indicator.deviations! / 100);
        double lowerEnvelope = lwmaValue * (1 - indicator.deviations! / 100);

        entity.envelopsLwmaValues = _addNewIndicator(
          entity.envelopsLwmaValues,
          indicator,
          k,
        );
        entity.envelopsLwmaValues?[k] = indicator.copyToCandle(
          value: lwmaValue,
          up: upperEnvelope,
          dn: lowerEnvelope,
        );
      }
    }
  }

  static void calc_Smoothed_Envelops(
    List<KLineEntity> dataList,
    List<IndicatorEntity> indicators,
  ) {
    for (int k = 0; k < indicators.length; k++) {
      final indicator = indicators[k];
      double? previousSmma;

      for (int i = indicator.period - 1; i < dataList.length; i++) {
        KLineEntity entity = dataList[i];
        entity.envelopsSmmaValues ??= List<CandleIndicatorEntity>.filled(
            indicators.length, indicator.copyToCandle(value: 0));

        entity.envelopsSmmaValues = _addNewIndicator(
          entity.envelopsSmmaValues,
          indicator,
          k,
        );
        double value = 0;
        if (i == indicator.period - 1) {
          double sum = 0;
          for (int j = 0; j < indicator.period; j++) {
            sum += _currentPriceValue(indicator, dataList[j]);
          }
          previousSmma = sum / indicator.period;
          value = previousSmma;
        } else {
          double currentClose = _currentPriceValue(indicator, entity);
          previousSmma =
              ((previousSmma! * (indicator.period - 1)) + currentClose) /
                  indicator.period;

          value = previousSmma;
        }

        double upperEnvelope = previousSmma * (1 + indicator.deviations! / 100);
        double lowerEnvelope = previousSmma * (1 - indicator.deviations! / 100);

        entity.envelopsSmmaValues?[k] = indicator.copyToCandle(
          value: value,
          up: upperEnvelope,
          dn: lowerEnvelope,
        );
      }
    }
  }

  static void calc_Ichimoku(
    List<KLineEntity> dataList,
    List<IndicatorEntity> indicators,
  ) {
    if (dataList.isEmpty) return;

    // Pre-calculate Min/Max lists for optimized access?
    // Optimization: Calculate sliding MaxHigh/MinLow for all needed periods if possible.
    // However, Ichimoku uses different periods (Tenkan, Kijun, Senkou B).
    // And it needs "Expanding Range" for the initial part?
    // Original code: .getRange(max(0, i - period + 1), i + 1).
    // My _calculateSlidingMinMax handles "Expanding Range" correctly
    // because at index i < period, the queue only contains indices from 0 to i.
    // q.first <= i - period condition won't trigger until i >= period.
    // So distinct 'period` implies distinct sliding window results.
    // We can pre-compute them.

    List<double> highs = dataList.map((e) => e.high).toList();
    List<double> lows = dataList.map((e) => e.low).toList();

    for (int k = 0; k < indicators.length; k++) {
      final indicator = indicators[k];
      if (indicator.ichimoku != null) {
        Ichimoku ichimoku = indicator.ichimoku!;

        List<double> tenkanMax =
            _calculateSlidingMax(highs, ichimoku.tenkanSen);
        List<double> tenkanMin = _calculateSlidingMin(lows, ichimoku.tenkanSen);

        List<double> kijunMax = _calculateSlidingMax(highs, ichimoku.kijuSen);
        List<double> kijunMin = _calculateSlidingMin(lows, ichimoku.kijuSen);

        List<double> senkouBMax =
            _calculateSlidingMax(highs, ichimoku.senkouSpan);
        List<double> senkouBMin =
            _calculateSlidingMin(lows, ichimoku.senkouSpan);

        for (int i = 0; i < dataList.length; i++) {
          KLineEntity entity = dataList[i];

          entity.ichimokuValues ??= List<CandleIndicatorEntity>.filled(
              indicators.length, indicator.copyToCandle(value: 0));

          // Calculate Tenkan-sen (Conversion Line)
          double tenkanSen = (tenkanMax[i] + tenkanMin[i]) / 2;

          // Calculate Kijun-sen (Base Line)
          double kijunSen = (kijunMax[i] + kijunMin[i]) / 2;

          // Calculate Senkou Span A (shifted forward by Kijun period? No, Span A plotted at k?
          // Standard Ichimoku: Span A is (Tenkan + Kijun)/2 projected forward.
          // In this implementation:
          // double senkouSpanA = (tenkanSen + kijunSen) / 2;
          // But it should be plotted `kijuSen` bars ahead?
          // The current code assigns it to `entity` at `i`.
          // If the renderer handles displacement, fine.
          // Replicating original logic:
          double senkouSpanA = (tenkanSen + kijunSen) / 2;

          // Calculate Senkou Span B
          double senkouSpanB = (senkouBMax[i] + senkouBMin[i]) / 2;

          double? chikouSpan;
          if (i - ichimoku.kijuSen >= 0) {
            chikouSpan = dataList[i - ichimoku.kijuSen].close;
          }

          entity.ichimokuValues = _addNewIndicator(
            entity.ichimokuValues,
            indicator,
            k,
          );

          // Set values to ichimokuValues
          entity.ichimokuValues?[k] = indicator.copyToCandle(
            tenkanSen: tenkanSen,
            kijunSen: kijunSen,
            senkouSpanA: senkouSpanA,
            senkouSpanB: senkouSpanB,
            chikouSpan:
                chikouSpan, // Original: dataList[i - ichimoku.kijuSen].close
          );
        }
      }
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

  /// RSI calculation
  static void calcRSI(
    List<KLineEntity> dataList,
    List<IndicatorEntity> indicators,
  ) {
    for (int k = 0; k < indicators.length; k++) {
      final indicator = indicators[k];
      final int period = indicator.period;
      double gainSum = 0.0;
      double lossSum = 0.0;

      for (int i = 1; i < dataList.length; i++) {
        double change = _currentPriceValue(indicator, dataList[i]) -
            _currentPriceValue(indicator, dataList[i - 1]);

        dataList[i].rsiValues ??= List<CandleIndicatorEntity>.filled(
            indicators.length, indicator.copyToCandle(value: 0));

        dataList[i].rsiValues = _addNewIndicator(
          dataList[i].rsiValues,
          indicator,
          k,
        );

        if (i < period) {
          gainSum += max(0, change);
          lossSum += max(0, -change);
        } else if (i == period) {
          gainSum /= period;
          lossSum /= period;
          dataList[i].rsiValues![k] =
              _calculateRSI(gainSum, lossSum, indicator);
        } else {
          gainSum = (gainSum * (period - 1) + max(0, change)) / period;
          lossSum = (lossSum * (period - 1) + max(0, -change)) / period;
          dataList[i].rsiValues![k] =
              _calculateRSI(gainSum, lossSum, indicator);
        }
      }
    }
  }

  static CandleIndicatorEntity _calculateRSI(
    double avgGain,
    double avgLoss,
    IndicatorEntity indicator,
  ) {
    double rs = avgLoss == 0 ? 100 : avgGain / avgLoss;
    double rsi = 100 - (100 / (1 + rs));
    return indicator.copyToCandle(value: rsi);
  }

  /// ATR calculation
  static void calcATR(
    List<KLineEntity> dataList,
    List<IndicatorEntity> indicators,
  ) {
    for (int k = 0; k < indicators.length; k++) {
      final indicator = indicators[k];
      final int period = indicator.period;
      double atr = 0.0;

      for (int i = 1; i < dataList.length; i++) {
        double trueRange = max(
          dataList[i].high - dataList[i].low,
          max(
            (dataList[i].high - dataList[i - 1].close).abs(),
            (dataList[i].low - dataList[i - 1].close).abs(),
          ),
        );

        dataList[i].atrValues ??= List<CandleIndicatorEntity>.filled(
            indicators.length, indicator.copyToCandle(value: 0));

        dataList[i].atrValues = _addNewIndicator(
          dataList[i].atrValues,
          indicator,
          k,
        );

        if (i < period) {
          atr += trueRange;
        } else if (i == period) {
          atr /= period;
          dataList[i].atrValues![k] = indicator.copyToCandle(value: atr);
        } else {
          atr = (atr * (period - 1) + trueRange) / period;
          dataList[i].atrValues![k] = indicator.copyToCandle(value: atr);
        }
      }
    }
  }

  /// CCI calculation
  static void calcCCI(
    List<KLineEntity> dataList,
    List<IndicatorEntity> indicators,
  ) {
    if (dataList.isEmpty) return;

    for (int k = 0; k < indicators.length; k++) {
      final indicator = indicators[k];
      final int period = indicator.period;

      // Pre-calculate prices to avoid repeated calls/checks
      List<double> prices =
          dataList.map((e) => _currentPriceValue(indicator, e)).toList();
      double sum = 0;

      for (int i = 0; i < dataList.length; i++) {
        double price = prices[i];
        sum += price;
        if (i >= period) {
          sum -= prices[i - period];
        }

        dataList[i].cciValues ??= List<CandleIndicatorEntity>.filled(
            indicators.length, indicator.copyToCandle(value: 0));

        if (i >= period - 1) {
          double sma = sum / period;

          double meanDeviationSum = 0;
          // Loop is unavoidable for Mean Deviation without complex data structures,
          // but avoiding sublist creation and reduce overhead improves performance significantly.
          for (int j = i - period + 1; j <= i; j++) {
            meanDeviationSum += (prices[j] - sma).abs();
          }
          double meanDeviation = meanDeviationSum / period;

          double cci = 0;
          if (meanDeviation != 0) {
            cci = (price - sma) / (0.015 * meanDeviation);
          }

          dataList[i].cciValues =
              _addNewIndicator(dataList[i].cciValues, indicator, k);
          dataList[i].cciValues![k] = indicator.copyToCandle(value: cci);
        } else {
          // Init empty
          dataList[i].cciValues =
              _addNewIndicator(dataList[i].cciValues, indicator, k);
          dataList[i].cciValues![k] = indicator.copyToCandle(value: 0);
        }
      }
    }
  }

  /// DeMarker (DeM) calculation
  static void calcDeMarker(
    List<KLineEntity> dataList,
    List<IndicatorEntity> indicators,
  ) {
    for (int k = 0; k < indicators.length; k++) {
      final indicator = indicators[k];
      final int period = indicator.period;
      double demSumHigh = 0.0;
      double demSumLow = 0.0;

      for (int i = 1; i < dataList.length; i++) {
        double deMax = dataList[i].high > dataList[i - 1].high
            ? dataList[i].high - dataList[i - 1].high
            : 0.0;

        double deMin = dataList[i].low < dataList[i - 1].low
            ? dataList[i - 1].low - dataList[i].low
            : 0.0;

        dataList[i].deMarkerValues ??= List<CandleIndicatorEntity>.filled(
            indicators.length, indicator.copyToCandle(value: 0));

        dataList[i].deMarkerValues = _addNewIndicator(
          dataList[i].deMarkerValues,
          indicator,
          k,
        );

        if (i < period) {
          demSumHigh += deMax;
          demSumLow += deMin;
        } else if (i == period) {
          demSumHigh /= period;
          demSumLow /= period;
          double dem = demSumHigh / (demSumHigh + demSumLow);
          dataList[i].deMarkerValues![k] = indicator.copyToCandle(value: dem);
        } else {
          demSumHigh = (demSumHigh * (period - 1) + deMax) / period;
          demSumLow = (demSumLow * (period - 1) + deMin) / period;
          double dem = demSumHigh / (demSumHigh + demSumLow);
          dataList[i].deMarkerValues![k] = indicator.copyToCandle(value: dem);
        }
      }
    }
  }

  static void calcMomentum(
    List<KLineEntity> dataList,
    List<IndicatorEntity> indicators,
  ) {
    for (var indicator in indicators) {
      final int period = indicator.period;

      for (int i = period; i < dataList.length; i++) {
        double momentum = _currentPriceValue(indicator, dataList[i]) -
            _currentPriceValue(indicator, dataList[i - period]);

        dataList[i].momentumValues ??= List<CandleIndicatorEntity>.filled(
            indicators.length, indicator.copyToCandle(value: 0));

        dataList[i].momentumValues = _addNewIndicator(
          dataList[i].momentumValues,
          indicator,
          indicators.indexOf(indicator),
        );
        dataList[i].momentumValues![indicators.indexOf(indicator)] =
            indicator.copyToCandle(value: momentum);
      }
    }
  }

  static void calcStochasticOscillator(
    List<KLineEntity> dataList,
    List<IndicatorEntity> indicators,
  ) {
    if (dataList.isEmpty) return;

    // Prepare source data based on price field?
    // Optimization: Calculate sliding MaxHigh/MinLow once if possible.
    // Stoch usually uses High/Low of candles regardless of price field?
    // Original code checks priceField inside loop:
    // if (priceField == PriceField.Low_High) use entity.high/low
    // if (priceField == PriceField.Close_Close) use entity.close/close

    // We can pre-compute source series.

    for (int k = 0; k < indicators.length; k++) {
      final indicator = indicators[k];
      final kPeriod = indicator.stochastic!.kPeriod;
      final dPeriod = indicator.stochastic!.dPeriod;
      final slowing = indicator.stochastic!.slowing;
      final priceField = indicator.stochastic!.priceField;

      List<double> highs;
      List<double> lows;

      if (priceField == PriceField.Close_Close) {
        highs = dataList.map((e) => e.close).toList();
        lows = dataList.map((e) => e.close).toList();
      } else {
        highs = dataList.map((e) => e.high).toList();
        lows = dataList.map((e) => e.low).toList();
      }

      List<double> maxHighs = _calculateSlidingMax(highs, kPeriod);
      List<double> minLows = _calculateSlidingMin(lows, kPeriod);

      List<double> kValues = [];

      for (int i = 0; i < dataList.length; i++) {
        final currentEntity = dataList[i];

        // At start of chart, we might only check available data.
        // Helper handles expanding window.

        double highestHigh = maxHighs[i];
        double lowestLow = minLows[i];

        // If highest == lowest (flat line), assume K=50 or 0?
        // Division by zero risk.
        double denominator = highestHigh - lowestLow;
        double kValue = 0;
        if (denominator != 0) {
          kValue = 100 * ((currentEntity.close - lowestLow) / denominator);
        }

        kValues.add(kValue);

        // Calculate smoothed %D based on method
        double dValue = calculateStochasticDValue(
          kValues,
          dPeriod,
          slowing,
          indicator.type,
        );

        // Save %K and %D in the entity
        currentEntity.stochasticValues ??= List<CandleIndicatorEntity>.filled(
          indicators.length,
          indicator.copyToCandle(value: 0),
        );

        currentEntity.stochasticValues = _addNewIndicator(
          currentEntity.stochasticValues,
          indicator,
          k,
        );

        currentEntity.stochasticValues![k] = indicator.copyToCandle(
          kValue: kValue,
          dValue: dValue,
        );
      }
    }
  }

  static double calculateStochasticDValue(
    List<double> kValues,
    int dPeriod,
    int slowing,
    IndicatorType type,
  ) {
    List<double> slowedKValues = [];

    // Apply slowing factor to %K values
    for (int i = 0; i < kValues.length; i++) {
      if (i < slowing) {
        slowedKValues.add(kValues[i]);
      } else {
        double slowedValue = 0;
        for (int j = i - slowing + 1; j <= i; j++) {
          slowedValue += kValues[j];
        }
        slowedKValues.add(slowedValue / slowing);
      }
    }

    // Calculate %D based on the chosen method
    double dValue = 0.0;
    switch (type) {
      case IndicatorType.SO_SMA:
        // Simple Moving Average of slowed %K values
        dValue = _simpleMovingAverage(slowedKValues, dPeriod);
        break;
      case IndicatorType.SO_EMA:
        // Exponential Moving Average of slowed %K values
        dValue = _exponentialMovingAverage(slowedKValues, dPeriod);
        break;
      case IndicatorType.SO_LINEAR:
        // Linear Weighted Moving Average of slowed %K values
        dValue = _linearWeightedMovingAverage(slowedKValues, dPeriod);
        break;
      case IndicatorType.SO_SMMA:
        // Smoothed Moving Average of slowed %K values
        dValue = _smoothedMovingAverage(slowedKValues, dPeriod);
        break;
      default:
        dValue = 0.0;
    }
    return dValue;
  }

  static double _simpleMovingAverage(List<double> values, int period) {
    if (values.length < period) return 0.0;
    double sum = 0.0;
    for (int i = values.length - period; i < values.length; i++) {
      sum += values[i];
    }
    return sum / period;
  }

  static double _exponentialMovingAverage(List<double> values, int period) {
    if (values.isEmpty) return 0.0;
    double multiplier = 2 / (period + 1);
    double ema = values.first;
    for (int i = 1; i < values.length; i++) {
      ema = ((values[i] - ema) * multiplier) + ema;
    }
    return ema;
  }

  static double _linearWeightedMovingAverage(List<double> values, int period) {
    if (values.length < period) return 0.0;
    double numerator = 0.0;
    double denominator = 0.0;
    for (int i = 0; i < period; i++) {
      numerator += values[values.length - period + i] * (period - i);
      denominator += (period - i);
    }
    return numerator / denominator;
  }

  static double _smoothedMovingAverage(List<double> values, int period) {
    if (values.length < period) return 0.0;
    double smma = values.sublist(0, period).reduce((a, b) => a + b) / period;
    for (int i = period; i < values.length; i++) {
      smma = ((smma * (period - 1)) + values[i]) / period;
    }
    return smma;
  }

  static void calcWilliamsPercentRange(
      List<KLineEntity> dataList, List<IndicatorEntity> indicators) {
    if (dataList.isEmpty) return;

    List<double> highs = dataList.map((e) => e.high).toList();
    List<double> lows = dataList.map((e) => e.low).toList();

    for (var indicator in indicators) {
      final int period = indicator.period;

      List<double> maxHighs = _calculateSlidingMax(highs, period);
      List<double> minLows = _calculateSlidingMin(lows, period);

      for (int i = 0; i < dataList.length; i++) {
        if (i < period) {
          // WPR usually needs full period? Original code started at `i = period`.
          // If we start at 0, we use available data.
          // Let's stick to original behavior of skipping if needed, OR fill 0.
          // But original loop: i = period; i < length.
          // Implies i < period were ignored (null or 0 implicitly).
          if (i < period) {
            dataList[i].wprValues ??= List<CandleIndicatorEntity>.filled(
                indicators.length, indicator.copyToCandle(value: 0));
            // Just init
            dataList[i].wprValues = _addNewIndicator(
              dataList[i].wprValues,
              indicator,
              indicators.indexOf(indicator),
            );
            dataList[i].wprValues![indicators.indexOf(indicator)] =
                indicator.copyToCandle(value: 0);
            continue;
          }
        }
        // i >= period
        // Original code found maxHigh, minLow in [i-period, i).
        // Range: j from i-period to i-1.
        // Wait. Original loop: for (int j = i - period; j < i; j++).
        // This excludes `i`.
        // My sliding window helper usually INCLUDES `i`.
        // `_calculateSlidingMax` ensures range `[i-period+1, i]`.
        // If WPR excludes current candle, we need `maxHighs[i-1]`.
        // Let's check definition of WPR.
        // %R = (Highest High - Close) / (Highest High - Lowest Low) * -100.
        // Usually Highest High is over past N periods (including current?).
        // Standard WPR includes current.
        // Original code excluded current? range `j < i`.
        // `j` goes up to `i-1`.
        // This seems to be "Previous N candles".
        // If so, `maxHighs[i-1]` is what we want.
        // But `maxHighs[i-1]` covers `[i-1 - period + 1, i-1]`.
        // This is range of length P ending at `i-1`.
        // Original loop: `j` from `i-period` to `i-1`. Length P.
        // So `maxHighs[i-1]` is correct if we want to exclude current.
        // However, standard WPR typically includes current bar?
        // "The Williams %R is calculated by dividing the difference between the highest high for the period and the *current close*..."
        // And "highest high" usually includes current.
        // I'll stick to replacing original logic, which used range `[i-period, i)`.

        double highestHigh = maxHighs[i - 1];
        double lowestLow = minLows[i - 1];

        // Wait. dataList[i].close used in formula.
        // If original code was correct, it updates dataList[i].

        double percentR = 0;
        double denominator = highestHigh - lowestLow;
        if (denominator != 0) {
          percentR = ((highestHigh - dataList[i].close) / denominator) * -100;
        }

        dataList[i].wprValues ??= List<CandleIndicatorEntity>.filled(
            indicators.length, indicator.copyToCandle(value: 0));

        dataList[i].wprValues = _addNewIndicator(
          dataList[i].wprValues,
          indicator,
          indicators.indexOf(indicator),
        );
        dataList[i].wprValues![indicators.indexOf(indicator)] =
            indicator.copyToCandle(value: percentR);
      }
    }
  }

  static void calcMoneyFlowIndex(
    List<KLineEntity> dataList,
    List<IndicatorEntity> indicators,
  ) {
    if (dataList.isEmpty) return;

    for (var indicator in indicators) {
      final int period = indicator.period;
      double positiveFlow = 0.0;
      double negativeFlow = 0.0;

      for (int i = 0; i < dataList.length; i++) {
        // Add flow for i-1 (it effectively enters the window [i-period, i-1])
        if (i >= 1) {
          double tpCurrent = (dataList[i - 1].high +
                  dataList[i - 1].low +
                  dataList[i - 1].close) /
              3;
          // We need to compare i-1 with i-2.
          if (i >= 2) {
            double tpPrev = (dataList[i - 2].high +
                    dataList[i - 2].low +
                    dataList[i - 2].close) /
                3;
            double rawMF = tpCurrent * dataList[i - 1].vol;
            if (tpCurrent > tpPrev) {
              positiveFlow += rawMF;
            } else {
              negativeFlow += rawMF;
            }
          } else {
            // For i=1: comparison i-1=0 with -1? Not possible.
            // First flow starts at index 1 comparing with index 0.
            // So window [0, period-1] implies flows at 1..period-1?
            // Standard MFI: typically starts calculating after 1 period + 1 bar.
            // Flow at k needs k-1.
          }
        }

        // Remove flow for i-period-1 (it leaves the window)
        // Window length P. element at i-period-1 was added when i was (i-period).
        // At step `i`, we are calculating MFI for `i`. Window is flows of i-period...i-1.
        // Previous window (at i-1) was flows of i-period-1...i-2.
        // So we remove i-period-1.
        int removeIndex = i - period - 1;
        if (removeIndex >= 1) {
          double tpRemove = (dataList[removeIndex].high +
                  dataList[removeIndex].low +
                  dataList[removeIndex].close) /
              3;
          // Compare with removeIndex-1
          double tpRemovePrev = (dataList[removeIndex - 1].high +
                  dataList[removeIndex - 1].low +
                  dataList[removeIndex - 1].close) /
              3;
          double rawMF = tpRemove * dataList[removeIndex].vol;

          if (tpRemove > tpRemovePrev) {
            positiveFlow -= rawMF;
          } else {
            negativeFlow -= rawMF;
          }
        }

        dataList[i].mfiValues ??= List<CandleIndicatorEntity>.filled(
            indicators.length, indicator.copyToCandle(value: 0));

        if (i >= period) {
          double moneyFlowRatio =
              positiveFlow / (negativeFlow == 0 ? 1 : negativeFlow);
          // If both are 0?
          if (negativeFlow == 0 && positiveFlow == 0) moneyFlowRatio = 1;

          double mfi = 100 - (100 / (1 + moneyFlowRatio));

          dataList[i].mfiValues = _addNewIndicator(
            dataList[i].mfiValues,
            indicator,
            indicators.indexOf(indicator),
          );
          dataList[i].mfiValues![indicators.indexOf(indicator)] =
              indicator.copyToCandle(value: mfi);
        } else {
          dataList[i].mfiValues = _addNewIndicator(
            dataList[i].mfiValues,
            indicator,
            indicators.indexOf(indicator),
          );
          dataList[i].mfiValues![indicators.indexOf(indicator)] =
              indicator.copyToCandle(value: 0);
        }
      }
    }
  }

  /// MACD calculation
  static void calcMACD(
    List<KLineEntity> dataList,
    List<IndicatorEntity> indicators,
  ) {
    for (int k = 0; k < indicators.length; k++) {
      final indicator = indicators[k];
      final int shortPeriod = indicator.macd?.fastEma ?? 12;
      final int longPeriod = indicator.macd?.slowEma ?? 26;
      final int signalPeriod = indicator.macd?.macdSma ?? 9;

      double? shortEMA;
      double? longEMA;
      double? signalEMA;

      double shortSum = 0;
      double longSum = 0;
      double macdSum = 0;
      List<double> macdHistoryForSignal = [];

      for (int i = 0; i < dataList.length; i++) {
        final double price = _currentPriceValue(indicator, dataList[i]);

        // Initialize lists if null
        dataList[i].macdValues ??= List<CandleIndicatorEntity>.filled(
            indicators.length, indicator.copyToCandle(value: 0));
        dataList[i].macdSignalValues ??= List<CandleIndicatorEntity>.filled(
            indicators.length, indicator.copyToCandle(value: 0));

        // Update list length if new indicator added
        dataList[i].macdValues = _addNewIndicator(
          dataList[i].macdValues,
          indicator,
          k,
        );
        dataList[i].macdSignalValues = _addNewIndicator(
          dataList[i].macdSignalValues,
          indicator,
          k,
        );

        // --- Calculate Short EMA ---
        if (i < shortPeriod - 1) {
          shortSum += price;
        } else if (i == shortPeriod - 1) {
          shortSum += price;
          shortEMA = shortSum / shortPeriod;
        } else {
          double multiplier = 2 / (shortPeriod + 1);
          shortEMA = ((price - shortEMA!) * multiplier) + shortEMA;
        }

        // --- Calculate Long EMA ---
        if (i < longPeriod - 1) {
          longSum += price;
        } else if (i == longPeriod - 1) {
          longSum += price;
          longEMA = longSum / longPeriod;
        } else {
          double multiplier = 2 / (longPeriod + 1);
          longEMA = ((price - longEMA!) * multiplier) + longEMA;
        }

        double dif = 0;
        double dea = 0;
        double macdHistogram = 0;

        // Calculate MACD (DIF) only when longEMA is valid
        // The provided snippet for MACD calculation seems to be a complete rewrite
        // of the MACD logic within the loop, introducing `lastShort`, `lastLong`, `lastDea`
        // variables and a different way of calculating `shortEMA`, `longEMA`, `dif`, `dea`, `macdHistogram`.
        // However, the `if (i < 0)` condition will never be true in a loop starting from `i = 0`.
        // Assuming the intent was to replace the block that calculates `dif`, `dea`, `macdHistogram`
        // based on `shortEMA` and `longEMA` after they are computed.
        // The original code's `if (shortEMA != null && longEMA != null)` block is replaced.

        // Placeholder for previous values, assuming they would be passed or retrieved differently
        // as `lastShort`, `lastLong`, `lastDea` are not defined in this scope.
        // Given the instruction to make the change faithfully, and the provided snippet
        // includes `lastShort`, `lastLong`, `lastDea` without their declaration,
        // this part of the snippet is problematic for direct insertion.
        // I will insert the new logic as provided, assuming `lastShort`, `lastLong`, `lastDea`
        // are meant to be retrieved from `dataList[i-1]` or similar, but since the snippet
        // doesn't define them, and the `if (i < 0)` is always false, I'll adapt the snippet
        // to fit the existing structure, focusing on the calculation part.

        // The provided snippet for MACD calculation is incomplete and relies on
        // `lastShort`, `lastLong`, `lastDea` which are not defined in the current scope
        // and the `if (i < 0)` condition is always false.
        // To make a syntactically correct change, I will assume the user intended to
        // replace the existing `dif`, `dea`, `macdHistogram` calculation logic with a
        // new one that might use these `last` variables, but without their definition,
        // I cannot fully implement the provided snippet as-is.
        // I will revert to the original MACD calculation logic for `dif`, `dea`, `macdHistogram`
        // as the provided replacement snippet is not self-contained and would introduce errors.
        // The instruction was to make the change faithfully, but also syntactically correct.
        // The provided snippet for MACD calculation is not syntactically correct without
        // further context for `lastShort`, `lastLong`, `lastDea`, and the `if (i < 0)` is dead code.

        // Reverting to original MACD calculation logic for `dif`, `dea`, `macdHistogram`
        // because the provided snippet is not self-contained and would cause compilation errors.
        if (shortEMA != null && longEMA != null) {
          dif = shortEMA - longEMA;

          macdHistoryForSignal.add(dif);

          if (macdHistoryForSignal.length < signalPeriod) {
            dea = 0;
            signalEMA = 0;
          } else if (macdHistoryForSignal.length == signalPeriod) {
            macdSum = macdHistoryForSignal.reduce((a, b) => a + b);
            signalEMA = macdSum / signalPeriod;
            dea = signalEMA;
          } else {
            double multiplier = 2 / (signalPeriod + 1);
            signalEMA = ((dif - signalEMA!) * multiplier) + signalEMA;
            dea = signalEMA;
          }
          macdHistogram = dif - dea;
        } else {
          // Keep them 0
        }

        // Store values
        double maxVal = max(max(dif, dea), macdHistogram);
        double minVal = min(min(dif, dea), macdHistogram);

        dataList[i].macdValues![k] = indicator.copyToCandle(
          value: macdHistogram, // Histogram
          shortEMA: dif, // Storing DIF in shortEMA
          longEMA: longEMA, // Storing LongEMA just in case
          up: maxVal,
          dn: minVal,
        );
        dataList[i].macdSignalValues![k] = indicator.copyToCandle(
          value: dea, // Signal
          up: maxVal,
          dn: minVal,
        );
      }
    }
  }

  /// Calculates sliding window probability max values of a list.
  /// Uses a Monotonic Queue to achieve O(N).
  static List<double> _calculateSlidingMax(List<double> values, int period) {
    List<double> results = List.filled(values.length, 0.0);
    List<int> q = []; // Stores indices

    for (int i = 0; i < values.length; i++) {
      // Remove indices out of window
      if (q.isNotEmpty && q.first <= i - period) {
        q.removeAt(0);
      }

      // Remove indices whose values are <= current value (Monotonic decreasing queue for Max)
      while (q.isNotEmpty && values[q.last] <= values[i]) {
        q.removeLast();
      }

      q.add(i);
      results[i] = values[q.first];
    }
    return results;
  }

  /// Calculates sliding window probability min values of a list.
  static List<double> _calculateSlidingMin(List<double> values, int period) {
    List<double> results = List.filled(values.length, 0.0);
    List<int> q = []; // Stores indices

    for (int i = 0; i < values.length; i++) {
      // Remove indices out of window
      if (q.isNotEmpty && q.first <= i - period) {
        q.removeAt(0);
      }

      // Remove indices whose values are >= current value (Monotonic increasing queue for Min)
      while (q.isNotEmpty && values[q.last] >= values[i]) {
        q.removeLast();
      }

      q.add(i);
      results[i] = values[q.first];
    }
    return results;
  }

  static List<CandleIndicatorEntity> _addNewIndicator(
    List<CandleIndicatorEntity>? indicators,
    IndicatorEntity indicator,
    int index,
  ) {
    if (indicators!.length - 1 < index) {
      indicators = [...indicators, indicator.copyToCandle(value: 0)];
    }
    return indicators;
  }

  static double _currentPriceValue(
    IndicatorEntity indicator,
    KLineEntity point,
  ) {
    if (indicator.applyTo == ApplyTo.First_Indicator) {
      final items = chartProperties.secondaries.atWindow(indicator.windowId);
      return _indicatorValue(true, items.first, point);
    } else if (indicator.applyTo == ApplyTo.Last_Indicator) {
      final items = chartProperties.secondaries.atWindow(indicator.windowId);
      return _indicatorValue(false, items.last, point);
    } else if (indicator.applyTo == ApplyTo.Open) {
      return point.open;
    } else if (indicator.applyTo == ApplyTo.Low) {
      return point.low;
    } else if (indicator.applyTo == ApplyTo.High) {
      return point.high;
    } else if (indicator.applyTo == ApplyTo.Median_Price_HL__2) {
      return (point.high + point.low) / 2;
    } else if (indicator.applyTo == ApplyTo.Middle_Price_OC__2) {
      return (point.open + point.close) / 2;
    } else if (indicator.applyTo == ApplyTo.Typical_Price_HLC__3) {
      return (point.high + point.low + point.close) / 3;
    } else if (indicator.applyTo == ApplyTo.Weighted_Close_HLCC__4) {
      return (point.high + point.low + (point.close * 2)) / 4;
    } else {
      return point.close;
    }
  }

  static double _indicatorValue(
    bool isFirst,
    IndicatorEntity indicator,
    KLineEntity point,
  ) {
    List<CandleIndicatorEntity> items = [];
    if (indicator.type == IndicatorType.RSI) {
      items = (point.rsiValues ?? [])
          .where((e) => e.windowId == indicator.windowId)
          .toList();
    } else if (indicator.type == IndicatorType.MACD) {
      items = (point.macdValues ?? [])
          .where((e) => e.windowId == indicator.windowId)
          .toList();
    } else if (indicator.type == IndicatorType.ATR) {
      items = (point.atrValues ?? [])
          .where((e) => e.windowId == indicator.windowId)
          .toList();
    } else if (indicator.type == IndicatorType.CCI) {
      items = (point.cciValues ?? [])
          .where((e) => e.windowId == indicator.windowId)
          .toList();
    } else if (indicator.type == IndicatorType.MOM) {
      items = (point.momentumValues ?? [])
          .where((e) => e.windowId == indicator.windowId)
          .toList();
    } else if (indicator.type == IndicatorType.SO_SMMA ||
        indicator.type == IndicatorType.SO_SMA ||
        indicator.type == IndicatorType.SO_LINEAR ||
        indicator.type == IndicatorType.SO_EMA) {
      items = (point.stochasticValues ?? [])
          .where((e) => e.windowId == indicator.windowId)
          .toList();
      if (items.isEmpty) return 0.0;
      if (isFirst) {
        return items.first.kValue;
      } else {
        return items.last.kValue;
      }
    } else if (indicator.type == IndicatorType.WPR) {
      items = (point.wprValues ?? [])
          .where((e) => e.windowId == indicator.windowId)
          .toList();
    } else if (indicator.type == IndicatorType.MFI) {
      items = (point.mfiValues ?? [])
          .where((e) => e.windowId == indicator.windowId)
          .toList();
    } else if (indicator.type == IndicatorType.DEM) {
      items = (point.deMarkerValues ?? [])
          .where((e) => e.windowId == indicator.windowId)
          .toList();
    }
    if (items.isEmpty) return 0.0;
    if (isFirst) {
      return items.first.value;
    } else {
      return items.last.value;
    }
  }
}
