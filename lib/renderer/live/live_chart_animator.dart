import 'dart:math' as math;
import 'dart:ui' show lerpDouble, VoidCallback;

import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

/// Drives the live line chart: tick tweening, the glide when a point is
/// appended, Y-range easing and the tip pulse. The painter repaints from this
/// [Listenable], so animation frames never rebuild the widget tree.
class LiveChartAnimator extends ChangeNotifier {
  LiveChartAnimator({
    required TickerProvider vsync,
    this.maxTickDuration = const Duration(milliseconds: 450),
    this.glideDuration = const Duration(milliseconds: 500),
    this.curve = Curves.easeOutCubic,
  }) {
    _tick =
        AnimationController(vsync: vsync, duration: maxTickDuration, value: 1)
          ..addListener(notifyListeners);
    _glide =
        AnimationController(vsync: vsync, duration: glideDuration, value: 1)
          ..addListener(notifyListeners);
    _pulse = AnimationController(
        vsync: vsync, duration: const Duration(milliseconds: 1600))
      ..addListener(notifyListeners);
    range = RangeSmoother(notifyListeners);
  }

  final Duration maxTickDuration, glideDuration;
  final Curve curve;
  late final AnimationController _tick, _glide, _pulse;
  late final RangeSmoother range;
  bool _disposed = false;

  double? _fromP, _toP, _fromA, _toA, _fromB, _toB;
  double _glideDist = 0;
  DateTime? _lastPush;

  /// +1 last move up, -1 down, 0 flat.
  int direction = 0;

  double get tickT => curve.transform(_tick.value);
  double get growT => curve.transform(_glide.value);
  double get pulse => _pulse.value;

  /// Start or stop the idle tip pulse (it repaints every frame while running).
  void setPulse(bool enabled) {
    if (_disposed) return;
    if (enabled && !_pulse.isAnimating) {
      _pulse.repeat();
    } else if (!enabled && _pulse.isAnimating) {
      _pulse.stop();
    }
  }

  double? _lerp(double? a, double? b) =>
      b == null ? null : lerpDouble(a ?? b, b, tickT);

  double? get price => _lerp(_fromP, _toP);
  double? get ask => _lerp(_fromA, _toA);
  double? get bid => _lerp(_fromB, _toB);
  double? get targetPrice => _toP;
  double? get targetAsk => _toA;
  double? get targetBid => _toB;

  /// Extra translateX (data units). Starts at +pointWidth and eases to 0.
  double get glideOffset => _glideDist * (1 - growT);

  void push({required double price, double? ask, double? bid}) {
    if (_disposed) return;
    if (price == _toP &&
        (ask == null || ask == _toA) &&
        (bid == null || bid == _toB)) {
      return; // nothing changed: do not restart the tween (keeps the flash)
    }
    final now = DateTime.now();
    if (_lastPush != null) {
      final gap = now.difference(_lastPush!);
      var d = gap < maxTickDuration ? gap * 0.9 : maxTickDuration;
      if (d < const Duration(milliseconds: 80)) {
        d = const Duration(milliseconds: 80);
      }
      _tick.duration = d;
    }
    _lastPush = now;
    if (_toP != null && price != _toP) direction = price.compareTo(_toP!);

    // Capture what is on screen *now* before retargeting: never jumps.
    final curP = this.price, curA = this.ask, curB = this.bid;
    _fromP = curP ?? price;
    _toP = price;
    _fromA = curA ?? ask;
    _toA = ask ?? _toA;
    _fromB = curB ?? bid;
    _toB = bid ?? _toB;
    _tick.forward(from: 0);
  }

  /// Drop the ask/bid targets (e.g. the ask line was switched off).
  void clearAsk() {
    _fromA = _toA = null;
    notifyListeners();
  }

  void clearBid() {
    _fromB = _toB = null;
    notifyListeners();
  }

  /// Call right after a point is appended while following the live edge.
  void onNewPoint(double pointWidth) {
    if (_disposed) return;
    _glideDist = pointWidth;
    _glide.forward(from: 0);
  }

  void reset() {
    if (_disposed) return;
    _fromP = _toP = _fromA = _toA = _fromB = _toB = null;
    _lastPush = null;
    direction = 0;
    _glide.value = 1;
    _tick.value = 1;
    range.reset();
  }

  @override
  void dispose() {
    _disposed = true;
    range.dispose();
    _tick.dispose();
    _glide.dispose();
    _pulse.dispose();
    super.dispose();
  }
}

/// Frame-rate independent exponential smoothing for the Y range.
/// Safe to call from paint(): it never notifies synchronously.
class RangeSmoother {
  RangeSmoother(this._notify, {this.halfLifeMs = 140});
  final VoidCallback _notify;
  final double halfLifeMs;
  double? _max, _min;
  Duration? _last;
  bool _scheduled = false;
  bool _disposed = false;
  bool snap = false; // set true during pinch-zoom for instant response

  (double, double) smooth(double tMax, double tMin) {
    if (_max == null || _min == null || snap) {
      _max = tMax;
      _min = tMin;
      _last = null;
      return (tMax, tMin);
    }
    final now = SchedulerBinding.instance.currentSystemFrameTimeStamp;
    final dt = _last == null ? 16.0 : (now - _last!).inMicroseconds / 1000.0;
    _last = now;
    final k = 1 - math.pow(0.5, dt / halfLifeMs).toDouble();
    _max = _max! + (tMax - _max!) * k;
    _min = _min! + (tMin - _min!) * k;

    final eps = (tMax - tMin).abs() * 1e-4;
    if ((tMax - _max!).abs() <= eps && (tMin - _min!).abs() <= eps) {
      _max = tMax;
      _min = tMin;
      _last = null;
    } else if (!_scheduled) {
      _scheduled = true;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _scheduled = false;
        if (!_disposed) _notify(); // next frame
      });
    }
    return (_max!, _min!);
  }

  void reset() {
    _max = _min = null;
    _last = null;
  }

  void dispose() => _disposed = true;
}
