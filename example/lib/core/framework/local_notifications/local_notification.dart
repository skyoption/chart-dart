// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:mwidgets/mwidgets.dart';
import 'package:path_provider/path_provider.dart';

import 'notificatin_model.dart';

class AppNotifications {
  bool isShowNotification = true;
  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
  AppNotifications() {
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (data) {},
      onDidReceiveBackgroundNotificationResponse: onReceiveBackgroundResponse,
    );

    // flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin>()
    //     ?.requestPermission();
  }

  static void onReceiveBackgroundResponse(NotificationResponse details) {
    kPrint(details.payload.toString());
  }

  static void orderNavigation(NotificationResponse details) {
    if (details.payload != null) {
      kPrint('notification payload: ${details.payload}');
    }
  }

  final DarwinInitializationSettings initializationSettingsIOS =
      const DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
    defaultPresentSound: true,
    defaultPresentAlert: true,
    defaultPresentBadge: true,
  );

  static const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('ic_stat_name');

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> showNotification(NotificationModel notification) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      enableVibration: true,
      onlyAlertOnce: true,
      // playSound: true,
      //  sound: RawResourceAndroidNotificationSound('notification'),
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    // flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin>()
    //     ?.requestPermission();
    kPrint(notification.toJson().toString());
    if (isShowNotification) {
      await flutterLocalNotificationsPlugin.show(
        0,
        notification.title,
        notification.body,
        platformChannelSpecifics,
        payload: payload(notification),
      );
    }
  }

  String payload(NotificationModel notification) {
    kPrint('${notification.status}');
    return notification.status.toString();
  }

  Future<void> showBigPictureNotification() async {
    final String largeIconPath =
        await getImageFilePathFromAssets("assets/images/test_team_logo2.png");
    final String bigPicturePath =
        await getImageFilePathFromAssets("assets/images/stadium.png");
    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      largeIcon: FilePathAndroidBitmap(largeIconPath),
      contentTitle: 'overridden <b>big</b> content title',
      htmlFormatContentTitle: true,
      summaryText: 'summary <i>text</i>',
      htmlFormatSummaryText: true,
    );
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'big text channel id',
      'big text channel name',
      channelDescription: 'big text channel description',
      styleInformation: bigPictureStyleInformation,
      sound: const RawResourceAndroidNotificationSound('notification'),
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    if (isShowNotification) {
      await flutterLocalNotificationsPlugin.show(
        0,
        'big text title',
        'silent body',
        platformChannelSpecifics,
      );
    }
  }

  Future<void> showBigPictureNotificationURL(
      NotificationModel notification) async {
    final ByteArrayAndroidBitmap largeIcon = ByteArrayAndroidBitmap(
        await _getByteArrayFromUrl(notification.imageUrl!));
    final ByteArrayAndroidBitmap bigPicture = ByteArrayAndroidBitmap(
        await _getByteArrayFromUrl(notification.imageUrl!));

    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(
      bigPicture,
      largeIcon: largeIcon,
      contentTitle: 'overridden <b>big</b> ${notification.title}',
      htmlFormatContentTitle: true,
      summaryText: 'summary <i>${notification.body}</i>',
      htmlFormatSummaryText: true,
    );
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'big text channel id',
      'big text channel name',
      channelDescription: 'big text channel description',
      styleInformation: bigPictureStyleInformation,
      sound: const RawResourceAndroidNotificationSound('notification'),
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    if (isShowNotification) {
      await flutterLocalNotificationsPlugin.show(
        0,
        'big text title',
        'silent body',
        platformChannelSpecifics,
      );
    }
  }

  Future<Uint8List> _getByteArrayFromUrl(String url) async {
    final http.Response response = await http.get(Uri.parse(url));
    return response.bodyBytes;
  }

  Future<String> getImageFilePathFromAssets(String asset) async {
    final byteData = await rootBundle.load(asset);

    final file = File(
        '${(await getTemporaryDirectory()).path}/${asset.split('/').last}');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file.path;
  }

  Future<void> showBigPictureNotificationHiddenLargeIcon(
      NotificationModel notification) async {
    final ByteArrayAndroidBitmap largeIcon = ByteArrayAndroidBitmap(
        await _getByteArrayFromUrl(notification.imageUrl!));
    final ByteArrayAndroidBitmap bigPicture = ByteArrayAndroidBitmap(
        await _getByteArrayFromUrl(notification.imageUrl!));
    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(
      bigPicture,
      hideExpandedLargeIcon: true,
      contentTitle: '${notification.title}',
      htmlFormatContentTitle: true,
      summaryText: '${notification.body}',
      htmlFormatSummaryText: true,
    );
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'big text channel id',
      'big text channel name',
      channelDescription: 'big text channel description',
      largeIcon: largeIcon,
      styleInformation: bigPictureStyleInformation,
      sound: const RawResourceAndroidNotificationSound('notification'),
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    if (isShowNotification) {
      final random = Random();
      await flutterLocalNotificationsPlugin.show(
        random.nextInt(1000),
        '${notification.title}',
        '${notification.body}',
        platformChannelSpecifics,
      );
    }
  }
}
