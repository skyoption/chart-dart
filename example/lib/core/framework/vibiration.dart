import 'package:vibration/vibration.dart';

class Vibrate {
  static Future<void> run() async {
    final value = await Vibration.hasCustomVibrationsSupport();
    if (value == true) {
      Vibration.vibrate(duration: 400);
    } else {
      final amplitude = await Vibration.hasAmplitudeControl();
      if (amplitude == true) {
        await Vibration.vibrate(amplitude: 128);
      } else {
        await Vibration.vibrate();
      }
    }
  }

  static Future<void> cancel() async {
    await Vibration.cancel();
  }
}
