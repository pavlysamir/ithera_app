import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ithera_app/core/theme/app_colors.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialize() {
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/launcher_icon'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      ),
    );
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onTap);
  }

  static void onTap(NotificationResponse notificationResponse) {
    // navigator
    if (int.parse(notificationResponse.payload.toString()) != -1) {
      //handle navigate to app
    }
  }

  static void showSimpleNotification(RemoteMessage message) async {
    try {
      Random random = Random();
      int id = random.nextInt(1000);

      NotificationDetails notificationDetails = const NotificationDetails(
        android: AndroidNotificationDetails(
          'myChanel',
          'my chanel',
          icon: '@mipmap/launcher_icon',
          largeIcon: DrawableResourceAndroidBitmap('@mipmap/launcher_icon'),
          color: AppColors.primaryColor,
          channelShowBadge: true,

          importance: Importance.max,
          priority: Priority.high,
          // styleInformation: bigPictureStyleInformation, // Add the style here
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      );

      if (kDebugMode) {
        print('my id is ${id.toString()}');
      }

      await _flutterLocalNotificationsPlugin.show(
        id,
        message.notification?.title,
        message.notification?.body,
        notificationDetails,
        payload: message.data['type'].toString(),
      );
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Error>>>>$e');
      }
    }
  }
}
