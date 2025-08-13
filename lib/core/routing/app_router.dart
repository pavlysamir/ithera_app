import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithera_app/core/Layouts/patient_home_layout.dart';
import 'package:ithera_app/core/cashe/cache_helper.dart';
import 'package:ithera_app/core/cashe/cashe_constance.dart';
import 'package:ithera_app/core/di/service_locator.dart';
import 'package:ithera_app/core/routing/routes.dart';
import 'package:ithera_app/features/add_files/manager/cubit/add_files_cubit.dart';
import 'package:ithera_app/features/auth/presentation/doctor_auth/screens/doctor_add_password_screen.dart';
import 'package:ithera_app/features/auth/presentation/doctor_auth/screens/doctor_signup_screen.dart';
import 'package:ithera_app/features/auth/managers/doctor_auth_cubit/doctor_auth_cubit.dart';
import 'package:ithera_app/features/auth/managers/patients_auth_cubit/patient_auth_cubit.dart';
import 'package:ithera_app/features/auth/presentation/doctor_auth/screens/doctor_verify_phone_otp.dart';
import 'package:ithera_app/features/auth/presentation/patient_auth/screens/add_password_screen.dart';
import 'package:ithera_app/features/auth/presentation/patient_auth/screens/forget_password_screen.dart';
import 'package:ithera_app/features/auth/presentation/patient_auth/screens/signin_screen.dart';
import 'package:ithera_app/features/auth/presentation/patient_auth/screens/signup_screen.dart';
import 'package:ithera_app/features/auth/presentation/patient_auth/screens/verify_phone_otp.dart';
import 'package:ithera_app/features/auth/presentation/patient_auth/screens/welcome_screen.dart';
import 'package:ithera_app/features/booking/doctor_booking/data/models/doctor_booking_model.dart';
import 'package:ithera_app/features/booking/doctor_booking/presentation/screens/book_details_screen.dart';
import 'package:ithera_app/features/booking/patient_booking/data/models/patient_booking_model.dart';
import 'package:ithera_app/features/booking/patient_booking/presentation/screens/patient_booking_details_screen.dart';
import 'package:ithera_app/features/get_baseLookUp/manager/cubit/bade_look_up_cubit.dart';
import 'package:ithera_app/features/home/patient_home/data/models/doctors_model.dart';
import 'package:ithera_app/features/home/patient_home/managers/booking_cubit/cubit/booking_cubit.dart';
import 'package:ithera_app/features/home/patient_home/managers/filter_cubit/filter_pagination_cubit.dart';
import 'package:ithera_app/features/home/patient_home/presentation/screens/book_now_screen.dart';
import 'package:ithera_app/features/home/patient_home/presentation/screens/filter_results_screen.dart';
import 'package:ithera_app/features/home/patient_home/presentation/screens/filter_screen.dart';
import 'package:ithera_app/features/home/patient_home/presentation/screens/doctor_screen.dart';
import 'package:ithera_app/features/notification/managers/cubit/notifications_cubit.dart';
import 'package:ithera_app/features/notification/presentation/screens/notification_screen.dart';
import 'package:ithera_app/features/on_boarding/presentations/on_boarding_view.dart';
import 'package:ithera_app/features/settings/doctors_settings/managers/cubit/setting_cubit.dart';
import 'package:ithera_app/features/settings/doctors_settings/presentation/screens/add_balance_screen.dart';
import 'package:ithera_app/features/settings/doctors_settings/presentation/screens/doctor_edit_profile.dart';
import 'package:ithera_app/features/settings/doctors_settings/presentation/screens/refund_balance_screen.dart';
import 'package:ithera_app/features/settings/doctors_settings/presentation/screens/wallet_screen.dart';
import 'package:ithera_app/features/settings/patients_settings/managers/cubit/seetings_cubit.dart';
import 'package:ithera_app/features/settings/patients_settings/presentation/screens/contant_us_screen.dart';
import 'package:ithera_app/features/settings/patients_settings/presentation/screens/patient_edit_profile.dart';
import 'package:ithera_app/features/settings/patients_settings/presentation/screens/prices_screen.dart';
import 'package:ithera_app/features/splash/presentation/screens/splash_screen.dart';

class AppRouter {
  static String initialRoute =
      // CacheHelper.getBool(key: 'OnBoarding') == true
      //     ? Routes.onBoardingScreen
      //     : Routes.onBoardingScreen;
      '/';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const SplashViewBody(),
          settings: settings,
        );
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (_) => OnBoardingScreen(),
          settings: settings,
        );
      case Routes.welcomeScreen:
        return MaterialPageRoute(
          builder: (_) => const WelcomeScreen(),
          settings: settings,
        );
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<BadeLookUpCubit>(
                create: (context) => getIt<BadeLookUpCubit>()..getAllCities(),
              ),
              BlocProvider<PatientAuthCubit>(
                create: (context) => getIt<PatientAuthCubit>(),
              ),
            ],
            child: const SignUpScreen(),
          ),
          settings: settings,
        );
      case Routes.verifyOtpScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<PatientAuthCubit>(),
            child: VerifyPhoneOtpRegisterScreen(
              isFromForgetPassword: settings.arguments as bool,
            ),
          ),
          settings: settings,
        );
      case Routes.addPassasswordScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<PatientAuthCubit>(),
            child: AddPasswordScreen(
              isFromForgetPassword: settings.arguments as bool,
            ),
          ),
          settings: settings,
        );

      case Routes.doctorAddPasswordScreen:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<AddFilesCubit>(
                create: (context) => getIt<AddFilesCubit>(),
              ),
              BlocProvider<DoctorAuthCubit>(
                create: (context) => getIt<DoctorAuthCubit>(),
              ),
            ],
            child: DoctorAddPasswordScreen(
              isFromForgetPassword: settings.arguments as bool,
            ),
          ),
          settings: settings,
        );
      case Routes.doctorVerifyForgetOtpScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<DoctorAuthCubit>(),
            child: DoctorVerifyPhoneOtpRegisterScreen(
              isFromForgetPassword: settings.arguments as bool,
            ),
          ),
          settings: settings,
        );
      case Routes.signInScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<PatientAuthCubit>(),
            child: SigninScreen(
              isFromPatient: settings.arguments as bool,
            ),
          ),
          settings: settings,
        );
      case Routes.forgtPasswordScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<PatientAuthCubit>(),
            child: const ForgetPasswordScreen(),
          ),
          settings: settings,
        );
      case Routes.patientHomeLayout:
        return MaterialPageRoute(
          builder: (_) => const PatientHomeLayout(),
          settings: settings,
        );
      case Routes.filterScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<BadeLookUpCubit>(
                create: (context) => getIt<BadeLookUpCubit>()
                  ..getAllCities()
                  ..getAllSpecialties(),
              ),
              BlocProvider<FilterPaginationCubit>(
                create: (context) => getIt<FilterPaginationCubit>(),
              ),
            ],
            child: const FilterScreen(),
          ),
          settings: settings,
        );
      case Routes.resultFilterScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<FilterPaginationCubit>()),
              BlocProvider(
                create: (context) => getIt<BadeLookUpCubit>()..getAllCities(),
              ),
            ],
            child: const FilterResultsScreen(),
          ),
          settings: settings,
        );
      case Routes.patientEditProfileScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(providers: [
            BlocProvider<BadeLookUpCubit>(
                create: (context) => getIt<BadeLookUpCubit>()..getAllCities()),
            BlocProvider<SettingsCubit>(
              create: (context) => getIt<SettingsCubit>(),
            ),
          ], child: const PatientEditProfile()),
          settings: settings,
        );
      case Routes.patientContentUsScreen:
        return MaterialPageRoute(
          builder: (_) => const ContantUsScreen(),
          settings: settings,
        );
      case Routes.patientPricesScreen:
        return MaterialPageRoute(
          builder: (_) => const PricesScreen(),
          settings: settings,
        );
      case Routes.doctorSignUpScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<BadeLookUpCubit>(
                create: (context) => getIt<BadeLookUpCubit>()
                  ..getAllCities()
                  ..getAllSpecialties(),
              ),
              BlocProvider<DoctorAuthCubit>(
                create: (context) => getIt<DoctorAuthCubit>(),
              ),
            ],
            child: const DoctorSignupScreen(),
          ),
          settings: settings,
        );
      case Routes.doctorScreen:
        return MaterialPageRoute(
          builder: (context) => DoctorScreen(
            doctorModel: settings.arguments as DoctorModel,
          ),
          settings: settings,
        );
      case Routes.bookNowScreen:
        final args = settings.arguments as Map<String, dynamic>;

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<BookingCubit>(),
            child: BookNowScreen(
              doctorId: args['doctorId'] as int,
              schedule: args['schedule'] as DoctorRegionSchedule,
            ),
          ),
          settings: settings,
        );
      // case Routes.doctorHomeScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => const DoctorHomeScreen(),
      //     settings: settings,
      //   );
      case Routes.doctorEditProfileScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(providers: [
            BlocProvider<BadeLookUpCubit>(
              create: (context) => getIt<BadeLookUpCubit>()
                ..getAllCities()
                ..getAllSpecialties(),
            ),
            BlocProvider<SettingCubit>(
              create: (context) => getIt<SettingCubit>(),
            ),
            BlocProvider<AddFilesCubit>(
              create: (context) => getIt<AddFilesCubit>(),
            )
          ], child: const DoctorEditProfile()),
          settings: settings,
        );
      case Routes.walletScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                getIt<SettingCubit>()..getDoctorWalletDetails(),
            child: const WalletScreen(),
          ),
          settings: settings,
        );
      case Routes.addBalanceScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SettingCubit>(),
            child: const AddBalanceScreen(),
          ),
          settings: settings,
        );

      case Routes.refundBalanceScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SettingCubit>(),
            child: const RefundBalanceScreen(),
          ),
          settings: settings,
        );
      case Routes.bookDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => BookDetailsScreen(
            booking: settings.arguments as DoctorBookingModel,
          ),
          settings: settings,
        );
      case Routes.bookPatientDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => BookPatientDetailsScreen(
            activeBookings: settings.arguments as PatientBookingModel,
          ),
          settings: settings,
        );

      case Routes.notificationsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<NotificationsCubit>()
              ..getNotificatios(
                  role: CacheHelper.getInt(key: CacheConstants.role) ?? 0,
                  userId: CacheHelper.getInt(key: CacheConstants.userId) ?? 0),
            child: const NotificationScreen(),
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
