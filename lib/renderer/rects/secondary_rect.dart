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
      maxPrice = _findMaxIchimoku(item.ichimokuValues ?? []);
      minPrice = _findMinIchimoku(item.ichimokuValues ?? []);
    } else if (indicator.type == IndicatorType.SMA_ENVELOPS) {
      maxPrice = _findMaxUP(item.smaEnvelopsValues ?? []);
      minPrice = _findMinDN(item.smaEnvelopsValues ?? []);
    } else if (indicator.type == IndicatorType.EMA_ENVELOPS) {
      maxPrice = _findMaxUP(item.emaEnvelopsValues ?? []);
      minPrice = _findMinDN(item.emaEnvelopsValues ?? []);
    } else if (indicator.type == IndicatorType.LINEAR_ENVELOPS) {
      maxPrice = _findMaxUP(item.lwmaEnvelopsValues ?? []);
      minPrice = _findMinDN(item.lwmaEnvelopsValues ?? []);
    } else if (indicator.type == IndicatorType.SMMA_ENVELOPS) {
      maxPrice = _findMaxUP(item.smmaEnvelopsValues ?? []);
      minPrice = _findMinDN(item.smmaEnvelopsValues ?? []);
    } else if (indicator.type == IndicatorType.PARABOLIC) {
      maxPrice = _findMaxMA(item.parabolicValues ?? []);
      minPrice = _findMinMA(item.parabolicValues ?? []);
    } else if (indicator.type == IndicatorType.LINEAR_MA) {
      maxPrice = _findMaxMA(item.lwmaMaValues ?? []);
      minPrice = _findMinMA(item.lwmaMaValues ?? []);
    } else if (indicator.type == IndicatorType.EMA_MA) {
      maxPrice = _findMaxMA(item.emaMaValues ?? []);
      minPrice = _findMinMA(item.emaMaValues ?? []);
    } else if (indicator.type == IndicatorType.SMA_MA) {
      maxPrice = _findMaxMA(item.smaMaValues ?? []);
      minPrice = _findMinMA(item.smaMaValues ?? []);
    } else if (indicator.type == IndicatorType.BOLL) {
      maxPrice = _findMaxUP(item.bollValues ?? []);
      minPrice = _findMinDN(item.bollValues ?? []);
    }

    onSet(max(maxPrice, mMaxValue), min(minPrice, mMinValue));
  }

  // compute maximum and minimum of secondary value
  getSecondaryMaxMinValue(int i, int index, int rectIndex, KLineEntity item) {
    final indicator =
        HighLevelIndicator.getIndicator(secondaryIndicators, i, index);
    switch (indicator.type) {
      case IndicatorType.MACD:
        final max = _findMaxUP(item.macdValues ?? []);
        mSecondaryRectList[rectIndex].mMaxValue = max;
        mSecondaryRectList[rectIndex].mMinValue = -max;
        break;
      case IndicatorType.KDJ:
        if (item.d != null) {
          mSecondaryRectList[rectIndex].mMaxValue = max(
              mSecondaryRectList[rectIndex].mMaxValue,
              max(item.k!, max(item.d!, item.j!)));
          mSecondaryRectList[rectIndex].mMinValue = min(
              mSecondaryRectList[rectIndex].mMinValue,
              min(item.k!, min(item.d!, item.j!)));
        }
        break;
      case IndicatorType.RSI:
        mSecondaryRectList[rectIndex].mMaxValue = 100;
        mSecondaryRectList[rectIndex].mMinValue = 0.0;
        break;
      case IndicatorType.WR:
        mSecondaryRectList[rectIndex].mMaxValue = 0;
        mSecondaryRectList[rectIndex].mMinValue = -100;
        break;
      case IndicatorType.CCI:
        if (item.cci != null) {
          mSecondaryRectList[rectIndex].mMaxValue =
              max(mSecondaryRectList[rectIndex].mMaxValue, item.cci!);
          mSecondaryRectList[rectIndex].mMinValue =
              min(mSecondaryRectList[rectIndex].mMinValue, item.cci!);
        }
        break;
      default:
        if (indicator.applyTo == ApplyTo.First_Indicator) {
          final items = secondaryIndicators.atWindow(indicator.windowId);
          if (items.isNotEmpty) {
            if (items.first.type == IndicatorType.RSI) {
              mSecondaryRectList[rectIndex].mMaxValue = 100;
              mSecondaryRectList[rectIndex].mMinValue = 0;
              break;
            } else if (items.first.type == IndicatorType.MACD) {
              final max = _findMaxUP(item.macdValues ?? []);
              mSecondaryRectList[rectIndex].mMaxValue = max;
              mSecondaryRectList[rectIndex].mMinValue = -max;
              break;
            }
          }
        } else if (indicator.applyTo == ApplyTo.Last_Indicator) {
          final items = secondaryIndicators.atWindow(indicator.windowId);
          if (items.isNotEmpty) {
            if (items.last.type == IndicatorType.RSI) {
              mSecondaryRectList[rectIndex].mMaxValue = 100;
              mSecondaryRectList[rectIndex].mMinValue = 0;
              break;
            } else if (items.last.type == IndicatorType.MACD) {
              final max = _findMaxUP(item.macdValues ?? []);
              mSecondaryRectList[rectIndex].mMaxValue = max;
              mSecondaryRectList[rectIndex].mMinValue = -max;
              break;
            }
          }
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
        if (indicator.type == IndicatorType.ICHIMOKU) {
          kPrint(
              '${mSecondaryRectList[rectIndex].mMinValue} ${mSecondaryRectList[rectIndex].mMaxValue}');
        }
        break;
    }
  }

  // find maximum of the MA
  double _findMaxMA(List<CandleIndicatorEntity> a) {
    double result = double.minPositive;
    for (CandleIndicatorEntity i in a) {
      if (i.isSecondary) {
        result = max(result, i.value);
      }
    }
    return result;
  }

  // find minimum of the UP
  double _findMaxUP(List<CandleIndicatorEntity> a) {
    double result = double.minPositive;
    for (CandleIndicatorEntity i in a) {
      if (i.isSecondary) {
        result = max(result, i.up ?? 0);
      }
    }
    return result;
  }

  // find minimum of the MA
  double _findMinMA(List<CandleIndicatorEntity> a) {
    double result = double.maxFinite;
    for (CandleIndicatorEntity i in a) {
      if (i.isSecondary) {
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
      if (i.isSecondary) {
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
      if (i.isSecondary) {
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
      if (i.isSecondary) {
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
      return e.type == IndicatorType.MACD || e.type == IndicatorType.RSI;
    });
    return items.toList();
  }
}
