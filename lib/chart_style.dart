import 'package:flutter/material.dart' show Color, Colors;

/// ChartColors
///
/// Note:
/// If you need to apply multi theme, you need to change at least the colors related to the text, border and background color
/// Ex:
/// Background: bgColor, selectFillColor
/// Border
/// Text
///
class ChartColors {
  /// the background color of base chart
  Color bgColor;

  Color kLineColor;

  Color iconColor;
  Color optionsColor;
  Color primary;
  Color ask;
  Color bid;
  Color chartColor;
  Color stopLoss;
  Color takeProfit;

  ///
  Color lineFillColor;

  ///
  Color lineFillInsideColor;

  /// color: ma5, ma10, ma30, up, down, vol, macd, diff, dea, k, d, j, rsi
  Color ma5Color;
  Color ma10Color;
  Color ma30Color;
  Color upColor;
  Color dnColor;
  Color volColor;

  /// default text color: apply for text at grid
  Color defaultTextColor;

  /// color of the current price
  Color nowPriceUpColor;
  Color nowPriceDnColor;
  Color nowPriceTextColor;
  Color priceTextColor;

  ///value border color after selection
  Color selectBorderColor;

  ///background color when value selected
  Color selectFillColor;

  ///color of grid
  Color gridColor;
  Color black;

  ///color of annotation content
  Color infoWindowNormalColor;
  Color infoWindowTitleColor;
  Color infoWindowUpColor;
  Color infoWindowDnColor;

  /// color of the horizontal cross line
  Color hCrossColor;

  /// color of the vertical cross line
  Color vCrossColor;

  /// text color
  Color crossTextColor;

  ///The color of the maximum and minimum values in the current display
  Color maxColor;
  Color minColor;

  double sizeText = 10.0;

  /// get MA color via index
  Color getMAColor(int index) {
    switch (index % 3) {
      case 1:
        return ma10Color;
      case 2:
        return ma30Color;
      default:
        return ma5Color;
    }
  }

  /// constructor chart color
  ChartColors({
    this.bgColor = const Color(0xffffffff),
    this.chartColor = Colors.blue,
    this.ask = Colors.red,
    this.bid = Colors.black,
    this.takeProfit = Colors.blue,
    this.stopLoss = Colors.blue,
    this.kLineColor = const Color(0xff4C86CD),
    this.iconColor = Colors.blue,
    this.optionsColor = Colors.black,
    this.primary = Colors.blue,

    ///
    this.lineFillColor = const Color(0x554C86CD),

    ///
    this.lineFillInsideColor = const Color(0x00000000),

    ///
    this.ma5Color = const Color(0xffD5405D),
    this.ma10Color = const Color(0xff1FD1AC),
    this.ma30Color = const Color(0xffE5B767),
    this.upColor = const Color(0xFF14AD8F),
    this.dnColor = const Color(0xFFD5405D),
    this.volColor = const Color(0xff2f8fd5),
    this.defaultTextColor = const Color(0xFF909196),
    this.nowPriceUpColor = const Color(0xFF14AD8F),
    this.nowPriceDnColor = const Color(0xFFD5405D),
    this.nowPriceTextColor = const Color(0xffffffff),
    this.priceTextColor = const Color(0xffffffff),

    ///value border color after selection
    this.selectBorderColor = const Color(0xFF222223),

    ///background color when value selected
    this.selectFillColor = const Color(0xffffffff),

    ///color of grid
    this.gridColor = const Color(0xFFD1D3DB),
    this.black = const Color(0xFf00000),

    ///color of annotation content
    this.infoWindowNormalColor = const Color(0xFF222223),
    this.infoWindowTitleColor = const Color(0xFF4D4D4E), //0xFF707070
    this.infoWindowUpColor = const Color(0xFF14AD8F),
    this.infoWindowDnColor = const Color(0xFFD5405D),
    this.hCrossColor = const Color(0xFF222223),
    this.vCrossColor = const Color(0x28424652),
    this.crossTextColor = const Color(0xFF222223),

    ///The color of the maximum and minimum values in the current display
    this.maxColor = const Color(0xFF222223),
    this.minColor = const Color(0xFF222223),
    this.sizeText = 10.0,
  });
}

class ChartPosition {
  double bottomPrice;
  double topPrice;

  ChartPosition({
    this.bottomPrice = 0,
    this.topPrice = 0,
  });
}

class ChartStyle {
  double topPadding = 30.0;

  double leftPadding = 5.0;

  double rightPadding = 5.0;

  double priceWidth = 60.0;

  // 是否保留小数点 - 左侧刻度
  bool isNotPoint = false;

  // 是否显示最高最低点
  bool isShowHighOrLowPoint = false;

  // 是否显示左侧顶部最大刻度
  bool isShowLeftTopicPoint = true;

  // 是否显示策略类型顶部
  bool isShowStrategyTypeTop = true;

  // 是否显示策略类型底部
  bool isShowStrategyTypeBottom = true;

  // 是否显示策略类型底部最大成交量
  bool isShowStrategyTypeBottomForMaxVol = true;

  // 是否显示策略类型EMA
  // bool isShowEma = true;

  // 是否显示策略类型底部的MA标题
  bool isShowBottomMa = true;

  // 是否显示策略类型底部的MA柱状图线段
  bool showMAVolume = true;

  double bottomPadding = 20.0;

  double childPadding = 12.0;

  ///point-to-point distance
  double pointWidth = 11.0;

  ///candle width
  double candleWidth = 8.5;
  double candleLineWidth = 1.0;

  ///vol column width
  double volWidth = 8.5;

  ///vol column is double
  bool volisDouble = false;

  ///macd column width
  double macdWidth = 1.2;

  ///vertical-horizontal cross line width
  double vCrossWidth = 8.5;
  double hCrossWidth = 0.5;

  ///(line length - space line - thickness) of the current price
  double nowPriceLineLength = 4.5;
  double priceLineLength = 4.5;
  double nowPriceLineSpan = 3.5;
  double priceLineSpan = 2.5;
  double priceLineLongSpan = 4.5;
  double nowPriceLineWidth = 1;
  double priceLineWidth = 1;

  int gridRows = 18;
  int gridColumns = 4;

  double sizeText = 9.0;
  double iconSize = 21.0;

  bool isFocusCloseText = true;

  ///customize the time below
  List<String>? dateTimeFormat;

  //# 十字光标长按 / 短按切换 0.5秒后才触发
  bool isLongFocus = false;
}
