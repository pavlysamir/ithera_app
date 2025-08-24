import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
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
      sound: true,
    );

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
      final userId = CacheHelper.getInt(key: CacheConstants.userId).toString();
      if (tokenRefresh != null) {
        await CacheHelper.setSecureData(
            key: CacheConstants.fcmToken, value: tokenRefresh);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .set({'fcmToken': tokenRefresh});
      } else {
        String? fcmToken = await FirebaseMessaging.instance.getToken();
        await CacheHelper.setSecureData(
            key: CacheConstants.fcmToken, value: fcmToken ?? '');

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
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

  static Future<String> getfcmTokenFromDb({String? userId}) async {
    final docSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (docSnapshot.exists) {
      final fcmToken = docSnapshot.data()?['fcmToken'];
      print('FCM Token: $fcmToken');
      return fcmToken;
    } else {
      print("User document not found");
      return '';
    }
  }

  // SECURE VERSION: Load service account from assets
  static Future<String?> getAccessToken() async {
    try {
      // Load service account JSON from assets instead of hardcoding
      final serviceAccountString =
          await rootBundle.loadString('assets/service_account.json');
      final serviceAccountJson = json.decode(serviceAccountString);

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

      // Debug print (only in debug mode)
      if (kDebugMode) {
        print("Access Token obtained successfully");
      }

      return accessToken.data;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print("Error getting access token: $e");
        print("Stack trace: $stackTrace");
      }
      return null;
    }
  }

  // ALTERNATIVE: Environment-based configuration
  Future<String?> getAccessTokenFromEnv() async {
    try {
      // Read from environment variables or secure storage
      final serviceAccountJson = {
        "type": "service_account",
        "project_id": const String.fromEnvironment('FIREBASE_PROJECT_ID',
            defaultValue: 'your-project-id'),
        "private_key_id":
            const String.fromEnvironment('FIREBASE_PRIVATE_KEY_ID'),
        "private_key": const String.fromEnvironment('FIREBASE_PRIVATE_KEY'),
        "client_email": const String.fromEnvironment('FIREBASE_CLIENT_EMAIL'),
        "client_id": const String.fromEnvironment('FIREBASE_CLIENT_ID'),
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url":
            "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url":
            const String.fromEnvironment('FIREBASE_CLIENT_CERT_URL'),
        "universe_domain": "googleapis.com"
      };

      // Validate that required environment variables are present
      if (serviceAccountJson['private_key'] == null ||
          serviceAccountJson['private_key'] == '') {
        throw Exception('Required environment variables not set');
      }

      List<String> scopes = [
        "https://www.googleapis.com/auth/firebase.database",
        "https://www.googleapis.com/auth/firebase.messaging",
      ];

      final credentials =
          auth.ServiceAccountCredentials.fromJson(serviceAccountJson);

      final client = await auth.clientViaServiceAccount(credentials, scopes);
      final accessToken = await client.credentials.accessToken;
      client.close();

      if (kDebugMode) {
        print("Access Token obtained from environment");
      }

      return accessToken.data;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print("Error getting access token from environment: $e");
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

  static Future<void> sendNotifications({
    required String fcmToken,
    required String title,
    required String body,
    required String userId,
    String? type,
  }) async {
    try {
      final token = await getAccessToken(); // or use getAccessTokenFromEnv()

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

      // Debug prints (only in debug mode)
      if (kDebugMode) {
        print('Request URL: $urlEndPoint');
        print('Request Headers: ${dio.options.headers}');
        print('Request Body: $requestBody');
      }

      final response = await dio.post(
        urlEndPoint,
        data: requestBody,
      );

      if (kDebugMode) {
        print('Response Status: ${response.statusCode}');
        print('Response Body: ${response.data}');
      }
    } catch (e) {
      if (e is DioException) {
        if (kDebugMode) {
          print('DioError Type: ${e.type}');
          print('DioError Message: ${e.message}');
          print('DioError Response: ${e.response?.data}');
          print('DioError Status Code: ${e.response?.statusCode}');
        }
      }
      if (kDebugMode) {
        print('Error sending notification: $e');
      }
      rethrow;
    }
  }
}
