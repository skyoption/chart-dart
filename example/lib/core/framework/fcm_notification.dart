import 'package:example/core/consts/exports.dart';
import 'package:firebase_core/firebase_core.dart';

abstract class FCMNotification extends Cubit<FlowState> {
  FCMNotification() : super(const FlowState());

  Future<String> getFCMToken();

  Future<void> init({FirebaseOptions? options});

  void onClick({required RemoteMessage message});

  void onReceived({required RemoteMessage message});
}

@pragma('vm:entry-point')
Future<void> onMessagingBackground(RemoteMessage message) async {
  await FCMConfig.instance.local.displayNotificationFrom(
    message,
    (androidNotificationDetails, remoteMessage) async {
      return androidNotificationDetails;
    },
    (darwinNotificationDetails, remoteMessage) async {
      return darwinNotificationDetails;
    },
    (darwinNotificationDetails, remoteMessage) async {
      return darwinNotificationDetails;
    },
  );
}

@LazySingleton(as: FCMNotification)
class FCMNotificationImpl extends FCMNotification {
  @override
  Future<String> getFCMToken() async {
    try {
      String? token = '';
      token = await FCMConfig.instance.messaging.getToken();
      kPrint('FCMToken : $token');
      return token ?? '';
    } catch (e) {
      return DateTime.now().toIso8601String();
    }
  }

  @override
  Future<void> init({FirebaseOptions? options}) async {
    await FCMConfig.instance.init(
      onBackgroundMessage: onMessagingBackground,
      defaultAndroidChannel: const AndroidNotificationChannel(
        'fcm_channel',
        'fcm_title',
        importance: Importance.high,
        sound: RawResourceAndroidNotificationSound('sound_alert'),
      ),
      options: options,
    );
    FirebaseMessaging.onMessageOpenedApp.listen((event) async {
      onDataReceive(event.data);
      kPrint(event.data);
    });
  }

  @override
  Future<void> onClick({required RemoteMessage message}) async {
    onDataReceive(message.data);
  }

  @override
  Future<void> onReceived({required RemoteMessage message}) async {
    kPrint(message.notification);
    kPrint(message.data);
  }
}

void onDataReceive(Map<String, dynamic> data) {}
