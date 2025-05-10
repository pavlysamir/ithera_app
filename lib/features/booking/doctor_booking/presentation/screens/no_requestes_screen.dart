import 'package:flutter/material.dart';
import 'package:ithera_app/core/assets/assets.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_svgImage.dart';

class NoRequestesScreen extends StatelessWidget {
  const NoRequestesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CustomSvgimage(
            path: AssetsData.noRequestes,
          ),
          const SizedBox(
            height: 45,
          ),
          Text(
            'لا توجد حالات حالياً. سيتم إرسال إشعار لك فور توفر حالة تم طلبك لها.',
            style: AppTextStyles.font20Regular.copyWith(
              color: AppColors.blackLight,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
