import 'package:flutter/material.dart';
import 'package:ithera_app/core/routing/routes.dart';
import 'package:ithera_app/features/auth/patient_auth/presentation/screens/signup_screen.dart';
import 'package:ithera_app/features/auth/patient_auth/presentation/screens/welcome_screen.dart';
import 'package:ithera_app/features/on_boarding/presentations/on_boarding_view.dart';
import 'package:ithera_app/features/splash/presentation/screens/splash_screen.dart';

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
          builder: (_) => SplashViewBody(),
          settings: settings,
        );
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (_) => OnBoardingScreen(),
          settings: settings,
        );
      case Routes.welcomeScreen:
        return MaterialPageRoute(
          builder: (_) => WelcomeScreen(),
          settings: settings,
        );
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => SignUpScreen(),
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
