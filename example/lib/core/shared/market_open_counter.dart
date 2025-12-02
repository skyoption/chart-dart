import 'dart:async';

import 'package:example/app.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/features/symbols/models/symbol_entity.dart';

class MarketOpenCounter extends StatefulWidget {
  final Function() onCountdownFinished;
  final SymbolEntity? symbol;
  const MarketOpenCounter({
    super.key,
    required this.onCountdownFinished,
    this.symbol,
  });

  @override
  State<MarketOpenCounter> createState() => _MarketOpenCounterState();
}

class _MarketOpenCounterState extends State<MarketOpenCounter> {
  Timer? _countdownTimer;
  String _countdownText = '';
  final testTime = DateTime.now().toUtc().add(const Duration(seconds: 30));
  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    _updateCountdown();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        _updateCountdown();
      }
    });
  }

  void _updateCountdown() {
    final now = DateTime.now().toUtc();

    late DateTime targetTime;
    if (widget.symbol != null) {
      targetTime = testTime;
    } else {
      // Default to next Monday if no symbol provided
      final now = DateTime.now().toUtc();
      final daysUntilMonday = (DateTime.monday - now.weekday) % 7;
      final nextMonday = now.add(
        Duration(days: daysUntilMonday == 0 ? 7 : daysUntilMonday),
      );
      targetTime = DateTime.utc(
        nextMonday.year,
        nextMonday.month,
        nextMonday.day,
        0,
        0,
        0,
      );
    }

    final difference = targetTime.difference(now);

    if (difference.isNegative || difference.inSeconds <= 0) {
      widget.onCountdownFinished();
      _countdownText = '';
      _countdownTimer?.cancel();
      setState(() {});
      return;
    }

    final totalSeconds = difference.inSeconds;
    final days = totalSeconds ~/ (24 * 60 * 60);
    final hours = (totalSeconds % (24 * 60 * 60)) ~/ (60 * 60);
    final minutes = (totalSeconds % (60 * 60)) ~/ 60;
    final seconds = totalSeconds % 60;

    setState(() {
      _countdownText = SkyTrading.tr.marketWillOpenIn(
        days,
        hours.toString().padLeft(2, '0'),
        minutes.toString().padLeft(2, '0'),
        seconds.toString().padLeft(2, '0'),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MText(
      text: _countdownText,
      size: FoontSize.font16,
      color: context.colorScheme.primary,
      weight: FontWeight.w600,
    );
  }
}
