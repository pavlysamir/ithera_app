import 'package:dio/dio.dart';
import 'dart:convert';

class ApiInterceptor extends Interceptor {
  ApiInterceptor();
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    const String username = '11236180'; // Replace with your username
    const String password = '60-dayfreetrial'; // Replace with your password
    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    options.headers['Authorization'] = basicAuth;
    options.headers['Content-Type'] = 'application/json';
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // Check for token expiration in the www-authenticate header
      if (err.response?.headers.value('www-authenticate') != null &&
          err.response!.headers
              .value('www-authenticate')!
              .contains('invalid_token')) {
        // Token is expired, navigate to login screen
        // navigatorKey.currentState?.pushReplacementNamed();
        // customGoAndDeleteNavigate(
        //     context: navigatorKey.currentState!.context,
        //     path: AppRouter.kLoginScreen);
      }
    }
    super.onError(err, handler);
  }
}
