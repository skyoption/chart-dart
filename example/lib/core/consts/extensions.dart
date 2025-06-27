import 'package:example/core/consts/exports.dart';
import 'package:web_socket_client/web_socket_client.dart' as socket;

extension DoubleExtension on double {
  Color getColor() {
    if (this == 0) return Coolors.grey;
    return this > 0 ? Coolors.green : Coolors.red;
  }

  String signFixed(int fixed) {
    if (this == 0) return toStringAsFixed(fixed);
    return this > 0 ? '+${toStringAsFixed(fixed)}' : toStringAsFixed(fixed);
  }

  String get signingFixed {
    if (this == 0) return '$this';
    return this > 0 ? '+$this' : '$this';
  }

  String get toTwoDecimal {
    return '${(this * 100).truncateToDouble() / 100}';
  }

  double get toTwoDecimalNum {
    return (this * 100).truncateToDouble() / 100;
  }
}

extension ConnectionStateExt on socket.ConnectionState? {
  bool get isDisconnected =>
      this == null ||
      this is socket.Disconnected ||
      this is socket.Reconnecting;

  Color connectionColor(Color connectedColor, Color disconnectedColor) {
    if (isDisconnected) return disconnectedColor;
    return connectedColor;
  }

  Color get connectivityColor {
    if (this is socket.Disconnected) return AppColors.failure;
    if (this is socket.Reconnecting) return AppColors.pending;
    return AppColors.success;
  }
}
