import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/assets/assets.dart';
import 'package:ithera_app/core/routing/navigation_services.dart';
import 'package:ithera_app/core/routing/routes.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_button_large.dart';
import 'package:ithera_app/core/widgets/custom_svgImage.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.backgroundWelcome,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 40),
        child: Column(
          children: [
            CustomSvgimage(
              hight: 150,
              path: AssetsData.logoWhite,
            ),
            SizedBox(
              height: 30.h,
            ),
            Text('اهلا بك في\nتطبيق i-Thera\nللعلاج الطبيعي',
                textAlign: TextAlign.center, style: AppTextStyles.font25Medium),
            SizedBox(
              height: 90.h,
            ),
            CustomButtonLarge(
              text: 'حجز جلسات منزلية',
              color: AppColors.white,
              function: () {
                NavigationService().navigateTo(Routes.signUpScreen);
              },
              textColor: AppColors.primaryColor,
            ),
            SizedBox(
              height: 30.h,
            ),
            CustomButtonLarge(
              text: 'البحث عن عيادة (قريبا..)',
              color: AppColors.blueLight,
              function: () {},
              textColor: AppColors.white,
            ),
            Spacer(),
            Text(
              'الـأنضمام كدكتور',
              style: AppTextStyles.font20Regular.copyWith(
                color: AppColors.primaryColor,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.primaryColor,
              ),
            )
          ],
        ),
      ),
    ));
  }
}
