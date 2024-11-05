import 'dart:math';

import 'package:candle_chart/entity/candle_indicator_entity.dart';
import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/k_chart_widget.dart';
import 'package:candle_chart/utils/kprint.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';

class IndicatorUtils {
  static calculate(List<KLineEntity> data) async {
    List<IndicatorEntity> SMA_MA = [],
        EMA_MA = [],
        Linear_MA = [],
        Smoothed_MA = [],
        SMA_ENVELOPS = [],
        EMA_ENVELOPS = [],
        LINEAR_ENVELOPS = [],
        SMMA_ENVELOPS = [],
        BOLL = [],
        ICHIMOKU = [],
        PARABOLIC = [],
        RSI = [],
        MACD = [];

    await chartProperties.loadIndicators();

    /// reset candles
    _resetCandles(data);

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
      } else if (indicator.type == IndicatorType.ICHIMOKU) {
        ICHIMOKU.add(indicator);
      }
    }

    for (var item in chartProperties.secondaries.entries) {
      for (var indicator in item.value) {
        if (indicator.type == IndicatorType.RSI) {
          RSI.add(indicator);
        } else if (indicator.type == IndicatorType.MACD) {
          MACD.add(indicator);
        }
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
    if (ICHIMOKU.isNotEmpty) calc_Ichimoku(data, ICHIMOKU);
    if (RSI.isNotEmpty) calcRSI(data, RSI);
    if (MACD.isNotEmpty) calcMACD(data, MACD);

    /// calc the volume indicator
    calcVolumeMA(data);
  }

  static void _resetCandles(List<KLineEntity> data) {
    for (int k = 0; k < data.length; k++) {
      ///MA
      data[k].emaMaValues = null;
      data[k].smaMaValues = null;
      data[k].lwmaMaValues = null;
      data[k].smmaMaValues = null;

      ///Envelops
      data[k].emaEnvelopsValues = null;
      data[k].smaEnvelopsValues = null;
      data[k].lwmaEnvelopsValues = null;
      data[k].smmaEnvelopsValues = null;

      ///BOLL
      data[k].bollValues = null;

      ///Parabolic
      data[k].parabolicValues = null;

      /// Ichimoku
      data[k].ichimokuValues = null;

      /// RSI
      data[k].rsiValues = null;

      /// MACD
      data[k].macdValues = null;
      data[k].macdSignalValues = null;
    }
  }

  static void calc_SMA_MA(
    List<KLineEntity> dataList,
    List<IndicatorEntity> indicators,
  ) {
    for (int k = 0; k < indicators.length; k++) {
      final indicator = indicators[k];
      for (int i = indicator.period - 1; i < dataList.length; i++) {
        KLineEntity entity = dataList[i];
        entity.smaMaValues ??= List<CandleIndicatorEntity>.filled(
            indicators.length, indicator.copyToCandle(value: 0));
        if (i >= indicator.period - 1) {
          double sum = 0;
          for (int j = i; j > i - indicator.period; j--) {
            sum += _currentPriceValue(indicator, dataList[j]);
          }
          double smaValue = sum / indicator.period;
          entity.smaMaValues = _addNewIndicator(
            entity.smaMaValues,
            indicator,
            k,
          );
          entity.smaMaValues![k] = indicator.copyToCandle(value: smaValue);
        } else {
          entity.smaMaValues ??= List<CandleIndicatorEntity>.filled(
              indicators.length, indicator.copyToCandle(value: 0));
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
      for (int i = indicator.period - 1; i < dataList.length; i++) {
        KLineEntity entity = dataList[i];
        entity.lwmaMaValues ??= List<CandleIndicatorEntity>.filled(
            indicators.length, indicator.copyToCandle(value: 0));
        if (i >= indicator.period - 1) {
          double numerator = 0;
          double denominator = (indicator.period * (indicator.period + 1)) / 2;
          for (int j = 0; j < indicator.period; j++) {
            numerator += _currentPriceValue(indicator, dataList[i - j]) *
                (indicator.period - j);
          }
          double lwmaValue = numerator / denominator;
          entity.lwmaMaValues = _addNewIndicator(
            entity.lwmaMaValues,
            indicator,
            k,
          );

          entity.lwmaMaValues![k] = indicator.copyToCandle(value: lwmaValue);
        } else {
          entity.lwmaMaValues ??= List<CandleIndicatorEntity>.filled(
              indicators.length, indicator.copyToCandle(value: 0));
        }
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
        entity.emaMaValues ??= List<CandleIndicatorEntity>.filled(
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
        entity.emaMaValues = _addNewIndicator(
          entity.emaMaValues,
          indicator,
          k,
        );
        entity.emaMaValues![k] = indicator.copyToCandle(value: previousEma);
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
        entity.smmaMaValues ??= List<CandleIndicatorEntity>.filled(
            indicators.length, indicator.copyToCandle(value: 0));

        if (i == indicator.period - 1) {
          // First SMMA value: Simple Moving Average (SMA)
          double sum = 0;
          for (int j = 0; j < indicator.period; j++) {
            sum += _currentPriceValue(indicator, dataList[j]);
          }
          previousSmma = sum / indicator.period;
          entity.smmaMaValues = _addNewIndicator(
            entity.smmaMaValues,
            indicator,
            k,
          );
          entity.smmaMaValues![k] = indicator.copyToCandle(value: previousSmma);
        } else {
          // Subsequent SMMA values
          double currentClose = _currentPriceValue(indicator, entity);
          previousSmma =
              ((previousSmma! * (indicator.period - 1)) + currentClose) /
                  indicator.period;

          entity.smmaMaValues = _addNewIndicator(
            entity.smmaMaValues,
            indicator,
            k,
          );
          // Set the current SMMA value in the list
          entity.smmaMaValues![k] = indicator.copyToCandle(value: previousSmma);
        }
      }
    }
  }

  static void calc_BOLL(
    List<KLineEntity> dataList,
    List<IndicatorEntity> indicators,
  ) {
    for (int k = 0; k < indicators.length; k++) {
      final indicator = indicators[k];
      // Calculate the moving average (Middle Band)
      List<double> movingAverage = _calcBOLLMA(dataList, indicator);

      // Loop over data and calculate the Upper and Lower bands
      for (int i = 0; i < dataList.length; i++) {
        KLineEntity entity = dataList[i];
        entity.bollValues ??= List<CandleIndicatorEntity>.filled(
            indicators.length, indicator.copyToCandle(value: 0));
        if (i >= indicator.period - 1) {
          double sumOfSquares = 0;

          // Calculate the standard deviation for this window
          for (int j = i - indicator.period + 1; j <= i; j++) {
            double currentPrice = _currentPriceValue(indicator, dataList[j]);
            sumOfSquares += pow(currentPrice - movingAverage[i], 2);
          }

          double standardDeviation = sqrt(sumOfSquares / indicator.period);

          // Calculate Bollinger Bands
          final value = movingAverage[i];
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
      for (int i = indicator.period - 1; i < dataList.length; i++) {
        KLineEntity entity = dataList[i];
        entity.smaEnvelopsValues ??= List<CandleIndicatorEntity>.filled(
            indicators.length, indicator.copyToCandle(value: 0));

        if (i >= indicator.period - 1) {
          double sum = 0;
          for (int j = i; j > i - indicator.period; j--) {
            sum += _currentPriceValue(indicator, dataList[j]);
          }
          double smaValue = sum / indicator.period;
          double upperEnvelope = smaValue * (1 + indicator.deviations! / 100);
          double lowerEnvelope = smaValue * (1 - indicator.deviations! / 100);

          entity.smaEnvelopsValues = _addNewIndicator(
            entity.smaEnvelopsValues,
            indicator,
            k,
          );

          entity.smaEnvelopsValues?[k] = indicator.copyToCandle(
            value: smaValue,
            up: upperEnvelope,
            dn: lowerEnvelope,
          );
        } else {
          entity.smaEnvelopsValues ??= List<CandleIndicatorEntity>.filled(
              indicators.length, indicator.copyToCandle(value: 0));
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
        entity.emaEnvelopsValues ??= List<CandleIndicatorEntity>.filled(
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
        entity.emaEnvelopsValues = _addNewIndicator(
          entity.emaEnvelopsValues,
          indicator,
          k,
        );

        entity.emaEnvelopsValues?[k] = indicator.copyToCandle(
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
      for (int i = indicator.period - 1; i < dataList.length; i++) {
        KLineEntity entity = dataList[i];
        entity.lwmaEnvelopsValues ??= List<CandleIndicatorEntity>.filled(
            indicators.length, indicator.copyToCandle(value: 0));

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

          entity.lwmaEnvelopsValues = _addNewIndicator(
            entity.lwmaEnvelopsValues,
            indicator,
            k,
          );
          entity.lwmaEnvelopsValues?[k] = indicator.copyToCandle(
            value: lwmaValue,
            up: upperEnvelope,
            dn: lowerEnvelope,
          );
        } else {
          entity.lwmaEnvelopsValues ??= List<CandleIndicatorEntity>.filled(
              indicators.length, indicator.copyToCandle(value: 0));
        }
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
        entity.smmaEnvelopsValues ??= List<CandleIndicatorEntity>.filled(
            indicators.length, indicator.copyToCandle(value: 0));

        entity.smmaEnvelopsValues = _addNewIndicator(
          entity.smmaEnvelopsValues,
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

        entity.smmaEnvelopsValues?[k] = indicator.copyToCandle(
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
    for (int k = 0; k < indicators.length; k++) {
      final indicator = indicators[k];
      if (indicator.ichimoku != null) {
        Ichimoku ichimoku = indicator.ichimoku!;

        for (int i = ichimoku.kijuSen; i < dataList.length; i++) {
          KLineEntity entity = dataList[i];

          entity.ichimokuValues ??= List<CandleIndicatorEntity>.filled(
              indicators.length, indicator.copyToCandle(value: 0));

          // Calculate Tenkan-sen (Conversion Line)
          double tenkanSen = (dataList
                      .getRange(max(0, i - ichimoku.tenkanSen + 1), i + 1)
                      .map((e) => e.high)
                      .reduce(max) +
                  dataList
                      .getRange(max(0, i - ichimoku.tenkanSen + 1), i + 1)
                      .map((e) => e.low)
                      .reduce(min)) /
              2;

          // Calculate Kijun-sen (Base Line)
          double kijunSen = (dataList
                      .getRange(max(0, i - ichimoku.kijuSen + 1), i + 1)
                      .map((e) => e.high)
                      .reduce(max) +
                  dataList
                      .getRange(max(0, i - ichimoku.kijuSen + 1), i + 1)
                      .map((e) => e.low)
                      .reduce(min)) /
              2;

          // Calculate Senkou Span A
          double senkouSpanA = (tenkanSen + kijunSen) / 2;

          // Calculate Senkou Span B
          double senkouSpanB = (dataList
                      .getRange(max(0, i - ichimoku.senkouSpan + 1), i + 1)
                      .map((e) => e.high)
                      .reduce(max) +
                  dataList
                      .getRange(max(0, i - ichimoku.senkouSpan + 1), i + 1)
                      .map((e) => e.low)
                      .reduce(min)) /
              2;

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
            chikouSpan: dataList[i - ichimoku.kijuSen].close,
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

  /// MACD calculation
  static void calcMACD(
    List<KLineEntity> dataList,
    List<IndicatorEntity> indicators,
  ) {
    double low = double.minPositive;
    double high = 0;
    for (int k = 0; k < indicators.length; k++) {
      final indicator = indicators[k];
      final int shortPeriod = indicator.macd?.fastEma ?? 12;
      final int longPeriod = indicator.macd?.slowEma ?? 26;
      final int signalPeriod = indicator.macd?.macdSma ?? 9;

      List<double> macdLine = [];
      List<double> signalLine = [];

      double? shortEMA;
      double? longEMA;

      for (int i = 0; i < dataList.length; i++) {
        if (i < longPeriod - 1) {
          macdLine.add(0);
          signalLine.add(0);
          continue;
        }

        dataList[i].macdValues ??= List<CandleIndicatorEntity>.filled(
            indicators.length, indicator.copyToCandle(value: 0));

        dataList[i].macdSignalValues ??= List<CandleIndicatorEntity>.filled(
            indicators.length, indicator.copyToCandle(value: 0));

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

        shortEMA = _calculateEMA(
            dataList.map((e) => _currentPriceValue(indicator, e)).toList(),
            i,
            shortPeriod,
            shortEMA);
        longEMA = _calculateEMA(
            dataList.map((e) => _currentPriceValue(indicator, e)).toList(),
            i,
            longPeriod,
            longEMA);

        double macdValue = (shortEMA - longEMA);
        macdLine.add(macdValue);
        if (macdValue < low) {
          low = macdValue;
        }
        if (macdValue > high) {
          high = macdValue;
        }
        if (i >= longPeriod + signalPeriod - 2) {
          double signalValue = signalLine.length < signalPeriod
              ? macdLine
                      .sublist(i - signalPeriod + 1, i + 1)
                      .reduce((a, b) => a + b) /
                  signalPeriod
              : _calculateEMA(macdLine, i, signalPeriod, signalLine.last);

          signalLine.add(signalValue);

          dataList[i].macdValues![k] = indicator.copyToCandle(
            value: macdValue,
            shortEMA: shortEMA,
            longEMA: longEMA,
            up: high,
            dn: low,
          );
          dataList[i].macdSignalValues![k] = indicator.copyToCandle(
            value: signalValue,
            up: high,
            dn: low,
          );
        } else {
          signalLine.add(0);
        }
      }
    }
  }

  static double _calculateEMA(
      List<double> dataList, int index, int period, double? previousEMA) {
    double multiplier = 2 / (period + 1);
    return previousEMA == null
        ? dataList
                .sublist(index - period + 1, index + 1)
                .map((e) => e)
                .reduce((a, b) => a + b) /
            period
        : ((dataList[index] - previousEMA) * multiplier + previousEMA);
  }

  // /// Set RSI levels
  // static List<CandleIndicatorEntity> _setRSILevels(double rsiValue) {
  //   // Create a list for the RSI value and levels
  //   List<CandleIndicatorEntity> rsiLevels = [];
  //
  //   // Store the RSI value
  //   rsiLevels.add(CandleIndicatorEntity(value: rsiValue));
  //
  //   // Add the upper and lower levels
  //   rsiLevels.add(CandleIndicatorEntity(value: 70, isLevel: true));  // Overbought level
  //   rsiLevels.add(CandleIndicatorEntity(value: 30, isLevel: true));  // Oversold level
  //
  //   return rsiLevels;
  // }

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
    if (indicator.applyTo == ApplyTo.Open) {
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
}
