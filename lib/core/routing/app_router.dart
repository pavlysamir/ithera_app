import 'package:flutter/material.dart';
import 'package:ithera_app/iThera_app.dart';

class AppRouter {
  static String initialRoute =
      // getIt.get<CashHelperSharedPreferences>().getData(key: 'onBoarding') ==
      //         true
      //     ? Routes.onBoardingScreen
      //     : Routes.onBoardingScreen;
      '/';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const ItheraApp(),
          settings: settings,
        );

      // Add more routes as needed

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
