// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:math';

import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/entity/line_entity.dart';
import 'package:candle_chart/indicators/indicators_screen.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/objects/bottom_sheets/properties_bottom_sheet.dart';
import 'package:candle_chart/objects/objects_screen.dart';
import 'package:candle_chart/renderer/base_dimension.dart';
import 'package:candle_chart/utils/properties/chart_properties.dart';
import 'package:candle_chart/widgets/paddings.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gesture_x_detector/gesture_x_detector.dart';

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

enum CandleTimeFormat { M1, M5, M15, M30, H1, H4, D1, W1, MN1 }

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
  bool volHidden;
  final bool isLine;
  final bool isTapShowInfoDialog;
  final bool hideGrid;
  final List<String> timeFormat;

  final Function(CandleTimeFormat frame, String symbol) onGettingSettings;
  final Function(bool value)? onLoadMore;
  final Function(bool value)? onZoomingStart;
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
  final int isLongFocusDurationTime;
  static ChartColors? colors;
  final double? mBaseHeight;

  KChartWidget({
    Key? key,
    required this.chartStyle,
    required this.chartColors,
    required this.onGettingSettings,
    this.graphStyle = GraphStyle.line,
    this.xFrontPadding = 100,
    this.volHidden = true,
    this.isLine = false,
    this.isTapShowInfoDialog = false,
    this.hideGrid = false,
    this.mBaseHeight,
    this.timeFormat = TimeFormat.YEAR_MONTH_DAY,
    this.onLoadMore,
    this.fixedLength = 2,
    this.maDayList = const [5, 10, 20],
    this.flingTime = 600,
    this.flingRatio = 0.5,
    this.flingCurve = Curves.decelerate,
    this.isOnDrag,
    this.onZoomingStart,
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
  List<KLineEntity> lineCandles = [];
  List<LineEntity> askAndBid = [];
  double mScaleX = 1.0, mScaleY = 1, mScrollX = 0.0, mSelectX = 0.0;
  double mHeight = 0, mWidth = 0;
  AnimationController? _controller;
  Animation<double>? aniX;
  Offset? _tapPosition;
  double mSelectY = 0.0;
  bool isSecondOffset = false;
  bool objectEditable = false;
  bool bottomSheetShown = false;

  double getMinScrollX() {
    return mScaleX;
  }

  ObjectType? objectType;
  ObjectEntity? object;
  double _lastScaleX = 1.0;
  bool isScale = false, isDrag = false, isLongPress = false, isOnTap = false;

  Random rand = Random();
  int pointerCount = 0;

  @override
  void initState() {
    chartProperties.getDefaultSettings(onGetting: widget.onGettingSettings);
    super.initState();
  }

  void openObjects() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ObjectsScreen(
          data: lineCandles,
          onDone: (type) {
            objectType = type;
            notifyChanged();
          },
        ),
      ),
    );
  }

  Future<void> setLoadedCandles({
    required List<KLineEntity> candles,
    required CandleTimeFormat frame,
    required String symbol,
  }) async {
    lineCandles = candles;
    await chartProperties.updateDefaultSettings(
      frame: frame,
      symbol: symbol,
      values: candles,
    );
    notifyChanged();
  }

  void updateAskOrBid(LineEntity line) {
    final index = askAndBid.indexWhere((e) => e.id == line.id);
    if (index == -1) {
      askAndBid.add(line);
    } else {
      askAndBid[index] = line;
    }
    notifyChanged();
  }

  void removeAskBid(int id) {
    askAndBid.removeWhere((e) => e.id == id);
    notifyChanged();
  }

  void openIndicators() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => IndicatorsScreen(
          onDone: () async {
            _onFling(10);
            notifyChanged();
          },
        ),
      ),
    );
  }

  void resetZoom() {
    mScaleX = 1.0;
    mScaleY = 1.0;
    _lastScaleX = 1.0;
    notifyChanged();
  }

  @override
  void dispose() {
    mInfoWindowStream.sink.close();
    mInfoWindowStream.close();
    _controller?.dispose();
    super.dispose();
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
      // gestures[ScaleGestureRecognizer] = horizontalScaleRecognizer();
      gestures[HorizontalDragGestureRecognizer] = horizontalRecognizer();
    }

    if (lineCandles.isEmpty) {
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
      askAndBid: askAndBid,
      graphStyle: widget.graphStyle,
      indicators: chartProperties.indicators,
      baseDimension: baseDimension,
      //For TrendLine
      sink: mInfoWindowStream.sink,
      xFrontPadding: widget.xFrontPadding,
      scaleY: mScaleY,
      data: lineCandles,
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
                XGestureDetector(
                  onScaleUpdate: (event) {
                    if (!objectEditable) {
                      pointerCount = 2;
                      if (isDrag || isLongPress) return;
                      if (isLongPress) return;
                      if (pointerCount == 2) {
                        mScaleX = (_lastScaleX * event.scale).clamp(0.1, 2.0);
                      }
                      if (widget.onZoomingStart != null) {
                        widget.onZoomingStart!(mScaleX == 1 && mScaleY == 1);
                      }
                      notifyChanged();
                    }
                  },
                  onScaleEnd: () {
                    if (!objectEditable) {
                      pointerCount = 1;
                      isScale = false;
                      _lastScaleX = mScaleX;
                    }
                  },
                  onScaleStart: (initialFocusPoint) {
                    if (!objectEditable) {
                      pointerCount = 2;
                      isScale = true;
                      isDrag = false;
                      isLongPress = false;
                    }
                  },
                  child: CustomPaint(
                    size: Size(
                      double.infinity,
                      baseDimension.mDisplayHeight,
                    ),
                    painter: _painter,
                  ),
                ),
                Positioned(
                  top: 0.0,
                  bottom: 0.0,
                  right: 0.0,
                  width: 40.0,
                  child: GestureDetector(
                    onScaleStart: (details) {
                      if (!objectEditable) {
                        isScale = true;
                        pointerCount = details.pointerCount;
                      }
                    },
                    onScaleEnd: (details) {
                      if (!objectEditable) {
                        pointerCount = details.pointerCount;
                        isScale = false;
                      }
                    },
                    onScaleUpdate: (details) {
                      if (!objectEditable) {
                        if (!isScale) return;
                        if (pointerCount == 2) {
                          const double step = 0.00012;

                          if (details.verticalScale > 1) {
                            mScaleY = (mScaleY + step).clamp(0.9, 1.0);
                          } else if (details.verticalScale < 1) {
                            mScaleY = (mScaleY - step).clamp(0.9, 1.0);
                          }
                        }
                        if (widget.onZoomingStart != null)
                          widget.onZoomingStart!(mScaleX == 1 && mScaleY == 1);
                        notifyChanged();
                      }
                    },
                    child: Container(
                      width: 40.0,
                      color: Colors.transparent,
                    ),
                  ),
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
                        _tapPosition!.dx - 25,
                        _tapPosition!.dy,
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
        data: lineCandles,
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
      } else if (objectType == ObjectType.Position) {
        chartProperties.updatePositionLine(object!);
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
            chartProperties.addVerticalLine(object!, lineCandles);
            _painter!.setVerticalLineOffset(
              object!,
              details.localPosition,
              lineCandles,
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
              lineCandles,
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
              lineCandles,
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
                lineCandles,
              );
            } else if (object!.type == ObjectType.Rectangle) {
              _painter!.setRectangleOffset2(
                object!,
                details.localPosition,
                lineCandles,
              );
            } else if (object!.type == ObjectType.Horizontal) {
              _painter!.setHorizontalLineOffset(object!, details.localPosition);
            } else if (object!.type == ObjectType.Vertical) {
              _painter!.setVerticalLineOffset(
                object!,
                details.localPosition,
                lineCandles,
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
                lineCandles,
              );
              chartProperties.updateTrendLine(object!);
            } else if (object!.type == ObjectType.Rectangle) {
              _painter!.setRectangleOffset2(
                object!,
                details.localPosition,
                lineCandles,
              );
              chartProperties.updateRectangle(object!);
            } else if (object!.type == ObjectType.Horizontal) {
              _painter!.setHorizontalLineOffset(object!, details.localPosition);
              chartProperties.updateHorizontalLine(object!);
            } else if (object!.type == ObjectType.Vertical) {
              _painter!.setVerticalLineOffset(
                object!,
                details.localPosition,
                lineCandles,
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
                  lineCandles,
                );
              } else {
                _painter!.setTrendLineOffset1(
                  object!,
                  details.localPosition,
                  lineCandles,
                );
              }
            } else if (object!.type == ObjectType.Rectangle) {
              if (isSecondOffset) {
                _painter!.setRectangleOffset2(
                  object!,
                  details.localPosition,
                  lineCandles,
                );
              } else {
                _painter!.setRectangleOffset1(
                  object!,
                  details.localPosition,
                  lineCandles,
                );
              }
            } else if (object!.type == ObjectType.Horizontal) {
              _painter!.setHorizontalLineOffset(object!, details.localPosition);
            } else if (object!.type == ObjectType.Position) {
              _painter!.setHorizontalLineOffset(object!, details.localPosition);
            } else if (object!.type == ObjectType.Vertical) {
              _painter!.setVerticalLineOffset(
                object!,
                details.localPosition,
                lineCandles,
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
                  lineCandles,
                );
              } else {
                object = _painter!.setTrendLineOffset1(
                  object!,
                  details.localPosition,
                  lineCandles,
                );
              }
              chartProperties.updateTrendLine(object!);
            } else if (object!.type == ObjectType.Rectangle) {
              if (isSecondOffset) {
                object = _painter!.setRectangleOffset2(
                  object!,
                  details.localPosition,
                  lineCandles,
                );
              } else {
                object = _painter!.setRectangleOffset1(
                  object!,
                  details.localPosition,
                  lineCandles,
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
                lineCandles,
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
            if (widget.onZoomingStart != null) {
              widget.onZoomingStart!(mScaleX == 1 && mScaleY == 1);
            }
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
          widget.onLoadMore!(true);
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
