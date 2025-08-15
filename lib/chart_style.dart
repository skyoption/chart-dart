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
  Color cursorColor;

  Color kLineColor;

  Color iconColor;
  Color optionsColor;
  Color primary;
  Color ask;
  Color bid;
  Color lineChartColor;
  Color areaColor;
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
    this.cursorColor = const Color.fromARGB(255, 194, 195, 197),
    this.lineChartColor = Colors.blue,
    this.areaColor = Colors.blue,
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
    this.upColor = const Color(0xFF6AE547),
    this.dnColor = const Color(0xFFEA1D0A),
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
  double topPadding;
  double leftPadding;
  double rightPadding;
  double priceWidth;
  bool isNotPoint;
  bool isShowHighOrLowPoint;
  bool isShowLeftTopicPoint;
  bool isShowStrategyTypeTop;
  bool isShowStrategyTypeBottom;
  bool isShowStrategyTypeBottomForMaxVol;
  bool isShowBottomMa;
  bool isSmallChart;
  bool showMAVolume;
  double bottomPadding;
  double childPadding;
  double pointWidth;
  double candleWidth;
  double candleLineWidth;
  double volWidth;
  bool volisDouble;
  double macdWidth;
  int digits;
  double vCrossWidth;
  double hCrossWidth;
  double nowPriceLineLength;
  double lineLength;
  double areaLineWidth;
  double lineSpan;
  double priceLineSpan;
  double priceLineLongSpan;
  double nowPriceLineWidth;
  double priceLineWidth;
  int gridRows;
  int gridColumns;
  double sizeText;
  double iconSize;
  bool isFocusCloseText;
  List<String>? dateTimeFormat;
  bool isLongFocus;
  double rightEmptySpace;

  ChartStyle({
    this.topPadding = 30.0,
    this.leftPadding = 5.0,
    this.rightPadding = 5.0,
    this.priceWidth = 60.0,
    this.isNotPoint = false,
    this.isShowHighOrLowPoint = false,
    this.isSmallChart = false,
    this.isShowLeftTopicPoint = true,
    this.isShowStrategyTypeTop = true,
    this.isShowStrategyTypeBottom = true,
    this.isShowStrategyTypeBottomForMaxVol = true,
    this.isShowBottomMa = true,
    this.showMAVolume = true,
    this.bottomPadding = 20.0,
    this.childPadding = 12.0,
    this.pointWidth = 11.0,
    this.candleWidth = 8.5,
    this.candleLineWidth = 1.0,
    this.areaLineWidth = 1.0,
    this.volWidth = 8.5,
    this.volisDouble = false,
    this.macdWidth = 1.2,
    this.vCrossWidth = 8.5,
    this.hCrossWidth = 0.5,
    this.nowPriceLineLength = 4.5,
    this.lineLength = 4.5,
    this.lineSpan = 3.5,
    this.priceLineSpan = 2.5,
    this.priceLineLongSpan = 4.5,
    this.nowPriceLineWidth = 1,
    this.priceLineWidth = 1,
    this.gridRows = 12,
    this.gridColumns = 4,
    this.sizeText = 9.0,
    this.iconSize = 21.0,
    this.isFocusCloseText = true,
    this.dateTimeFormat,
    this.isLongFocus = false,
    this.digits = 5,
    this.rightEmptySpace = 0.0,
  });
}
