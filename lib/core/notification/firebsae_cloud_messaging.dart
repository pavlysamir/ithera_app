import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:ithera_app/core/notification/firebase_messaging_navigation.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print("Handling a background message: ${message.notification!.title}");
  }
}

class FirebaseApi {
  static final _firebaseMessaging = FirebaseMessaging.instance;

  static Future<void> initNotification() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
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
      alert: true,
      badge: true,
      sound: true,
    );

    //FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

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

  static void handleOpenAppMessage(BuildContext context) {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
      if (message!.data['type'] == 'any thing') {
        //navigate to any thing
      }
    });
  }

  static void handleGetInitialMessage(BuildContext context) {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null && message.data['type'] == 'anyThing') {
        //navigateto any screen
      }
    });
  }

  static Future<void> storeToken(
      {required String userId, required String? token}) async {
    try {
      // String? token = await FirebaseMessaging.instance.getToken();
      // kTokenMssage = token!;
      // if (kDebugMode) {
      //   print('fcmToken :  $token');
      // }
      //

      if (token == null) return;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'fcmToken': token});
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
        "project_id": "manasa-a5d28",
        "private_key_id": "6ecaf24a951f13c5c415da182879dc6d72349b1d",
        "private_key":
            "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQCxWE/5oLtZ7cpj\n7+4Tzzfo3Sny0lQNOpawzfz+jjdaZWn8nMdE/hvP/GoUxHQDaL4c+2blaOflZKNC\nSi8E73RyGeL2B/r5PjYr7St0NqUpiKW8+Sf9thXHg9Iym+svxvF72a53V5jzGOds\naWYMTCETubimC2c/FibExMHOEzf1R1hQ3NLv76iegbO9KK64fzH4Dg7q7aADdtfx\n9lHzsDQtz0FJVZA7gT/jz6X45tAtM1EWlyLM7n3Ecx4e0479Sqkiw6b2l0NmkVgp\n86jd66LF7kqa/fxB8wEKG1xAThpTZrnUqZbIF4E4/OjMinTObWnyhwFvyBmnopny\ngyKqdlQzAgMBAAECggEADt9upECNZcR89DZOG5LbHVLVmUZ4A7yq9ZHuNTTybHN+\ng3psdcXvyYNhgXNbnWDpN19YE5uMKHSbrSFb4ciT1fEuKQml9nAitTqzKbsJd+W8\nrI/4AXLbTxD9jalTfH1tNBX0ko/3RO/iPKPMNJzP1f/TKKMNL2u+qELYqV0llL1u\nbZHCXuc8l6A7k9fDgbkEfgqhTPmOeqQbN4LNCt9v7uG37gwCLbk/38SuXMa1peN7\nXIZ4TUVfsNO2eYw5tSGe5X3jd7nG6zZP43M3EKy5aTMf0K3xY5AVT+axW3CCNp1p\nmVlUTEJsswxui/Mdf0H4koG25TNFX2GAyxbthlTCeQKBgQDz7hZztkHcLk8q6Kgh\n+UWki/MeV8e2oXdB/pV3SEF/bR0F+nwE/LQ2OytoXJKoSevqLQV4uHRmfarUzePw\najoRG1kbAS0XXW/jB9a6IXP1rFYzNvHzjReF+moiG2iRJ6iNUbiSxqG4gpU2xjaf\nYIV5wsFo5LWDXZwiTZF2yOi1iQKBgQC6HscmrBG7UcxFXcBaX6NWHbN9Yfnpxvus\nC+Sc5Dg6CT31a8cMvJSGwinnyvckq1snqMOAxwZyj1L/NNEhS1fDfRr2ZEI/fX6v\ns1aQc7z08zBgju7pb9h/br34POvq6qjuoNkLYljqV9CRpJ9spIciSjr0GJt94BD4\nZ5cyPRDI2wKBgQDXoaq7U2xZBZ76YXzvu3mzAfxC4HotmgLglfru3TL5QC2d8VXc\n2r88CYZP1TXYCrC/7Fif5P8Q8xom0HMlPeJi6PgWBS4lL3YPDgjltVja3iO9Vl8A\nW8Nlrn5P9Ea1uocnlgxBw9GGV/kr2IDE1wBnKKDs5vEGVaQGNufWR7hfcQKBgQCK\nakdLcF5Dg+K5l65sx4FukuogjhPRE0WpvrKHJ4bVSnhEo6HFzB1dVtrZYm2IXNOO\n3AiBJgKaghKEb2A0NZcQcGLz6L4H/6mOu33eMeTN+mn49XOiMaa9prsq+QuuilOW\nHBMuTza3GRWoqthRcM565t+PFxnUdCXKxyd/mkB4TwKBgQC+2Y88pbZ1iYSuAC7y\nvbn+pCIBbsq8gUoJa7juN1LxxbV7YtiGR2SWLheyD+EjoBjwUSb/mNB1zIVwPtC1\nicjXzL38TU+5a1ObmccBhOTnRMevzU+Dx68ThGxCW6zWTBAjxlit+mv1B1ULcMui\n0sy+dHrJExKKGq/xUxWzlkXU/Q==\n-----END PRIVATE KEY-----\n",
        "client_email":
            "firebase-adminsdk-wy7fm@manasa-a5d28.iam.gserviceaccount.com",
        "client_id": "114742733742206403505",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url":
            "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url":
            "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-wy7fm%40manasa-a5d28.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com"
      };

      // Updated scopes - only include FCM scope
      List<String> scopes = [
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
      print("Access Token obtained: ${accessToken.data}");

      return accessToken.data;
    } catch (e, stackTrace) {
      print("Error getting access token: $e");
      print("Stack trace: $stackTrace");
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
          "https://fcm.googleapis.com/v1/projects/manasa-a5d28/messages:send";

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

// هندها في ال main

// void setupFCMTokenRefresh(String userId) {
//   FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
//     await FirebaseMessagingService.storeToken(userId, newToken);
//   });
// }
}
