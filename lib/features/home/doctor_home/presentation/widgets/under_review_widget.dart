import 'package:flutter/material.dart';
import 'package:ithera_app/core/assets/assets.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_svgImage.dart';

class UnderReviewWidget extends StatelessWidget {
  const UnderReviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomSvgimage(
            path: AssetsData.underReview,
          ),
          const SizedBox(
            height: 45,
          ),
          Text(
            'حسابك قيد المراجعة حاليًا',
            style: AppTextStyles.font22Regular.copyWith(
              color: AppColors.textGreenLight,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'سيقوم الفريق المختص بمراجعة طلبك، وسنبلغك قريبًا بقرار القبول أو الرفض. شكرًا لانتظارك!',
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
