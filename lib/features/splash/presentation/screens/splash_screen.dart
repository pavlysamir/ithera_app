import 'package:flutter/material.dart';
import 'package:ithera_app/core/assets/assets.dart';
import 'package:ithera_app/core/cashe/cache_helper.dart';
import 'package:ithera_app/core/cashe/cashe_constance.dart';
import 'package:ithera_app/core/routing/navigation_services.dart';
import 'package:ithera_app/core/routing/routes.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_svgImage.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    initSliderAnimation();
    navigateToHome();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AnimatedBuilder(
            animation: animation,
            builder: (context, _) {
              return FadeTransition(
                  opacity: animation,
                  child: const CustomSvgimage(
                    path: AssetsData.logoWhite,
                  ));
            },
          ),
          const SizedBox(
            height: 6,
          ),
          AnimatedBuilder(
            animation: animation,
            builder: (context, _) {
              return FadeTransition(
                opacity: animation,
                child: Text(
                  textAlign: TextAlign.center,
                  'i-Thera',
                  style: AppTextStyles.font25Bold.copyWith(
                    color: AppColors.white,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void initSliderAnimation() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = Tween<double>(begin: 0, end: 1).animate(animationController);
    animationController.forward();
  }

  void navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));

    final token =
        await CacheHelper.getSecureData(key: CacheConstants.token) ?? '';
    final isFromPatient =
        await CacheHelper.getBool(key: CacheConstants.isFromPatient);
    final hasViewedOnBoarding =
        await CacheHelper.getBool(key: CacheConstants.onBoardingViewed);

    debugPrint(token, wrapWidth: 1024);
    print('isFromPatient: $isFromPatient');
    print('hasViewedOnBoarding: $hasViewedOnBoarding');

    if (token != null &&
        token != '' &&
        isFromPatient == true &&
        hasViewedOnBoarding == true) {
      NavigationService().navigateToReplacement(Routes.patientHomeLayout);
    } else if (token != null &&
        token != '' &&
        isFromPatient == false &&
        hasViewedOnBoarding == true) {
      NavigationService().navigateToReplacement(Routes.patientHomeLayout);
    } else if (hasViewedOnBoarding == true) {
      NavigationService().navigateToReplacement(Routes.welcomeScreen);
    } else {
      NavigationService().navigateToReplacement(Routes.onBoardingScreen);
    }
  }
}
