import 'package:local_auth/local_auth.dart';
import 'package:example/core/consts/exports.dart';

class LocalAuth {
  final _auth = LocalAuthentication();
  final _device = DeviceLocalAuth();
  bool canCheckBiometrics = false;
  bool isDeviceSupported = false;
  List<BiometricType> availableBiometrics = [];

  Future<bool> init() async {
    isDeviceSupported = await _auth.isDeviceSupported();
    await _device.init();
    if (_device.deviceSupported) {
      await _checkBiometrics();
      await _getAvailableBiometrics();
    }
    return isDeviceSupported;
  }

  Future<void> clear() async {
    await _device.clear();
  }

  Future<void> _checkBiometrics() async {
    try {
      canCheckBiometrics = await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      kPrint(e);
    }
  }

  Future<void> _getAvailableBiometrics() async {
    try {
      availableBiometrics = await _auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      kPrint(e);
    }
  }

  Future<void> setCredentials({
    required String username,
    required String password,
  }) async {
    await _device.setCredentials(username: username, password: password);
  }

  Future<DeviceLocalAuth> auth() async {
    bool authenticated = false;
    if (isDeviceSupported && _device.deviceSupported) {
      try {
        authenticated = await _auth.authenticate(
          localizedReason:
              'Scan your fingerprint (or face or whatever) to authenticate',
          biometricOnly: false,
          sensitiveTransaction: true,
        );
      } on PlatformException catch (e) {
        kPrint(e);
      }
    }
    if (authenticated) {
      return _device;
    }
    return DeviceLocalAuth();
  }

  Future<DeviceLocalAuth> authWithBiometricOnly() async {
    bool authenticated = false;
    if (availableBiometrics.isNotEmpty &&
        isDeviceSupported &&
        _device.deviceSupported) {
      try {
        authenticated = await _auth.authenticate(
          localizedReason:
              'Scan your fingerprint (or face or whatever) to authenticate',
          biometricOnly: false,
          sensitiveTransaction: true,
        );
      } on PlatformException catch (e) {
        kPrint(e);
      }
    }
    if (authenticated) {
      return _device;
    }
    return DeviceLocalAuth();
  }

  Future<void> cancel() async {
    await _auth.stopAuthentication();
  }
}

class DeviceLocalAuth {
  SharedPreferences? sharedPreferences;
  String username, password;
  bool deviceSupported;

  DeviceLocalAuth({
    this.password = '',
    this.username = '',
    this.deviceSupported = false,
  });

  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    deviceSupported = sharedPreferences?.getBool('deviceSupported') ?? false;
    if (deviceSupported) {
      username = sharedPreferences?.getString('username') ?? '';
      password = sharedPreferences?.getString('password') ?? '';
    }
  }

  Future<void> setCredentials({
    required String username,
    required String password,
  }) async {
    this.username = username;
    this.password = password;
    await sharedPreferences?.setBool('deviceSupported', true);
    await sharedPreferences?.setString('username', username);
    await sharedPreferences?.setString('password', password);
  }

  Future<void> clear() async {
    await sharedPreferences?.setBool('deviceSupported', false);
    await sharedPreferences?.setString('username', '');
    await sharedPreferences?.setString('password', '');
  }
}
