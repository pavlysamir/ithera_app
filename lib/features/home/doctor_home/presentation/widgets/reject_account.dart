import 'package:flutter/material.dart';
import 'package:ithera_app/core/assets/assets.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_button_large.dart';
import 'package:ithera_app/core/widgets/custom_svgImage.dart';

class RejectAccount extends StatelessWidget {
  const RejectAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomSvgimage(
            path: AssetsData.rejectedAccount,
          ),
          const SizedBox(
            height: 45,
          ),
          Text(
            'تم رفض حسابك',
            style: AppTextStyles.font22Regular.copyWith(
              color: AppColors.error100,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            '( رسالة من الادمن )',
            style: AppTextStyles.font20Regular.copyWith(
              color: AppColors.blackLight,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 35,
          ),
          CustomButtonLarge(
              text: 'تعديل البروفايل',
              color: AppColors.primaryColor,
              function: () {}),
        ],
      ),
    );
  }
}
