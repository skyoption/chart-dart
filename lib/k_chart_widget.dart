import 'dart:async';

import 'package:candle_chart/chart_translations.dart';
import 'package:candle_chart/components/popup_info_view.dart';
import 'package:candle_chart/functions/chart_properties_screen.dart';
import 'package:candle_chart/functions/widgets/svg.dart';
import 'package:candle_chart/functions/objects_screen.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/renderer/update_point_position.dart';
import 'package:candle_chart/utils/icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'renderer/base_dimension.dart';

enum MainState { MA, BOLL, NONE }

// enum SecondaryState { MACD, KDJ, RSI, WR, CCI, NONE }
enum SecondaryState { MACD, KDJ, RSI, WR, CCI } //no support NONE

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
}

class KChartWidget extends StatefulWidget {
  final List<KLineEntity>? datas;
  MainState mainState;
  bool volHidden;
  Set<SecondaryState> secondaryStateLi;

  // final Function()? onSecondaryTap;
  final bool isLine;
  final bool
      isTapShowInfoDialog; //Whether to enable click to display detailed data
  final bool hideGrid;
  final bool showNowPrice;
  final bool showInfoDialog;
  final bool materialInfoDialog; // Material Style Information Popup
  final ChartTranslations chartTranslations;
  final List<String> timeFormat;

  // It will be called when the screen scrolls to the end.
  // If true, it will be scrolled to the end of the right side of the screen.
  // If it is false, it will be scrolled to the end of the left side of the screen.
  final Function(bool)? onLoadMore;

  final int fixedLength;
  final List<int> maDayList;
  final int flingTime;
  final double flingRatio;
  final Curve flingCurve;
  final Function(bool)? isOnDrag;
  final ChartColors chartColors;
  final ChartStyle chartStyle;
  final VerticalTextAlignment verticalTextAlignment;
  final bool isTrendLine;
  final double xFrontPadding;
  final int isLongFocusDurationTime;

  KChartWidget(
    this.datas,
    this.chartStyle,
    this.chartColors, {
    required this.isTrendLine,
    this.xFrontPadding = 100,
    this.mainState = MainState.MA,
    this.secondaryStateLi = const <SecondaryState>{},
    // this.onSecondaryTap,
    this.volHidden = true,
    this.isLine = false,
    this.isTapShowInfoDialog = false,
    this.hideGrid = false,
    this.showNowPrice = true,
    this.showInfoDialog = true,
    this.materialInfoDialog = true,
    this.chartTranslations = const ChartTranslations(),
    this.timeFormat = TimeFormat.YEAR_MONTH_DAY,
    this.onLoadMore,
    this.fixedLength = 2,
    this.maDayList = const [5, 10, 20],
    this.flingTime = 600,
    this.flingRatio = 0.5,
    this.flingCurve = Curves.decelerate,
    this.isOnDrag,
    this.verticalTextAlignment = VerticalTextAlignment.right,
    this.isLongFocusDurationTime = 500,
  });

  @override
  _KChartWidgetState createState() => _KChartWidgetState();
}

bool longPressTriggered = false;

class _KChartWidgetState extends State<KChartWidget>
    with TickerProviderStateMixin {
  final StreamController<InfoWindowEntity?> mInfoWindowStream =
      StreamController<InfoWindowEntity?>.broadcast();
  double mScaleX = 1.0, mScrollX = 0.0, mSelectX = 0.0;
  double mHeight = 0, mWidth = 0;
  AnimationController? _controller;
  Animation<double>? aniX;

  //For price lines
  List<LineEntity> linesPrice = [];

  //For TrendLine
  List<TrendLine> lines = [];
  double? changeinXposition;
  double? changeinYposition;
  double mSelectY = 0.0;
  bool waitingForOtherPairofCords = false;
  bool enableCordRecord = false;
  bool objectEditable = false;

  double getMinScrollX() {
    return mScaleX;
  }

  double _lastScale = 1.0;
  bool isScale = false, isDrag = false, isLongPress = false, isOnTap = false;

  int pointerCount = 0;
  String currentLineName = '';
  int currentLineIndex = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    mInfoWindowStream.sink.close();
    mInfoWindowStream.close();
    _controller?.dispose();
    _timer?.cancel();
    super.dispose();
  }

  DateTime? _longPressStartTime;
  Timer? _timer;

  Map<Type, GestureRecognizerFactory<GestureRecognizer>> gestures = {};

  late final height = MediaQuery.of(context).size.height;
  ChartPainter? _painter;
  late double mBaseHeight = height * 0.88;

  @override
  Widget build(BuildContext context) {
    if (widget.datas != null && widget.datas!.isEmpty) {
      mScrollX = mSelectX = 0.0;
      mScaleX = 1.0;
    }
    final BaseDimension baseDimension = BaseDimension(
      mBaseHeight: mBaseHeight,
      volHidden: widget.volHidden,
      secondaryStateLi: widget.secondaryStateLi,
    );
    _painter = ChartPainter(
      widget.chartStyle,
      widget.chartColors,
      screenHeight: mBaseHeight,
      baseDimension: baseDimension,
      lines: lines,
      linesPrice: linesPrice,
      //For TrendLine
      sink: mInfoWindowStream.sink,
      xFrontPadding: widget.xFrontPadding,
      isTrendLine: widget.isTrendLine,
      //For TrendLine
      selectY: mSelectY,
      //For TrendLine
      datas: widget.datas,
      scaleX: mScaleX,
      scrollX: mScrollX,
      selectX: mSelectX,
      isLongPass: isLongPress,
      isOnTap: isOnTap,
      isTapShowInfoDialog: widget.isTapShowInfoDialog,
      mainState: widget.mainState,
      volHidden: widget.volHidden,
      secondaryStateLi: widget.secondaryStateLi,
      isLine: widget.isLine,
      hideGrid: widget.hideGrid,
      showNowPrice: widget.showNowPrice,
      fixedLength: widget.fixedLength,
      maDayList: widget.maDayList,
      verticalTextAlignment: widget.verticalTextAlignment,
    );

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(
              top: 12.0,
              start: 12.0,
              end: 12.0,
            ),
            child: Stack(
              children: [
                // Align(
                //   alignment: AlignmentDirectional.centerStart,
                //   child: Text(
                //     '${currentLineName.split(' ').first} ${currentLineName.split(' ').last}',
                //     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                //           fontWeight: FontWeight.w500,
                //         ),
                //   ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ChartPropertiesScreen(
                              volHidden: widget.volHidden,
                              mainState: widget.mainState,
                              secondaryStateLi:
                                  widget.secondaryStateLi.toList(),
                              setMode: (volHidden, mainState, secondaryState) {
                                widget.volHidden = volHidden;
                                widget.mainState = mainState;
                                widget.secondaryStateLi =
                                    secondaryState.toSet();
                                if (widget.secondaryStateLi.isNotEmpty &&
                                    !widget.volHidden) {
                                  mBaseHeight = height * 0.63;
                                } else if (widget.secondaryStateLi.isNotEmpty) {
                                  mBaseHeight = height * 0.74;
                                } else if (!widget.volHidden) {
                                  mBaseHeight = height * 0.74;
                                } else {
                                  mBaseHeight = height * 0.88;
                                }
                                setState(() {});
                              },
                            ),
                          ),
                        );
                      },
                      child: MSvg(
                        name: Svgs.chartSettings,
                        width: 20.0,
                        height: 20.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 20.0),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ObjectsScreen(
                              onDone: (line) {
                                linesPrice.add(line);
                                notifyChanged();
                              },
                            ),
                          ),
                        );
                      },
                      child: MSvg(
                        name: Svgs.objects,
                        width: 20.0,
                        height: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey.withOpacity(0.2)),
          LayoutBuilder(
            builder: (context, constraints) {
              mHeight = constraints.maxHeight;
              mWidth = constraints.maxWidth;

              if (objectEditable) {
                gestures[VerticalDragGestureRecognizer] =
                    verticalDragGestureRecognizer();
              } else {
                // Registering a ScaleGestureRecognizer to handle scale gestures
                gestures[ScaleGestureRecognizer] = scaleGestureRecognizer();

                // Registering a HorizontalDragGestureRecognizer to handle horizontal drag gestures
                gestures[HorizontalDragGestureRecognizer] =
                    horizontalDragGestureRecognizer();
              }

              return RawGestureDetector(
                gestures: gestures,
                child: GestureDetector(
                  // onDoubleTapDown: (details) {
                  //   _objectSetOnUpdate(details.localPosition);
                  // },
                  onTapUp: (details) {
                    if (!objectEditable) _onTapUp(details);
                  },
                  onLongPressStart: (details) {
                    _objectSetOnUpdate(details.localPosition);
                    if (!objectEditable) _longPressStart(details);
                  },
                  onLongPressMoveUpdate: (details) {
                    if (!objectEditable) _onLongPressMoveUpdate(details);
                  },
                  onLongPressEnd: (details) {
                    if (!objectEditable) _onLongPressEnd();
                  },
                  child: Stack(
                    children: <Widget>[
                      CustomPaint(
                        size:
                            Size(double.infinity, baseDimension.mDisplayHeight),
                        painter: _painter,
                      ),
                      //#十字光标长按0.5秒后才触发 -----------------------------------------------》》》》》 !! 关键 ！！ （isLongFocusDurationTime: 500/0 和 isLongFocus：true/false 切换）
                      if (widget.showInfoDialog &&
                          (widget.isLongFocusDurationTime == 0 ||
                              longPressTriggered))
                        _buildInfoDialog()
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _updateObjectPosition(Offset offset) {
    if (currentLineIndex != -1) {
      linesPrice[currentLineIndex].dy = offset.dy;
      notifyChanged();
    }
  }

  void _objectSetOnUpdate(Offset offset) {
    // final index = _painter!.updatePointPosition
    //     ?.updateLineOffsetPoint(offset: offset, linesPrice: linesPrice);
    // currentLineIndex = index!;
    // objectEditable = index != -1;
    // notifyChanged();
    // print(currentLineIndex);
  }

  GestureRecognizerFactoryWithHandlers<VerticalDragGestureRecognizer>
      verticalDragGestureRecognizer() {
    return GestureRecognizerFactoryWithHandlers<VerticalDragGestureRecognizer>(
        () => VerticalDragGestureRecognizer(),
        (VerticalDragGestureRecognizer instance) {
      instance
        ..onUpdate = (DragUpdateDetails details) {
          _updateObjectPosition(details.globalPosition);
        }
        ..onEnd = (DragEndDetails details) {
          // enableObject = false;
          notifyChanged();
        };
    });
  }

  GestureRecognizerFactoryWithHandlers<ScaleGestureRecognizer>
      scaleGestureRecognizer() {
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
            mScaleX = (_lastScale * details.scale).clamp(0.5, 2.2);
            notifyChanged();
          }
          ..onEnd = (details) {
            pointerCount = 1;
            isScale = false;
            _lastScale = mScaleX;
          };
      },
    );
  }

  GestureRecognizerFactoryWithHandlers<HorizontalDragGestureRecognizer>
      horizontalDragGestureRecognizer() {
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

  void _onTapUp(details) {
    if (!widget.isTrendLine && _painter!.isInMainRect(details.localPosition)) {
      isOnTap = true;

      if (mSelectX != details.localPosition.dx && widget.isTapShowInfoDialog) {
        mSelectX = details.localPosition.dx;

        longPressTriggered = false;
        _timer?.cancel();

        Future.delayed(Duration(milliseconds: 12500), () {
          notifyChanged();
        });
      }
    }
    if (widget.isTrendLine && !isLongPress && enableCordRecord) {
      enableCordRecord = false;
      Offset p1 = Offset(getTrendLineX(), mSelectY);
      if (!waitingForOtherPairofCords) {
        lines
            .add(TrendLine(p1, Offset(-1, -1), trendLineMax!, trendLineScale!));
      }

      if (waitingForOtherPairofCords) {
        var a = lines.last;
        lines.removeLast();
        lines.add(TrendLine(a.p1, p1, trendLineMax!, trendLineScale!));
        waitingForOtherPairofCords = false;
      } else {
        waitingForOtherPairofCords = true;
      }
      notifyChanged();
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

  void _onLongPressMoveUpdate(details) {
    var longPressTemp = (_longPressStartTime?.millisecondsSinceEpoch ?? 0);
    if (DateTime.now().millisecondsSinceEpoch - longPressTemp >= 500) {
      longPressTriggered = true;
      notifyChanged();
    } else {
      // longPressTriggered = false;
      // notifyChanged();
    }

    if ((mSelectX != details.localPosition.dx ||
            mSelectY != details.globalPosition.dy) &&
        !widget.isTrendLine) {
      mSelectX = details.localPosition.dx;
      mSelectY = details.localPosition.dy;
      notifyChanged();
    }
    if (widget.isTrendLine) {
      mSelectX = mSelectX + (details.localPosition.dx - changeinXposition!);
      changeinXposition = details.localPosition.dx;
      mSelectY = mSelectY + (details.globalPosition.dy - changeinYposition!);
      changeinYposition = details.globalPosition.dy;
      notifyChanged();
    }
  }

  void _longPressStart(details) {
    _timer?.cancel();
    _longPressStartTime = DateTime.now();
    longPressTriggered = false;

    isOnTap = false;
    isLongPress = true;
    if ((mSelectX != details.localPosition.dx ||
            mSelectY != details.globalPosition.dy) &&
        !widget.isTrendLine) {
      mSelectX = details.localPosition.dx;
      notifyChanged();
    }
    //For TrendLine
    if (widget.isTrendLine && changeinXposition == null) {
      mSelectX = changeinXposition = details.localPosition.dx;
      mSelectY = changeinYposition = details.globalPosition.dy;
      notifyChanged();
    }
    //For TrendLine
    if (widget.isTrendLine && changeinXposition != null) {
      changeinXposition = details.localPosition.dx;
      changeinYposition = details.globalPosition.dy;
      notifyChanged();
    }
  }

  void _onLongPressEnd() {
    // _timer?.cancel();
    isLongPress = false;
    enableCordRecord = true;

    if (widget.isLongFocusDurationTime == 0) {
      mInfoWindowStream.sink.add(null);
      notifyChanged();
    }

    if (!longPressTriggered) {
      notifyChanged();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        mInfoWindowStream.sink.add(null);
      });
    }
  }

  late List<String> infos;

  Widget _buildInfoDialog() {
    return StreamBuilder<InfoWindowEntity?>(
      stream: mInfoWindowStream.stream,
      builder: (context, snapshot) {
        if (widget.isLongFocusDurationTime == 0 &&
            ((!isLongPress && !isOnTap) ||
                widget.isLine == true ||
                !snapshot.hasData ||
                snapshot.data?.kLineEntity == null)) {
          return SizedBox();
        }
        if (widget.isLongFocusDurationTime != 0 &&
            (!longPressTriggered || widget.isLine == true
            // ||
            // !snapshot.hasData ||
            // snapshot.data?.kLineEntity == null
            )) return SizedBox();
        if (widget.isLongFocusDurationTime != 0 &&
            !longPressTriggered &&
            snapshot.data == null) {
          return SizedBox.shrink();
        }
        if (snapshot.data == null) return SizedBox.shrink();

        KLineEntity entity = snapshot.data!.kLineEntity;
        final dialogWidth = mWidth / 3;
        if (snapshot.data!.isLeft) {
          return Positioned(
            top: 25,
            left: 10.0,
            child: PopupInfoView(
              entity: entity,
              width: dialogWidth,
              chartColors: widget.chartColors,
              chartTranslations: widget.chartTranslations,
              materialInfoDialog: widget.materialInfoDialog,
              timeFormat: widget.timeFormat,
              fixedLength: widget.fixedLength,
            ),
          );
        }
        return Positioned(
          top: 25,
          right: 10.0,
          child: PopupInfoView(
            entity: entity,
            width: dialogWidth,
            chartColors: widget.chartColors,
            chartTranslations: widget.chartTranslations,
            materialInfoDialog: widget.materialInfoDialog,
            timeFormat: widget.timeFormat,
            fixedLength: widget.fixedLength,
          ),
        );
      },
    );
  }
}
