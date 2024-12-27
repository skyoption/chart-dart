// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:math';

import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/objects/bottom_sheets/properties_bottom_sheet.dart';
import 'package:candle_chart/objects/objects_screen.dart';
import 'package:candle_chart/indicators/indicators_screen.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/renderer/base_dimension.dart';
import 'package:candle_chart/utils/date_util.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';
import 'package:candle_chart/widgets/chart_loader.dart';
import 'package:candle_chart/widgets/paddings.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

enum GraphStyle { area, candles, line }

enum IndicatorType {
  MA_LINEAR,
  MA_SMMA,
  MA_EMA,
  MA_SMA,
  ENVELOPS_LINEAR,
  ENVELOPS_SMMA,
  ENVELOPS_EMA,
  ENVELOPS_SMA,
  BOLL,
  PARABOLIC,
  ICHIMOKU,
  MACD,
  RSI,
  ATR,
  DEM,
  CCI,
  MOM,
  SO_EMA,
  SO_LINEAR,
  SO_SMMA,
  SO_SMA,
  WPR,
  MFI,
}

class TimeFormat {
  static const List<String> YEAR_MONTH_DAY = [yyyy, '-', mm, '-', dd];
  static const List<String> YEAR_MONTH_DAY_WITH_HOUR = [
    yyyy,
    '-',
    mm,
    '-',
    dd,
    ' ',
    HH,
    ':',
    nn
  ];
  static const List<String> MONTH_DAY_WITH_HOUR = [
    M,
    '-',
    dd,
    ' ',
    HH,
    ':',
    nn
  ];
}

class KChartWidget extends StatefulWidget {
  List<KLineEntity>? data;
  bool volHidden;
  final bool isLine;
  final bool isTapShowInfoDialog;
  final bool hideGrid;
  final List<String> timeFormat;

  final Function(bool)? onLoadMore;
  final Function? onZooomingStart;
  final Function(
    CandleTimeFormat frame,
    List<KLineEntity> candles,
    KLineEntity? firstCandle,
    KLineEntity? lastCandle,
  ) onLoaded;
  final int fixedLength;
  final List<int> maDayList;
  final int flingTime;
  final double flingRatio;
  final Curve flingCurve;
  final Function(bool)? isOnDrag;
  final ChartColors chartColors;
  final ChartStyle chartStyle;
  final GraphStyle graphStyle;
  final VerticalTextAlignment verticalTextAlignment;
  final double xFrontPadding;
  final bool showNowPrice;
  final int isLongFocusDurationTime;
  static ChartColors? colors;
  final double? mBaseHeight;

  KChartWidget(
    this.data,
    this.chartStyle,
    this.chartColors, {
    Key? key,
    this.graphStyle = GraphStyle.line,
    required this.onLoaded,
    this.xFrontPadding = 100,
    this.volHidden = true,
    this.isLine = false,
    this.isTapShowInfoDialog = false,
    this.hideGrid = false,
    this.mBaseHeight,
    this.showNowPrice = true,
    this.timeFormat = TimeFormat.YEAR_MONTH_DAY,
    this.onLoadMore,
    this.fixedLength = 2,
    this.maDayList = const [5, 10, 20],
    this.flingTime = 600,
    this.flingRatio = 0.5,
    this.flingCurve = Curves.decelerate,
    this.isOnDrag,
    this.onZooomingStart,
    this.verticalTextAlignment = VerticalTextAlignment.right,
    this.isLongFocusDurationTime = 500,
  }) : super(key: key) {
    KChartWidget.colors = chartColors;
  }

  @override
  KChartWidgetState createState() => KChartWidgetState();
}

bool longPressTriggered = false;

class KChartWidgetState extends State<KChartWidget>
    with TickerProviderStateMixin {
  final StreamController<InfoWindowEntity?> mInfoWindowStream =
      StreamController<InfoWindowEntity?>.broadcast();
  double mScaleX = 1.0, mScaleY = 1, mScrollX = 0.0, mSelectX = 0.0;
  double mHeight = 0, mWidth = 0;
  AnimationController? _controller;
  Animation<double>? aniX;
  bool loading = true;
  Offset? _tapPosition;

  double? changeInXposition;
  double? changeInYposition;
  double mSelectY = 0.0;
  bool waitingForOtherPairOfCords = false;
  bool isSecondOffset = false;
  bool objectEditable = false;
  bool bottomSheetShown = false;

  double getMinScrollX() {
    return mScaleX;
  }

  ObjectType? objectType;
  ObjectEntity? object;
  double _lastScaleX = 1.0;
  double _lastScaleY = 1.0;
  bool isScale = false, isDrag = false, isLongPress = false, isOnTap = false;

  Random rand = Random();
  int pointerCount = 0;
  String currentLineName = '';

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadCandles();
    });
    super.initState();
  }

  void openObjects() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ObjectsScreen(
          data: widget.data!,
          onDone: (type) {
            objectType = type;
            notifyChanged();
          },
        ),
      ),
    );
  }

  void openIndicators() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => IndicatorsScreen(
          onDone: () async {
            _onFling(10);
            _reload();
          },
        ),
      ),
    );
  }

  void resetZoom() {
    mScaleX = 1.0;
    mScaleY = 1.0;
    _lastScaleX = 1.0;
    _lastScaleY = 1.0;
    notifyChanged();
  }

  Future<void> loadCandles({CandleTimeFormat? frame}) async {
    loading = true;
    widget.data = null;
    notifyChanged();
    if (KChart.isar == null) await Future.delayed(Duration(seconds: 1));
    if (frame != null) {
      await chartProperties.setTimeframe(frame);
      notifyChanged();
    }
    chartProperties.loadCandles(
      onLoaded: (timeframe, symbol, candles, firstCandle, lastCandle) async {
        List<KLineEntity>? data;
        data = await widget.onLoaded(
          frame != null ? frame : timeframe,
          candles,
          firstCandle,
          lastCandle,
        );
        if (data != null) {
          chartProperties.setCandles(data);
        } else {
          widget.data = candles;
        }
        _reload();
      },
    );
  }

  void _reload() {
    Future.delayed(Duration(milliseconds: 200), () async {
      await IndicatorUtils.calculate(widget.data!);
      loading = false;
      notifyChanged();
    });
  }

  @override
  void dispose() {
    mInfoWindowStream.sink.close();
    mInfoWindowStream.close();
    _controller?.dispose();
    super.dispose();
  }

  void zoomIn() {
    mScaleX = (_lastScaleX * 1.1).clamp(0.1, 2.0);
    mScaleY = (_lastScaleY * 1.1).clamp(0.5, 1.0);
    _lastScaleX = mScaleX;
    _lastScaleY = mScaleY;
    notifyChanged();
  }

  void zoomOut() {
    mScaleX = (_lastScaleX * 0.9).clamp(0.1, 2.0);
    mScaleY = (_lastScaleY * 0.9).clamp(0.5, 1.0);
    _lastScaleX = mScaleX;
    _lastScaleY = mScaleY;
    notifyChanged();
  }

  late final height = MediaQuery.of(context).size.height;
  ChartPainter? _painter;

  @override
  Widget build(BuildContext context) {
    double mBaseHeight = widget.mBaseHeight ?? height * 0.7;
    Map<Type, GestureRecognizerFactory<GestureRecognizer>> gestures = {};
    if (objectType != null) {
      if (!bottomSheetShown) {
        if (objectEditable) {
          gestures[PanGestureRecognizer] = panUpdateGestureRecognizer();
          gestures[TapGestureRecognizer] = tapGestureRecognizer();
        } else {
          gestures[PanGestureRecognizer] = panFirstGestureRecognizer();
        }
      }
    } else {
      gestures[LongPressGestureRecognizer] = longPressRecognizer();
      gestures[ScaleGestureRecognizer] = horizontalScaleRecognizer();
      gestures[HorizontalDragGestureRecognizer] = horizontalRecognizer();
    }

    if (widget.data != null && widget.data!.isEmpty) {
      mScrollX = mSelectX = 0.0;
      mScaleX = 1.0;
    }

    final BaseDimension baseDimension = BaseDimension(
      height: mBaseHeight,
      volHidden: widget.volHidden,
      indicators: chartProperties.secondaries,
    );

    _painter = ChartPainter(
      widget.chartStyle,
      widget.chartColors,
      graphStyle: widget.graphStyle,
      indicators: chartProperties.indicators,
      screenHeight: mBaseHeight,
      baseDimension: baseDimension,
      //For TrendLine
      sink: mInfoWindowStream.sink,
      xFrontPadding: widget.xFrontPadding,
      scaleY: mScaleY,
      data: widget.data,
      scaleX: mScaleX,
      scrollX: mScrollX,
      selectX: mSelectX,
      isLongPass: isLongPress,
      isOnTap: isOnTap,
      isTapShowInfoDialog: widget.isTapShowInfoDialog,
      volHidden: widget.volHidden,
      isLine: widget.isLine,
      hideGrid: widget.hideGrid,
      secondaryIndicators: chartProperties.secondaries,
      showNowPrice: widget.showNowPrice,
      fixedLength: widget.fixedLength,
      verticalTextAlignment: widget.verticalTextAlignment,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        mHeight = constraints.maxHeight;
        mWidth = constraints.maxWidth;
        return RawGestureDetector(
          gestures: gestures,
          child: GestureDetector(
            onDoubleTapDown: (details) {
              _objectSetOnBottomSheet(details);
            },
            child: Stack(
              children: <Widget>[
                CustomPaint(
                  size: Size(
                    double.infinity,
                    baseDimension.mDisplayHeight,
                  ),
                  painter: _painter,
                ),
                Positioned(
                  bottom: 0.0,
                  right: 0.0,
                  width: 100,
                  child: ChartLoader(),
                ),
                if (loading)
                  Positioned(
                    bottom: 0.0,
                    right: 0.0,
                    left: 0.0,
                    child: ChartLoader(),
                  ),
                if (_tapPosition != null)
                  Container(
                    margin: MPadding.set(horizontal: 6.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: KChartWidget.colors!.iconColor,
                      ),
                    ),
                    child: RawMagnifier(
                      focalPointOffset: Offset(
                        _tapPosition!.dx - 25.0,
                        _tapPosition!.dy - 25.0,
                      ),
                      size: const Size(50, 45),
                      magnificationScale: 1.0,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _objectSetOnBottomSheet(details) {
    final nearObject = _painter!.findNearOffset(
      offset: details.localPosition,
    );
    objectEditable = nearObject.object != null;
    if (objectEditable) {
      object = nearObject.object;
      object!.currentEditIndex = -1;
      if (objectType == ObjectType.Trend) {
        chartProperties.updateTrendLine(object!);
      } else if (objectType == ObjectType.Rectangle) {
        chartProperties.updateRectangle(object!);
      } else if (objectType == ObjectType.Horizontal) {
        chartProperties.updateHorizontalLine(object!);
      } else if (objectType == ObjectType.Vertical) {
        chartProperties.updateVerticalLine(object!);
      }
      _tapPosition = null;
      objectType = null;
      objectEditable = false;
      isSecondOffset = false;
      bottomSheetShown = true;
      notifyChanged();
      showPropertiesBottomSheet(
        context: context,
        item: object!,
        data: widget.data!,
        onDone: (type) {
          bottomSheetShown = false;
          notifyChanged();
        },
      );
    }
  }

  void _objectSetOnUpdate(details) {
    final nearObject = _painter!.findNearOffset(
      offset: details.localPosition,
    );
    objectEditable = nearObject.object != null;
    if (objectEditable && !bottomSheetShown) {
      _tapPosition = details.localPosition;
      object = nearObject.object;
      objectType = nearObject.object?.type;
      isSecondOffset = nearObject.isSecondPoint;
      if (objectType == ObjectType.Trend) {
        chartProperties.updateTrendLine(object!);
      } else if (objectType == ObjectType.Rectangle) {
        chartProperties.updateRectangle(object!);
      } else if (objectType == ObjectType.Horizontal) {
        chartProperties.updateHorizontalLine(object!);
      } else if (objectType == ObjectType.Vertical) {
        chartProperties.updateVerticalLine(object!);
      }
    }
    notifyChanged();
  }

  GestureRecognizerFactoryWithHandlers<LongPressGestureRecognizer>
      longPressRecognizer() {
    return GestureRecognizerFactoryWithHandlers<LongPressGestureRecognizer>(
        () => LongPressGestureRecognizer(),
        (LongPressGestureRecognizer instance) {
      instance
        ..onLongPressDown = (details) {
          _objectSetOnUpdate(details);
        };
    });
  }

  GestureRecognizerFactoryWithHandlers<PanGestureRecognizer>
      panFirstGestureRecognizer() {
    return GestureRecognizerFactoryWithHandlers<PanGestureRecognizer>(
        () => PanGestureRecognizer(), (PanGestureRecognizer instance) {
      instance
        ..onDown = (details) {
          _tapPosition = details.localPosition;
          if (objectType == ObjectType.Vertical) {
            object = ObjectEntity(
              type: objectType!,
              name: 'Vertical Line ${rand.nextInt(10000)}',
              dx1: details.localPosition.dx,
              dx2: details.localPosition.dx,
            );
            chartProperties.addVerticalLine(object!, widget.data!);
            _painter!.setVerticalLineOffset(
              object!,
              details.localPosition,
              widget.data!,
            );
            notifyChanged();
          } else if (objectType == ObjectType.Horizontal) {
            object = ObjectEntity(
              type: objectType!,
              name: 'Horizontal Line ${rand.nextInt(10000)}',
              dy1: details.localPosition.dy,
            );
            chartProperties.addHorizontalLine(object!);
            _painter!.setHorizontalLineOffset(object!, details.localPosition);
            notifyChanged();
          } else if (objectType == ObjectType.Trend) {
            object = ObjectEntity(
              type: objectType!,
              name: 'Trend Line ${rand.nextInt(10000)}',
              dx1: details.localPosition.dx,
              dx2: details.localPosition.dx + 50,
              dy1: details.localPosition.dy,
              dy2: details.localPosition.dy + 50,
            );
            chartProperties.addTrendLine(object!);
            _painter!.setTrendLineOffset1(
              object!,
              details.localPosition,
              widget.data!,
            );
            notifyChanged();
          } else if (objectType == ObjectType.Rectangle) {
            object = ObjectEntity(
              type: objectType!,
              name: 'Rectangle Line ${rand.nextInt(10000)}',
              dx1: details.localPosition.dx,
              dx2: details.localPosition.dx + 50,
              dy1: details.localPosition.dy,
              dy2: details.localPosition.dy + 50,
            );
            chartProperties.addRectangle(object!);
            _painter!.setRectangleOffset1(
              object!,
              details.localPosition,
              widget.data!,
            );
            notifyChanged();
          }
        }
        ..onUpdate = (details) {
          if (object != null) {
            _tapPosition = details.localPosition;
            if (object!.type == ObjectType.Trend) {
              _painter!.setTrendLineOffset2(
                object!,
                details.localPosition,
                widget.data!,
              );
            } else if (object!.type == ObjectType.Rectangle) {
              _painter!.setRectangleOffset2(
                object!,
                details.localPosition,
                widget.data!,
              );
            } else if (object!.type == ObjectType.Horizontal) {
              _painter!.setHorizontalLineOffset(object!, details.localPosition);
            } else if (object!.type == ObjectType.Vertical) {
              _painter!.setVerticalLineOffset(
                object!,
                details.localPosition,
                widget.data!,
              );
            }
          }
          notifyChanged();
        }
        ..onEnd = (DragEndDetails details) async {
          if (object != null) {
            object!.dx2 = details.localPosition.dx;
            object!.dy2 = details.localPosition.dy;
            object!.currentEditIndex = -1;
            if (object!.type == ObjectType.Trend) {
              _painter!.setTrendLineOffset2(
                object!,
                details.localPosition,
                widget.data!,
              );
              chartProperties.updateTrendLine(object!);
            } else if (object!.type == ObjectType.Rectangle) {
              _painter!.setRectangleOffset2(
                object!,
                details.localPosition,
                widget.data!,
              );
              chartProperties.updateRectangle(object!);
            } else if (object!.type == ObjectType.Horizontal) {
              _painter!.setHorizontalLineOffset(object!, details.localPosition);
              chartProperties.updateHorizontalLine(object!);
            } else if (object!.type == ObjectType.Vertical) {
              _painter!.setVerticalLineOffset(
                object!,
                details.localPosition,
                widget.data!,
              );
              chartProperties.updateVerticalLine(object!);
            }
          }
          _tapPosition = null;
          objectType = null;
          object = null;
          notifyChanged();
        };
    });
  }

  GestureRecognizerFactoryWithHandlers<PanGestureRecognizer>
      panUpdateGestureRecognizer() {
    return GestureRecognizerFactoryWithHandlers<PanGestureRecognizer>(
        () => PanGestureRecognizer(), (PanGestureRecognizer instance) {
      instance
        ..onUpdate = (details) {
          if (object != null) {
            _tapPosition = details.localPosition;
            if (object!.type == ObjectType.Trend) {
              if (isSecondOffset) {
                _painter!.setTrendLineOffset2(
                  object!,
                  details.localPosition,
                  widget.data!,
                );
              } else {
                _painter!.setTrendLineOffset1(
                  object!,
                  details.localPosition,
                  widget.data!,
                );
              }
            } else if (object!.type == ObjectType.Rectangle) {
              if (isSecondOffset) {
                _painter!.setRectangleOffset2(
                  object!,
                  details.localPosition,
                  widget.data!,
                );
              } else {
                _painter!.setRectangleOffset1(
                  object!,
                  details.localPosition,
                  widget.data!,
                );
              }
            } else if (object!.type == ObjectType.Horizontal) {
              _painter!.setHorizontalLineOffset(object!, details.localPosition);
            } else if (object!.type == ObjectType.Vertical) {
              _painter!.setVerticalLineOffset(
                object!,
                details.localPosition,
                widget.data!,
              );
            }
            notifyChanged();
          }
        }
        ..onEnd = (DragEndDetails details) async {
          if (object != null) {
            object!.currentEditIndex = -1;
            if (object!.type == ObjectType.Trend) {
              if (isSecondOffset) {
                object = _painter!.setTrendLineOffset2(
                  object!,
                  details.localPosition,
                  widget.data!,
                );
              } else {
                object = _painter!.setTrendLineOffset1(
                  object!,
                  details.localPosition,
                  widget.data!,
                );
              }
              chartProperties.updateTrendLine(object!);
            } else if (object!.type == ObjectType.Rectangle) {
              if (isSecondOffset) {
                object = _painter!.setRectangleOffset2(
                  object!,
                  details.localPosition,
                  widget.data!,
                );
              } else {
                object = _painter!.setRectangleOffset1(
                  object!,
                  details.localPosition,
                  widget.data!,
                );
              }
              chartProperties.updateRectangle(object!);
            } else if (object!.type == ObjectType.Horizontal) {
              object = _painter!.setHorizontalLineOffset(
                object!,
                details.localPosition,
              );
              chartProperties.updateHorizontalLine(object!);
            } else if (object!.type == ObjectType.Vertical) {
              object = _painter!.setVerticalLineOffset(
                object!,
                details.localPosition,
                widget.data!,
              );
              chartProperties.updateVerticalLine(object!);
            }
          }
          _tapPosition = null;
          objectType = null;
          object = null;
          objectEditable = false;
          notifyChanged();
        };
    });
  }

  GestureRecognizerFactoryWithHandlers<ScaleGestureRecognizer>
      verticalScaleGestureRecognizer() {
    return GestureRecognizerFactoryWithHandlers<ScaleGestureRecognizer>(
      () => ScaleGestureRecognizer(),
      (ScaleGestureRecognizer instance) {
        instance
          ..onStart = (_) {
            pointerCount = _.pointerCount;
            isScale = true;
          }
          ..onUpdate = (details) {
            pointerCount = details.pointerCount;
            if (isDrag || isLongPress) return;
            if (isLongPress) return;
            if (pointerCount == 2) {
              mScaleY = (_lastScaleY * details.verticalScale).clamp(0.5, 1.0);
            }
            if (widget.onZooomingStart != null) widget.onZooomingStart!();
            notifyChanged();
          }
          ..onEnd = (details) {
            pointerCount = 1;
            isScale = false;
            _lastScaleY = mScaleY;
          };
      },
    );
  }

  GestureRecognizerFactoryWithHandlers<ScaleGestureRecognizer>
      horizontalScaleRecognizer() {
    return GestureRecognizerFactoryWithHandlers<ScaleGestureRecognizer>(
      () => ScaleGestureRecognizer(),
      (ScaleGestureRecognizer instance) {
        instance
          ..onStart = (_) {
            pointerCount = _.pointerCount;
            isScale = true;
          }
          ..onUpdate = (details) {
            pointerCount = details.pointerCount;
            if (isDrag || isLongPress) return;
            if (isLongPress) return;
            if (pointerCount == 2) {
              mScaleX = (_lastScaleX * details.horizontalScale).clamp(0.1, 2.0);
            }
            if (widget.onZooomingStart != null) widget.onZooomingStart!();

            notifyChanged();
          }
          ..onEnd = (details) {
            pointerCount = 1;
            isScale = false;
            _lastScaleX = mScaleX;
          };
      },
    );
  }

  GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>
      tapGestureRecognizer() {
    return GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
      () => TapGestureRecognizer(),
      (TapGestureRecognizer instance) {
        instance
          ..onTap = () {
            if (object != null) {
              chartProperties.updateObject(object!..currentEditIndex = -1);
            }
            _tapPosition = null;
            objectType = null;
            object = null;
            objectEditable = false;
            isSecondOffset = false;
            notifyChanged();
          };
      },
    );
  }

  GestureRecognizerFactoryWithHandlers<HorizontalDragGestureRecognizer>
      horizontalRecognizer() {
    return GestureRecognizerFactoryWithHandlers<
        HorizontalDragGestureRecognizer>(
      () => HorizontalDragGestureRecognizer(),
      (HorizontalDragGestureRecognizer instance) {
        instance
          ..onDown = (details) {
            if (pointerCount > 1) {
              return;
            }
            isOnTap = false;
            _stopAnimation();
            _onDragChanged(true);
          }
          ..onUpdate = (details) {
            if (pointerCount > 1) {
              return;
            }
            if (isScale || isLongPress) return;
            mScrollX = ((details.primaryDelta ?? 0) / mScaleX + mScrollX)
                .clamp(0.0, ChartPainter.maxScrollX)
                .toDouble();
            notifyChanged();
          }
          ..onEnd = (details) {
            var velocity = details.velocity.pixelsPerSecond.dx;
            _onFling(velocity);
            _onDragChanged(false);
          }
          ..onCancel = () {
            _onDragChanged(false);
          };
      },
    );
  }

  void _stopAnimation({bool needNotify = true}) {
    if (_controller != null && _controller!.isAnimating) {
      _controller!.stop();
      _onDragChanged(false);
      if (needNotify) {
        notifyChanged();
      }
    }
  }

  void _onDragChanged(bool isOnDrag) {
    isDrag = isOnDrag;
    if (widget.isOnDrag != null) {
      widget.isOnDrag!(isDrag);
    }
  }

  void _onFling(double x) {
    _controller = AnimationController(
        duration: Duration(milliseconds: widget.flingTime), vsync: this);
    aniX = null;
    aniX = Tween<double>(begin: mScrollX, end: x * widget.flingRatio + mScrollX)
        .animate(CurvedAnimation(
            parent: _controller!.view, curve: widget.flingCurve));
    print(_controller!.view);
    aniX!.addListener(() {
      mScrollX = aniX!.value;
      if (mScrollX <= 0) {
        mScrollX = 0;
        if (widget.onLoadMore != null) {
          widget.onLoadMore!(true);
        }
        _stopAnimation();
      } else if (mScrollX >= ChartPainter.maxScrollX) {
        mScrollX = ChartPainter.maxScrollX;
        if (widget.onLoadMore != null) {
          widget.onLoadMore!(false);
        }
        _stopAnimation();
      }
      notifyChanged();
    });
    aniX!.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        _onDragChanged(false);
        notifyChanged();
      }
    });
    _controller!.forward();
  }

  void notifyChanged() => Future.delayed(Duration.zero, () => setState(() {}));
}
