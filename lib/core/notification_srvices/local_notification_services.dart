import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ithera_app/core/theme/app_colors.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialize() async {
    // Create high-priority notification channel for Android
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'myChanel',
      'my chanel',
      description: 'High priority notifications',
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
      showBadge: true,
    );

    // Create the notification channel
    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/launcher_icon'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        requestCriticalPermission: false, // For high-priority notifications
      ),
    );

    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: onNotificationTap,
      onDidReceiveNotificationResponse: onNotificationTap,
    );
  }

  /// Set up notification response listener.
  static StreamController<NotificationResponse> notificationResponseController =
      StreamController<NotificationResponse>.broadcast();
  static void onNotificationTap(
    NotificationResponse notificationResponse,
  ) {
    notificationResponseController.add(notificationResponse);
  }

  static void showSimpleNotification(RemoteMessage message) async {
    try {
      Random random = Random();
      int id = random.nextInt(1000);

      String? title;
      String? body;

      // Default values
      title = message.notification?.title;
      body = message.notification?.body;

      // Check custom notification data if needed
      if ((title == null || body == null) &&
          message.data.containsKey('notification')) {
        final dynamic notificationData = message.data['notification'];

        if (notificationData is String) {
          try {
            final decoded = jsonDecode(notificationData);
            title ??= decoded['Title'] ?? 'No Title';
            body ??= decoded['Body'] ?? 'No Body';
            if (kDebugMode) {
              print('Decoded notification: $decoded');
            }
          } catch (e) {
            if (kDebugMode) print('❌ Error decoding notification: $e');
          }
        } else if (notificationData is Map) {
          title ??= notificationData['Title'] ?? 'No Title';
          body ??= notificationData['Body'] ?? 'No Body';
          if (kDebugMode) {
            print('Notification data: $notificationData');
          }
        }
      }

      title ??= 'No Notification Title';
      body ??= 'No Notification Body';

      // Enhanced notification details for better delivery
      NotificationDetails notificationDetails = const NotificationDetails(
        android: AndroidNotificationDetails(
          'myChanel',
          'my chanel',
          channelDescription: 'High priority notifications',
          largeIcon: DrawableResourceAndroidBitmap('@mipmap/launcher_icon'),
          color: AppColors.primaryColor,
          channelShowBadge: true,
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          enableVibration: true,
          fullScreenIntent:
              true, // This helps show notification even when phone is locked
          category: AndroidNotificationCategory.message,
          visibility: NotificationVisibility.public,
          autoCancel: true,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          sound: 'default',
          interruptionLevel: InterruptionLevel.timeSensitive, // For iOS 15+
          categoryIdentifier: 'message_category',
        ),
      );

      await _flutterLocalNotificationsPlugin.show(
        id,
        title,
        body,
        notificationDetails,
        payload: message.data['type']?.toString() ?? 'default',
      );

      if (kDebugMode) {
        print('✅ Local notification shown: ${message.data}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error in showSimpleNotification: $e');
      }
    }
  }

  // Optional: Method to test notifications
  static Future<void> showTestNotification() async {
    const NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'myChanel',
        'my chanel',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await _flutterLocalNotificationsPlugin.show(
      999,
      'Test Notification',
      'This is a test notification',
      notificationDetails,
      payload: 'test',
    );
  }
}
