import 'package:example/core/consts/exports.dart';
import 'package:example/firebase_options.dart';

abstract class FCMNotification extends Cubit<FlowState> {
  FCMNotification() : super(const FlowState());

  Future<String> getFCMToken();

  Future<void> init();

  void onClick({required RemoteMessage message});

  void onReceived({required RemoteMessage message});
}

@pragma('vm:entry-point')
Future<void> onMessagingBackground(RemoteMessage message) async {
  // await FCMConfig.instance.local.displayNotificationFrom(message);
}

@LazySingleton(as: FCMNotification)
class FCMNotificationImpl extends FCMNotification {
  FCMNotificationImpl() : super();

  @override
  Future<String> getFCMToken() async {
    String? token = '';
    token = await FCMConfig.instance.messaging.getToken();
    kPrint('FCMToken : $token');
    return token ?? '';
  }

  @override
  Future<void> init() async {
    await FCMConfig.instance.init(
      onBackgroundMessage: onMessagingBackground,
      defaultAndroidChannel: const AndroidNotificationChannel(
        'fcm_channel',
        'fcm_title',
        importance: Importance.high,
        sound: RawResourceAndroidNotificationSound('notification'),
      ),
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging.onMessageOpenedApp.listen((event) async {
      kPrint(event.notification);
      kPrint(event.data);
    });
  }

  @override
  void onClick({required RemoteMessage message}) {
    kPrint(message.notification);
    kPrint(message.data);
  }

  @override
  void onReceived({required RemoteMessage message}) {
    kPrint(message.notification);
    kPrint(message.data);
  }
}
