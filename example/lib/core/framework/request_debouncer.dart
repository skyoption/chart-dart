import 'dart:async';
import 'dart:ui';

class RequestDebouncer {
  static Timer? _timer;

  /// Debounces a [callback] by cancelling previous ones within [duration].
  static void run(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 700),
  }) {
    _timer?.cancel();
    _timer = Timer(duration, callback);
  }

  /// Cancel any pending debounce operation
  static void cancel() {
    _timer?.cancel();
  }

  /// Check if there's an active debounce running
  static bool get isActive => _timer?.isActive ?? false;
}
