import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  ApiInterceptor();
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Get the token from SharedPreferences
    // String? token =
    //     getIt.get<CashHelperSharedPreferences>().getData(key: ApiKey.token);

    // If token is not null, add it to the request headers as a Bearer token
    // if (token != null) {
    //   options.headers[ApiKey.authorizationHeader] = 'Bearer $token';
    // }
    //options.headers[ApiKey.contantType] = 'application/json-patch+json';

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
