import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithera_app/core/di/service_locator.dart';
import 'package:ithera_app/core/routing/routes.dart';
import 'package:ithera_app/features/auth/patient_auth/managers/cubit/patient_auth_cubit.dart';
import 'package:ithera_app/features/auth/patient_auth/presentation/screens/add_password_screen.dart';
import 'package:ithera_app/features/auth/patient_auth/presentation/screens/signup_screen.dart';
import 'package:ithera_app/features/auth/patient_auth/presentation/screens/verify_phone_otp.dart';
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
          builder: (context) => BlocProvider(
            create: (context) => getIt<PatientAuthCubit>(),
            child: SignUpScreen(),
          ),
          settings: settings,
        );
      case Routes.verifyOtpScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<PatientAuthCubit>(),
            child: VerifyPhoneOtpRegisterScreen(),
          ),
          settings: settings,
        );
      case Routes.addPassasswordScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<PatientAuthCubit>(),
            child: AddPasswordScreen(),
          ),
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
