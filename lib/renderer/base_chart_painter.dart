import 'dart:math';

import 'package:candle_chart/utils/kprint.dart';
import 'package:candle_chart/entity/candle_indicator_entity.dart';
import 'package:candle_chart/entity/indicator_entity.dart';
import 'package:candle_chart/entity/line_entity.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/renderer/draw_object_lines.dart';
import 'package:candle_chart/utils/date_format_util.dart';
import 'package:flutter/material.dart'
    show
        Canvas,
        Color,
        CustomPainter,
        FontFeature,
        FontWeight,
        Rect,
        Size,
        TextSpan,
        TextStyle;

import '../chart_style.dart' show ChartStyle;
import '../entity/k_line_entity.dart';
import 'base_dimension.dart';

export 'package:flutter/material.dart'
    show Color, required, TextStyle, Rect, Canvas, Size, CustomPainter;

/// BaseChartPainter
abstract class BaseChartPainter extends CustomPainter
    implements DrawObjectLines {
  static double maxScrollX = 0.0;
  List<KLineEntity>? data; // data of chart
  List<LineEntity> linesPrice; // data of chart

  final List<IndicatorEntity> indicators;

  final List<IndicatorEntity> secondaryIndicators;

  bool volHidden;
  bool isTapShowInfoDialog;
  double scaleX = 1.0, scrollX = 0.0, selectX;
  bool isLongPress = false;
  bool isOnTap;
  bool isLine;

  /// Rectangle box of main chart
  late Rect mMainRect;

  /// Rectangle box of the vol chart
  Rect? mVolRect;

  /// Secondary list support
  List<RenderRect> mSecondaryRectList = [];
  late double mDisplayHeight, mWidth;

  // padding
  double mTopPadding = 30.0,
      mBottomPadding = 20.0,
      mChildPadding = 12.0,
      mSecondaryTopPadding = 28.0;

  // grid: rows - columns
  int mGridRows = 12, mGridColumns = 4;
  int mStartIndex = 0, mStopIndex = 0;
  double mMainMaxValue = double.minPositive, mMainMinValue = double.maxFinite;
  double mVolMaxValue = double.minPositive, mVolMinValue = double.maxFinite;
  double mTranslateX = double.minPositive;
  int mMainMaxIndex = 0, mMainMinIndex = 0;

  int mItemCount = 0;
  double mDataLen = 0.0; // the data occupies the total length of the screen
  final ChartStyle chartStyle;
  late double mPointWidth;

  // format time
  List<String> mFormats = [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn];
  double xFrontPadding;

  /// base dimension
  final BaseDimension baseDimension;

  /// constructor BaseChartPainter
  ///
  BaseChartPainter(
    this.chartStyle, {
    this.data,
    this.linesPrice = const [],
    required this.scaleX,
    required this.scrollX,
    required this.isLongPress,
    required this.selectX,
    required this.xFrontPadding,
    required this.baseDimension,
    this.isOnTap = false,
    this.indicators = const [],
    this.volHidden = false,
    this.isTapShowInfoDialog = false,
    this.secondaryIndicators = const [],
    this.isLine = false,
  }) {
    mItemCount = data?.length ?? 0;
    mPointWidth = this.chartStyle.pointWidth;
    mTopPadding = this.chartStyle.topPadding;
    mBottomPadding = this.chartStyle.bottomPadding;
    mChildPadding = this.chartStyle.childPadding;
    mGridRows = this.chartStyle.gridRows;
    mGridColumns = this.chartStyle.gridColumns;
    mDataLen = mItemCount * mPointWidth;
    initFormats();
  }

  /// init format time
  void initFormats() {
    if (this.chartStyle.dateTimeFormat != null) {
      mFormats = this.chartStyle.dateTimeFormat!;
      return;
    }

    if (mItemCount < 2) {
      mFormats = [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn];
      return;
    }

    int firstTime = data!.first.time ?? 0;
    int secondTime = data![1].time ?? 0;
    int time = secondTime - firstTime;
    time ~/= 1000;
    // monthly line
    if (time >= 24 * 60 * 60 * 28) {
      mFormats = [yyyy, '-', mm];
    } else if (time >= 24 * 60 * 60) {
      // daily line
      mFormats = [yyyy, '-', mm, '-', dd];
    } else {
      // hour line
      mFormats = [M, '-', dd, ' ', HH, ':', nn];
    }
  }

  bool isInitial = false;

  /// paint chart
  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTRB(0, 0, size.width, size.height));
    mDisplayHeight = size.height - mTopPadding - mBottomPadding;
    mWidth = size.width - this.chartStyle.priceWidth;
    initRect(size);
    calculateValue();
    initChartRenderer(size.height);

    canvas.save();
    canvas.scale(1, 1);
    drawBg(canvas, size);
    drawGrid(canvas);
    if (data != null && data!.isNotEmpty) {
      drawChart(canvas, size);
      drawVerticalText(canvas);
      drawDate(canvas, size);

      drawText(canvas, data!.last, 5);
      drawMaxAndMin(canvas);
      // drawNowPrice(canvas);
      drawLinePrice(canvas, size);
      if (this.chartStyle.isLongFocus &&
          (isLongPress == true ||
              (isTapShowInfoDialog && longPressTriggered))) {
        drawCrossLineText(canvas, size);
      } else if (!this.chartStyle.isLongFocus &&
          (isLongPress == true || (isTapShowInfoDialog && isOnTap))) {
        drawCrossLineText(canvas, size);
      }
    }
    canvas.restore();
  }

  /// init chart renderer
  void initChartRenderer(double height);

  /// draw the background of chart
  void drawBg(Canvas canvas, Size size);

  /// draw the grid of chart
  void drawGrid(canvas);

  /// draw chart
  void drawChart(Canvas canvas, Size size);

  /// draw vertical text
  void drawVerticalText(canvas);

  /// draw date
  void drawDate(Canvas canvas, Size size);

  /// draw text
  void drawText(Canvas canvas, KLineEntity data, double x);

  /// draw maximum and minimum values
  void drawMaxAndMin(Canvas canvas);

  /// draw the current price
  void drawNowPrice(Canvas canvas);

  /// draw the line price
  void drawLinePrice(Canvas canvas, Size size);

  /// draw cross line
  void drawCrossLine(Canvas canvas, Size size);

  /// draw text of the cross line
  void drawCrossLineText(Canvas canvas, Size size);

  /// init the rectangle box to draw chart
  void initRect(Size size) {
    double volHeight = baseDimension.mVolumeHeight;
    double secondaryHeight = baseDimension.mSecondaryHeight;

    double mainHeight = mDisplayHeight;
    mainHeight -= volHeight;
    mainHeight -= secondaryHeight;

    mMainRect = Rect.fromLTRB(0, mTopPadding, mWidth, mTopPadding + mainHeight);

    if (volHidden != true) {
      mVolRect = Rect.fromLTRB(
        0,
        mMainRect.bottom + mChildPadding,
        mWidth,
        mMainRect.bottom + volHeight,
      );
    }

    mSecondaryRectList.clear();
    double rowSpace = ((mDisplayHeight * 0.85) / mGridRows);
    double _secondaryHeight = 0;
    for (int i = 0; i < secondaryIndicators.length; ++i) {
      final secondary =
          baseDimension.getSecondaryHeight(secondaryIndicators[i]);
      mSecondaryRectList.add(
        RenderRect(
          Rect.fromLTRB(
            0,
            mMainRect.bottom + volHeight + _secondaryHeight,
            mWidth,
            mMainRect.bottom + volHeight + _secondaryHeight + secondary,
          ),
        ),
      );
      _secondaryHeight += secondary;
    }
  }

  /// calculate values
  calculateValue() {
    if (data == null) return;
    if (data!.isEmpty) return;
    maxScrollX = getMinTranslateX().abs();
    setTranslateXFromScrollX(scrollX);
    mStartIndex = indexOfTranslateX(xToTranslateX(0));
    mStopIndex = indexOfTranslateX(xToTranslateX(mWidth));
    for (int i = mStartIndex; i <= mStopIndex; i++) {
      var item = data![i];
      getMainMaxMinValue(item, i);
      getVolMaxMinValue(item);
      for (int idx = 0; idx < mSecondaryRectList.length; ++idx) {
        getSecondaryMaxMinValue(idx, item);
      }
    }
  }

  /// compute maximum and minimum value
  void getMainMaxMinValue(KLineEntity item, int i) {
    double maxPrice = item.high, minPrice = item.low;

    for (var indicator in indicators) {
      if (indicator.type == IndicatorType.ICHIMOKU) {
        maxPrice = max(_findMaxIchimoku(item.ichimokuValues ?? []), item.high);
        minPrice = min(_findMinIchimoku(item.ichimokuValues ?? []), item.low);
      } else if (indicator.type == IndicatorType.SMA_ENVELOPS) {
        maxPrice = max(item.high, _findMaxUP(item.smaEnvelopsValues ?? []));
        minPrice = min(item.low, _findMinDN(item.smaEnvelopsValues ?? []));
      } else if (indicator.type == IndicatorType.EMA_ENVELOPS) {
        maxPrice = max(item.high, _findMaxUP(item.emaEnvelopsValues ?? []));
        minPrice = min(item.low, _findMinMA(item.emaEnvelopsValues ?? []));
      } else if (indicator.type == IndicatorType.LINEAR_ENVELOPS) {
        maxPrice = max(item.high, _findMaxUP(item.lwmaEnvelopsValues ?? []));
        minPrice = min(item.low, _findMinDN(item.lwmaEnvelopsValues ?? []));
      } else if (indicator.type == IndicatorType.SMMA_ENVELOPS) {
        maxPrice = max(item.high, _findMaxUP(item.smmaEnvelopsValues ?? []));
        minPrice = min(item.low, _findMinDN(item.smmaEnvelopsValues ?? []));
      } else if (indicator.type == IndicatorType.PARABOLIC) {
        maxPrice = max(item.high, _findMaxMA(item.parabolicValues ?? []));
        minPrice = min(item.low, _findMinMA(item.parabolicValues ?? []));
      } else if (indicator.type == IndicatorType.LINEAR_MA) {
        maxPrice = max(item.high, _findMaxMA(item.lwmaMaValues ?? []));
        minPrice = min(item.low, _findMinMA(item.lwmaMaValues ?? []));
      } else if (indicator.type == IndicatorType.EMA_MA) {
        maxPrice = max(item.high, _findMaxMA(item.emaMaValues ?? []));
        minPrice = min(item.low, _findMinMA(item.emaMaValues ?? []));
      } else if (indicator.type == IndicatorType.SMA_MA) {
        maxPrice = max(item.high, _findMaxMA(item.smaMaValues ?? []));
        minPrice = min(item.low, _findMinMA(item.smaMaValues ?? []));
      } else if (indicator.type == IndicatorType.BOLL) {
        maxPrice = max(_findMaxUP(item.bollValues ?? []), item.high);
        minPrice = min(_findMinDN(item.bollValues ?? []), item.low);
      }
    }
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

  // find maximum of the MA
  double _findMaxMA(List<CandleIndicatorEntity> a) {
    double result = double.minPositive;
    for (CandleIndicatorEntity i in a) {
      result = max(result, i.value);
    }
    return result;
  }

  // find minimum of the UP
  double _findMaxUP(List<CandleIndicatorEntity> a) {
    double result = double.minPositive;
    for (CandleIndicatorEntity i in a) {
      result = max(result, i.up ?? 0);
    }
    return result;
  }

  // find minimum of the ChikouSpan
  double _findMaxIchimoku(List<CandleIndicatorEntity> a) {
    double result = double.minPositive;
    for (CandleIndicatorEntity i in a) {
      result = max(result, i.chikouSpan ?? 0);
    }
    return result;
  }

  // find minimum of the MA
  double _findMinMA(List<CandleIndicatorEntity> a) {
    double result = double.maxFinite;
    for (CandleIndicatorEntity i in a) {
      result = min(result, i.value == 0 ? double.maxFinite : i.value);
    }
    return result;
  }

  // find minimum of the ChikouSpan
  double _findMinIchimoku(List<CandleIndicatorEntity> a) {
    double result = double.maxFinite;
    for (CandleIndicatorEntity i in a) {
      result = min(result,
          i.chikouSpan == 0 ? double.maxFinite : i.chikouSpan ?? result);
    }
    return result;
  }

  // find minimum of the DN
  double _findMinDN(List<CandleIndicatorEntity> a) {
    double result = double.maxFinite;
    for (CandleIndicatorEntity i in a) {
      result = min(result, i.dn == 0 ? double.maxFinite : i.dn ?? result);
    }
    return result;
  }

  // get the maximum and minimum of the Vol value
  void getVolMaxMinValue(KLineEntity item) {
    mVolMaxValue = max(mVolMaxValue,
        max(item.vol, max(item.MA5Volume ?? 0, item.MA10Volume ?? 0)));
    mVolMinValue = min(mVolMinValue,
        min(item.vol, min(item.MA5Volume ?? 0, item.MA10Volume ?? 0)));
  }

  // compute maximum and minimum of secondary value
  getSecondaryMaxMinValue(int index, KLineEntity item) {
    final indicator = secondaryIndicators.elementAt(index);
    switch (indicator.type) {
      case IndicatorType.MACD:
        mSecondaryRectList[index].mMaxValue = _findMaxUP(item.macdValues ?? []);
        mSecondaryRectList[index].mMinValue = _findMinDN(item.macdValues ?? []);
        break;
      case IndicatorType.KDJ:
        if (item.d != null) {
          mSecondaryRectList[index].mMaxValue = max(
              mSecondaryRectList[index].mMaxValue,
              max(item.k!, max(item.d!, item.j!)));
          mSecondaryRectList[index].mMinValue = min(
              mSecondaryRectList[index].mMinValue,
              min(item.k!, min(item.d!, item.j!)));
        }
        break;
      case IndicatorType.RSI:
        // if (item.rsi != null) {
        mSecondaryRectList[index].mMaxValue = 100;
        mSecondaryRectList[index].mMinValue = 0.0;
        // }
        break;
      case IndicatorType.WR:
        mSecondaryRectList[index].mMaxValue = 0;
        mSecondaryRectList[index].mMinValue = -100;
        break;
      case IndicatorType.CCI:
        if (item.cci != null) {
          mSecondaryRectList[index].mMaxValue =
              max(mSecondaryRectList[index].mMaxValue, item.cci!);
          mSecondaryRectList[index].mMinValue =
              min(mSecondaryRectList[index].mMinValue, item.cci!);
        }
        break;
      default:
        mSecondaryRectList[index].mMaxValue = 0;
        mSecondaryRectList[index].mMinValue = 0;
        break;
    }
  }

  // translate x
  double xToTranslateX(double x) => -mTranslateX + x / scaleX;

  int indexOfTranslateX(double translateX) =>
      _indexOfTranslateX(translateX, 0, mItemCount - 1);

  /// Using binary search for the index of the current value
  int _indexOfTranslateX(double translateX, int start, int end) {
    if (end == start || end == -1) {
      return start;
    }
    if (end - start == 1) {
      double startValue = getX(start);
      double endValue = getX(end);
      return (translateX - startValue).abs() < (translateX - endValue).abs()
          ? start
          : end;
    }
    int mid = start + (end - start) ~/ 2;
    double midValue = getX(mid);
    if (translateX < midValue) {
      return _indexOfTranslateX(translateX, start, mid);
    } else if (translateX > midValue) {
      return _indexOfTranslateX(translateX, mid, end);
    } else {
      return mid;
    }
  }

  /// Get x coordinate based on index
  /// + mPointWidth / 2 to prevent the first and last K-line from displaying incorrectly
  /// @param position index value
  double getX(int position) => position * mPointWidth + mPointWidth / 2;

  KLineEntity getItem(int position) {
    return data![position];
    // if (datas != null) {
    //   return datas[position];
    // } else {
    //   return null;
    // }
  }

  /// scrollX convert to TranslateX
  void setTranslateXFromScrollX(double scrollX) =>
      mTranslateX = scrollX + getMinTranslateX();

  /// get the minimum value of translation
  double getMinTranslateX() {
    var x = -mDataLen + mWidth / scaleX - mPointWidth / 2 - xFrontPadding;
    return x >= 0 ? 0.0 : x;
  }

  /// calculate the value of x after long pressing and convert to [index]
  int calculateSelectedX(double selectX) {
    int mSelectedIndex = indexOfTranslateX(xToTranslateX(selectX));
    if (mSelectedIndex < mStartIndex) {
      mSelectedIndex = mStartIndex;
    }
    if (mSelectedIndex > mStopIndex) {
      mSelectedIndex = mStopIndex;
    }
    return mSelectedIndex;
  }

  /// translateX is converted to X in view
  double translateXtoX(double translateX) =>
      (translateX + mTranslateX) * scaleX;

  @override
  bool shouldRepaint(BaseChartPainter oldDelegate) {
    return true;
  }
}

/// Render Rectangle
class RenderRect {
  Rect mRect;
  double mMaxValue = double.minPositive, mMinValue = double.maxFinite;

  RenderRect(this.mRect);
}

//# 科学下标
TextSpan formatValueSpan(double? value, TextStyle style) {
  if (value == 0.00) {
    return TextSpan(text: ' 0.00', style: style);
    // return TextSpan(text: '\$ 0.00', style: style);
  }

  String _dollarValue(double value, int decimals) {
    return '' + value.toStringAsFixed(decimals);
    // return '\$' + value.toStringAsFixed(decimals);
  }

  if (value != null && value < 0.01) {
    final temp = value.toStringAsFixed(8).split('.');
    if (temp.length != 2) {
      return TextSpan(text: _dollarValue(value, 2), style: style);
    }
    var index = 0;
    for (; index < temp[1].length; index++) {
      if (temp[1][index] != '0') {
        break;
      }
    }
    final remain = temp[1].replaceRange(0, index, '');
    return TextSpan(
      text: '0.0',
      // text: '\$0.0',
      children: [
        ///	•	FontFeature.alternativeFractions(): 使用替代分数样式。
        // 	•	FontFeature.caseSensitiveForms(): 使用大小写敏感表单样式。
        // 	•	FontFeature.characterVariant(int value): 使用字符变体。
        // 	•	FontFeature.contextualAlternates(): 使用上下文替代样式。
        // 	•	FontFeature.denominator(): 使用分母样式。
        // 	•	FontFeature.fractions(): 使用分数样式。
        // 	•	FontFeature.historicalForms(): 使用历史表单样式。
        // 	•	FontFeature.liningFigures(): 使用等线数字。
        // 	•	FontFeature.localeAware(value): 使用特定语言环境的字体特性。
        // 	•	FontFeature.notationalForms(int value): 使用符号表单。
        // 	•	FontFeature.numerators(): 使用分子样式。
        // 	•	FontFeature.ordinalForms(): 使用序数样式。
        // 	•	FontFeature.proportionalFigures(): 使用比例数字。
        // 	•	FontFeature.scientificInferiors(): 使用科学下标样式。
        // 	•	FontFeature.slashedZero(): 使用带斜线的零。
        TextSpan(
          text: '$index',
          style: style.copyWith(
              fontFeatures: [
                FontFeature.oldstyleFigures(),
                FontFeature.scientificInferiors(),
              ],
              fontSize: style.fontSize == null ? null : style.fontSize! - 3,
              fontWeight: FontWeight.w900), // 调整行高以模拟偏移效果
        ),
        // WidgetSpan(
        //   child: Transform.translate(
        //     offset: Offset(0, 0),
        //     child: Text(
        //       '$index',
        //       style: style.copyWith(
        //           fontWeight: FontWeight.w900,
        //           textBaseline: TextBaseline.ideographic,
        //           fontSize:
        //               style.fontSize == null ? null : style.fontSize! - 3,
        //          ),
        //     ),
        //   ),
        // ),
        TextSpan(
            text: remain.substring(0, min(remain.length, 4)), style: style),
      ],
      style: style,
    );
  }

  String realValueStr = '-';
  if (value != null) {
    if (value >= 1000000000) {
      realValueStr = '${_dollarValue(value / 1000000000, 2)}B';
    } else if (value >= 1000000) {
      realValueStr = '${_dollarValue(value / 1000000, 2)}M';
    } else if (value >= 1000) {
      realValueStr = value.toStringAsFixed(2);
    } else {
      realValueStr = _dollarValue(value, 2);
    }
  }
  return TextSpan(text: realValueStr, style: style);
}
