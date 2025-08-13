import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:ithera_app/core/notification/local_notification_services.dart';

class FirebaseMessagingNavigate {
  // forground
  static Future<void> forGroundHandler(RemoteMessage? message) async {
    if (message?.notification != null) {
      if (kDebugMode) {
        print('notification: ${message?.notification!.title}');
      }
      if (kDebugMode) {
        print('notification: ${message?.notification!.body}');
      }
    }
    LocalNotificationService.showSimpleNotification(message!);
  }

  // background
  static void backGroundHandler(RemoteMessage? message) {
    if (message != null) {
      _navigate(message);
    }
  }

  // terminated
  static void terminatedHandler(RemoteMessage? message) {
    if (message != null) {
      _navigate(message);
    }
  }

// will handle navigation based on the message type
  static void _navigate(RemoteMessage message) {
    if (message.data['type'] == 'anyThing') {
      return;
    } else {
      return;
    }
  }
}
