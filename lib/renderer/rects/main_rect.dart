import 'dart:math';

import 'package:candle_chart/entity/candle_indicator_entity.dart';
import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/k_chart_widget.dart';
import 'package:candle_chart/utils/kprint.dart';

class MainRect {
  double mMainMaxValue = double.minPositive, mMainMinValue = double.maxFinite;
  int mMainMaxIndex = 0, mMainMinIndex = 0;
  final bool isLine;
  final List<IndicatorEntity> indicators;
  late double mMainHighMaxValue, mMainLowMinValue;

  MainRect({
    required this.indicators,
    required this.isLine,
    required this.mMainHighMaxValue,
    required this.mMainLowMinValue,
  });

  /// compute maximum and minimum value
  void getMainMaxMinValue(KLineEntity item, int i) {
    double maxPrice = item.high, minPrice = item.low;
    _setMaxAndMin(
      item,
      (max, min) {
        maxPrice = max;
        minPrice = min;
      },
      indicators,
    );
    mMainMaxValue = max(mMainMaxValue, maxPrice);
    mMainMinValue = min(mMainMinValue, minPrice);

    if (mMainHighMaxValue < item.high) {
      mMainHighMaxValue = item.high;
      mMainMaxIndex = i;
    }
    if (mMainLowMinValue > item.low) {
      mMainLowMinValue = item.low;
      mMainMinIndex = i;
    }

    if (isLine == true) {
      mMainMaxValue = max(mMainMaxValue, item.close);
      mMainMinValue = min(mMainMinValue, item.close);
    }
  }

  void _setMaxAndMin(
    KLineEntity item,
    Function(double maxPrice, double minPrice) onSet,
    List<IndicatorEntity> indicators,
  ) {
    double maxPrice = item.high, minPrice = item.low;
    for (var indicator in indicators) {
      if (indicator.type == IndicatorType.ICHIMOKU) {
        maxPrice = max(_findMaxIchimoku(item.ichimokuValues ?? []), maxPrice);
        minPrice = min(_findMinIchimoku(item.ichimokuValues ?? []), minPrice);
      } else if (indicator.type == IndicatorType.ENVELOPS_SMA) {
        maxPrice = max(maxPrice, _findMaxUP(item.envelopsSmaValues ?? []));
        minPrice = min(minPrice, _findMinDN(item.envelopsSmaValues ?? []));
      } else if (indicator.type == IndicatorType.ENVELOPS_EMA) {
        maxPrice = max(maxPrice, _findMaxUP(item.envelopsEmaValues ?? []));
        minPrice = min(minPrice, _findMinDN(item.envelopsEmaValues ?? []));
      } else if (indicator.type == IndicatorType.ENVELOPS_LINEAR) {
        maxPrice = max(maxPrice, _findMaxUP(item.envelopsLwmaValues ?? []));
        minPrice = min(minPrice, _findMinDN(item.envelopsLwmaValues ?? []));
      } else if (indicator.type == IndicatorType.ENVELOPS_SMMA) {
        maxPrice = max(maxPrice, _findMaxUP(item.envelopsSmmaValues ?? []));
        minPrice = min(minPrice, _findMinDN(item.envelopsSmmaValues ?? []));
      } else if (indicator.type == IndicatorType.PARABOLIC) {
        maxPrice = max(maxPrice, _findMaxMA(item.parabolicValues ?? []));
        minPrice = min(minPrice, _findMinMA(item.parabolicValues ?? []));
      } else if (indicator.type == IndicatorType.MA_LINEAR) {
        maxPrice = max(maxPrice, _findMaxMA(item.maLwmaValues ?? []));
        minPrice = min(minPrice, _findMinMA(item.maLwmaValues ?? []));
      } else if (indicator.type == IndicatorType.MA_EMA) {
        maxPrice = max(maxPrice, _findMaxMA(item.maEmaValues ?? []));
        minPrice = min(minPrice, _findMinMA(item.maEmaValues ?? []));
      } else if (indicator.type == IndicatorType.MA_SMA) {
        maxPrice = max(maxPrice, _findMaxMA(item.maSmaValues ?? []));
        minPrice = min(minPrice, _findMinMA(item.maSmaValues ?? []));
      } else if (indicator.type == IndicatorType.BOLL) {
        maxPrice = max(_findMaxUP(item.bollValues ?? []), maxPrice);
        minPrice = min(_findMinDN(item.bollValues ?? []), minPrice);
      }
    }
    onSet(maxPrice, minPrice);
  }

  // find maximum of the MA
  double _findMaxMA(List<CandleIndicatorEntity> a) {
    double result = double.minPositive;
    for (CandleIndicatorEntity i in a) {
      if (i.isMain) {
        result = max(result, i.value);
      }
    }
    return result;
  }

  // find minimum of the UP
  double _findMaxUP(List<CandleIndicatorEntity> a) {
    double result = double.minPositive;
    for (CandleIndicatorEntity i in a) {
      if (i.isMain) {
        result = max(result, i.up ?? 0);
      }
    }
    return result;
  }

  // find minimum of the MA
  double _findMinMA(List<CandleIndicatorEntity> a) {
    double result = double.maxFinite;
    for (CandleIndicatorEntity i in a) {
      if (i.isMain) {
        result = min(
          result,
          i.value == 0 ? double.maxFinite : i.value,
        );
      }
    }
    return result;
  }

  // find minimum of the ChikouSpan
  double _findMaxIchimoku(List<CandleIndicatorEntity> a) {
    double result = double.minPositive;
    for (CandleIndicatorEntity i in a) {
      if (i.isMain) {
        result = max(result, i.chikouSpan ?? 0);
        result = max(result, i.senkouSpanA ?? 0);
        result = max(result, i.senkouSpanB ?? 0);
        result = max(result, i.kijunSen ?? 0);
        result = max(result, i.tenkanSen ?? 0);
      }
    }
    return result;
  }

  // find minimum of the ChikouSpan
  double _findMinIchimoku(List<CandleIndicatorEntity> a) {
    double result = double.maxFinite;
    for (CandleIndicatorEntity i in a) {
      if (i.isMain) {
        result = min(result,
            i.chikouSpan == 0 ? double.maxFinite : i.chikouSpan ?? result);
        result = min(result,
            i.senkouSpanA == 0 ? double.maxFinite : i.senkouSpanA ?? result);
        result = min(result,
            i.senkouSpanB == 0 ? double.maxFinite : i.senkouSpanB ?? result);
        result = min(
            result, i.kijunSen == 0 ? double.maxFinite : i.kijunSen ?? result);
        result = min(result,
            i.tenkanSen == 0 ? double.maxFinite : i.tenkanSen ?? result);
      }
    }
    return result;
  }

  // find minimum of the DN
  double _findMinDN(List<CandleIndicatorEntity> a) {
    double result = double.maxFinite;
    for (CandleIndicatorEntity i in a) {
      if (i.isMain) {
        result = min(
          result,
          i.dn == 0 ? double.maxFinite : i.dn ?? result,
        );
      }
    }
    return result;
  }
}
