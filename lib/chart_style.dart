import 'package:flutter/material.dart' show Color, Colors;

import 'k_chart_widget.dart' show CandleTimeFormat;

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

  // ── Live price line ──
  Color livePillColor;
  Color livePillTextColor;
  Color askTextColor;
  Color bidTextColor;
  // ── Hints ──
  Color hintBgColor;
  Color hintTextColor;
  Color expiryLineColor;

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
    this.livePillColor = const Color(0xFF2F9AFD),
    this.livePillTextColor = const Color(0xFFFFFFFF),
    this.askTextColor = const Color(0xFF2BC48A),
    this.bidTextColor = const Color(0xFFE5414F),
    this.hintBgColor = const Color(0xFF1B2130),
    this.hintTextColor = const Color(0xFF8A93A6),
    this.expiryLineColor = const Color(0xFFE8A33D),
  });

  /// Preset that matches the live dark line chart (flat navy, blue line).
  factory ChartColors.liveDark() => ChartColors(
        bgColor: const Color(0xFF111219),
        lineChartColor: const Color(0xFF239BFF),
        areaColor: const Color(0xFF239BFF),
        gridColor: const Color(0x00000000),
        maxColor: const Color(0xFF8A93A6), // axis label text
        minColor: const Color(0xFF8A93A6),
        defaultTextColor: const Color(0xFF8A93A6),
        upColor: const Color(0xFF2BC48A),
        dnColor: const Color(0xFFE5414F),
        nowPriceUpColor: const Color(0xFF2BC48A),
        nowPriceDnColor: const Color(0xFFE5414F),
      );
}

class ChartPosition {
  double bottomPrice;
  double topPrice;

  ChartPosition({
    this.bottomPrice = 0,
    this.topPrice = 0,
  });
}

enum LineInterpolation { linear, monotone }

enum LivePriceSource { bid, ask, mid }

class ChartStyle {
  double scaleStep;
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
  double initialRightDistance;

  /// Live look for every graph style (candles too): single price line with a
  /// pill, hints, axis tags, future space, glide and an animated forming
  /// candle. Line and area always use it.
  bool liveStyle;

  /// Single live price line (pill, ask above, bid below).
  bool showLivePriceLine;

  /// High/low tags on the visible extremes.
  bool showPriceHints;

  /// Dark tag behind each axis label.
  bool showAxisLabelTags;

  /// Pulsing halo around the live tip.
  bool pulseEndpoint;

  /// Soft blur under the line stroke.
  bool lineGlow;

  /// Pill flashes green/red on a tick, then eases back.
  bool flashPillOnTick;
  LineInterpolation lineInterpolation;
  LivePriceSource livePriceSource;

  /// Headroom above max / below min in line and area mode (fraction).
  double liveVerticalPadding;

  /// Future space (fraction of the width), used when [rightEmptySpace] is 0.
  double rightEmptySpaceRatio;

  /// Expiry time in ms since epoch; null hides the vertical line.
  int? expiryTime;

  /// Frames that get the continuous video-style left drift.
  Set<CandleTimeFormat> liveDriftFrames;

  /// Drift speed on seconds frames, in screen px per second (video ≈ 3.8).
  /// Sets the on-screen bar width: S5 = 19 px, S10 = 38 px.
  double secondsPxPerSecond;

  /// Line shape on seconds frames. The video draws straight segments.
  LineInterpolation secondsLineInterpolation;

  /// Candle body width as a fraction of the slot (0 = keep [candleWidth]).
  double candleBodyRatio;

  /// Candle body corner radius, in screen px.
  double candleRadius;

  /// Soft halo on the forming candle.
  bool liveCandleGlow;

  ChartStyle({
    this.scaleStep = 0.000085,
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
    this.pointWidth = 15.0,
    this.candleWidth = 10.0,
    this.candleLineWidth = 1.0,
    this.areaLineWidth = 2.0,
    this.volWidth = 8.5,
    this.volisDouble = false,
    this.macdWidth = 1.2,
    this.vCrossWidth = 8.5,
    this.hCrossWidth = 0.5,
    this.nowPriceLineLength = 4.5,
    this.lineLength = 4.5,
    this.initialRightDistance = 0.0,
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
    this.liveStyle = true,
    this.showLivePriceLine = true,
    this.showPriceHints = true,
    this.showAxisLabelTags = true,
    this.pulseEndpoint = true,
    this.lineGlow = true,
    this.flashPillOnTick = true,
    this.lineInterpolation = LineInterpolation.monotone,
    this.livePriceSource = LivePriceSource.bid,
    this.liveVerticalPadding = 0.12,
    this.rightEmptySpaceRatio = 0.12,
    this.expiryTime,
    this.liveDriftFrames = const {CandleTimeFormat.S5, CandleTimeFormat.S10},
    this.secondsPxPerSecond = 3.8,
    this.secondsLineInterpolation = LineInterpolation.monotone,
    this.candleBodyRatio = 0.62,
    this.candleRadius = 1.5,
    this.liveCandleGlow = true,
  });
}
