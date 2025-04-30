import 'package:flutter/material.dart';
import 'package:ithera_app/core/assets/assets.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_button_large.dart';
import 'package:ithera_app/core/widgets/custom_svgImage.dart';

class AcceptedAccount extends StatelessWidget {
  const AcceptedAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomSvgimage(
            path: AssetsData.acceptedAccount,
          ),
          const SizedBox(
            height: 45,
          ),
          Text(
            'تمت الموافقة على حسابك!',
            style: AppTextStyles.font22Regular.copyWith(
              color: AppColors.textGreenLight,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'أكمل عملية الدفع لتبدأ بالظهور للمستخدمين.',
            textAlign: TextAlign.center,
            style: AppTextStyles.font20Regular.copyWith(
              color: AppColors.blackLight,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          CustomButtonLarge(
              text: 'أضافة رصيد',
              color: AppColors.primaryColor,
              function: () {}),
        ],
      ),
    );
  }
}
