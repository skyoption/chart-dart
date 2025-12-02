import 'package:vibration/vibration.dart';

class Vibrate {
  static bool _isVibrating = false;

  /// Check if vibration is currently running
  static bool get isVibrating => _isVibrating;

  static Future<void> run({Duration? duration}) async {
    // Check if vibration is already running
    if (_isVibrating) return;

    final isVibrating = await Vibration.hasVibrator();
    if (isVibrating == false) return;

    _isVibrating = true;

    try {
      final value = await Vibration.hasCustomVibrationsSupport();
      if (value == true) {
        await Vibration.vibrate(
          duration:
              (duration ?? const Duration(milliseconds: 300)).inMilliseconds,
        );
      } else {
        final amplitude = await Vibration.hasAmplitudeControl();
        if (amplitude == true) {
          await Vibration.vibrate(amplitude: 128);
        } else {
          await Vibration.vibrate();
        }
      }
    } finally {
      // Reset the flag after vibration completes
      Future.delayed(duration ?? const Duration(milliseconds: 300), () async {
        await cancel();
      });
    }
  }

  static Future<void> cancel() async {
    if (!_isVibrating) return;
    await Vibration.cancel();
    _isVibrating = false;
  }
}
