import 'package:device_info_plus/device_info_plus.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/fcm_notification.dart';
import 'package:example/injection/injectable.dart';

class DeviceInfo {
  static Future<Device> getInfo() async {
    String id = '';
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    bool isHuawei = false;
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      id = androidInfo.id;
      final manufacturer = androidInfo.manufacturer.toLowerCase();
      final brand = androidInfo.brand.toLowerCase();
      isHuawei = manufacturer.contains("huawei") || brand.contains("huawei");
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      id = iosInfo.identifierForVendor ?? '';
    }
    return Device(
      id: id,
      type: isHuawei
          ? 'huawei'
          : Platform.isIOS
              ? 'ios'
              : 'android',
      fcmToken: isHuawei ? null : "${await _getToken()}",
    );
  }

  static Future<String?> _getToken() async {
    try {
      return await getIt<FCMNotification>().getFCMToken();
    } catch (e) {
      return '';
    }
  }
}

class Device {
  final String id;
  final String type;
  final String? fcmToken;

  Device({required this.id, required this.type, this.fcmToken});
}
