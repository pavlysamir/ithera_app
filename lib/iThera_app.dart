import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/routing/app_router.dart';
import 'package:ithera_app/core/routing/navigation_services.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';

class ItheraApp extends StatelessWidget {
  final NavigationService _navigationService = NavigationService();

  ItheraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: _navigationService.navigatorKey,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: AppRouter.initialRoute,
        locale: const Locale('ar'),
        title: 'iThera',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
