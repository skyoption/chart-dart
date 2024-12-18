import 'dart:math';

import 'package:candle_chart/entity/candle_indicator_entity.dart';
import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/k_chart_widget.dart';
import 'package:candle_chart/renderer/rects/secondary_rect.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';

class IndicatorUtils {
  static calculate(List<KLineEntity> data) async {
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

    await chartProperties.loadIndicators();

    /// reset candles
    _resetCandles(data);

    /// Group the indicators by type
    for (var indicator in chartProperties.indicators) {
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

    for (var item in chartProperties.secondaries.entries) {
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
    await Future.delayed(Duration(milliseconds: 300));
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

    /// calc the volume indicator
    calcVolumeMA(data);
  }

  static void _resetCandles(List<KLineEntity> data) {
    for (int k = 0; k < data.length; k++) {
      ///MA
      data[k].maEmaValues = null;
      data[k].maSmaValues = null;
      data[k].maLwmaValues = null;
      data[k].maSmmaValues = null;

      ///Envelops
      data[k].envelopsEmaValues = null;
      data[k].envelopsSmaValues = null;
      data[k].envelopsLwmaValues = null;
      data[k].envelopsSmmaValues = null;

      data[k].bollValues = null;
      data[k].parabolicValues = null;
      data[k].ichimokuValues = null;
      data[k].rsiValues = null;
      data[k].macdValues = null;
      data[k].macdSignalValues = null;
      data[k].cciValues = null;
      data[k].atrValues = null;
      data[k].deMarkerValues = null;
      data[k].momentumValues = null;
      data[k].wprValues = null;
      data[k].mfiValues = null;
      data[k].stochasticValues = null;
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
        entity.maSmaValues ??= List<CandleIndicatorEntity>.filled(
            indicators.length, indicator.copyToCandle(value: 0));
        if (i >= indicator.period - 1) {
          double sum = 0;
          for (int j = i; j > i - indicator.period; j--) {
            final value = _currentPriceValue(indicator, dataList[j]);

            sum += value;
          }
          double smaValue = sum / indicator.period;
          entity.maSmaValues = _addNewIndicator(
            entity.maSmaValues,
            indicator,
            k,
          );
          entity.maSmaValues![k] = indicator.copyToCandle(value: smaValue);
        } else {
          entity.maSmaValues ??= List<CandleIndicatorEntity>.filled(
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
        entity.maLwmaValues ??= List<CandleIndicatorEntity>.filled(
            indicators.length, indicator.copyToCandle(value: 0));
        if (i >= indicator.period - 1) {
          double numerator = 0;
          double denominator = (indicator.period * (indicator.period + 1)) / 2;
          for (int j = 0; j < indicator.period; j++) {
            numerator += _currentPriceValue(indicator, dataList[i - j]) *
                (indicator.period - j);
          }
          double lwmaValue = numerator / denominator;
          entity.maLwmaValues = _addNewIndicator(
            entity.maLwmaValues,
            indicator,
            k,
          );

          entity.maLwmaValues![k] = indicator.copyToCandle(value: lwmaValue);
        } else {
          entity.maLwmaValues ??= List<CandleIndicatorEntity>.filled(
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
        entity.envelopsSmaValues ??= List<CandleIndicatorEntity>.filled(
            indicators.length, indicator.copyToCandle(value: 0));

        if (i >= indicator.period - 1) {
          double sum = 0;
          for (int j = i; j > i - indicator.period; j--) {
            sum += _currentPriceValue(indicator, dataList[j]);
          }
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
          entity.envelopsSmaValues ??= List<CandleIndicatorEntity>.filled(
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
      for (int i = indicator.period - 1; i < dataList.length; i++) {
        KLineEntity entity = dataList[i];
        entity.envelopsLwmaValues ??= List<CandleIndicatorEntity>.filled(
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
        } else {
          entity.envelopsLwmaValues ??= List<CandleIndicatorEntity>.filled(
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
    for (int k = 0; k < indicators.length; k++) {
      final indicator = indicators[k];
      final int period = indicator.period;
      List<double> typicalPrices = [];

      for (int i = 0; i < dataList.length; i++) {
        double price = _currentPriceValue(indicator, dataList[i]);
        typicalPrices.add(price);

        dataList[i].cciValues ??= List<CandleIndicatorEntity>.filled(
            indicators.length, indicator.copyToCandle(value: 0));

        dataList[i].cciValues = _addNewIndicator(
          dataList[i].cciValues,
          indicator,
          k,
        );

        if (i >= period - 1) {
          double sma = typicalPrices
                  .sublist(i - period + 1, i + 1)
                  .reduce((a, b) => a + b) /
              period;
          double meanDeviation = typicalPrices
                  .sublist(i - period + 1, i + 1)
                  .map((tp) => (tp - sma).abs())
                  .reduce((a, b) => a + b) /
              period;
          double cci = (price - sma) / (0.015 * meanDeviation);

          dataList[i].cciValues![k] = indicator.copyToCandle(value: cci);
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
    for (int k = 0; k < indicators.length; k++) {
      final indicator = indicators[k];
      final kPeriod = indicator.stochastic!.kPeriod; // %K period
      final dPeriod = indicator.stochastic!.dPeriod; // %D period
      final slowing = indicator.stochastic!.slowing; // slowing factor
      final priceField = indicator.stochastic!.priceField;

      List<double> kValues = [];

      // Iterate over data starting from (kPeriod - 1)
      for (int i = kPeriod - 1; i < dataList.length; i++) {
        final currentEntity = dataList[i];

        // Determine low/high or close/close based on selected price field
        double highestHigh = double.negativeInfinity;
        double lowestLow = double.infinity;

        for (int j = i - kPeriod + 1; j <= i; j++) {
          final entity = dataList[j];
          if (priceField == PriceField.Low_High) {
            if (entity.high > highestHigh) highestHigh = entity.high;
            if (entity.low < lowestLow) lowestLow = entity.low;
          } else if (priceField == PriceField.Close_Close) {
            if (entity.close > highestHigh) highestHigh = entity.close;
            if (entity.close < lowestLow) lowestLow = entity.close;
          }
        }

        // Calculate %K
        double kValue = 100 *
            ((currentEntity.close - lowestLow) / (highestHigh - lowestLow));
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
    for (var indicator in indicators) {
      final int period = indicator.period;

      for (int i = period; i < dataList.length; i++) {
        double highestHigh = 0.0;
        double lowestLow = double.maxFinite;

        for (int j = i - period; j < i; j++) {
          if (dataList[j].high > highestHigh) highestHigh = dataList[j].high;
          if (dataList[j].low < lowestLow) lowestLow = dataList[j].low;
        }

        double percentR =
            ((highestHigh - dataList[i].close) / (highestHigh - lowestLow)) *
                -100;

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
    for (var indicator in indicators) {
      final int period = indicator.period;

      for (int i = period; i < dataList.length; i++) {
        double positiveFlow = 0.0;
        double negativeFlow = 0.0;

        for (int j = i - period; j < i; j++) {
          double typicalPrice =
              (dataList[j].high + dataList[j].low + dataList[j].close) / 3;
          double rawMoneyFlow = typicalPrice * dataList[j].vol;

          if (j > 0 &&
              typicalPrice >
                  ((dataList[j - 1].high +
                          dataList[j - 1].low +
                          dataList[j - 1].close) /
                      3)) {
            positiveFlow += rawMoneyFlow;
          } else {
            negativeFlow += rawMoneyFlow;
          }
        }

        double moneyFlowRatio =
            positiveFlow / (negativeFlow == 0 ? 1 : negativeFlow);
        double mfi = 100 - (100 / (1 + moneyFlowRatio));

        dataList[i].mfiValues ??= List<CandleIndicatorEntity>.filled(
            indicators.length, indicator.copyToCandle(value: 0));

        dataList[i].mfiValues = _addNewIndicator(
          dataList[i].mfiValues,
          indicator,
          indicators.indexOf(indicator),
        );
        dataList[i].mfiValues![indicators.indexOf(indicator)] =
            indicator.copyToCandle(value: mfi);
      }
    }
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
