import 'package:flutter/material.dart';
import 'package:ithera_app/core/assets/assets.dart';
import 'package:ithera_app/core/routing/navigation_services.dart';
import 'package:ithera_app/core/routing/routes.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_button_large.dart';
import 'package:ithera_app/core/widgets/custom_svgImage.dart';

class NoBookingScreen extends StatelessWidget {
  const NoBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CustomSvgimage(
            path: AssetsData.noBooking,
          ),
          const SizedBox(
            height: 45,
          ),
          Text(
            'لا توجد حجوزات حالية مع أي دكتور.',
            textAlign: TextAlign.center,
            style: AppTextStyles.font22Regular.copyWith(
              color: AppColors.black,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'ابحث الآن عن الدكتور المناسب لك وابدأ الحجز بسهولة!',
            style: AppTextStyles.font20Regular.copyWith(
              color: AppColors.blackLight,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 35,
          ),
          CustomButtonLarge(
              text: 'الصفحة الرئيسية',
              color: AppColors.primaryColor,
              function: () {
                NavigationService()
                    .navigateToReplacement(Routes.patientHomeLayout);
              }),
        ],
      ),
    );
  }
}
