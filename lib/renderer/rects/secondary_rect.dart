import 'dart:math';

import 'package:candle_chart/entity/candle_indicator_entity.dart';
import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/k_chart_widget.dart';
import 'package:candle_chart/renderer/base_chart_painter.dart';
import 'package:candle_chart/renderer/rects/render_rect.dart';
import 'package:candle_chart/utils/kprint.dart';

class SecondaryRect {
  final Map<int, List<IndicatorEntity>> secondaryIndicators;
  List<RenderRect> mSecondaryRectList = [];

  SecondaryRect({
    required this.mSecondaryRectList,
    required this.secondaryIndicators,
  });

  void _setMaxAndMinSecondary(
    KLineEntity item,
    Function(double maxPrice, double minPrice) onSet,
    IndicatorEntity indicator,
    double mMaxValue,
    double mMinValue,
  ) {
    double maxPrice = 0, minPrice = 0;
    if (indicator.type == IndicatorType.ICHIMOKU) {
      maxPrice = _findMaxIchimoku(
        item.ichimokuValues ?? [],
        indicator.windowId,
      );
      minPrice = _findMinIchimoku(
        item.ichimokuValues ?? [],
        indicator.windowId,
      );
    } else if (indicator.type == IndicatorType.SMA_ENVELOPS) {
      maxPrice = _findMaxUP(item.smaEnvelopsValues ?? [], indicator.windowId);
      minPrice = _findMinDN(item.smaEnvelopsValues ?? [], indicator.windowId);
    } else if (indicator.type == IndicatorType.EMA_ENVELOPS) {
      maxPrice = _findMaxUP(item.emaEnvelopsValues ?? [], indicator.windowId);
      minPrice = _findMinDN(item.emaEnvelopsValues ?? [], indicator.windowId);
    } else if (indicator.type == IndicatorType.LINEAR_ENVELOPS) {
      maxPrice = _findMaxUP(item.lwmaEnvelopsValues ?? [], indicator.windowId);
      minPrice = _findMinDN(item.lwmaEnvelopsValues ?? [], indicator.windowId);
    } else if (indicator.type == IndicatorType.SMMA_ENVELOPS) {
      maxPrice = _findMaxUP(item.smmaEnvelopsValues ?? [], indicator.windowId);
      minPrice = _findMinDN(item.smmaEnvelopsValues ?? [], indicator.windowId);
    } else if (indicator.type == IndicatorType.PARABOLIC) {
      maxPrice = _findMaxMA(item.parabolicValues ?? [], indicator.windowId);
      minPrice = _findMinMA(item.parabolicValues ?? [], indicator.windowId);
    } else if (indicator.type == IndicatorType.LINEAR_MA) {
      maxPrice = _findMaxMA(item.lwmaMaValues ?? [], indicator.windowId);
      minPrice = _findMinMA(item.lwmaMaValues ?? [], indicator.windowId);
    } else if (indicator.type == IndicatorType.EMA_MA) {
      maxPrice = _findMaxMA(item.emaMaValues ?? [], indicator.windowId);
      minPrice = _findMinMA(item.emaMaValues ?? [], indicator.windowId);
    } else if (indicator.type == IndicatorType.SMA_MA) {
      maxPrice = _findMaxMA(item.smaMaValues ?? [], indicator.windowId);
      minPrice = _findMinMA(item.smaMaValues ?? [], indicator.windowId);
    } else if (indicator.type == IndicatorType.BOLL) {
      maxPrice = _findMaxUP(item.bollValues ?? [], indicator.windowId);
      minPrice = _findMinDN(item.bollValues ?? [], indicator.windowId);
    }

    onSet(max(maxPrice, mMaxValue) + 2, min(minPrice, mMinValue) - 2);
  }

  void _setMaxMin(
    indicator,
    KLineEntity item,
    Function(double maxPrice, double minPrice) onSet,
    double mMaxValue,
    double mMinValue,
  ) {
    switch (indicator.type) {
      case IndicatorType.MACD:
        final max = _findMaxUP(item.macdValues ?? [], indicator.windowId);
        mMaxValue = max;
        mMinValue = -max;
        break;
      case IndicatorType.RSI:
        mMaxValue = 100;
        mMinValue = 0.0;
        break;
      case IndicatorType.CCI ||
            IndicatorType.DEM ||
            IndicatorType.ATR ||
            IndicatorType.WPR ||
            IndicatorType.MOM:
        double resMax = 0;
        double resMin = 0;
        double space = 0;
        if (indicator.type == IndicatorType.ATR) {
          resMax = _findMinMA(item.atrValues ?? [], indicator.windowId);
          resMin = _findMaxMA(item.atrValues ?? [], indicator.windowId);
          space = 2;
        } else if (indicator.type == IndicatorType.CCI) {
          resMax = _findMaxMA(item.cciValues ?? [], indicator.windowId);
          resMin = _findMinMA(item.cciValues ?? [], indicator.windowId);
          space = 2;
        } else if (indicator.type == IndicatorType.WPR) {
          resMax = _findMaxMA(item.wprValues ?? [], indicator.windowId);
          resMin = _findMinMA(item.wprValues ?? [], indicator.windowId);
          space = 2;
        } else if (indicator.type == IndicatorType.MOM) {
          resMax = _findMaxMA(item.momentumValues ?? [], indicator.windowId);
          resMin = _findMinMA(item.momentumValues ?? [], indicator.windowId);
          space = 2;
        } else if (indicator.type == IndicatorType.DEM) {
          resMax = _findMaxMA(item.deMarkerValues ?? [], indicator.windowId);
          resMin = _findMinMA(item.deMarkerValues ?? [], indicator.windowId);
          space = 0.005;
        }
        mMaxValue = max(mMaxValue, resMax) + space;
        mMinValue = min(mMinValue, resMin) - space;
        break;
      default:
        break;
    }
    onSet(mMaxValue, mMinValue);
  }

  // compute maximum and minimum of secondary value
  getSecondaryMaxMinValue(int i, int index, int rectIndex, KLineEntity item) {
    final indicator =
        HighLevelIndicator.getIndicator(secondaryIndicators, i, index);
    switch (indicator.type) {
      case IndicatorType.MACD ||
            IndicatorType.RSI ||
            IndicatorType.CCI ||
            IndicatorType.DEM ||
            IndicatorType.ATR ||
            IndicatorType.WPR ||
            IndicatorType.MOM:
        _setMaxMin(
          indicator,
          item,
          (maxPrice, minPrice) {
            mSecondaryRectList[rectIndex].mMaxValue = maxPrice;
            mSecondaryRectList[rectIndex].mMinValue = minPrice;
          },
          mSecondaryRectList[rectIndex].mMaxValue,
          mSecondaryRectList[rectIndex].mMinValue,
        );
        break;
      default:
        if (indicator.applyTo == ApplyTo.First_Indicator) {
          final items = secondaryIndicators.atWindow(indicator.windowId);
          if (items.isNotEmpty) {
            _setMaxMin(
              items.first,
              item,
              (maxPrice, minPrice) {
                mSecondaryRectList[rectIndex].mMaxValue = maxPrice;
                mSecondaryRectList[rectIndex].mMinValue = minPrice;
              },
              mSecondaryRectList[rectIndex].mMaxValue,
              mSecondaryRectList[rectIndex].mMinValue,
            );
          }
          break;
        } else if (indicator.applyTo == ApplyTo.Last_Indicator) {
          final items = secondaryIndicators.atWindow(indicator.windowId);
          if (items.isNotEmpty) {
            _setMaxMin(
              items.last,
              item,
              (maxPrice, minPrice) {
                mSecondaryRectList[rectIndex].mMaxValue = maxPrice;
                mSecondaryRectList[rectIndex].mMinValue = minPrice;
              },
              mSecondaryRectList[rectIndex].mMaxValue,
              mSecondaryRectList[rectIndex].mMinValue,
            );
          }
          break;
        }
        double maxPrice = 0, minPrice = 0;
        _setMaxAndMinSecondary(
          item,
          (max, min) {
            maxPrice = max;
            minPrice = min;
          },
          indicator,
          mSecondaryRectList[rectIndex].mMaxValue,
          mSecondaryRectList[rectIndex].mMinValue,
        );
        mSecondaryRectList[rectIndex].mMaxValue = maxPrice;
        mSecondaryRectList[rectIndex].mMinValue = minPrice;
        break;
    }
  }

  // find maximum of the MA
  double _findMaxMA(List<CandleIndicatorEntity> a, int windowId) {
    double result = double.minPositive;
    for (CandleIndicatorEntity i in a) {
      if (i.isSecondary && windowId == i.windowId) {
        result = max(result, i.value);
      }
    }
    return result;
  }

  // find minimum of the UP
  double _findMaxUP(List<CandleIndicatorEntity> a, int windowId) {
    double result = double.minPositive;
    for (CandleIndicatorEntity i in a) {
      if (i.isSecondary && windowId == i.windowId) {
        result = max(result, i.up ?? 0);
      }
    }
    return result;
  }

  // find minimum of the MA
  double _findMinMA(List<CandleIndicatorEntity> a, int windowId) {
    double result = double.maxFinite;
    for (CandleIndicatorEntity i in a) {
      if (i.isSecondary && windowId == i.windowId) {
        result = min(
          result,
          i.value == 0 ? double.maxFinite : i.value,
        );
      }
    }
    return result;
  }

  // find minimum of the ChikouSpan
  double _findMaxIchimoku(List<CandleIndicatorEntity> a, int windowId) {
    double result = double.minPositive;
    for (CandleIndicatorEntity i in a) {
      if (i.isSecondary && windowId == i.windowId) {
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
  double _findMinIchimoku(List<CandleIndicatorEntity> a, int windowId) {
    double result = double.maxFinite;
    for (CandleIndicatorEntity i in a) {
      if (i.isSecondary && windowId == i.windowId) {
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
  double _findMinDN(List<CandleIndicatorEntity> a, int windowId) {
    double result = double.maxFinite;
    for (CandleIndicatorEntity i in a) {
      if (i.isSecondary && windowId == i.windowId) {
        result = min(
          result,
          i.dn == 0 ? double.maxFinite : i.dn ?? result,
        );
      }
    }
    return result;
  }
}

extension OnMap on Map<int, List<IndicatorEntity>> {
  List<IndicatorEntity> atWindow(int id) {
    final values = this[id] ?? [];
    final items = values.where((e) {
      return e.type == IndicatorType.MACD ||
          e.type == IndicatorType.RSI ||
          e.type == IndicatorType.ATR ||
          e.type == IndicatorType.CCI ||
          e.type == IndicatorType.MOM ||
          e.type == IndicatorType.SO ||
          e.type == IndicatorType.WPR ||
          e.type == IndicatorType.MFI ||
          e.type == IndicatorType.DEM;
    });
    return items.toList();
  }
}
