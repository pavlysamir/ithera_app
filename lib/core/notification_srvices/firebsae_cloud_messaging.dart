import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:ithera_app/core/cashe/cache_helper.dart';
import 'package:ithera_app/core/cashe/cashe_constance.dart';
import 'package:ithera_app/core/notification_srvices/firebase_messaging_navigation.dart';
import 'package:ithera_app/core/notification_srvices/local_notification_services.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print("Handling a background message: ${message.notification!.title}");
  }
  LocalNotificationService.showSimpleNotification(message);
}

class FirebaseApi {
  FirebaseApi();

  static final _firebaseMessaging = FirebaseMessaging.instance;

  static Future<void> initNotification() async {
    _firebaseMessaging.onTokenRefresh.listen((fcmToken) async {
      storeToken(tokenRefresh: fcmToken);
    });
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    initPushNotification();
  }

  static Future initPushNotification() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: false,
      badge: false,
      sound: false,
    );

    //FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage
        .listen(FirebaseMessagingNavigate.forGroundHandler);

    // terminated
    await FirebaseMessaging.instance
        .getInitialMessage()
        .then(FirebaseMessagingNavigate.terminatedHandler);

    // background
    FirebaseMessaging.onMessageOpenedApp
        .listen(FirebaseMessagingNavigate.backGroundHandler);
  }

  static Future<void> storeToken({String? tokenRefresh}) async {
    try {
      if (kDebugMode) {
        print('fcmToken :  eh alklaaam');
      }
      final token =
          await CacheHelper.getSecureData(key: CacheConstants.token) ?? '';
      if (tokenRefresh != null) {
        await CacheHelper.setSecureData(
            key: CacheConstants.fcmToken, value: tokenRefresh);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(token)
            .set({'fcmToken': tokenRefresh});
      } else {
        String? fcmToken = await FirebaseMessaging.instance.getToken();
        await CacheHelper.setSecureData(
            key: CacheConstants.fcmToken, value: fcmToken ?? '');

        await FirebaseFirestore.instance
            .collection('users')
            .doc(token)
            .set({'fcmToken': fcmToken});
        if (kDebugMode) {
          print('fcmToken :  $fcmToken');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('error is $e');
      }
    }
  }

  Future<String?> getAccessToken() async {
    try {
      final serviceAccountJson = {
        "type": "service_account",
        "project_id": "ithera-f62c6",
        "private_key_id": "f667a607f20a52f1395519d24b95c0b90901e9a2",
        "private_key":
            "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDKuvyyypj4DJ/Y\nLpYSIhAAKn9+rp6Lup63inzissqQIXWSJTs6xKn/ZYUYq7LeguLsGTR3JzY6DfLt\ne6gMp8qfvzz3SdbzrPN+vFZguUfvPHfA+NKC9opsjcLcSdT1B6V1A6Lmo7VaAjar\nlSwbvGnR2Su00ThS94qAK/5rI+Lr7iCi33SW1ZYca2frfQGym8sTViQbcq184JFp\n18IPbfAur6HvkC4nbxElIQIEyAE9gNzp7QQ26B4Zh7JVixHGTCt41S9G/pV+LxCa\nwvByyRQumAufWlvqUosORDj5edKl9ps/u2nkkvqllCB4iYfY0Jc8I2x2f7s2M6oi\ny0/bhRlnAgMBAAECggEAG8tBA94k1LUeYQwaBQhoey1YZ2zXTb7bLbyt3IK4pMQB\nk3TJRwhZaitn8PbxQfJd3BKkj8VveMwaxxZR9tI2RGp6mEimUKgghfqaOQ6N3y3C\nGVHDwrK8TZ+t3He+240d0QobllVRcrKk/icocfEF7QBCLrsUZsOLWIEvk07LOJ8h\nh5q16I8Ed+RFU2BrxUDlvRAFaysp8a4gjPsnzQM8t6Whc+WyNKMqTDu0/S7Ugh/r\nrXbZvULAbCPaOnESSR84dTTQW++kpd0e/BnOhnGGa/PwpbX/UouFf/1OpinyDWo8\nzCSuqDCnSwRuyPQVMQ91dlLUA/zzyJEe6k+nNvwViQKBgQDw/Q2TzgvLN9sSnWYA\nOUJtZaaeY5XbOW11V2IAxFDtBGNgP3pv5HrHnrEvKQfToyfRvKAHuoUYXY7m1Ao5\nC2xqO4jA9s9qhvaA0PvoeSl/XQylmDowdQaN1385LYX0z4skh6oR/9nDRxQkuekR\n87Gw6+mSO7sTzeP/cQI4qppaiwKBgQDXW9kSaNun/igwY7jzH5SZ03kINLKX1Lpc\nhIzPrVLtQhtyc3MqUmowTGYLawNmPwTbCwnTMqoIh5E+qXDBpWBvtj0zOmNKmxWp\n0tC6pA+Hq43yGqcbSa4dMiF+izsBNttRJ+KJaoNEbYXjB/gDGNClW6SaIMGGvaz+\nG0ZiFASEFQKBgBA5OPzGVkzsCbeLGR7SvAIZYcov8hq8Fv5bT6G1la0fKoGERH3b\n59ggetUt8fTxevDHvg5HJEarpb8sbzO/7SCJuX8kHnqRc27gotTXs097uCo9wU0Z\n08MgytPSmL4OatOevnhPvR1EX7rJOUOYIFJEz4iktMd0iPDdbsTZ12JZAoGBAIlN\nNqUlEz4UrRzEx2rB7KTyDY0sw9xHNRW9MGVLlL5NUmByuK734lmuq7SF4qHyda8N\nZ5MuDvfnLrPrpUbgoA44+uXJSPqMy4/9JzSHWptdxd7gHUAphod4qaAbNmA80DD6\no9SGgvBCf4TSVM3sqUFznwrg7WFxVnSfgQ0QxBxNAoGBAObnAqEK70JSsII9UelV\nfCW0iCdb/XYzwMO7TpzKVaAKjAYcfEaXxsBJKgaZfV8E8kYE6CI4KcvsBX+x85rh\nkKR/uV3FtVpbUrsPgS62WBaElxwQjlcCGJFnDNk+srEJitl66gCMu+8FRPXMqGBf\n1oK+q6Fj6y5QTBPQ/ZvE6t4p\n-----END PRIVATE KEY-----\n",
        "client_email": "ithera@ithera-f62c6.iam.gserviceaccount.com",
        "client_id": "101211803418428687347",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url":
            "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url":
            "https://www.googleapis.com/robot/v1/metadata/x509/ithera%40ithera-f62c6.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com"
      };

      // Updated scopes - only include FCM scope
      List<String> scopes = [
        "https://www.googleapis.com/auth/firebase.database",
        "https://www.googleapis.com/auth/firebase.messaging",
      ];

      // Create credentials
      final credentials =
          auth.ServiceAccountCredentials.fromJson(serviceAccountJson);

      // Get the client
      final client = await auth.clientViaServiceAccount(credentials, scopes);

      // Get access token
      final accessToken = await client.credentials.accessToken;

      // Close the client
      client.close();

      // Debug print
      if (kDebugMode) {
        print("Access Token obtained: ${accessToken.data}");
      }

      return accessToken.data;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print("Error getting access token: $e");
      }
      if (kDebugMode) {
        print("Stack trace: $stackTrace");
      }
      return null;
    }
  }

  Map<String, dynamic> getBody({
    required String userId,
    required String fcmToken,
    required String title,
    required String body,
    required String type,
  }) {
    return {
      "message": {
        "token": fcmToken,
        "notification": {"title": title, "body": body},
        "data": {
          "userId": userId,
          "type": type,
          "click_action": "FLUTTER_NOTIFICATION_CLICK"
        }
      }
    };
  }

  Future<void> sendNotifications({
    required String fcmToken,
    required String title,
    required String body,
    required String userId,
    String? type,
  }) async {
    try {
      final token = await getAccessToken();

      if (token == null) {
        throw Exception('Failed to obtain access token');
      }

      const String urlEndPoint =
          "https://fcm.googleapis.com/v1/projects/ithera-f62c6/messages:send";

      final dio = Dio();

      // Set headers
      dio.options.headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      // Prepare request body
      final requestBody = {
        "message": {
          "token": fcmToken,
          "notification": {
            "title": title.isNotEmpty ? title : "إشعار جديد",
            "body": body
          },
          "data": {
            "userId": userId,
            "type": type ?? "message",
            "click_action": "FLUTTER_NOTIFICATION_CLICK"
          }
        }
      };

      // Debug prints
      print('Request URL: $urlEndPoint');
      print('Request Headers: ${dio.options.headers}');
      print('Request Body: $requestBody');

      final response = await dio.post(
        urlEndPoint,
        data: requestBody,
      );

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.data}');
    } catch (e) {
      if (e is DioException) {
        print('DioError Type: ${e.type}');
        print('DioError Message: ${e.message}');
        print('DioError Response: ${e.response?.data}');
        print('DioError Status Code: ${e.response?.statusCode}');
      }
      print('Error sending notification: $e');
      rethrow;
    }
  }
}
