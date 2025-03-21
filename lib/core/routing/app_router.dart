import 'package:flutter/material.dart';
import 'package:ithera_app/core/routing/routes.dart';
import 'package:ithera_app/features/on_boarding/home/home.dart';
import 'package:ithera_app/features/on_boarding/presentations/on_boarding_view.dart';

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
          builder: (_) => OnBoardingScreen(),
          settings: settings,
        );
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (_) => Home(),
          settings: settings,
        );
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
