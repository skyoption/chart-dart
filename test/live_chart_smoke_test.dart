import 'dart:async';
import 'dart:ui' as ui;

import 'package:candle_chart/entity/info_window_entity.dart';
import 'package:candle_chart/entity/k_line_entity.dart';
import 'package:candle_chart/k_chart_plus.dart';
import 'package:candle_chart/renderer/base_dimension.dart';
import 'package:candle_chart/renderer/chart_painter.dart';
import 'package:candle_chart/renderer/live/live_chart_animator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:candle_chart/utils/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<KLineEntity> _candles(int n) => List.generate(n, (i) {
      final p = 1.1196 + (i % 7) * 0.00002;
      return KLineEntity(
          open: p,
          high: p + 0.00001,
          low: p - 0.00001,
          close: p,
          vol: 1,
          time: 1700000000 + i * 60);
    });

class _Vsync extends TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    try {
      // Sets the global chartProperties first; opening Isar itself may fail here.
      await KChart.openDB();
    } catch (_) {}
  });
  for (final style in GraphStyle.values) {
    for (final scroll in [0.0, 120.0]) {
      test('paints $style scroll=$scroll', () async {
        final animator = LiveChartAnimator(vsync: _Vsync());
        final data = _candles(80);
        animator.push(price: 1.11965, ask: 1.11967, bid: 1.11963);
        animator.onNewPoint(6);
        final controller = StreamController<InfoWindowEntity?>.broadcast();
        final painter = ChartPainter(
          ChartStyle(
              digits: 6,
              pointWidth: 6,
              isSmallChart: true,
              expiryTime: (1700000000 + 82 * 60) * 1000),
          ChartColors.liveDark(),
          askAndBid: const [],
          sink: controller.sink,
          scaleY: 1.0,
          scaleX: 1.0,
          data: data,
          scrollX: scroll,
          isLongPass: false,
          selectX: 0.0,
          xFrontPadding: 100.0,
          baseDimension: BaseDimension(
              height: 300,
              volHidden: true,
              indicators: const {},
              secondaryRetro: 0.4,
              hideIndicators: true),
          indicators: const [],
          secondaryIndicators: const {},
          graphStyle: style,
          verticalTextAlignment: VerticalTextAlignment.left,
          volHidden: true,
          hideGrid: true,
          hideIndicators: true,
          trades: const [],
          isOnTap: false,
          isTapShowInfoDialog: false,
          animator: animator,
        );
        final recorder = ui.PictureRecorder();
        final canvas = Canvas(recorder);
        painter.paint(canvas, const Size(400, 300));
        painter.paint(canvas, const Size(400, 300)); // repaint, same instance
        recorder.endRecording();
        animator.dispose();
        controller.close();
      });
    }
  }

  group('S5 / S10 drift', () {
    test('enum indices are stable', () {
      expect(CandleTimeFormat.MN1.index, 8);
      expect(CandleTimeFormat.S5.index, 9);
      expect(CandleTimeFormat.S10.index, 10);
    });

    test('no drift until onNewBar; stopDrift clears it', () {
      final a = LiveChartAnimator(vsync: _Vsync());
      expect(a.driftActive, isFalse);
      expect(a.glideOffset, 0);
      a.onNewBar(
          barTime: 1700000000,
          frame: CandleTimeFormat.S5.duration!,
          pointWidth: 6);
      expect(a.driftActive, isTrue);
      a.stopDrift();
      expect(a.driftActive, isFalse);
      expect(a.glideOffset, 0);
      a.dispose();
    });

    for (final ms in [false, true]) {
      test('linear phase (barTime in ${ms ? 'ms' : 's'})', () {
        final a = LiveChartAnimator(vsync: _Vsync());
        var now = 1700000000 * 1000;
        a.nowMs = () => now;
        a.onNewBar(
            barTime: ms ? 1700000000 * 1000 : 1700000000,
            frame: CandleTimeFormat.S5.duration!,
            pointWidth: 19);
        expect(a.driftPhase, closeTo(0, 1e-9));
        expect(a.glideOffset, closeTo(19, 1e-9));
        now += 2500;
        expect(a.driftPhase, closeTo(0.5, 1e-9));
        expect(a.glideOffset, closeTo(9.5, 1e-9));
        now += 2500;
        expect(a.driftPhase, closeTo(1, 1e-9));
        expect(a.glideOffset, closeTo(0, 1e-9));
        a.dispose();
      });
    }

    test('late bar: phase and offset clamp, no run-past', () {
      final a = LiveChartAnimator(vsync: _Vsync());
      var now = 1700000000 * 1000;
      a.nowMs = () => now;
      a.onNewBar(
          barTime: 1700000000,
          frame: CandleTimeFormat.S10.duration!,
          pointWidth: 38);
      now += 60000;
      expect(a.driftPhase, 1);
      expect(a.glideOffset, 0);
      a.dispose();
    });

    test('toEpochMs handles seconds and ms', () {
      expect(toEpochMs(1700000000), 1700000000000);
      expect(toEpochMs(1700000000000), 1700000000000);
    });
  });
}
